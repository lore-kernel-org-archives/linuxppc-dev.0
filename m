Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D37F7B7D8A
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jun 2010 04:52:44 +1000 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e32.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o56IjHTW019131
	for <linuxppc-dev@ozlabs.org>; Sun, 6 Jun 2010 12:45:17 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o56Iqg58150658
	for <linuxppc-dev@ozlabs.org>; Sun, 6 Jun 2010 12:52:42 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o56IqfOR030411
	for <linuxppc-dev@ozlabs.org>; Sun, 6 Jun 2010 12:52:41 -0600
Date: Sun, 6 Jun 2010 14:52:40 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Rupjyoti Sarmah <rsarmah@amcc.com>
Subject: Re: [PATCH]460EX on-chip SATA driver<kernel 2.6.33><resubmission>
Message-ID: <20100606185240.GD7801@zod.rchland.ibm.com>
References: <201006041226.o54CQH2V017366@amcc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201006041226.o54CQH2V017366@amcc.com>
Cc: linux-ide@vger.kernel.org, sr@denx.de, jgarzik@pobox.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 04, 2010 at 05:56:17PM +0530, Rupjyoti Sarmah wrote:
>This patch enables the on-chip DWC SATA controller of the AppliedMicro processor 460EX.
>
>Signed-off-by: Rupjyoti Sarmah <rsarmah@appliedmicro.com> 
>Signed-off-by: Mark Miesfeld <mmiesfeld@appliedmicro.com>
>Signed-off-by: Prodyut Hazarika <phazarika@appliedmicro.com>

What does the <kernel 2.6.33> mean in the Subject?

>
>---
> drivers/ata/Kconfig          |    9 +
> drivers/ata/Makefile         |    1 +
> drivers/ata/sata_dwc_460ex.c | 1808 ++++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 1818 insertions(+), 0 deletions(-)
> create mode 100644 drivers/ata/sata_dwc_460ex.c
>
>diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
>index 56c6374..bba7b8a 100644
>--- a/drivers/ata/Kconfig
>+++ b/drivers/ata/Kconfig
>@@ -82,6 +82,15 @@ config SATA_FSL
>
> 	  If unsure, say N.
>
>+config SATA_DWC
>+	tristate "DesignWare Cores SATA support"
>+	depends on 460EX
>+	help
>+	  This option enables support for the on-chip SATA controller of the
>+	  AppliedMicro processor 460EX.
>+
>+	  If unsure, say N.
>+
> config ATA_SFF
> 	bool "ATA SFF support"
> 	default y
>diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
>index fc936d4..96ff315 100644
>--- a/drivers/ata/Makefile
>+++ b/drivers/ata/Makefile
>@@ -19,6 +19,7 @@ obj-$(CONFIG_SATA_INIC162X)	+= sata_inic162x.o
> obj-$(CONFIG_PDC_ADMA)		+= pdc_adma.o
> obj-$(CONFIG_SATA_FSL)		+= sata_fsl.o
> obj-$(CONFIG_PATA_MACIO)	+= pata_macio.o
>+obj-$(CONFIG_SATA_DWC)		+= sata_dwc_460ex.o
>
> obj-$(CONFIG_PATA_ALI)		+= pata_ali.o
> obj-$(CONFIG_PATA_AMD)		+= pata_amd.o
>diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
>new file mode 100644
>index 0000000..e6e2896
>--- /dev/null
>+++ b/drivers/ata/sata_dwc_460ex.c
>@@ -0,0 +1,1808 @@
>+/*
>+ * drivers/ata/sata_dwc_460ex.c
>+ *
>+ * Synopsys DesignWare Cores (DWC) SATA host driver
>+ *
>+ * Author: Mark Miesfeld <mmiesfeld@amcc.com>
>+ *
>+ * Ported from 2.6.19.2 to 2.6.25/26 by Stefan Roese <sr@denx.de>
>+ * Copyright 2008 DENX Software Engineering

I'm pretty sure Denx uses Signed-off-by lines in their trees.  If you've ported
it from their tree, perhaps you should keep Stefan's S-o-b line intact.

>+/******************************************************************************
>+ * Function: get_burst_length_encode
>+ * arguments: datalength: length in bytes of data
>+ * returns value to be programmed in register corrresponding to data length
>+ * This value is effectively the log(base 2) of the length
>+ *****************************************************************************/
>+static  int get_burst_length_encode(int datalength)
>+{
>+	int items = datalength >> 2;	/* div by 4 to get lword count */

A minor suggestion, but if you're going to document the interfaces this way
you might want to go ahead and use KernelDoc.  It's pretty close to what you 
have already.

josh
