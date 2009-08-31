Return-Path: <timur@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DA4F4B7099
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 31 Aug 2009 10:37:55 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 62524DDD01
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Aug 2009 10:37:54 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n7V0bZJl008718
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Aug 2009 17:37:46 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n7V0bYKb017666
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Aug 2009 19:37:35 -0500 (CDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA29D3.3B90454D"
Subject: RE: [PATCH 1/5] powerpc/qe: Make qe_reset() code path safe for
	repeated invocation
Date: Sun, 30 Aug 2009 17:36:28 -0700
Message-ID: <5610599F537DD74A8D1F5CC946A7507301DCCC8A@az33exm25.fsl.freescale.net>
References: <20090830193625.GA14693@oksana.dev.rtsoft.ru>
	<20090830193715.GA17519@oksana.dev.rtsoft.ru>
From: "Tabi Timur-B04825" <timur@freescale.com>
To: "Anton Vorontsov" <avorontsov@ru.mvista.com>,
	"Kumar Gala" <galak@kernel.crashing.org>
Cc: Wood Scott-B07421 <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA29D3.3B90454D
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Is the need to reinitialize the QE after resume something that is unique =
to the 8569, or would it apply to the 8360 and 8323 also?


-----Original Message-----
From: Anton Vorontsov [mailto:avorontsov@ru.mvista.com]
Sent: Sun 8/30/2009 2:37 PM
To: Kumar Gala
Cc: Tabi Timur-B04825; Wood Scott-B07421; linuxppc-dev@ozlabs.org
Subject: [PATCH 1/5] powerpc/qe: Make qe_reset() code path safe for =
repeated invocation
=20
For MPC8569 CPUs we'll need to reset QE after each suspend, so make
qe_reset() code path suitable for repeated invocation, that is:

- Don't initialize rheap structures if already initialized;
- Don't allocate muram for SDMA if already allocated, just reinitialize
  registers with previously allocated muram offset;
- Remove __init attributes from qe_reset() and cpm_muram_init();

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/include/asm/qe.h    |    2 +-
 arch/powerpc/sysdev/cpm_common.c |    5 ++++-
 arch/powerpc/sysdev/qe_lib/qe.c  |   12 +++++++-----
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/qe.h =
b/arch/powerpc/include/asm/qe.h
index e8232bb..2f44754 100644
--- a/arch/powerpc/include/asm/qe.h
+++ b/arch/powerpc/include/asm/qe.h
@@ -87,7 +87,7 @@ extern spinlock_t cmxgcr_lock;
=20
 /* Export QE common operations */
 #ifdef CONFIG_QUICC_ENGINE
-extern void __init qe_reset(void);
+extern void qe_reset(void);
 #else
 static inline void qe_reset(void) {}
 #endif
diff --git a/arch/powerpc/sysdev/cpm_common.c =
b/arch/powerpc/sysdev/cpm_common.c
index e4b6d66..9de72c9 100644
--- a/arch/powerpc/sysdev/cpm_common.c
+++ b/arch/powerpc/sysdev/cpm_common.c
@@ -72,7 +72,7 @@ static phys_addr_t muram_pbase;
 /* Max address size we deal with */
 #define OF_MAX_ADDR_CELLS	4
=20
-int __init cpm_muram_init(void)
+int cpm_muram_init(void)
 {
 	struct device_node *np;
 	struct resource r;
@@ -81,6 +81,9 @@ int __init cpm_muram_init(void)
 	int i =3D 0;
 	int ret =3D 0;
=20
+	if (muram_pbase)
+		return 0;
+
 	spin_lock_init(&cpm_muram_lock);
 	/* initialize the info header */
 	rh_init(&cpm_muram_info, 1,
diff --git a/arch/powerpc/sysdev/qe_lib/qe.c =
b/arch/powerpc/sysdev/qe_lib/qe.c
index b06564f..4eaf2a9 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -91,7 +91,7 @@ phys_addr_t get_qe_base(void)
=20
 EXPORT_SYMBOL(get_qe_base);
=20
-void __init qe_reset(void)
+void qe_reset(void)
 {
 	if (qe_immr =3D=3D NULL)
 		qe_immr =3D ioremap(get_qe_base(), QE_IMMAP_SIZE);
@@ -317,16 +317,18 @@ EXPORT_SYMBOL(qe_put_snum);
 static int qe_sdma_init(void)
 {
 	struct sdma __iomem *sdma =3D &qe_immr->sdma;
-	unsigned long sdma_buf_offset;
+	static unsigned long sdma_buf_offset =3D (unsigned long)-ENOMEM;
=20
 	if (!sdma)
 		return -ENODEV;
=20
 	/* allocate 2 internal temporary buffers (512 bytes size each) for
 	 * the SDMA */
- 	sdma_buf_offset =3D qe_muram_alloc(512 * 2, 4096);
-	if (IS_ERR_VALUE(sdma_buf_offset))
-		return -ENOMEM;
+	if (IS_ERR_VALUE(sdma_buf_offset)) {
+		sdma_buf_offset =3D qe_muram_alloc(512 * 2, 4096);
+		if (IS_ERR_VALUE(sdma_buf_offset))
+			return -ENOMEM;
+	}
=20
 	out_be32(&sdma->sdebcr, (u32) sdma_buf_offset & QE_SDEBCR_BA_MASK);
  	out_be32(&sdma->sdmr, (QE_SDMR_GLB_1_MSK |
--=20
1.6.3.3




------_=_NextPart_001_01CA29D3.3B90454D
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7654.12">
<TITLE>RE: [PATCH 1/5] powerpc/qe: Make qe_reset() code path safe for =
repeated invocation</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Is the need to reinitialize the QE after resume =
something that is unique to the 8569, or would it apply to the 8360 and =
8323 also?<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: Anton Vorontsov [<A =
HREF=3D"mailto:avorontsov@ru.mvista.com">mailto:avorontsov@ru.mvista.com<=
/A>]<BR>
Sent: Sun 8/30/2009 2:37 PM<BR>
To: Kumar Gala<BR>
Cc: Tabi Timur-B04825; Wood Scott-B07421; linuxppc-dev@ozlabs.org<BR>
Subject: [PATCH 1/5] powerpc/qe: Make qe_reset() code path safe for =
repeated invocation<BR>
<BR>
For MPC8569 CPUs we'll need to reset QE after each suspend, so make<BR>
qe_reset() code path suitable for repeated invocation, that is:<BR>
<BR>
- Don't initialize rheap structures if already initialized;<BR>
- Don't allocate muram for SDMA if already allocated, just =
reinitialize<BR>
&nbsp; registers with previously allocated muram offset;<BR>
- Remove __init attributes from qe_reset() and cpm_muram_init();<BR>
<BR>
Signed-off-by: Anton Vorontsov &lt;avorontsov@ru.mvista.com&gt;<BR>
---<BR>
&nbsp;arch/powerpc/include/asm/qe.h&nbsp;&nbsp;&nbsp; =
|&nbsp;&nbsp;&nbsp; 2 +-<BR>
&nbsp;arch/powerpc/sysdev/cpm_common.c |&nbsp;&nbsp;&nbsp; 5 ++++-<BR>
&nbsp;arch/powerpc/sysdev/qe_lib/qe.c&nbsp; |&nbsp;&nbsp; 12 =
+++++++-----<BR>
&nbsp;3 files changed, 12 insertions(+), 7 deletions(-)<BR>
<BR>
diff --git a/arch/powerpc/include/asm/qe.h =
b/arch/powerpc/include/asm/qe.h<BR>
index e8232bb..2f44754 100644<BR>
--- a/arch/powerpc/include/asm/qe.h<BR>
+++ b/arch/powerpc/include/asm/qe.h<BR>
@@ -87,7 +87,7 @@ extern spinlock_t cmxgcr_lock;<BR>
<BR>
&nbsp;/* Export QE common operations */<BR>
&nbsp;#ifdef CONFIG_QUICC_ENGINE<BR>
-extern void __init qe_reset(void);<BR>
+extern void qe_reset(void);<BR>
&nbsp;#else<BR>
&nbsp;static inline void qe_reset(void) {}<BR>
&nbsp;#endif<BR>
diff --git a/arch/powerpc/sysdev/cpm_common.c =
b/arch/powerpc/sysdev/cpm_common.c<BR>
index e4b6d66..9de72c9 100644<BR>
--- a/arch/powerpc/sysdev/cpm_common.c<BR>
+++ b/arch/powerpc/sysdev/cpm_common.c<BR>
@@ -72,7 +72,7 @@ static phys_addr_t muram_pbase;<BR>
&nbsp;/* Max address size we deal with */<BR>
&nbsp;#define OF_MAX_ADDR_CELLS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4<BR>
<BR>
-int __init cpm_muram_init(void)<BR>
+int cpm_muram_init(void)<BR>
&nbsp;{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_node *np;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct resource r;<BR>
@@ -81,6 +81,9 @@ int __init cpm_muram_init(void)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i =3D 0;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<BR>
<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (muram_pbase)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<BR>
+<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
spin_lock_init(&amp;cpm_muram_lock);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* initialize the info header =
*/<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rh_init(&amp;cpm_muram_info, =
1,<BR>
diff --git a/arch/powerpc/sysdev/qe_lib/qe.c =
b/arch/powerpc/sysdev/qe_lib/qe.c<BR>
index b06564f..4eaf2a9 100644<BR>
--- a/arch/powerpc/sysdev/qe_lib/qe.c<BR>
+++ b/arch/powerpc/sysdev/qe_lib/qe.c<BR>
@@ -91,7 +91,7 @@ phys_addr_t get_qe_base(void)<BR>
<BR>
&nbsp;EXPORT_SYMBOL(get_qe_base);<BR>
<BR>
-void __init qe_reset(void)<BR>
+void qe_reset(void)<BR>
&nbsp;{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (qe_immr =3D=3D NULL)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qe_immr =3D =
ioremap(get_qe_base(), QE_IMMAP_SIZE);<BR>
@@ -317,16 +317,18 @@ EXPORT_SYMBOL(qe_put_snum);<BR>
&nbsp;static int qe_sdma_init(void)<BR>
&nbsp;{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct sdma __iomem *sdma =3D =
&amp;qe_immr-&gt;sdma;<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long sdma_buf_offset;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static unsigned long =
sdma_buf_offset =3D (unsigned long)-ENOMEM;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!sdma)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENODEV;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* allocate 2 internal =
temporary buffers (512 bytes size each) for<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the SDMA */<BR>
- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_buf_offset =3D qe_muram_alloc(512 =
* 2, 4096);<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(IS_ERR_VALUE(sdma_buf_offset))<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR_VALUE(sdma_buf_offset)) =
{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_buf_offset =3D =
qe_muram_alloc(512 * 2, 4096);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(IS_ERR_VALUE(sdma_buf_offset))<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
out_be32(&amp;sdma-&gt;sdebcr, (u32) sdma_buf_offset &amp; =
QE_SDEBCR_BA_MASK);<BR>
&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; out_be32(&amp;sdma-&gt;sdmr, =
(QE_SDMR_GLB_1_MSK |<BR>
--<BR>
1.6.3.3<BR>
<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CA29D3.3B90454D--
