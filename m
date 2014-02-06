Return-Path: <daniel.lezcano@linaro.org>
Received: from mail-vc0-f172.google.com (mail-vc0-f172.google.com
 [209.85.220.172])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A5FDD2C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 03:25:32 +1100 (EST)
Received: by mail-vc0-f172.google.com with SMTP id lf12so1628899vcb.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Feb 2014 08:25:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1391696188-14540-1-git-send-email-nicolas.pitre@linaro.org>
References: <1391696188-14540-1-git-send-email-nicolas.pitre@linaro.org>
Date: Thu, 6 Feb 2014 16:25:29 +0000
Message-ID: <CAKnoXLxCAqKaniGOwegNcOarS4FpoNKDY5PxOhe6j4wdtUAkLQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] PPC: powernv: remove redundant cpuidle_idle_call()
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Content-Type: multipart/alternative; boundary=089e01183fb857fdf004f1bf5202
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Linux ARM Kernel ML <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--089e01183fb857fdf004f1bf5202
Content-Type: text/plain; charset=ISO-8859-1

Hi Nico,


On 6 February 2014 14:16, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:

> The core idle loop now takes care of it.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
>  arch/powerpc/platforms/powernv/setup.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/setup.c
> b/arch/powerpc/platforms/powernv/setup.c
> index 21166f65c9..a932feb290 100644
> --- a/arch/powerpc/platforms/powernv/setup.c
> +++ b/arch/powerpc/platforms/powernv/setup.c
> @@ -26,7 +26,6 @@
>  #include <linux/of_fdt.h>
>  #include <linux/interrupt.h>
>  #include <linux/bug.h>
> -#include <linux/cpuidle.h>
>
>  #include <asm/machdep.h>
>  #include <asm/firmware.h>
> @@ -217,16 +216,6 @@ static int __init pnv_probe(void)
>         return 1;
>  }
>
> -void powernv_idle(void)
> -{
> -       /* Hook to cpuidle framework if available, else
> -        * call on default platform idle code
> -        */
> -       if (cpuidle_idle_call()) {
> -               power7_idle();
> -       }
>

The cpuidle_idle_call is called from arch_cpu_idle in
arch/powerpc/kernel/idle.c between a ppc64_runlatch_off|on section.
Shouldn't the cpuidle-powernv driver call these functions when entering
idle ?

  -- Daniel


> -}
> -
>  define_machine(powernv) {
>         .name                   = "PowerNV",
>         .probe                  = pnv_probe,
> @@ -236,7 +225,7 @@ define_machine(powernv) {
>         .show_cpuinfo           = pnv_show_cpuinfo,
>         .progress               = pnv_progress,
>         .machine_shutdown       = pnv_shutdown,
> -       .power_save             = powernv_idle,
> +       .power_save             = power7_idle,
>         .calibrate_decr         = generic_calibrate_decr,
>  #ifdef CONFIG_KEXEC
>         .kexec_cpu_down         = pnv_kexec_cpu_down,
> --
> 1.8.4.108.g55ea5f6
>
>

--089e01183fb857fdf004f1bf5202
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra">Hi Nico,</div><div class=3D=
"gmail_extra"><br></div><div class=3D"gmail_extra"><div class=3D"gmail_quot=
e"><br></div><div class=3D"gmail_quote">On 6 February 2014 14:16, Nicolas P=
itre <span dir=3D"ltr">&lt;<a href=3D"mailto:nicolas.pitre@linaro.org" targ=
et=3D"_blank">nicolas.pitre@linaro.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">The core idle loop now takes care of it.<br>
<br>
Signed-off-by: Nicolas Pitre &lt;<a href=3D"mailto:nico@linaro.org">nico@li=
naro.org</a>&gt;<br>
---<br>
=A0arch/powerpc/platforms/powernv/setup.c | 13 +------------<br>
=A01 file changed, 1 insertion(+), 12 deletions(-)<br>
<br>
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platform=
s/powernv/setup.c<br>
index 21166f65c9..a932feb290 100644<br>
--- a/arch/powerpc/platforms/powernv/setup.c<br>
+++ b/arch/powerpc/platforms/powernv/setup.c<br>
@@ -26,7 +26,6 @@<br>
=A0#include &lt;linux/of_fdt.h&gt;<br>
=A0#include &lt;linux/interrupt.h&gt;<br>
=A0#include &lt;linux/bug.h&gt;<br>
-#include &lt;linux/cpuidle.h&gt;<br>
<br>
=A0#include &lt;asm/machdep.h&gt;<br>
=A0#include &lt;asm/firmware.h&gt;<br>
@@ -217,16 +216,6 @@ static int __init pnv_probe(void)<br>
=A0 =A0 =A0 =A0 return 1;<br>
=A0}<br>
<br>
-void powernv_idle(void)<br>
-{<br>
- =A0 =A0 =A0 /* Hook to cpuidle framework if available, else<br>
- =A0 =A0 =A0 =A0* call on default platform idle code<br>
- =A0 =A0 =A0 =A0*/<br>
- =A0 =A0 =A0 if (cpuidle_idle_call()) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 power7_idle();<br>
- =A0 =A0 =A0 }<br></blockquote><div><br></div><div>The cpuidle_idle_call i=
s called from arch_cpu_idle in arch/powerpc/kernel/idle.c between a ppc64_r=
unlatch_off|on section.</div><div>Shouldn&#39;t the cpuidle-powernv driver =
call these functions when entering idle ?</div>
<div><br></div><div>=A0 -- Daniel=A0</div><div>=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">
-}<br>
-<br>
=A0define_machine(powernv) {<br>
=A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D &quot;PowerNV=
&quot;,<br>
=A0 =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D pnv_probe,<br=
>
@@ -236,7 +225,7 @@ define_machine(powernv) {<br>
=A0 =A0 =A0 =A0 .show_cpuinfo =A0 =A0 =A0 =A0 =A0 =3D pnv_show_cpuinfo,<br>
=A0 =A0 =A0 =A0 .progress =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D pnv_progress,<br>
=A0 =A0 =A0 =A0 .machine_shutdown =A0 =A0 =A0 =3D pnv_shutdown,<br>
- =A0 =A0 =A0 .power_save =A0 =A0 =A0 =A0 =A0 =A0 =3D powernv_idle,<br>
+ =A0 =A0 =A0 .power_save =A0 =A0 =A0 =A0 =A0 =A0 =3D power7_idle,<br>
=A0 =A0 =A0 =A0 .calibrate_decr =A0 =A0 =A0 =A0 =3D generic_calibrate_decr,=
<br>
=A0#ifdef CONFIG_KEXEC<br>
=A0 =A0 =A0 =A0 .kexec_cpu_down =A0 =A0 =A0 =A0 =3D pnv_kexec_cpu_down,<br>
<span class=3D""><font color=3D"#888888">--<br>
1.8.4.108.g55ea5f6<br>
<br>
</font></span></blockquote></div><br></div></div>

--089e01183fb857fdf004f1bf5202--
