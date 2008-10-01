Return-Path: <jwboyer@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by ozlabs.org (Postfix) with ESMTP id E2628DDE1B
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2008 04:09:49 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m33so344287wag.9
	for <linuxppc-dev@ozlabs.org>; Wed, 01 Oct 2008 11:09:48 -0700 (PDT)
Date: Wed, 1 Oct 2008 14:08:35 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Niklaus Giger <niklaus.giger@member.fsf.org>
Subject: Re: [PATCH] Added preliminary support for Netstal HCU4 board
Message-ID: <20081001180835.GA7601@yoda.jdub.homelinux.org>
References: <200810011947.16543.niklaus.giger@member.fsf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200810011947.16543.niklaus.giger@member.fsf.org>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 01, 2008 at 07:47:16PM +0200, Niklaus Giger wrote:
>Adds preliminary support for a HCU4 PPC405GPr based board from
>Netstal Maschinen AG.
>
>For the last 3 years I have been the only user running Linux on this board, 
>but it served me well as testbed for the xenomai realtime extension to the 
>Linux kernel.

Overall, really nice for a first submission.

>Patch against the  git://www.denx.de/git/linux-2.6-denx.git

Can you rebase against:

git://git.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git next

?

>diff --git a/arch/powerpc/boot/dts/hcu4.dts b/arch/powerpc/boot/dts/hcu4.dts
>new file mode 100644
>index 0000000..a954165
>--- /dev/null
>+++ b/arch/powerpc/boot/dts/hcu4.dts
>@@ -0,0 +1,175 @@
>+/*
>+ * Device Tree Source for Netstal Maschinen HCU4
>+ * based on the IBM Walnut

<snip>

We want dts-v1 files in the kernel now.  It's a much
cleaner represenation.  See the DTS files in the git repo
I pointed to above for examples.  I think there are 
conversion scripts as well.

>+/ {
>+	#address-cells = <1>;
>+	#size-cells = <1>;
>+	model = "ibm,hcu4";
>+	compatible = "ibm,hcu4";

These shouldn't be "ibm,hcu4".  IBM didn't make these boards.
Instead, you should make them "<company>,<board>", where
<company> is the company that made them (often the stock ticker
is used), and <board> is obviously hcu4 in this case.

>+	dcr-parent = <&/cpus/cpu@0>;
>+
>+	aliases {
>+		ethernet0 = &EMAC;
>+		serial0 = &UART0;
>+	};
>+
>+	cpus {
>+		#address-cells = <1>;
>+		#size-cells = <0>;
>+
>+		cpu@0 {
>+			device_type = "cpu";
>+			model = "PowerPC,405GPr";
>+			reg = <0>;
>+			clock-frequency = <bebc200>; /* Filled in by zImage */

Still filled in, or is the comment bogus now?

<snip>

>diff --git a/arch/powerpc/platforms/40x/Kconfig 
>b/arch/powerpc/platforms/40x/Kconfig
>index a9260e2..3bf4eb5 100644
>--- a/arch/powerpc/platforms/40x/Kconfig
>+++ b/arch/powerpc/platforms/40x/Kconfig
>@@ -23,6 +23,14 @@ config EP405
> 	help
> 	  This option enables support for the EP405/EP405PC boards.
> 
>+config HCU4
>+	bool "Hcu4"
>+	depends on 40x
>+	default y
>+	select 405GPr

I think this should have been:

select 405GPR

<snip>

>diff --git a/arch/ppc/platforms/4xx/hcu4.h b/arch/ppc/platforms/4xx/hcu4.h
>new file mode 100644
>index 0000000..c05a825
>--- /dev/null
>+++ b/arch/ppc/platforms/4xx/hcu4.h

arch/ppc doesn't exist anymore.  You can drop this file entirely.

<snip>

>diff --git a/include/asm-ppc/ibm4xx.h b/include/asm-ppc/ibm4xx.h
>index f56f1f8..71507c6 100644
>--- a/include/asm-ppc/ibm4xx.h
>+++ b/include/asm-ppc/ibm4xx.h

Same comment as above.

josh
