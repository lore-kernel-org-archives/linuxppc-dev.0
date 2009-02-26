Return-Path: <tiejun.china@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.239])
	by ozlabs.org (Postfix) with ESMTP id E999ADDDA1
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Feb 2009 21:08:06 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id l9so469282rvb.9
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Feb 2009 02:08:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1235642785-9684-1-git-send-email-tiejun.chen@windriver.com>
References: <1235642785-9684-1-git-send-email-tiejun.chen@windriver.com>
Date: Thu, 26 Feb 2009 18:08:04 +0800
Message-ID: <7a800c8d0902260208g4a65b07fi1bb287910c51b342@mail.gmail.com>
Subject: [PATCH 1/1] Fix 64bit Mapple Host Bridge Address and Size Nodes
From: Tiejun Chen <tiejun.china@gmail.com>
To: benh@kernel.crashing.org
Content-Type: multipart/alternative; boundary=000e0cd20d1435b8ec0463cf87c5
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--000e0cd20d1435b8ec0463cf87c5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

In the DTB tree created by firmware on Maple 64bit target, host bridge
parent
node has specified both of these two properties to be 2. However, the actual
"cell" value for host bridge node is 1. we have to provide one fixup
function.

Signed-off-by: Tiejun Chen <tiejun.china@gmail.com>
---
 arch/powerpc/kernel/prom_init.c |   42
+++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c
b/arch/powerpc/kernel/prom_init.c
index 2445945..9cd23b6 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -1948,8 +1948,49 @@ static void __init fixup_device_tree_maple(void)
       prom_setprop(isa, name, "ranges",
                       isa_ranges, sizeof(isa_ranges));
 }
+
+/* On Maple 64bit target host bridge parent node has specified address and
+ * size properties to be 2. But the actual "cell" value for host bridge
node
+ * is 1 since early MOTLoad internal bug. */
+static void __init fixup_device_tree_maple_hb(void)
+{
+       phandle hb;
+       u32 hb_ranges[4];
+       u32 size_cell, addr_cell;
+       struct prom_t *_prom = &RELOC(prom);
+       char *name;
+
+       name = "/hostbridge@f8000000";
+       hb = call_prom("finddevice", 1, 1, ADDR(name));
+       if (!PHANDLE_VALID(hb))
+               return;
+
+       if (prom_getproplen(hb, "reg") != 8)
+               return;
+
+       if (prom_getprop(hb, "reg", hb_ranges, (sizeof(hb_ranges))/2)
+               == PROM_ERROR)
+               return;
+
+       prom_getprop(_prom->root, "#address-cells", &addr_cell,
sizeof(addr_cell));
+       prom_getprop(_prom->root, "#size-cells", &size_cell,
sizeof(size_cell));
+
+       if ((addr_cell != 2) || (size_cell != 2) ||
+               (hb_ranges[0] != 0xf8000000))
+               return;
+
+       prom_printf("Fixing up bogus HOSTBRIDGE reg on Maple/Apache...\n");
+
+       hb_ranges[3] = hb_ranges[1];
+       hb_ranges[1] = hb_ranges[0];
+       hb_ranges[0] = hb_ranges[2] = 0;
+       prom_setprop(hb, name, "reg",
+               hb_ranges, sizeof(hb_ranges));
+}
+
 #else
 #define fixup_device_tree_maple()
+#define fixup_device_tree_maple_hb()
 #endif

 #ifdef CONFIG_PPC_CHRP
@@ -2190,6 +2231,7 @@ static void __init fixup_device_tree_efika(void)
 static void __init fixup_device_tree(void)
 {
       fixup_device_tree_maple();
+       fixup_device_tree_maple_hb();
       fixup_device_tree_chrp();
       fixup_device_tree_pmac();
       fixup_device_tree_efika();
--
1.5.6

--000e0cd20d1435b8ec0463cf87c5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

In the DTB tree created by firmware on Maple 64bit target, host bridge pare=
nt<br><div class=3D"gmail_quote">
node has specified both of these two properties to be 2. However, the actua=
l<br>
&quot;cell&quot; value for host bridge node is 1. we have to provide one fi=
xup function.<br>
<br>
Signed-off-by: Tiejun Chen &lt;<a href=3D"mailto:tiejun.china@gmail.com">ti=
ejun.china@gmail.com</a>&gt;<br>
---<br>
=A0arch/powerpc/kernel/prom_init.c | =A0 42 +++++++++++++++++++++++++++++++=
++++++++<br>
=A01 files changed, 42 insertions(+), 0 deletions(-)<br>
<br>
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_ini=
t.c<br>
index 2445945..9cd23b6 100644<br>
--- a/arch/powerpc/kernel/prom_init.c<br>
+++ b/arch/powerpc/kernel/prom_init.c<br>
@@ -1948,8 +1948,49 @@ static void __init fixup_device_tree_maple(void)<br>
 =A0 =A0 =A0 =A0prom_setprop(isa, name, &quot;ranges&quot;,<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0isa_ranges, sizeof(isa_rang=
es));<br>
=A0}<br>
+<br>
+/* On Maple 64bit target host bridge parent node has specified address and=
<br>
+ * size properties to be 2. But the actual &quot;cell&quot; value for host=
 bridge node<br>
+ * is 1 since early MOTLoad internal bug. */<br>
+static void __init fixup_device_tree_maple_hb(void)<br>
+{<br>
+ =A0 =A0 =A0 phandle hb;<br>
+ =A0 =A0 =A0 u32 hb_ranges[4];<br>
+ =A0 =A0 =A0 u32 size_cell, addr_cell;<br>
+ =A0 =A0 =A0 struct prom_t *_prom =3D &amp;RELOC(prom);<br>
+ =A0 =A0 =A0 char *name;<br>
+<br>
+ =A0 =A0 =A0 name =3D &quot;/hostbridge@f8000000&quot;;<br>
+ =A0 =A0 =A0 hb =3D call_prom(&quot;finddevice&quot;, 1, 1, ADDR(name));<b=
r>
+ =A0 =A0 =A0 if (!PHANDLE_VALID(hb))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
+<br>
+ =A0 =A0 =A0 if (prom_getproplen(hb, &quot;reg&quot;) !=3D 8)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
+<br>
+ =A0 =A0 =A0 if (prom_getprop(hb, &quot;reg&quot;, hb_ranges, (sizeof(hb_r=
anges))/2)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=3D PROM_ERROR)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
+<br>
+ =A0 =A0 =A0 prom_getprop(_prom-&gt;root, &quot;#address-cells&quot;, &amp=
;addr_cell, sizeof(addr_cell));<br>
+ =A0 =A0 =A0 prom_getprop(_prom-&gt;root, &quot;#size-cells&quot;, &amp;si=
ze_cell, sizeof(size_cell));<br>
+<br>
+ =A0 =A0 =A0 if ((addr_cell !=3D 2) || (size_cell !=3D 2) ||<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 (hb_ranges[0] !=3D 0xf8000000))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
+<br>
+ =A0 =A0 =A0 prom_printf(&quot;Fixing up bogus HOSTBRIDGE reg on Maple/Apa=
che...\n&quot;);<br>
+<br>
+ =A0 =A0 =A0 hb_ranges[3] =3D hb_ranges[1];<br>
+ =A0 =A0 =A0 hb_ranges[1] =3D hb_ranges[0];<br>
+ =A0 =A0 =A0 hb_ranges[0] =3D hb_ranges[2] =3D 0;<br>
+ =A0 =A0 =A0 prom_setprop(hb, name, &quot;reg&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 hb_ranges, sizeof(hb_ranges));<br>
+}<br>
+<br>
=A0#else<br>
=A0#define fixup_device_tree_maple()<br>
+#define fixup_device_tree_maple_hb()<br>
=A0#endif<br>
<br>
=A0#ifdef CONFIG_PPC_CHRP<br>
@@ -2190,6 +2231,7 @@ static void __init fixup_device_tree_efika(void)<br>
=A0static void __init fixup_device_tree(void)<br>
=A0{<br>
 =A0 =A0 =A0 =A0fixup_device_tree_maple();<br>
+ =A0 =A0 =A0 fixup_device_tree_maple_hb();<br>
 =A0 =A0 =A0 =A0fixup_device_tree_chrp();<br>
 =A0 =A0 =A0 =A0fixup_device_tree_pmac();<br>
 =A0 =A0 =A0 =A0fixup_device_tree_efika();<br>
<font color=3D"#888888">--<br>
1.5.6<br>
<br>
</font></div><br>

--000e0cd20d1435b8ec0463cf87c5--
