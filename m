Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sHjfT2MfBzDqCZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 16:02:57 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7M5xDVC130461
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 02:02:55 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24y31bvwqm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 02:02:55 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 22 Aug 2016 00:02:52 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, Michael Neuling <mikey@neuling.org>,
 Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH 1/2] Enable storage keys for radix - user mode execution
In-Reply-To: <1471831017-18167-1-git-send-email-bsingharora@gmail.com>
References: <1471831017-18167-1-git-send-email-bsingharora@gmail.com>
Date: Mon, 22 Aug 2016 11:32:44 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87y43pibnf.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

> ISA 3 defines new encoded access authority that allows instruction
> access prevention in privileged mode and allows normal access
> to problem state. This patch just enables IAMR (Instruction Authority
> Mask Register), enabling AMR would require more work.
>

Don't we need to do them in hypervisor mode. Ie, the hypervisor setup
things such that guest privileged mode cannot execute guest userspace.

> I've tested this with a buggy driver and a simple payload. The payload
> is specific to the build I've tested.
>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> ---
>  arch/powerpc/mm/pgtable-radix.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> index af897d9..9e25663 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -294,6 +294,27 @@ found:
>  	return;
>  }
>
> +/*
> + * For radix page tables we setup, the IAMR values as follows
> + * IMAR = 0100...00 (key 0 is set to 1)
> + * AMOR = 1100....00 (Mask for key 0 is 11)
> + * AMR, UAMR, UAMOR are not affected
> + */
> +static void __init radix_init_iamr(void)
> +{
> +	unsigned long iamr_mask = 0x4000000000000000;
> +	unsigned long iamr = mfspr(SPRN_IAMR);
> +
> +	unsigned long amor_mask = 0xc000000000000000;
> +	unsigned long amor = mfspr(SPRN_AMOR);

Isn't AMOR hypervisor privileged ?.

> +
> +	iamr |= iamr_mask;
> +	amor |= amor_mask;
> +
> +	mtspr(SPRN_AMOR, amor);
> +	mtspr(SPRN_IAMR, iamr);
> +}
> +
>  void __init radix__early_init_mmu(void)
>  {
>  	unsigned long lpcr;
> @@ -350,6 +371,7 @@ void __init radix__early_init_mmu(void)
>  		radix_init_partition_table();
>  	}
>
> +	radix_init_iamr();
>  	radix_init_pgtable();
>  }
>
> -- 
> 2.5.5
