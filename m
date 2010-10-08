Return-Path: <vgallardo@apm.com>
Received: from exprod5og111.obsmtp.com (exprod5og111.obsmtp.com [64.18.0.22])
	by ozlabs.org (Postfix) with SMTP id 94CF6B70D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  9 Oct 2010 04:38:15 +1100 (EST)
Received: by qwa26 with SMTP id 26so841451qwa.29
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 08 Oct 2010 10:38:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20101008134600.GB10590@zod.rchland.ibm.com>
References: <1286478436-9942-1-git-send-email-vgallardo@apm.com>
	<20101008134600.GB10590@zod.rchland.ibm.com>
Date: Fri, 8 Oct 2010 10:32:19 -0700
Message-ID: <AANLkTi=NoVvC5DmQAVM5Rm-yz-_=hXipKP+x4FRq9Xi+@mail.gmail.com>
Subject: Re: [PATCH 1/3] Powerpc/4xx: Add suspend and idle support
From: Victor Gallardo <vgallardo@apm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 8, 2010 at 6:46 AM, Josh Boyer <jwboyer@linux.vnet.ibm.com> wro=
te:
> On Thu, Oct 07, 2010 at 12:07:16PM -0700, Victor Gallardo wrote:
>
> I hit send too soon on my earlier response. =A0My apologies.
>
>>--- /dev/null
>>+++ b/arch/powerpc/sysdev/ppc4xx_cpm.c
>>@@ -0,0 +1,339 @@
>>+/*
>>+ * PowerPC 4xx Clock and Power Management
>>+ *
>>+ * Copyright (C) 2010, Applied Micro Circuits Corporation
>>+ * Victor Gallardo (vgallardo@apm.com)
>>+ *
>>+ * Based on arch/powerpc/platforms/44x/idle.c:
>>+ * Jerone Young <jyoung5@us.ibm.com>
>>+ * Copyright 2008 IBM Corp.
>>+ *
>>+ * Based on arch/powerpc/sysdev/fsl_pmc.c:
>>+ * Anton Vorontsov <avorontsov@ru.mvista.com>
>>+ * Copyright 2009 =A0MontaVista Software, Inc.
>>+ *
>>+ * See file CREDITS for list of people who contributed to this
>>+ * project.
>>+ *
>>+ * This program is free software; you can redistribute it and/or
>>+ * modify it under the terms of the GNU General Public License as
>>+ * published by the Free Software Foundation; either version 2 of
>>+ * the License, or (at your option) any later version.
>>+ *
>>+ * This program is distributed in the hope that it will be useful,
>>+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>>+ * GNU General Public License for more details.
>>+ *
>>+ * You should have received a copy of the GNU General Public License
>>+ * along with this program; if not, write to the Free Software
>>+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
>>+ * MA 02111-1307 USA
>>+ */
>>+
>>+#include <linux/kernel.h>
>>+#include <linux/of_platform.h>
>>+#include <linux/sysfs.h>
>>+#include <linux/cpu.h>
>>+#include <linux/suspend.h>
>>+#include <asm/dcr.h>
>>+#include <asm/dcr-native.h>
>>+#include <asm/machdep.h>
>>+
>>+#define CPM_ER =A0 =A0 =A0 =A00
>>+#define CPM_FR =A0 =A0 =A0 =A01
>>+#define CPM_SR =A0 =A0 =A0 =A02
>>+
>>+#define CPM_IDLE_WAIT 0
>>+#define CPM_IDLE_DOZE 1
>>+
>>+struct cpm {
>>+ =A0 =A0 =A0dcr_host_t =A0 =A0 =A0dcr_host;
>>+ =A0 =A0 =A0unsigned int =A0 =A0dcr_offset[3];
>>+ =A0 =A0 =A0unsigned int =A0 =A0powersave_off;
>>+ =A0 =A0 =A0unsigned int =A0 =A0unused;
>>+ =A0 =A0 =A0unsigned int =A0 =A0idle_doze;
>>+ =A0 =A0 =A0unsigned int =A0 =A0standby;
>>+ =A0 =A0 =A0unsigned int =A0 =A0suspend;
>>+};
>>+
>>+static struct cpm cpm;
>>+
>>+struct cpm_idle_mode {
>>+ =A0 =A0 =A0unsigned int enabled;
>>+ =A0 =A0 =A0const char =A0*name;
>>+};
>>+
>>+static struct cpm_idle_mode idle_mode[] =3D {
>>+ =A0 =A0 =A0[CPM_IDLE_WAIT] =3D { 1, "wait" }, /* default */
>>+ =A0 =A0 =A0[CPM_IDLE_DOZE] =3D { 0, "doze" },
>>+};
>>+
>>+static void cpm_set(unsigned int cpm_reg, unsigned int mask)
>>+{
>>+ =A0 =A0 =A0unsigned int value;
>>+
>>+ =A0 =A0 =A0value =3D dcr_read(cpm.dcr_host, cpm.dcr_offset[cpm_reg]);
>>+ =A0 =A0 =A0value |=3D mask;
>>+ =A0 =A0 =A0dcr_write(cpm.dcr_host, cpm.dcr_offset[cpm_reg], value);
>>+}
>
> This doesn't seem to do any sort of verification that the class 2 and
> class 3 devices actually got disabled. =A0Or at least I don't see where w=
e
> verify anything in the SR.
>
> Maybe in practice it doesn't matter, but we should add a comment that say
> we just expect them to eventually go off when they can.
>
Yes, you are correct. I will add a comment here.

>>+
>>+static void cpm_idle_wait(void)
>>+{
>>+ =A0 =A0 =A0unsigned long msr_save;
>>+
>>+ =A0 =A0 =A0/* save off initial state */
>>+ =A0 =A0 =A0msr_save =3D mfmsr();
>>+ =A0 =A0 =A0/* sync required when CPM0_ER[CPU] is set */
>>+ =A0 =A0 =A0mb();
>>+ =A0 =A0 =A0/* set wait state MSR */
>>+ =A0 =A0 =A0mtmsr(msr_save|MSR_WE|MSR_EE|MSR_CE|MSR_DE);
>>+ =A0 =A0 =A0isync();
>>+ =A0 =A0 =A0/* return to initial state */
>>+ =A0 =A0 =A0mtmsr(msr_save);
>>+ =A0 =A0 =A0isync();
>>+}
>>+
>>+static void cpm_idle_sleep(unsigned int mask)
>>+{
>>+ =A0 =A0 =A0unsigned int er_save;
>>+
>>+ =A0 =A0 =A0/* update CPM_ER state */
>>+ =A0 =A0 =A0er_save =3D dcr_read(cpm.dcr_host, cpm.dcr_offset[CPM_ER]);
>>+ =A0 =A0 =A0dcr_write(cpm.dcr_host, cpm.dcr_offset[CPM_ER],
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0er_save | mask);
>>+
>>+ =A0 =A0 =A0/* go to wait state */
>>+ =A0 =A0 =A0cpm_idle_wait();
>>+
>>+ =A0 =A0 =A0/* restore CPM_ER state */
>>+ =A0 =A0 =A0dcr_write(cpm.dcr_host, cpm.dcr_offset[CPM_ER], er_save);
>>+}
>
> For my clarification, the CPU is a class 2 device and we expect that the
> logic between the CPU and the CPM allows us to do the write to make it
> sleep, but not actually sleep until we set the idle state?
>

Yes, you are correct again. I will add another comment here to a little
more clear.

> josh
>
