Return-Path: <ben.dubb@gmail.com>
Received: from mail-iy0-f170.google.com (mail-iy0-f170.google.com
 [209.85.210.170])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E0BAD2C0096
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2012 13:54:48 +1000 (EST)
Received: by iamm10 with SMTP id m10so482717iam.15
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2012 20:54:46 -0700 (PDT)
MIME-Version: 1.0
From: Ben Dubb <ben.dubb@gmail.com>
Date: Wed, 22 Aug 2012 23:54:25 -0400
Message-ID: <CACLP1513KDxU95cY0_tpMqenwFmc8WZyuQMbaZbvU_pZdVqkSg@mail.gmail.com>
Subject: [PATCH] QE USB host fix for mpc832x
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=e89a8f3ba0a9fb7fa104c7e6d1a6
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--e89a8f3ba0a9fb7fa104c7e6d1a6
Content-Type: text/plain; charset=ISO-8859-1

This patch should be used to get QE USB host mode working on mpc832x and
mpc8360
based devices. It fixes the following issues:

- BRG divisor shall not be an add number greater than 3.
- USB param block in multi-user ram can't be accessed at default location
on mpc832x
  device. Allocate it dynamically.

These changes have been tested on mpc8360-rdk board as well as mpc8321e
based design.
On the mpc832x devices, the QE_USB3 microcode patch is required, and has to
be loaded
early during initialization sequence.

These changes are partially based on an earlier patch from Marcel Ziswiler,
[PATCH] QE USB Host Integration for
MPC832x"<http://lkml.indiana.edu/hypermail/linux/kernel/0904.0/00479.html>

-Ben
----

diff -Naur linux-2.6.34.13.orig/arch/powerpc/sysdev/qe_lib/qe.c
linux-2.6.34.13.new/arch/powerpc/sysdev/qe_lib/qe.c
--- linux-2.6.34.13.orig/arch/powerpc/sysdev/qe_lib/qe.c        2012-08-20
14:45:22.000000000 -0400
+++ linux-2.6.34.13.new/arch/powerpc/sysdev/qe_lib/qe.c 2012-08-22
21:51:05.093065082 -0400
@@ -215,8 +215,8 @@

        /* Errata QE_General4, which affects some MPC832x and MPC836x SOCs,
says
           that the BRG divisor must be even if you're not using
divide-by-16
-          mode. */
-       if (!div16 && (divisor & 1))
+          mode, and is greater than 3. */
+       if (!div16 && (divisor & 1) && (divisor > 3))
                divisor++;

        tempval = ((divisor - 1) << QE_BRGC_DIVISOR_SHIFT) |
diff -Naur linux-2.6.34.13.orig/drivers/usb/host/fhci-hcd.c
linux-2.6.34.13.new/drivers/usb/host/fhci-hcd.c
--- linux-2.6.34.13.orig/drivers/usb/host/fhci-hcd.c    2012-08-20
14:45:22.000000000 -0400
+++ linux-2.6.34.13.new/drivers/usb/host/fhci-hcd.c     2012-08-22
22:39:00.453065145 -0400
@@ -614,15 +614,8 @@
        }
        fhci->regs = hcd->regs;

-       /* Parameter RAM. */
-       iprop = of_get_property(node, "reg", &size);
-       if (!iprop || size < sizeof(*iprop) * 4) {
-               dev_err(dev, "can't get pram offset\n");
-               ret = -EINVAL;
-               goto err_pram;
-       }
-
-       pram_addr = cpm_muram_alloc_fixed(iprop[2], FHCI_PRAM_SIZE);
+       /* Dynamically allocate USB Parameter RAM. */
+       pram_addr = qe_muram_alloc(FHCI_PRAM_SIZE, 64);
        if (IS_ERR_VALUE(pram_addr)) {
                dev_err(dev, "failed to allocate usb pram\n");
                ret = -ENOMEM;
@@ -630,6 +623,11 @@
        }
        fhci->pram = cpm_muram_addr(pram_addr);

+       /* On mpc832x devices the usb param base address is outside the 16K
MURAM
+          space, and therefore must be remapped via QE Assign Page
command. */
+       qe_issue_cmd(QE_ASSIGN_PAGE_TO_DEVICE, QE_CR_SUBBLOCK_USB,


+               QE_CR_PROTOCOL_UNSPECIFIED, pi->pram_addr);
+
        /* GPIOs and pins */
        for (i = 0; i < NUM_GPIOS; i++) {
                int gpio;

--e89a8f3ba0a9fb7fa104c7e6d1a6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>This patch should be used to get QE USB host mode working on mpc832x=
=A0and mpc8360=A0</div><div>based devices.=A0It fixes the following issues:=
</div><div><br></div><div>- BRG divisor shall not be an add number greater =
than 3.</div>

<div>- USB param block in multi-user ram can&#39;t be accessed at default l=
ocation on mpc832x=A0</div><div>=A0 device. Allocate it dynamically.</div><=
div><br></div><div>These changes have been tested on mpc8360-rdk board as w=
ell as mpc8321e based design.</div>

<div>On the mpc832x devices, the=A0QE_USB3 microcode patch is required, and=
 has to be loaded=A0</div><div>early during=A0initialization sequence.</div=
><div><br></div><div>These changes are partially based on an earlier patch =
from Marcel Ziswiler,=A0</div>

<div><a href=3D"http://lkml.indiana.edu/hypermail/linux/kernel/0904.0/00479=
.html" style=3D"font-family:Times;font-size:medium;background-color:rgb(255=
,255,255)">[PATCH] QE USB Host Integration for MPC832x&quot;</a></div><div>

<br></div><div>-Ben</div><div>----</div><div><br></div><div>diff -Naur linu=
x-2.6.34.13.orig/arch/powerpc/sysdev/qe_lib/qe.c linux-2.6.34.13.new/arch/p=
owerpc/sysdev/qe_lib/qe.c</div><div>--- linux-2.6.34.13.orig/arch/powerpc/s=
ysdev/qe_lib/qe.c =A0 =A0 =A0 =A02012-08-20 14:45:22.000000000 -0400</div>

<div>+++ linux-2.6.34.13.new/arch/powerpc/sysdev/qe_lib/qe.c 2012-08-22 21:=
51:05.093065082 -0400</div><div>@@ -215,8 +215,8 @@</div><div>=A0</div><div=
>=A0 =A0 =A0 =A0 /* Errata QE_General4, which affects some MPC832x and MPC8=
36x SOCs, says</div>

<div>=A0 =A0 =A0 =A0 =A0 =A0that the BRG divisor must be even if you&#39;re=
 not using divide-by-16</div><div>- =A0 =A0 =A0 =A0 =A0mode. */</div><div>-=
 =A0 =A0 =A0 if (!div16 &amp;&amp; (divisor &amp; 1))</div><div>+ =A0 =A0 =
=A0 =A0 =A0mode, and is greater than 3. */</div>

<div>+ =A0 =A0 =A0 if (!div16 &amp;&amp; (divisor &amp; 1) &amp;&amp; (divi=
sor &gt; 3))</div><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 divisor++;</div><div=
>=A0</div><div>=A0 =A0 =A0 =A0 tempval =3D ((divisor - 1) &lt;&lt; QE_BRGC_=
DIVISOR_SHIFT) |</div><div>diff -Naur linux-2.6.34.13.orig/drivers/usb/host=
/fhci-hcd.c linux-2.6.34.13.new/drivers/usb/host/fhci-hcd.c</div>

<div>--- linux-2.6.34.13.orig/drivers/usb/host/fhci-hcd.c =A0 =A02012-08-20=
 14:45:22.000000000 -0400</div><div>+++ linux-2.6.34.13.new/drivers/usb/hos=
t/fhci-hcd.c =A0 =A0 2012-08-22 22:39:00.453065145 -0400</div><div>@@ -614,=
15 +614,8 @@</div>

<div>=A0 =A0 =A0 =A0 }</div><div>=A0 =A0 =A0 =A0 fhci-&gt;regs =3D hcd-&gt;=
regs;</div><div>=A0</div><div>- =A0 =A0 =A0 /* Parameter RAM. */</div><div>=
- =A0 =A0 =A0 iprop =3D of_get_property(node, &quot;reg&quot;, &amp;size);<=
/div><div>- =A0 =A0 =A0 if (!iprop || size &lt; sizeof(*iprop) * 4) {</div>

<div>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, &quot;can&#39;t get pram of=
fset\n&quot;);</div><div>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;</di=
v><div>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_pram;</div><div>- =A0 =A0 =A0=
 }</div><div>-</div><div>- =A0 =A0 =A0 pram_addr =3D cpm_muram_alloc_fixed(=
iprop[2], FHCI_PRAM_SIZE);</div>

<div>+ =A0 =A0 =A0 /* Dynamically allocate USB Parameter RAM. */</div><div>=
+ =A0 =A0 =A0 pram_addr =3D qe_muram_alloc(FHCI_PRAM_SIZE, 64);</div><div>=
=A0 =A0 =A0 =A0 if (IS_ERR_VALUE(pram_addr)) {</div><div>=A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 dev_err(dev, &quot;failed to allocate usb pram\n&quot;);</d=
iv>

<div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;</div><div>@@ -630,6 +=
623,11 @@</div><div>=A0 =A0 =A0 =A0 }</div><div>=A0 =A0 =A0 =A0 fhci-&gt;pr=
am =3D cpm_muram_addr(pram_addr);</div><div>=A0</div><div>+ =A0 =A0 =A0 /* =
On mpc832x devices the usb param base address is outside the 16K MURAM</div=
>

<div>+ =A0 =A0 =A0 =A0 =A0space, and therefore must be remapped via QE Assi=
gn Page command. */</div><div>+ =A0 =A0 =A0 qe_issue_cmd(QE_ASSIGN_PAGE_TO_=
DEVICE, QE_CR_SUBBLOCK_USB, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0</div>

<div>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 QE_CR_PROTOCOL_UNSPECIFIED, pi-&gt;pram_=
addr); =A0=A0</div><div>+</div><div>=A0 =A0 =A0 =A0 /* GPIOs and pins */</d=
iv><div>=A0 =A0 =A0 =A0 for (i =3D 0; i &lt; NUM_GPIOS; i++) {</div><div>=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int gpio;</div>

--e89a8f3ba0a9fb7fa104c7e6d1a6--
