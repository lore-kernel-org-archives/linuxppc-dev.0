Return-Path: <tmarri@apm.com>
Received: from exprod5og108.obsmtp.com (exprod5og108.obsmtp.com [64.18.0.186])
	by ozlabs.org (Postfix) with SMTP id 21952B70AA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Sep 2010 09:01:36 +1000 (EST)
Received: by qwj8 with SMTP id 8so1868946qwj.16
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Sep 2010 16:01:32 -0700 (PDT)
From: Tirumala Marri <tmarri@apm.com>
References: <1284143257-15993-1-git-send-email-tmarri@apm.com>
	<20100913135410.GB31548@zod.rchland.ibm.com>
In-Reply-To: <20100913135410.GB31548@zod.rchland.ibm.com>
MIME-Version: 1.0
Date: Mon, 13 Sep 2010 16:01:34 -0700
Message-ID: <f81c6a225154a8183aed8a3bd2afb2b0@mail.gmail.com>
Subject: RE: [PATCH v1] APM821xx: Add support for new SoC APM821xx
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

> >+			clock-frequency = <0>; /* Filled in by U-Boot */
>
> Out of curiosity, which version of U-Boot has (or will have) this
> support?
[Marri] Currently I am working with u-boot list to accept my patch. It
should
be available as soon as it is accepted.

>
> >diff --git a/arch/powerpc/configs/44x/bluestone_defconfig
> b/arch/powerpc/configs/44x/bluestone_defconfig
> >new file mode 100644
> >index 0000000..ac65b48
> >--- /dev/null
> >+++ b/arch/powerpc/configs/44x/bluestone_defconfig
>
> This defconfig is much better.  Thanks.
>
> >diff --git a/arch/powerpc/kernel/cpu_setup_44x.S
> b/arch/powerpc/kernel/cpu_setup_44x.S
> >index 7d606f8..549f482 100644
> >--- a/arch/powerpc/kernel/cpu_setup_44x.S
> >+++ b/arch/powerpc/kernel/cpu_setup_44x.S
> >@@ -35,6 +35,7 @@ _GLOBAL(__setup_cpu_440grx)
> > _GLOBAL(__setup_cpu_460ex)
> > _GLOBAL(__setup_cpu_460gt)
> > _GLOBAL(__setup_cpu_460sx)
> >+_GLOBAL(__setup_cpu_464)
> > 	mflr	r4
> > 	bl	__init_fpu_44x
> > 	bl	__fixup_440A_mcheck
>
> This doesn't look correct.  Not all 464 cores will have an FPU.
> Additionally, if this were correct then you could just replace all of
> the 460xx setup functions with a single one instead of adding one for
> 464 cores and ignoring those.
[Marri] I reverted back apm821xx in the next patch.

>
> >diff --git a/arch/powerpc/kernel/cputable.c
> b/arch/powerpc/kernel/cputable.c
> >index 1f9123f..89e55b1 100644
> >--- a/arch/powerpc/kernel/cputable.c
> >+++ b/arch/powerpc/kernel/cputable.c
> >@@ -48,6 +48,7 @@ extern void __setup_cpu_440x5(unsigned long offset,
> struct cpu_spec* spec);
> > extern void __setup_cpu_460ex(unsigned long offset, struct cpu_spec*
> spec);
> > extern void __setup_cpu_460gt(unsigned long offset, struct cpu_spec*
> spec);
> > extern void __setup_cpu_460sx(unsigned long offset, struct cpu_spec
> *spec);
> >+extern void __setup_cpu_464(unsigned long offset, struct cpu_spec
> *spec);
> > extern void __setup_cpu_603(unsigned long offset, struct cpu_spec*
> spec);
> > extern void __setup_cpu_604(unsigned long offset, struct cpu_spec*
> spec);
> > extern void __setup_cpu_750(unsigned long offset, struct cpu_spec*
> spec);
> >@@ -1805,6 +1806,20 @@ static struct cpu_spec __initdata cpu_specs[] =
> {
> > 		.machine_check		= machine_check_440A,
> > 		.platform		= "ppc440",
> > 	},
> >+	{ /* 464 in APM821xx */
> >+		.pvr_mask		= 0xffffff00,
> >+		.pvr_value		= 0x12C41C80,
> >+		.cpu_name		= "464 in APM821xx",
>
> That's a bit of an odd cpu_name.  Let's just stick with the SoC name
> for
> this, as the PVR really identifies the SoC on 4xx, not the core.  I'd
> suggest just creating the __setup_cpu_apm821xx function for now.  We
> can
> sort out how to break out the 4xx core inside the SoC later.
[Marri]Sure will do.
