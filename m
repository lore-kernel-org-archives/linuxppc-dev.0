Return-Path: <tiejun.china@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.169])
	by ozlabs.org (Postfix) with ESMTP id 6BA1BDE05F
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Apr 2009 12:27:37 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so1712520wfg.15
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Apr 2009 19:27:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <49E2A2D2.2000606@windriver.com>
References: <49E2A2D2.2000606@windriver.com>
Date: Mon, 13 Apr 2009 10:27:34 +0800
Message-ID: <7a800c8d0904121927h6ec3cb19n9573900f20cda84e@mail.gmail.com>
Subject: Re: [v1 PATCH 1/1] Fix 64bit Maple Host Bridge Address and Size Nodes
From: Tiejun Chen <tiejun.china@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, michael@ellerman.id.au,
	linuxppc-dev@ozlabs.org, akpm@linux-foundation.org
Content-Type: multipart/alternative; boundary=000e0cd2a0a80b8bd104676675a7
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--000e0cd2a0a80b8bd104676675a7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Michael and Ben,

If you are free please help me check this delayed patch.

For the original thread please filter email with the key words "Fix 64bit".

Best Regards
Tiejun



> In the DTB tree created by firmware on some Maple 64bit targets, such as
> ATCA6101,
> these two properties, address&size, should be 2. But the actual
> corresponding
> values
> of host bridge node are set 1 incorrectly by the firmware, we have to
> provide one
> fixup function to fix that.
>
> Signed-off-by: Tiejun Chen <tiejun.china@gmail.com>
> ---
>  arch/powerpc/kernel/prom_init.c |   51
> ++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 50 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/kernel/prom_init.c
> b/arch/powerpc/kernel/prom_init.c
> index 2445945..7848b45 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -1907,14 +1907,63 @@ static void __init flatten_device_tree(void)
>  }
>
>  #ifdef CONFIG_PPC_MAPLE
> +/* On ATCA6101 64bit target host bridge parent node has specified address
> and
> + * size properties to be 2. But the actual "cell" value for host bridge
> node
> + * is 1 since early MOTLoad internal bug. */
> +static void __init fixup_device_tree_atca6101(void)
> +{
> +       phandle hb;
> +       u32 hb_ranges[4];
> +       u32 size_cell, addr_cell;
> +       struct prom_t *_prom = &RELOC(prom);
> +       char *name;
> +
> +       name = "/hostbridge@f8000000";
> +       hb = call_prom("finddevice", 1, 1, ADDR(name));
> +       if (!PHANDLE_VALID(hb))
> +               return;
> +
> +       if (prom_getproplen(hb, "reg") != 8)
> +               return;
> +
> +       if (prom_getprop(hb, "reg", hb_ranges, (sizeof(hb_ranges))/2)
> +               == PROM_ERROR)
> +               return;
> +
> +       prom_getprop(_prom->root, "#address-cells", &addr_cell,
> sizeof(addr_cell));
> +       prom_getprop(_prom->root, "#size-cells", &size_cell,
> sizeof(size_cell));
> +
> +       if ((addr_cell != 2) || (size_cell != 2) ||
> +               (hb_ranges[0] != 0xf8000000))
> +               return;
> +
> +       prom_printf("Fixing up bogus HOSTBRIDGE reg on ATCA6101...\n");
> +
> +       hb_ranges[3] = hb_ranges[1];
> +       hb_ranges[1] = hb_ranges[0];
> +       hb_ranges[0] = hb_ranges[2] = 0;
> +       prom_setprop(hb, name, "reg",
> +       hb_ranges, sizeof(hb_ranges));
> +}
>  /* PIBS Version 1.05.0000 04/26/2005 has an incorrect /ht/isa/ranges
> property.
> - * The values are bad, and it doesn't even have the right number of cells.
> */
> + * The values are bad, and it doesn't even have the right number of cells.
> + * Additionally, the early MOTLoad generate incorrect address&size cells
> on
> + * some Maple platform such as ATCA6101. */
>  static void __init fixup_device_tree_maple(void)
>  {
>        phandle isa;
>        u32 rloc = 0x01002000; /* IO space; PCI device = 4 */
>        u32 isa_ranges[6];
>        char *name;
> +       u32 node;
> +       char prop[64];
> +       int model;
> +
> +       /*  FIXME: This may be used for more Maple targets not only
> ATCA6101. */
> +       node = call_prom("finddevice", 1, 1, ADDR("/"));
> +       model = prom_getprop(node, "model", prop, sizeof(prop));
> +       if (model != PROM_ERROR && (strcmp(prop, "Motorola,ATCA-6101") ==
> 0))
> +                fixup_device_tree_atca6101();
>
>        name = "/ht@0/isa@4";
>        isa = call_prom("finddevice", 1, 1, ADDR(name));
> --
> 1.5.6
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
>

--000e0cd2a0a80b8bd104676675a7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Michael and Ben,<br><br>If you are free please help me check this delayed p=
atch.<br><br>For the original thread please filter email with the key words=
 &quot;Fix 64bit&quot;.<br><br>Best Regards<br>Tiejun<br><br><div class=3D"=
gmail_quote">
<br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(2=
04, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
In the DTB tree created by firmware on some Maple 64bit targets, such as AT=
CA6101,<br>
these two properties, address&amp;size, should be 2. But the actual corresp=
onding<br>
values<br>
of host bridge node are set 1 incorrectly by the firmware, we have to provi=
de one<br>
fixup function to fix that.<br>
<br>
Signed-off-by: Tiejun Chen &lt;<a href=3D"mailto:tiejun.china@gmail.com">ti=
ejun.china@gmail.com</a>&gt;<br>
---<br>
=A0arch/powerpc/kernel/prom_init.c | =A0 51 +++++++++++++++++++++++++++++++=
+++++++-<br>
=A01 files changed, 50 insertions(+), 1 deletions(-)<br>
<br>
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_ini=
t.c<br>
index 2445945..7848b45 100644<br>
--- a/arch/powerpc/kernel/prom_init.c<br>
+++ b/arch/powerpc/kernel/prom_init.c<br>
@@ -1907,14 +1907,63 @@ static void __init flatten_device_tree(void)<br>
=A0}<br>
<br>
=A0#ifdef CONFIG_PPC_MAPLE<br>
+/* On ATCA6101 64bit target host bridge parent node has specified address =
and<br>
+ * size properties to be 2. But the actual &quot;cell&quot; value for host=
 bridge node<br>
+ * is 1 since early MOTLoad internal bug. */<br>
+static void __init fixup_device_tree_atca6101(void)<br>
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
+ =A0 =A0 =A0 prom_printf(&quot;Fixing up bogus HOSTBRIDGE reg on ATCA6101.=
..\n&quot;);<br>
+<br>
+ =A0 =A0 =A0 hb_ranges[3] =3D hb_ranges[1];<br>
+ =A0 =A0 =A0 hb_ranges[1] =3D hb_ranges[0];<br>
+ =A0 =A0 =A0 hb_ranges[0] =3D hb_ranges[2] =3D 0;<br>
+ =A0 =A0 =A0 prom_setprop(hb, name, &quot;reg&quot;,<br>
+ =A0 =A0 =A0 hb_ranges, sizeof(hb_ranges));<br>
+}<br>
=A0/* PIBS Version 1.05.0000 04/26/2005 has an incorrect /ht/isa/ranges pro=
perty.<br>
- * The values are bad, and it doesn&#39;t even have the right number of ce=
lls. */<br>
+ * The values are bad, and it doesn&#39;t even have the right number of ce=
lls.<br>
+ * Additionally, the early MOTLoad generate incorrect address&amp;size cel=
ls on<br>
+ * some Maple platform such as ATCA6101. */<br>
=A0static void __init fixup_device_tree_maple(void)<br>
=A0{<br>
 =A0 =A0 =A0 =A0phandle isa;<br>
 =A0 =A0 =A0 =A0u32 rloc =3D 0x01002000; /* IO space; PCI device =3D 4 */<b=
r>
 =A0 =A0 =A0 =A0u32 isa_ranges[6];<br>
 =A0 =A0 =A0 =A0char *name;<br>
+ =A0 =A0 =A0 u32 node;<br>
+ =A0 =A0 =A0 char prop[64];<br>
+ =A0 =A0 =A0 int model;<br>
+<br>
+ =A0 =A0 =A0 /* =A0FIXME: This may be used for more Maple targets not only=
 ATCA6101. */<br>
+ =A0 =A0 =A0 node =3D call_prom(&quot;finddevice&quot;, 1, 1, ADDR(&quot;/=
&quot;));<br>
+ =A0 =A0 =A0 model =3D prom_getprop(node, &quot;model&quot;, prop, sizeof(=
prop));<br>
+ =A0 =A0 =A0 if (model !=3D PROM_ERROR &amp;&amp; (strcmp(prop, &quot;Moto=
rola,ATCA-6101&quot;) =3D=3D 0))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fixup_device_tree_atca6101();<br>
<br>
 =A0 =A0 =A0 =A0name =3D &quot;/ht@0/isa@4&quot;;<br>
 =A0 =A0 =A0 =A0isa =3D call_prom(&quot;finddevice&quot;, 1, 1, ADDR(name))=
;<br>
<font color=3D"#888888">--<br>
1.5.6<br>
<br>
_______________________________________________<br>
Linuxppc-dev mailing list<br>
<a href=3D"mailto:Linuxppc-dev@ozlabs.org">Linuxppc-dev@ozlabs.org</a><br>
<a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-dev" target=3D"_bla=
nk">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a><br>
<br>
</font></blockquote></div><br>

--000e0cd2a0a80b8bd104676675a7--
