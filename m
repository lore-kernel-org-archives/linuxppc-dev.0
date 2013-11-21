Return-Path: <jimix@pobox.com>
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com [208.72.237.35])
 by ozlabs.org (Postfix) with ESMTP id 986A52C00E7
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Nov 2013 04:57:10 +1100 (EST)
Received: from smtp.pobox.com (unknown [127.0.0.1])
 by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA83752CAA
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Nov 2013 12:50:08 -0500 (EST)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
 by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA4BD52CA9
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Nov 2013 12:50:08 -0500 (EST)
Received: from mail-ie0-f180.google.com (unknown [209.85.223.180])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F84752C92
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Nov 2013 12:50:04 -0500 (EST)
Received: by mail-ie0-f180.google.com with SMTP id tp5so129497ieb.39
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Nov 2013 09:50:03 -0800 (PST)
MIME-Version: 1.0
From: Jimi Xenidis <jimix@pobox.com>
Date: Thu, 21 Nov 2013 09:49:43 -0800
Message-ID: <CAAen6A0vqbNKajZQrz4g=7wvPE9vO6r_CeaVo=_O8e0D3JpfQA@mail.gmail.com>
Subject: Re: powerpc: Fix missing includes needed for chroma
To: Michael Neuling <mikey@neuling.org>
Content-Type: multipart/alternative; boundary=bcaec517cb72fa6da704ebb38606
Cc: Yoonho Park <yoonho@us.ibm.com>, Linux PPC dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--bcaec517cb72fa6da704ebb38606
Content-Type: text/plain; charset=ISO-8859-1

Drop it now :)
However, it may be nice to keep the A2 stuff until BGQ EOLs
-jx



On Wed, Nov 20, 2013 at 8:40 PM, Michael Neuling <mikey@neuling.org> wrote:

> chroma_defconfig is horribly broken currently, so add a bunch of
> #includes to fix it.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
> So when are we dropping arch/powerpc/platforms/wsp?
>
> diff --git a/arch/powerpc/platforms/wsp/chroma.c
> b/arch/powerpc/platforms/wsp/chroma.c
> index 8ef53bc..aaa46b3 100644
> --- a/arch/powerpc/platforms/wsp/chroma.c
> +++ b/arch/powerpc/platforms/wsp/chroma.c
> @@ -15,6 +15,7 @@
>  #include <linux/of.h>
>  #include <linux/smp.h>
>  #include <linux/time.h>
> +#include <linux/of_fdt.h>
>
>  #include <asm/machdep.h>
>  #include <asm/udbg.h>
> diff --git a/arch/powerpc/platforms/wsp/h8.c
> b/arch/powerpc/platforms/wsp/h8.c
> index d18e6cc..a3c87f3 100644
> --- a/arch/powerpc/platforms/wsp/h8.c
> +++ b/arch/powerpc/platforms/wsp/h8.c
> @@ -10,6 +10,7 @@
>  #include <linux/kernel.h>
>  #include <linux/of.h>
>  #include <linux/io.h>
> +#include <linux/of_address.h>
>
>  #include "wsp.h"
>
> diff --git a/arch/powerpc/platforms/wsp/ics.c
> b/arch/powerpc/platforms/wsp/ics.c
> index 2d3b1dd..3b782ce 100644
> --- a/arch/powerpc/platforms/wsp/ics.c
> +++ b/arch/powerpc/platforms/wsp/ics.c
> @@ -18,6 +18,8 @@
>  #include <linux/smp.h>
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_address.h>
>
>  #include <asm/io.h>
>  #include <asm/irq.h>
> diff --git a/arch/powerpc/platforms/wsp/opb_pic.c
> b/arch/powerpc/platforms/wsp/opb_pic.c
> index cb565bf..3f67298 100644
> --- a/arch/powerpc/platforms/wsp/opb_pic.c
> +++ b/arch/powerpc/platforms/wsp/opb_pic.c
> @@ -15,6 +15,8 @@
>  #include <linux/of.h>
>  #include <linux/slab.h>
>  #include <linux/time.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
>
>  #include <asm/reg_a2.h>
>  #include <asm/irq.h>
> diff --git a/arch/powerpc/platforms/wsp/psr2.c
> b/arch/powerpc/platforms/wsp/psr2.c
> index 508ec82..a87b414 100644
> --- a/arch/powerpc/platforms/wsp/psr2.c
> +++ b/arch/powerpc/platforms/wsp/psr2.c
> @@ -15,6 +15,7 @@
>  #include <linux/of.h>
>  #include <linux/smp.h>
>  #include <linux/time.h>
> +#include <linux/of_fdt.h>
>
>  #include <asm/machdep.h>
>  #include <asm/udbg.h>
> diff --git a/arch/powerpc/platforms/wsp/scom_wsp.c
> b/arch/powerpc/platforms/wsp/scom_wsp.c
> index 8928507..6538b4d 100644
> --- a/arch/powerpc/platforms/wsp/scom_wsp.c
> +++ b/arch/powerpc/platforms/wsp/scom_wsp.c
> @@ -14,6 +14,7 @@
>  #include <linux/of.h>
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
> +#include <linux/of_address.h>
>
>  #include <asm/cputhreads.h>
>  #include <asm/reg_a2.h>
> diff --git a/arch/powerpc/platforms/wsp/wsp.c
> b/arch/powerpc/platforms/wsp/wsp.c
> index ddb6efe..58cd1f0 100644
> --- a/arch/powerpc/platforms/wsp/wsp.c
> +++ b/arch/powerpc/platforms/wsp/wsp.c
> @@ -13,6 +13,7 @@
>  #include <linux/smp.h>
>  #include <linux/delay.h>
>  #include <linux/time.h>
> +#include <linux/of_address.h>
>
>  #include <asm/scom.h>
>
>

--bcaec517cb72fa6da704ebb38606
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Drop it now :)<div>However, it may be nice to keep the A2 =
stuff until BGQ EOLs</div><div>-jx</div><div><br></div><div class=3D"gmail_=
extra"><br><br><div class=3D"gmail_quote">On Wed, Nov 20, 2013 at 8:40 PM, =
Michael Neuling <span dir=3D"ltr">&lt;<a href=3D"mailto:mikey@neuling.org" =
target=3D"_blank">mikey@neuling.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">chroma_defconfig is horribly broken currentl=
y, so add a bunch of<br>
#includes to fix it.<br>
<br>
Signed-off-by: Michael Neuling &lt;<a href=3D"mailto:mikey@neuling.org">mik=
ey@neuling.org</a>&gt;<br>
---<br>
So when are we dropping arch/powerpc/platforms/wsp?<br>
<br>
diff --git a/arch/powerpc/platforms/wsp/chroma.c b/arch/powerpc/platforms/w=
sp/chroma.c<br>
index 8ef53bc..aaa46b3 100644<br>
--- a/arch/powerpc/platforms/wsp/chroma.c<br>
+++ b/arch/powerpc/platforms/wsp/chroma.c<br>
@@ -15,6 +15,7 @@<br>
=A0#include &lt;linux/of.h&gt;<br>
=A0#include &lt;linux/smp.h&gt;<br>
=A0#include &lt;linux/time.h&gt;<br>
+#include &lt;linux/of_fdt.h&gt;<br>
<br>
=A0#include &lt;asm/machdep.h&gt;<br>
=A0#include &lt;asm/udbg.h&gt;<br>
diff --git a/arch/powerpc/platforms/wsp/h8.c b/arch/powerpc/platforms/wsp/h=
8.c<br>
index d18e6cc..a3c87f3 100644<br>
--- a/arch/powerpc/platforms/wsp/h8.c<br>
+++ b/arch/powerpc/platforms/wsp/h8.c<br>
@@ -10,6 +10,7 @@<br>
=A0#include &lt;linux/kernel.h&gt;<br>
=A0#include &lt;linux/of.h&gt;<br>
=A0#include &lt;linux/io.h&gt;<br>
+#include &lt;linux/of_address.h&gt;<br>
<br>
=A0#include &quot;wsp.h&quot;<br>
<br>
diff --git a/arch/powerpc/platforms/wsp/ics.c b/arch/powerpc/platforms/wsp/=
ics.c<br>
index 2d3b1dd..3b782ce 100644<br>
--- a/arch/powerpc/platforms/wsp/ics.c<br>
+++ b/arch/powerpc/platforms/wsp/ics.c<br>
@@ -18,6 +18,8 @@<br>
=A0#include &lt;linux/smp.h&gt;<br>
=A0#include &lt;linux/spinlock.h&gt;<br>
=A0#include &lt;linux/types.h&gt;<br>
+#include &lt;linux/of_irq.h&gt;<br>
+#include &lt;linux/of_address.h&gt;<br>
<br>
=A0#include &lt;asm/io.h&gt;<br>
=A0#include &lt;asm/irq.h&gt;<br>
diff --git a/arch/powerpc/platforms/wsp/opb_pic.c b/arch/powerpc/platforms/=
wsp/opb_pic.c<br>
index cb565bf..3f67298 100644<br>
--- a/arch/powerpc/platforms/wsp/opb_pic.c<br>
+++ b/arch/powerpc/platforms/wsp/opb_pic.c<br>
@@ -15,6 +15,8 @@<br>
=A0#include &lt;linux/of.h&gt;<br>
=A0#include &lt;linux/slab.h&gt;<br>
=A0#include &lt;linux/time.h&gt;<br>
+#include &lt;linux/of_address.h&gt;<br>
+#include &lt;linux/of_irq.h&gt;<br>
<br>
=A0#include &lt;asm/reg_a2.h&gt;<br>
=A0#include &lt;asm/irq.h&gt;<br>
diff --git a/arch/powerpc/platforms/wsp/psr2.c b/arch/powerpc/platforms/wsp=
/psr2.c<br>
index 508ec82..a87b414 100644<br>
--- a/arch/powerpc/platforms/wsp/psr2.c<br>
+++ b/arch/powerpc/platforms/wsp/psr2.c<br>
@@ -15,6 +15,7 @@<br>
=A0#include &lt;linux/of.h&gt;<br>
=A0#include &lt;linux/smp.h&gt;<br>
=A0#include &lt;linux/time.h&gt;<br>
+#include &lt;linux/of_fdt.h&gt;<br>
<br>
=A0#include &lt;asm/machdep.h&gt;<br>
=A0#include &lt;asm/udbg.h&gt;<br>
diff --git a/arch/powerpc/platforms/wsp/scom_wsp.c b/arch/powerpc/platforms=
/wsp/scom_wsp.c<br>
index 8928507..6538b4d 100644<br>
--- a/arch/powerpc/platforms/wsp/scom_wsp.c<br>
+++ b/arch/powerpc/platforms/wsp/scom_wsp.c<br>
@@ -14,6 +14,7 @@<br>
=A0#include &lt;linux/of.h&gt;<br>
=A0#include &lt;linux/spinlock.h&gt;<br>
=A0#include &lt;linux/types.h&gt;<br>
+#include &lt;linux/of_address.h&gt;<br>
<br>
=A0#include &lt;asm/cputhreads.h&gt;<br>
=A0#include &lt;asm/reg_a2.h&gt;<br>
diff --git a/arch/powerpc/platforms/wsp/wsp.c b/arch/powerpc/platforms/wsp/=
wsp.c<br>
index ddb6efe..58cd1f0 100644<br>
--- a/arch/powerpc/platforms/wsp/wsp.c<br>
+++ b/arch/powerpc/platforms/wsp/wsp.c<br>
@@ -13,6 +13,7 @@<br>
=A0#include &lt;linux/smp.h&gt;<br>
=A0#include &lt;linux/delay.h&gt;<br>
=A0#include &lt;linux/time.h&gt;<br>
+#include &lt;linux/of_address.h&gt;<br>
<br>
=A0#include &lt;asm/scom.h&gt;<br>
<br>
</blockquote></div><br></div></div>

--bcaec517cb72fa6da704ebb38606--
