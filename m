Return-Path: <michael.neuling@gmail.com>
Received: from mail-pb0-x22e.google.com (mail-pb0-x22e.google.com
 [IPv6:2607:f8b0:400e:c01::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 83D342C020B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 11:16:19 +1000 (EST)
Received: by mail-pb0-f46.google.com with SMTP id rq2so1412114pbb.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2013 18:16:16 -0700 (PDT)
MIME-Version: 1.0
Sender: michael.neuling@gmail.com
In-Reply-To: <1376611546.4255.120.camel@pasglop>
References: <1376611546.4255.120.camel@pasglop>
Date: Fri, 16 Aug 2013 11:16:16 +1000
Message-ID: <CAEjGV6wdjnoh__eAZ0pFh9o+-=ZpDB-Sg9CBuA2Z+FepgK1-1w@mail.gmail.com>
Subject: Re: [PATCH] powerpc/powernv: Return secondary CPUs to firmware on
 kexec
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: multipart/alternative; boundary=047d7bb0470858ff1104e4065663
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--047d7bb0470858ff1104e4065663
Content-Type: text/plain; charset=ISO-8859-1

> With OPAL v3 we can return secondary CPUs to firmware on kexec. This
> allows firmware to do various cleanups making things generally more
> reliable, and will enable the "new" kernel to call OPAL to perform
> some reconfiguration tasks early on that can only be done while
> all the CPUs are in firmware.

Dumb question, but isn't the point of kexec to avoid fw interactions like
this?

Mikey

> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>
> diff --git a/arch/powerpc/platforms/powernv/setup.c
b/arch/powerpc/platforms/powernv/setup.c
> index d4459bf..b59a1da 100644
> --- a/arch/powerpc/platforms/powernv/setup.c
> +++ b/arch/powerpc/platforms/powernv/setup.c
> @@ -31,6 +31,7 @@
>  #include <asm/xics.h>
>  #include <asm/rtas.h>
>  #include <asm/opal.h>
> +#include <asm/kexec.h>
>
>  #include "powernv.h"
>
> @@ -143,6 +144,16 @@ static void pnv_shutdown(void)
>  static void pnv_kexec_cpu_down(int crash_shutdown, int secondary)
>  {
>         xics_kexec_teardown_cpu(secondary);
> +
> +       /* Return secondary CPUs to firmware on OPAL v3 */
> +       if (firmware_has_feature(FW_FEATURE_OPALv3) && secondary) {
> +               mb();
> +               get_paca()->kexec_state = KEXEC_STATE_REAL_MODE;
> +               mb();
> +
> +               /* Return the CPU to OPAL */
> +               opal_return_cpu();
> +       }
>  }
>  #endif /* CONFIG_KEXEC */
>
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>

--047d7bb0470858ff1104e4065663
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
&gt; With OPAL v3 we can return secondary CPUs to firmware on kexec. This<b=
r>
&gt; allows firmware to do various cleanups making things generally more<br=
>
&gt; reliable, and will enable the &quot;new&quot; kernel to call OPAL to p=
erform<br>
&gt; some reconfiguration tasks early on that can only be done while<br>
&gt; all the CPUs are in firmware.</p>
<p dir=3D"ltr">Dumb question, but isn&#39;t the point of kexec to avoid fw =
interactions like this?</p>
<p dir=3D"ltr">Mikey<br></p>
<p dir=3D"ltr">&gt; Signed-off-by: Benjamin Herrenschmidt &lt;<a href=3D"ma=
ilto:benh@kernel.crashing.org">benh@kernel.crashing.org</a>&gt;<br>
&gt;<br>
&gt; diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/pla=
tforms/powernv/setup.c<br>
&gt; index d4459bf..b59a1da 100644<br>
&gt; --- a/arch/powerpc/platforms/powernv/setup.c<br>
&gt; +++ b/arch/powerpc/platforms/powernv/setup.c<br>
&gt; @@ -31,6 +31,7 @@<br>
&gt; =A0#include &lt;asm/xics.h&gt;<br>
&gt; =A0#include &lt;asm/rtas.h&gt;<br>
&gt; =A0#include &lt;asm/opal.h&gt;<br>
&gt; +#include &lt;asm/kexec.h&gt;<br>
&gt;<br>
&gt; =A0#include &quot;powernv.h&quot;<br>
&gt;<br>
&gt; @@ -143,6 +144,16 @@ static void pnv_shutdown(void)<br>
&gt; =A0static void pnv_kexec_cpu_down(int crash_shutdown, int secondary)<b=
r>
&gt; =A0{<br>
&gt; =A0 =A0 =A0 =A0 xics_kexec_teardown_cpu(secondary);<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 /* Return secondary CPUs to firmware on OPAL v3 */<br>
&gt; + =A0 =A0 =A0 if (firmware_has_feature(FW_FEATURE_OPALv3) &amp;&amp; s=
econdary) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mb();<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_paca()-&gt;kexec_state =3D KEXEC_STA=
TE_REAL_MODE;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mb();<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Return the CPU to OPAL */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 opal_return_cpu();<br>
&gt; + =A0 =A0 =A0 }<br>
&gt; =A0}<br>
&gt; =A0#endif /* CONFIG_KEXEC */<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; Linuxppc-dev mailing list<br>
&gt; <a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.oz=
labs.org</a><br>
&gt; <a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev">https://lis=
ts.ozlabs.org/listinfo/linuxppc-dev</a><br>
&gt;<br>
</p>

--047d7bb0470858ff1104e4065663--
