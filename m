Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E5E2AB70B8
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  9 Oct 2010 00:46:06 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o98DVDoi020028
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Oct 2010 09:31:13 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o98Dk2oI130344
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Oct 2010 09:46:02 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o98Dk1Pc008627
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Oct 2010 07:46:02 -0600
Date: Fri, 8 Oct 2010 09:46:00 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Victor Gallardo <vgallardo@apm.com>
Subject: Re: [PATCH 1/3] Powerpc/4xx: Add suspend and idle support
Message-ID: <20101008134600.GB10590@zod.rchland.ibm.com>
References: <1286478436-9942-1-git-send-email-vgallardo@apm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1286478436-9942-1-git-send-email-vgallardo@apm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 07, 2010 at 12:07:16PM -0700, Victor Gallardo wrote:

I hit send too soon on my earlier response.  My apologies.

>--- /dev/null
>+++ b/arch/powerpc/sysdev/ppc4xx_cpm.c
>@@ -0,0 +1,339 @@
>+/*
>+ * PowerPC 4xx Clock and Power Management
>+ *
>+ * Copyright (C) 2010, Applied Micro Circuits Corporation
>+ * Victor Gallardo (vgallardo@apm.com)
>+ *
>+ * Based on arch/powerpc/platforms/44x/idle.c:
>+ * Jerone Young <jyoung5@us.ibm.com>
>+ * Copyright 2008 IBM Corp.
>+ *
>+ * Based on arch/powerpc/sysdev/fsl_pmc.c:
>+ * Anton Vorontsov <avorontsov@ru.mvista.com>
>+ * Copyright 2009  MontaVista Software, Inc.
>+ *
>+ * See file CREDITS for list of people who contributed to this
>+ * project.
>+ *
>+ * This program is free software; you can redistribute it and/or
>+ * modify it under the terms of the GNU General Public License as
>+ * published by the Free Software Foundation; either version 2 of
>+ * the License, or (at your option) any later version.
>+ *
>+ * This program is distributed in the hope that it will be useful,
>+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>+ * GNU General Public License for more details.
>+ *
>+ * You should have received a copy of the GNU General Public License
>+ * along with this program; if not, write to the Free Software
>+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
>+ * MA 02111-1307 USA
>+ */
>+
>+#include <linux/kernel.h>
>+#include <linux/of_platform.h>
>+#include <linux/sysfs.h>
>+#include <linux/cpu.h>
>+#include <linux/suspend.h>
>+#include <asm/dcr.h>
>+#include <asm/dcr-native.h>
>+#include <asm/machdep.h>
>+
>+#define CPM_ER	0
>+#define CPM_FR	1
>+#define CPM_SR	2
>+
>+#define CPM_IDLE_WAIT	0
>+#define CPM_IDLE_DOZE	1
>+
>+struct cpm {
>+	dcr_host_t	dcr_host;
>+	unsigned int	dcr_offset[3];
>+	unsigned int	powersave_off;
>+	unsigned int	unused;
>+	unsigned int	idle_doze;
>+	unsigned int	standby;
>+	unsigned int	suspend;
>+};
>+
>+static struct cpm cpm;
>+
>+struct cpm_idle_mode {
>+	unsigned int enabled;
>+	const char  *name;
>+};
>+
>+static struct cpm_idle_mode idle_mode[] = {
>+	[CPM_IDLE_WAIT] = { 1, "wait" }, /* default */
>+	[CPM_IDLE_DOZE] = { 0, "doze" },
>+};
>+
>+static void cpm_set(unsigned int cpm_reg, unsigned int mask)
>+{
>+	unsigned int value;
>+
>+	value = dcr_read(cpm.dcr_host, cpm.dcr_offset[cpm_reg]);
>+	value |= mask;
>+	dcr_write(cpm.dcr_host, cpm.dcr_offset[cpm_reg], value);
>+}

This doesn't seem to do any sort of verification that the class 2 and
class 3 devices actually got disabled.  Or at least I don't see where we
verify anything in the SR.

Maybe in practice it doesn't matter, but we should add a comment that say
we just expect them to eventually go off when they can.

>+
>+static void cpm_idle_wait(void)
>+{
>+	unsigned long msr_save;
>+
>+	/* save off initial state */
>+	msr_save = mfmsr();
>+	/* sync required when CPM0_ER[CPU] is set */
>+	mb();
>+	/* set wait state MSR */
>+	mtmsr(msr_save|MSR_WE|MSR_EE|MSR_CE|MSR_DE);
>+	isync();
>+	/* return to initial state */
>+	mtmsr(msr_save);
>+	isync();
>+}
>+
>+static void cpm_idle_sleep(unsigned int mask)
>+{
>+	unsigned int er_save;
>+
>+	/* update CPM_ER state */
>+	er_save = dcr_read(cpm.dcr_host, cpm.dcr_offset[CPM_ER]);
>+	dcr_write(cpm.dcr_host, cpm.dcr_offset[CPM_ER],
>+		  er_save | mask);
>+
>+	/* go to wait state */
>+	cpm_idle_wait();
>+
>+	/* restore CPM_ER state */
>+	dcr_write(cpm.dcr_host, cpm.dcr_offset[CPM_ER], er_save);
>+}

For my clarification, the CPU is a class 2 device and we expect that the
logic between the CPU and the CPM allows us to do the write to make it
sleep, but not actually sleep until we set the idle state?

josh
