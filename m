Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcNZW2352zDqGx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 16:13:07 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4U699kH143656
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 02:13:02 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2as03r5ajf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 02:13:01 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 30 May 2017 16:12:59 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4U6Cn6o3998204
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 16:12:57 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4U6COPq008627
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 16:12:24 +1000
Subject: Re: [PATCH 1/3] powerpc/powernv/pci: Reduce spam when dumping PEST
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
References: <20170530054637.0D6C4AC0B9@b01ledav006.gho.pok.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 30 May 2017 16:12:00 +1000
MIME-Version: 1.0
In-Reply-To: <20170530054637.0D6C4AC0B9@b01ledav006.gho.pok.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <e5441c6f-d2e4-428a-9b1d-49a15e5be39c@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 30/05/17 15:44, Russell Currey wrote:
> Dumping the PE State Tables (PEST) can be highly verbose if a number of PEs
> are affected, especially in the case where the whole PHB is frozen and 512
> lines get printed.  Check for duplicates when dumping the PEST to reduce
> useless output.
>
> For example:
>
>     PE[0f8] A/B: 9700002600000000 80000080d00000f8
>     PE[0f9] A/B: 8000000000000000 0000000000000000
>     PE[..0fe] A/B: as above
>     PE[0ff] A/B: 8440002b00000000 0000000000000000
>
> instead of:
>
>     PE[0f8] A/B: 9700002600000000 80000080d00000f8
>     PE[0f9] A/B: 8000000000000000 0000000000000000
>     PE[0fa] A/B: 8000000000000000 0000000000000000
>     PE[0fb] A/B: 8000000000000000 0000000000000000
>     PE[0fc] A/B: 8000000000000000 0000000000000000
>     PE[0fd] A/B: 8000000000000000 0000000000000000
>     PE[0fe] A/B: 8000000000000000 0000000000000000
>     PE[0ff] A/B: 8440002b00000000 0000000000000000
>
> and you can imagine how much worse it can get for 512 PEs.
>
> Signed-off-by: Russell Currey <ruscur@russell.cc>

Minor comments below

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
> This is essentially V2 of a previous patch I submitted, with some changes
> thanks to feedback from Gavin.
> ---
>  arch/powerpc/platforms/powernv/pci.c | 50 +++++++++++++++++++++---------------
>  1 file changed, 30 insertions(+), 20 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
> index 935ccb249a8a..4852ac8d0b4d 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -227,11 +227,38 @@ void pnv_teardown_msi_irqs(struct pci_dev *pdev)
>  }
>  #endif /* CONFIG_PCI_MSI */
>
> +/* Nicely print the contents of the PE State Tables (PEST). */
> +static void pnv_pci_dump_pest(__be64 pestA[], __be64 pestB[], int pest_size)
> +{
> +	__be64 prevA = ULONG_MAX, prevB = ULONG_MAX;
> +	bool dup = false;
> +	int i;
> +
> +	for (i = 0; i < pest_size; i++) {
> +		__be64 peA = be64_to_cpu(pestA[i]);
> +		__be64 peB = be64_to_cpu(pestB[i]);
> +
> +		if (peA != prevA || peB != prevB) {
> +			if (dup) {
> +				pr_info("PE[..%03x] A/B: as above\n", i-1);
> +				dup = false;
> +			}
> +			prevA = peA;
> +			prevB = peB;
> +			if (peA >> 63 || peB >> 63)
> +				pr_info("PE[%03x] A/B: %016llx %016llx\n",
> +					i, peA, peB);
> +		} else if (!dup && (peA >> 63 || peB >> 63)) {

I'd prefer "peA >> 63" to be expressed as "peA & PPC_BIT(0)" but that 
might just be me?


> +			/* Don't need to track zeroes */

This comment is less than clear

> +			dup = true;
> +		}
> +	}
> +}
> +


-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
