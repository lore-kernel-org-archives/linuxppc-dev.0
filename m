Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rq7KK4sgGzDqVT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 15:52:53 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6D5ppdt046641
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 01:52:51 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2455jsrs4m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 01:52:51 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 13 Jul 2016 15:52:49 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 14BF92CE802D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 15:52:47 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6D5qlJM26411146
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 15:52:47 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6D5qkfV003502
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 15:52:46 +1000
Subject: Re: [PATCH 05/15] cxl: Allow a default context to be associated with
 an external pci_dev
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
References: <1468237822-26276-1-git-send-email-imunsie@au.ibm.com>
 <1468237822-26276-6-git-send-email-imunsie@au.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 13 Jul 2016 15:52:45 +1000
MIME-Version: 1.0
In-Reply-To: <1468237822-26276-6-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <0a7c4db6-7f48-be69-81e0-ca1ede3f6cea@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/07/16 21:50, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
>
> The cxl kernel API has a concept of a default context associated with
> each PCI device under the virtual PHB. The Mellanox CX4 will also use
> the cxl kernel API, but it does not use a virtual PHB - rather, the AFU
> appears as a physical function as a peer to the networking functions.
>
> In order to allow the kernel API to work with those networking
> functions, we will need to associate a default context with them as
> well. To this end, refactor the corresponding code to do this in vphb.c
> and export it so that it can be called from the PHB code.
>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
> index 012b6aa..c5b9c201 100644
> --- a/drivers/misc/cxl/vphb.c
> +++ b/drivers/misc/cxl/vphb.c
> @@ -40,11 +40,28 @@ static void cxl_teardown_msi_irqs(struct pci_dev *pdev)
>  	 */
>  }
>
> +bool _cxl_pci_associate_default_context(struct pci_dev *dev, struct cxl_afu *afu)

If we're sharing these functions between the vPHB and peer models, do we 
have a better place than vphb.c for them?

> +{
> +	struct cxl_context *ctx;
> +
> +	/*
> +	 * Allocate a context to do cxl things too. This is used for interrupts

s/too/to/?

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
