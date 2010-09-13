Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BF128B6EFF
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Sep 2010 23:54:16 +1000 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8DDZPA3023045
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Sep 2010 09:35:25 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8DDsDY0322522
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Sep 2010 09:54:13 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o8DDsCq1031836
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Sep 2010 10:54:12 -0300
Date: Mon, 13 Sep 2010 09:54:10 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: tmarri@apm.com
Subject: Re: [PATCH v1] APM821xx: Add support for new SoC APM821xx
Message-ID: <20100913135410.GB31548@zod.rchland.ibm.com>
References: <1284143257-15993-1-git-send-email-tmarri@apm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1284143257-15993-1-git-send-email-tmarri@apm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 10, 2010 at 11:27:37AM -0700, tmarri@apm.com wrote:
>From: Tirumala Marri <tmarri@apm.com>
>
>This patch adds CPU, device tree, defconfig and bluestone board
>support for APM821xx SoC.
>
>Signed-off-by: Tirumala R Marri <tmarri@apm.com>
>+	cpus {
>+		#address-cells = <1>;
>+		#size-cells = <0>;
>+
>+		cpu@0 {
>+			device_type = "cpu";
>+		model = "PowerPC,464";

Let's just keep this as it was in your first patch for now.  See why in
later comments.  (Also, the whitespace is odd here anyway.)

>+			reg = <0x00000000>;
>+			clock-frequency = <0>; /* Filled in by U-Boot */

Out of curiosity, which version of U-Boot has (or will have) this support?

>diff --git a/arch/powerpc/configs/44x/bluestone_defconfig b/arch/powerpc/configs/44x/bluestone_defconfig
>new file mode 100644
>index 0000000..ac65b48
>--- /dev/null
>+++ b/arch/powerpc/configs/44x/bluestone_defconfig

This defconfig is much better.  Thanks.

>diff --git a/arch/powerpc/kernel/cpu_setup_44x.S b/arch/powerpc/kernel/cpu_setup_44x.S
>index 7d606f8..549f482 100644
>--- a/arch/powerpc/kernel/cpu_setup_44x.S
>+++ b/arch/powerpc/kernel/cpu_setup_44x.S
>@@ -35,6 +35,7 @@ _GLOBAL(__setup_cpu_440grx)
> _GLOBAL(__setup_cpu_460ex)
> _GLOBAL(__setup_cpu_460gt)
> _GLOBAL(__setup_cpu_460sx)
>+_GLOBAL(__setup_cpu_464)
> 	mflr	r4
> 	bl	__init_fpu_44x
> 	bl	__fixup_440A_mcheck

This doesn't look correct.  Not all 464 cores will have an FPU.
Additionally, if this were correct then you could just replace all of
the 460xx setup functions with a single one instead of adding one for
464 cores and ignoring those.

>diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
>index 1f9123f..89e55b1 100644
>--- a/arch/powerpc/kernel/cputable.c
>+++ b/arch/powerpc/kernel/cputable.c
>@@ -48,6 +48,7 @@ extern void __setup_cpu_440x5(unsigned long offset, struct cpu_spec* spec);
> extern void __setup_cpu_460ex(unsigned long offset, struct cpu_spec* spec);
> extern void __setup_cpu_460gt(unsigned long offset, struct cpu_spec* spec);
> extern void __setup_cpu_460sx(unsigned long offset, struct cpu_spec *spec);
>+extern void __setup_cpu_464(unsigned long offset, struct cpu_spec *spec);
> extern void __setup_cpu_603(unsigned long offset, struct cpu_spec* spec);
> extern void __setup_cpu_604(unsigned long offset, struct cpu_spec* spec);
> extern void __setup_cpu_750(unsigned long offset, struct cpu_spec* spec);
>@@ -1805,6 +1806,20 @@ static struct cpu_spec __initdata cpu_specs[] = {
> 		.machine_check		= machine_check_440A,
> 		.platform		= "ppc440",
> 	},
>+	{ /* 464 in APM821xx */
>+		.pvr_mask		= 0xffffff00,
>+		.pvr_value		= 0x12C41C80,
>+		.cpu_name		= "464 in APM821xx",

That's a bit of an odd cpu_name.  Let's just stick with the SoC name for
this, as the PVR really identifies the SoC on 4xx, not the core.  I'd
suggest just creating the __setup_cpu_apm821xx function for now.  We can
sort out how to break out the 4xx core inside the SoC later.

josh
