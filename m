Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C7B3CB70A3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  9 Oct 2010 00:35:16 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e37.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o98DX58P016817
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Oct 2010 07:33:05 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o98DZChD064158
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Oct 2010 07:35:12 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o98DZCsM007744
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Oct 2010 07:35:12 -0600
Date: Fri, 8 Oct 2010 09:35:11 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Victor Gallardo <vgallardo@apm.com>
Subject: Re: [PATCH 1/3] Powerpc/4xx: Add suspend and idle support
Message-ID: <20101008133511.GA10590@zod.rchland.ibm.com>
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
>Add suspend/resume support for all 4xx compatible CPUs.
>See /sys/power/state for available power states configured in.
>
>Add two different idle states (idle-wait and idle-doze)
>controlled via sysfs. Default is idle-wait.
>	cat /sys/devices/system/cpu/cpu0/idle
>	[wait] doze
>
>To save additional power, use idle-doze.
>	echo doze > /sys/devices/system/cpu/cpu0/idle
>	cat /sys/devices/system/cpu/cpu0/idle
>	wait [doze]
>
>Signed-off-by: Victor Gallardo <vgallardo@apm.com>
>---
> Documentation/powerpc/dts-bindings/4xx/cpm.txt |   43 +++
> arch/powerpc/Kconfig                           |   13 +-
> arch/powerpc/platforms/44x/Makefile            |    5 +-
> arch/powerpc/sysdev/Makefile                   |    1 +
> arch/powerpc/sysdev/ppc4xx_cpm.c               |  339 ++++++++++++++++++++++++
> 5 files changed, 397 insertions(+), 4 deletions(-)
> create mode 100644 Documentation/powerpc/dts-bindings/4xx/cpm.txt
> create mode 100644 arch/powerpc/sysdev/ppc4xx_cpm.c
>
>diff --git a/Documentation/powerpc/dts-bindings/4xx/cpm.txt b/Documentation/powerpc/dts-bindings/4xx/cpm.txt
>new file mode 100644
>index 0000000..9635df8
>--- /dev/null
>+++ b/Documentation/powerpc/dts-bindings/4xx/cpm.txt
>@@ -0,0 +1,43 @@
>+PPC4xx Clock Power Management (CPM) node
>+
>+Required properties:
>+	- compatible		: compatible list, currently only "ibm,cpm"
>+	- dcr-access-method	: "native"
>+	- dcr-reg		: < DCR register range >
>+
>+Optional properties:
>+	- er-offset		: All 4xx SoCs with a CPM controller have
>+				  one of two different order for the CPM
>+				  registers. Some have the CPM registers
>+				  in the following order (ER,FR,SR). The
>+				  others have them in the following order
>+				  (SR,ER,FR). For the second case set
>+				  er-offset = <1>.
>+	- unused-units		: specifier consist of one cell. For each
>+				  bit in the cell, the corresponding bit
>+				  in CPM will be set to turn off unused
>+				  devices.
>+	- idle-doze		: specifier consist of one cell. For each
>+				  bit in the cell, the corresponding bit
>+				  in CPM will be set to turn off unused
>+				  devices. This is usually just CPM[CPU].
>+	- standby		: specifier consist of one cell. For each
>+				  bit in the cell, the corresponding bit
>+				  in CPM will be set on standby and
>+				  restored on resume.
>+	- suspend		: specifier consist of one cell. For each
>+				  bit in the cell, the corresponding bit
>+				  in CPM will be set on suspend (mem) and
>+				  restored on resume.

So the difference, from what I can tell, between standby and suspend is
really only what devices are turned off.  I don't see any code to put
the DRAM into self-refresh mode, etc.  If that is the case, perhaps we
could add a bit of description as to the different kinds of devices that
may be disabled in one mode but not the other.

>+
>+Example:
>+        CPM0: cpm {
>+                compatible = "ibm,cpm";
>+                dcr-access-method = "native";
>+                dcr-reg = <0x160 0x003>;
>+		er-offset = <0>;
>+                unused-units = <0x00000100>;
>+                idle-doze = <0x02000000>;
>+                standby = <0xfeff0000>;
>+                standby = <0xfeff791d>;

One of these two should be illustrating suspend.

josh
