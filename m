Return-Path: <B15061@freescale.com>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
	[213.199.154.206])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9E924B712E
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Nov 2010 22:46:28 +1100 (EST)
Received: from mail47-am1 (localhost.localdomain [127.0.0.1])	by
	mail47-am1-R.bigfish.com (Postfix) with ESMTP id 50C00E783DC	for
	<linuxppc-dev@ozlabs.org>; Fri, 12 Nov 2010 11:31:00 +0000 (UTC)
Received: from AM1EHSMHS012.bigfish.com (unknown [10.3.201.252])	by
	mail47-am1.bigfish.com (Postfix) with ESMTP id C55F51320051	for
	<linuxppc-dev@ozlabs.org>; Fri, 12 Nov 2010 11:30:58 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id oACBUrZb020466	for <linuxppc-dev@ozlabs.org>;
	Fri, 12 Nov 2010 04:30:54 -0700 (MST)
Received: from az33exm21.fsl.freescale.net (az33exm21.am.freescale.net
	[10.64.32.7])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	oACBUrIf028611	for <linuxppc-dev@ozlabs.org>;
	Fri, 12 Nov 2010 05:30:53 -0600 (CST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CB825D.2EDD1000"
Subject: RE: [PATCH] Add Freescale CodeWarrior debug support for kernel
Date: Fri, 12 Nov 2010 04:31:39 -0700
Message-ID: <B6052D7B0439FF40A64DCD3E3F3A3F600285FC@039-SN1MPN1-001.039d.mgd.msft.net>
In-Reply-To: <C621BC63-26DC-4495-B7EE-600D6C565AB9@kernel.crashing.org>
References: <1288255803-10948-1-git-send-email-tie-fei.zang@freescale.com>
	<C621BC63-26DC-4495-B7EE-600D6C565AB9@kernel.crashing.org>
From: Bogdan Adrian-Catalin-B15061 <B15061@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Zang Roy-R61911
	<r61911@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

------_=_NextPart_001_01CB825D.2EDD1000
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hello Kumar,

=20

These changes were added so that the CW debugger would be able to debug
all code in head_fsl_booke.S . I'm not sure why there was an assumption
about TLB entry #8, I guess there was some TLB  mapping remaining in
entry 8 (not sure who set up this mapping though) and some code was
added to mark it invalid so that the debugger would not try to take it
into consideration for converting virtual addresses.=20

=20

Adrian

=20

From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
Sent: Thursday, November 11, 2010 1:51 PM
To: Zang Roy-R61911
Cc: linuxppc-dev@ozlabs.org; Bogdan Adrian-Catalin-B15061
Subject: Re: [PATCH] Add Freescale CodeWarrior debug support for kernel

=20

=20

On Oct 28, 2010, at 3:50 AM, Roy Zang wrote:

> CodeWarrior is popular embedded tools to support debugging Powerpc.
> This patch adds Freescale CodeWarrior debug support for Linux kernel
on
> 85xx/QorIQ platform.
>
> Signed-off-by: Bogdan Adrin <drian.bogdan@freescale.com>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> ---
> arch/powerpc/Kconfig.debug                    |    8 ++++++++
> arch/powerpc/Makefile                         |    5 +++++
> arch/powerpc/include/asm/reg_booke.h          |    4 ++++
> arch/powerpc/kernel/fsl_booke_entry_mapping.S |    3 +++
> arch/powerpc/kernel/head_fsl_booke.S          |   11 +++++++++--
> arch/powerpc/kernel/idle.c                    |    5 ++++-
> 6 files changed, 33 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> index 2d38a50..eedd2ac 100644
> --- a/arch/powerpc/Kconfig.debug
> +++ b/arch/powerpc/Kconfig.debug
> @@ -153,6 +153,14 @@ config BDI_SWITCH
>         Unless you are intending to debug the kernel with one of these
>         machines, say N here.
>
> +config DEBUG_CODEWARRIOR
> +     bool "Include CodeWarrior kernel debugging"
> +     depends on DEBUG_KERNEL && PPC32
> +     help
> +       Say Y here to include CodeWarrior kernel debugging option
> +       Unless you are intending to debug the kernel with one of these
> +       machines, say N here.
> +
> config BOOTX_TEXT
>       bool "Support for early boot text console (BootX or OpenFirmware
only)"
>       depends on PPC_OF && PPC_BOOK3S
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index b7212b6..d3050e6 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -121,6 +121,11 @@ KBUILD_CFLAGS    +=3D $(call
cc-option,-fno-dwarf2-cfi-asm)
> # often slow when they are implemented at all
> KBUILD_CFLAGS         +=3D -mno-string
>
> +ifeq ($(CONFIG_DEBUG_CODEWARRIOR),y)
> +CFLAGS +=3D -g2 -gdwarf-2
> +AFLAGS_KERNEL +=3D -Wa,-gdwarf2
> +endif
> +
> ifeq ($(CONFIG_6xx),y)
> KBUILD_CFLAGS         +=3D -mcpu=3Dpowerpc
> endif
> diff --git a/arch/powerpc/include/asm/reg_booke.h
b/arch/powerpc/include/asm/reg_booke.h
> index 667a498..ac65fcd 100644
> --- a/arch/powerpc/include/asm/reg_booke.h
> +++ b/arch/powerpc/include/asm/reg_booke.h
> @@ -35,7 +35,11 @@
> #define MSR_KERNEL    (MSR_ME|MSR_RI|MSR_IR|MSR_DR|MSR_CE)
> #define MSR_USER      (MSR_KERNEL|MSR_PR|MSR_EE)
> #else
> +#if defined(CONFIG_DEBUG_CODEWARRIOR)
> +#define MSR_KERNEL   (MSR_ME|MSR_RI|MSR_CE|MSR_DE)
> +#else
> #define MSR_KERNEL    (MSR_ME|MSR_RI|MSR_CE)
> +#endif
> #define MSR_USER      (MSR_KERNEL|MSR_PR|MSR_EE)
> #endif
>
> diff --git a/arch/powerpc/kernel/fsl_booke_entry_mapping.S
b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
> index a92c79b..9102aa7 100644
> --- a/arch/powerpc/kernel/fsl_booke_entry_mapping.S
> +++ b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
> @@ -116,6 +116,9 @@ skpinv:   addi    r6,r6,1
/* Increment */
>
>       xori    r6,r4,1
>       slwi    r6,r6,5         /* setup new context with other address
space */
> +#if defined(CONFIG_DEBUG_CODEWARRIOR)
> +     ori     r6, r6, 0x200   /* enable DE bit for MSR */

Can we use MSR_DE@l instead of 0x200

> +#endif
>       bl      1f              /* Find our address */
> 1:    mflr    r9
>       rlwimi  r7,r9,0,20,31
> diff --git a/arch/powerpc/kernel/head_fsl_booke.S
b/arch/powerpc/kernel/head_fsl_booke.S
> index 529b817..9962d09 100644
> --- a/arch/powerpc/kernel/head_fsl_booke.S
> +++ b/arch/powerpc/kernel/head_fsl_booke.S
> @@ -21,7 +21,7 @@
>  *            debbie_chu@mvista.com
>  *    Copyright 2002-2004 MontaVista Software, Inc.
>  *    PowerPC 44x support, Matt Porter <mporter@kernel.crashing.org>
> - *    Copyright 2004 Freescale Semiconductor, Inc
> + *    Copyright 2004,2010 Freescale Semiconductor, Inc
>  *    PowerPC e500 modifications, Kumar Gala
<galak@kernel.crashing.org>
>  *
>  * This program is free software; you can redistribute  it and/or
modify it
> @@ -135,7 +135,7 @@ _ENTRY(__early_start)
>       mtspr   SPRN_HID0, r2
> #endif
>
> -#if !defined(CONFIG_BDI_SWITCH)
> +#if !defined(CONFIG_BDI_SWITCH) && !defined(CONFIG_DEBUG_CODEWARRIOR)
>       /*
>        * The Abatron BDI JTAG debugger does not tolerate others
>        * mucking with the debug registers.
> @@ -197,6 +197,13 @@ _ENTRY(__early_start)
> /*
>  * Decide what sort of machine this is and initialize the MMU.
>  */
> +#if defined(CONFIG_DEBUG_CODEWARRIOR)
> +     lis     r10, 0x1008 /* clear the V bit from the L2MMU_CAM8
register */

why do we need this code?  It seems pretty fragile if its assuming
something about TLB entry #8

> +     mtspr   SPRN_MAS0, r10
> +     lis     r10, 0x0
> +     mtspr   SPRN_MAS1, r10
> +     tlbwe
> +#endif
>       mr      r3,r31
>       mr      r4,r30
>       mr      r5,r29
> diff --git a/arch/powerpc/kernel/idle.c b/arch/powerpc/kernel/idle.c
> index 39a2baa..83fb019 100644
> --- a/arch/powerpc/kernel/idle.c
> +++ b/arch/powerpc/kernel/idle.c
> @@ -73,8 +73,11 @@ void cpu_idle(void)
>                               stop_critical_timings();
>
>                               /* check again after disabling irqs */
> -                             if (!need_resched() &&
!cpu_should_die())
> +                             if (!need_resched() &&
!cpu_should_die()) {
> +#if !defined(CONFIG_DEBUG_CODEWARRIOR)
>                                       ppc_md.power_save();
> +#endif
> +                             }
>
>                               start_critical_timings();
>
> --
> 1.5.6.5
>




------_=_NextPart_001_01CB825D.2EDD1000
Content-Type: text/html; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<title>Re: [PATCH] Add Freescale CodeWarrior debug support for =
kernel</title>
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p
	{mso-style-priority:99;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DWordSection1>

<p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'>Hello Kumar,<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'>These changes were added so that the CW debugger would be =
able
to debug all code in head_fsl_booke.S . I&#8217;m not sure why there was =
an
assumption about TLB entry #8, I guess there was some TLB&nbsp; mapping =
remaining in
entry 8 (not sure who set up this mapping though) and some code was =
added to
mark it invalid so that the debugger would not try to take it into
consideration for converting virtual addresses. <o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'>Adrian<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<div>

<div style=3D'border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt =
0in 0in 0in'>

<p class=3DMsoNormal><b><span =
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'>From:</span>=
</b><span
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'> Kumar Gala
[mailto:galak@kernel.crashing.org] <br>
<b>Sent:</b> Thursday, November 11, 2010 1:51 PM<br>
<b>To:</b> Zang Roy-R61911<br>
<b>Cc:</b> linuxppc-dev@ozlabs.org; Bogdan Adrian-Catalin-B15061<br>
<b>Subject:</b> Re: [PATCH] Add Freescale CodeWarrior debug support for =
kernel<o:p></o:p></span></p>

</div>

</div>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p style=3D'margin-bottom:12.0pt'><span style=3D'font-size:10.0pt'>On =
Oct 28, 2010,
at 3:50 AM, Roy Zang wrote:<br>
<br>
&gt; CodeWarrior is popular embedded tools to support debugging =
Powerpc.<br>
&gt; This patch adds Freescale CodeWarrior debug support for Linux =
kernel on<br>
&gt; 85xx/QorIQ platform.<br>
&gt;<br>
&gt; Signed-off-by: Bogdan Adrin &lt;drian.bogdan@freescale.com&gt;<br>
&gt; Signed-off-by: Roy Zang &lt;tie-fei.zang@freescale.com&gt;<br>
&gt; ---<br>
&gt;
arch/powerpc/Kconfig.debug&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
|&nbsp;&nbsp;&nbsp; 8 ++++++++<br>
&gt;
arch/powerpc/Makefile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;
|&nbsp;&nbsp;&nbsp; 5 +++++<br>
&gt; =
arch/powerpc/include/asm/reg_booke.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;
|&nbsp;&nbsp;&nbsp; 4 ++++<br>
&gt; arch/powerpc/kernel/fsl_booke_entry_mapping.S |&nbsp;&nbsp;&nbsp; 3 =
+++<br>
&gt;
arch/powerpc/kernel/head_fsl_booke.S&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;
|&nbsp;&nbsp; 11 +++++++++--<br>
&gt;
arch/powerpc/kernel/idle.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
|&nbsp;&nbsp;&nbsp; 5 ++++-<br>
&gt; 6 files changed, 33 insertions(+), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/arch/powerpc/Kconfig.debug =
b/arch/powerpc/Kconfig.debug<br>
&gt; index 2d38a50..eedd2ac 100644<br>
&gt; --- a/arch/powerpc/Kconfig.debug<br>
&gt; +++ b/arch/powerpc/Kconfig.debug<br>
&gt; @@ -153,6 +153,14 @@ config BDI_SWITCH<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; Unless you are intending to =
debug
the kernel with one of these<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; machines, say N here.<br>
&gt;<br>
&gt; +config DEBUG_CODEWARRIOR<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; bool &quot;Include CodeWarrior kernel
debugging&quot;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; depends on DEBUG_KERNEL &amp;&amp; =
PPC32<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; help<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; Say Y here to include CodeWarrior =
kernel
debugging option<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; Unless you are intending to debug =
the
kernel with one of these<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; machines, say N here.<br>
&gt; +<br>
&gt; config BOOTX_TEXT<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool &quot;Support for early boot =
text
console (BootX or OpenFirmware only)&quot;<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on PPC_OF &amp;&amp; =
PPC_BOOK3S<br>
&gt; diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile<br>
&gt; index b7212b6..d3050e6 100644<br>
&gt; --- a/arch/powerpc/Makefile<br>
&gt; +++ b/arch/powerpc/Makefile<br>
&gt; @@ -121,6 +121,11 @@ KBUILD_CFLAGS&nbsp;&nbsp;&nbsp; +=3D $(call
cc-option,-fno-dwarf2-cfi-asm)<br>
&gt; # often slow when they are implemented at all<br>
&gt; KBUILD_CFLAGS &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +=3D =
-mno-string<br>
&gt;<br>
&gt; +ifeq ($(CONFIG_DEBUG_CODEWARRIOR),y)<br>
&gt; +CFLAGS +=3D -g2 -gdwarf-2<br>
&gt; +AFLAGS_KERNEL +=3D -Wa,-gdwarf2<br>
&gt; +endif<br>
&gt; +<br>
&gt; ifeq ($(CONFIG_6xx),y)<br>
&gt; KBUILD_CFLAGS &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +=3D =
-mcpu=3Dpowerpc<br>
&gt; endif<br>
&gt; diff --git a/arch/powerpc/include/asm/reg_booke.h
b/arch/powerpc/include/asm/reg_booke.h<br>
&gt; index 667a498..ac65fcd 100644<br>
&gt; --- a/arch/powerpc/include/asm/reg_booke.h<br>
&gt; +++ b/arch/powerpc/include/asm/reg_booke.h<br>
&gt; @@ -35,7 +35,11 @@<br>
&gt; #define MSR_KERNEL&nbsp;&nbsp;&nbsp; =
(MSR_ME|MSR_RI|MSR_IR|MSR_DR|MSR_CE)<br>
&gt; #define MSR_USER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(MSR_KERNEL|MSR_PR|MSR_EE)<br>
&gt; #else<br>
&gt; +#if defined(CONFIG_DEBUG_CODEWARRIOR)<br>
&gt; +#define MSR_KERNEL&nbsp;&nbsp; (MSR_ME|MSR_RI|MSR_CE|MSR_DE)<br>
&gt; +#else<br>
&gt; #define MSR_KERNEL&nbsp;&nbsp;&nbsp; (MSR_ME|MSR_RI|MSR_CE)<br>
&gt; +#endif<br>
&gt; #define MSR_USER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(MSR_KERNEL|MSR_PR|MSR_EE)<br>
&gt; #endif<br>
&gt;<br>
&gt; diff --git a/arch/powerpc/kernel/fsl_booke_entry_mapping.S
b/arch/powerpc/kernel/fsl_booke_entry_mapping.S<br>
&gt; index a92c79b..9102aa7 100644<br>
&gt; --- a/arch/powerpc/kernel/fsl_booke_entry_mapping.S<br>
&gt; +++ b/arch/powerpc/kernel/fsl_booke_entry_mapping.S<br>
&gt; @@ -116,6 +116,9 @@ skpinv:&nbsp;&nbsp; addi&nbsp;&nbsp;&nbsp; =
r6,r6,1
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Increment */<br>
&gt;<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xori&nbsp;&nbsp;&nbsp; r6,r4,1<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; slwi&nbsp;&nbsp;&nbsp; r6,r6,5
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* setup new context with =
other
address space */<br>
&gt; +#if defined(CONFIG_DEBUG_CODEWARRIOR)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ori&nbsp;&nbsp;&nbsp;&nbsp; r6, r6,
0x200&nbsp;&nbsp; /* enable DE bit for MSR */<br>
<br>
Can we use MSR_DE@l instead of 0x200<br>
<br>
&gt; +#endif<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
1f&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*
Find our address */<br>
&gt; 1:&nbsp;&nbsp;&nbsp; mflr&nbsp;&nbsp;&nbsp; r9<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rlwimi&nbsp; r7,r9,0,20,31<br>
&gt; diff --git a/arch/powerpc/kernel/head_fsl_booke.S
b/arch/powerpc/kernel/head_fsl_booke.S<br>
&gt; index 529b817..9962d09 100644<br>
&gt; --- a/arch/powerpc/kernel/head_fsl_booke.S<br>
&gt; +++ b/arch/powerpc/kernel/head_fsl_booke.S<br>
&gt; @@ -21,7 +21,7 @@<br>
&gt;&nbsp; *&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
debbie_chu@mvista.com<br>
&gt;&nbsp; *&nbsp;&nbsp;&nbsp; Copyright 2002-2004 MontaVista Software, =
Inc.<br>
&gt;&nbsp; *&nbsp;&nbsp;&nbsp; PowerPC 44x support, Matt Porter
&lt;mporter@kernel.crashing.org&gt;<br>
&gt; - *&nbsp;&nbsp;&nbsp; Copyright 2004 Freescale Semiconductor, =
Inc<br>
&gt; + *&nbsp;&nbsp;&nbsp; Copyright 2004,2010 Freescale Semiconductor, =
Inc<br>
&gt;&nbsp; *&nbsp;&nbsp;&nbsp; PowerPC e500 modifications, Kumar Gala
&lt;galak@kernel.crashing.org&gt;<br>
&gt;&nbsp; *<br>
&gt;&nbsp; * This program is free software; you can redistribute&nbsp; =
it
and/or modify it<br>
&gt; @@ -135,7 +135,7 @@ _ENTRY(__early_start)<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mtspr&nbsp;&nbsp; SPRN_HID0, r2<br>
&gt; #endif<br>
&gt;<br>
&gt; -#if !defined(CONFIG_BDI_SWITCH)<br>
&gt; +#if !defined(CONFIG_BDI_SWITCH) &amp;&amp;
!defined(CONFIG_DEBUG_CODEWARRIOR)<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * The Abatron BDI JTAG =
debugger does
not tolerate others<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * mucking with the debug =
registers.<br>
&gt; @@ -197,6 +197,13 @@ _ENTRY(__early_start)<br>
&gt; /*<br>
&gt;&nbsp; * Decide what sort of machine this is and initialize the =
MMU.<br>
&gt;&nbsp; */<br>
&gt; +#if defined(CONFIG_DEBUG_CODEWARRIOR)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; lis&nbsp;&nbsp;&nbsp;&nbsp; r10, 0x1008 =
/* clear
the V bit from the L2MMU_CAM8 register */<br>
<br>
why do we need this code?&nbsp; It seems pretty fragile if its assuming
something about TLB entry #8<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mtspr&nbsp;&nbsp; SPRN_MAS0, r10<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; lis&nbsp;&nbsp;&nbsp;&nbsp; r10, 0x0<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mtspr&nbsp;&nbsp; SPRN_MAS1, r10<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; tlbwe<br>
&gt; +#endif<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
r3,r31<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
r4,r30<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
r5,r29<br>
&gt; diff --git a/arch/powerpc/kernel/idle.c =
b/arch/powerpc/kernel/idle.c<br>
&gt; index 39a2baa..83fb019 100644<br>
&gt; --- a/arch/powerpc/kernel/idle.c<br>
&gt; +++ b/arch/powerpc/kernel/idle.c<br>
&gt; @@ -73,8 +73,11 @@ void cpu_idle(void)<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stop_critical_timings();<br>
&gt;<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* check again after =
disabling irqs
*/<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!need_resched() =
&amp;&amp;
!cpu_should_die())<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!need_resched() =
&amp;&amp;
!cpu_should_die()) {<br>
&gt; +#if !defined(CONFIG_DEBUG_CODEWARRIOR)<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ppc_md.power_save();<br>
&gt; +#endif<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start_critical_timings();<br>
&gt;<br>
&gt; --<br>
&gt; 1.5.6.5<br>
&gt;<br>
<br>
</span><o:p></o:p></p>

</div>

</body>

</html>

------_=_NextPart_001_01CB825D.2EDD1000--
