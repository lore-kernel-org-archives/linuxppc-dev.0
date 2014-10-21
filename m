Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E7B181A0053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Oct 2014 10:37:39 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 22 Oct 2014 09:37:38 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9F7632CE804D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Oct 2014 10:37:36 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9LNdced33488998
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Oct 2014 10:39:38 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9LNbZvT017976
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Oct 2014 10:37:36 +1100
Date: Wed, 22 Oct 2014 10:37:35 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
Subject: Re: [PATCH] powernv/iommu: disable IOMMU bypass with param
 iommu=nobypass
Message-ID: <20141021233735.GA5725@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1413917383-18396-1-git-send-email-cascardo@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1413917383-18396-1-git-send-email-cascardo@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, corbet@lwn.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 21, 2014 at 04:49:43PM -0200, Thadeu Lima de Souza Cascardo wrote:
>When IOMMU bypass is enabled, a PCI device can read and write memory
>that was not mapped by the driver without causing an EEH. That might
>cause memory corruption, for example.
>
>When we disable bypass, DMA reads and writes to addresses not mapped by
>the IOMMU will cause an EEH, allowing us to debug such issues.
>
>Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Except minor things as below.

>---
> Documentation/kernel-parameters.txt       |    2 ++
> arch/powerpc/platforms/powernv/pci-ioda.c |   24 +++++++++++++++++++++++-
> 2 files changed, 25 insertions(+), 1 deletions(-)
>
>diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
>index 988160a..b03322a 100644
>--- a/Documentation/kernel-parameters.txt
>+++ b/Documentation/kernel-parameters.txt
>@@ -1454,6 +1454,8 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
> 		forcesac
> 		soft
> 		pt		[x86, IA-64]
>+		nobypass	[PPC/POWERNV]
>+			Disable IOMMU bypass, using IOMMU for PCI devices.
> 
> 
> 	io7=		[HW] IO7 for Marvel based alpha systems
>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>index 468a0f2..58a5a27 100644
>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>@@ -75,6 +75,27 @@ static void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
> #define pe_info(pe, fmt, ...)					\
> 	pe_level_printk(pe, KERN_INFO, fmt, ##__VA_ARGS__)
> 
>+static int __read_mostly disable_bypass;
>+

static bool pnv_iommu_bypass_disabled __read_mostly;

>+static int __init iommu_setup(char *str)
>+{
>+	if (!*str)
>+		return -EINVAL;

I guess it would be  "if (!str)" for malformed option.

>+	while (*str) {
>+		if (!strncmp(str, "nobypass", 8)) {
>+			disable_bypass = 1;
>+			pr_info("ppc iommu: disabling bypass.\n");

It would be more precise since the option is only visible to PowerNV:

			pr_info("PowerNV: IOMMU bypass window disabled\n");

>+		}
>+		str += strcspn(str, ",");
>+		if (*str == ',')
>+			str++;
>+	}
>+
>+	return 0;
>+}
>+
>+early_param("iommu", iommu_setup);
>+
> /*
>  * stdcix is only supposed to be used in hypervisor real mode as per
>  * the architecture spec
>@@ -1243,7 +1264,8 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
> 		pnv_ioda_setup_bus_dma(pe, pe->pbus, true);
> 
> 	/* Also create a bypass window */
>-	pnv_pci_ioda2_setup_bypass_pe(phb, pe);
>+	if (!disable_bypass)
>+		pnv_pci_ioda2_setup_bypass_pe(phb, pe);
> 	return;
> fail:
> 	if (pe->tce32_seg >= 0)

Thanks,
Gavin
