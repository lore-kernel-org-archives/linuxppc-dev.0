Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rf7H96hGFzDqrj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 00:19:49 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5SE4IwP067426
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 10:19:46 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23snu4kcjq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 10:19:45 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 28 Jun 2016 10:19:45 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Darren Stevens <darren@stevens-zone.net>, linuxppc-dev@lists.ozlabs.org
Cc: Pat Wall <pjwall@mac.com>, matthew@a-eon.com, aperez@alexperez.com,
 "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: Proposed: Patch to fix boot on PA6T
In-Reply-To: <4863e2f8235.599ebfcf@auth.smtp.1and1.co.uk>
References: <4863e2f8235.599ebfcf@auth.smtp.1and1.co.uk>
Date: Tue, 28 Jun 2016 19:48:55 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87vb0t4cs0.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Darren Stevens <darren@stevens-zone.net> writes:

> Hello All,
>
>     commit d6a9996e84ac4beb7713e9485f4563e100a9b03e
>     powerpc/mm: vmalloc abstraction in preparation for radix
>
>     This commit introduced variables for some linux kernel addresses that had
> before
>     been constants, unfortunately this stopped PaSemi PA6T systems(*) from
> booting as
>     they call ioremap to map SoC registers before the mmu is initialised. The
> attached
>     patch adds a hard-coded init of pci_io_base to the pas_init_early()
> function which
>     which allows the kernel to boot normally.
>
>     The value will be harmlessly set again once pci starts up.
>
>     (*) At the moment this has only been tested on an AmigaOneX1000, but I
> expect PaSemi
>     reference systems to have been affected in the same way.
>
> Kind regards
> Darren
> diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
> index d71b2c7..6b8d2ab 100644
> --- a/arch/powerpc/platforms/pasemi/setup.c
> +++ b/arch/powerpc/platforms/pasemi/setup.c
> @@ -61,6 +61,7 @@ static struct mce_regs mce_regs[MAX_MCE_REGS];
>  static int num_mce_regs;
>  static int nmi_virq = NO_IRQ;
>  
> +extern unsigned long pci_io_base;
>  
>  static void pas_restart(char *cmd)
>  {
> @@ -341,6 +342,10 @@ out:
>  
>  static void __init pas_init_early(void)
>  {
> +	/* Initialise the IO pointer so we don't crash on boot */
> +
> +	pci_io_base = (H_KERN_VIRT_START + (H_KERN_VIRT_SIZE >> 1));
> +
>  	iommu_init_early_pasemi();
>  }
>  

Another option is to init it along with rest of the variables as done in
hash__early_init_mmu(void)/radix__early_init_mmu(void)


-aneesh
