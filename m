Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE004.bigfish.com (va3ehsobe004.messaging.microsoft.com
	[216.32.180.14]) by ozlabs.org (Postfix) with ESMTP id 06E251007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Jul 2010 01:34:04 +1000 (EST)
Received: from mail84-va3 (localhost.localdomain [127.0.0.1])	by
	mail84-va3-R.bigfish.com (Postfix) with ESMTP id A1C9E15B0158	for
	<linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jul 2010 15:33:52 +0000 (UTC)
Received: from VA3EHSMHS026.bigfish.com (unknown [10.7.14.245])	by
	mail84-va3.bigfish.com (Postfix) with ESMTP id AA3F37081B9	for
	<linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jul 2010 15:33:20 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o6EFXH1Q013120	for
	<linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jul 2010 08:33:17 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o6EFjN9o009437	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Jul 2010 10:45:23 -0500 (CDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CB2369.E0AC23B7"
Subject: Re: [PATCH V4] powerpc/prom: Export device tree physical address via
	proc
Date: Wed, 14 Jul 2010 08:33:15 -0700
Message-ID: <5610599F537DD74A8D1F5CC946A750730347904A@az33exm25.fsl.freescale.net>
In-Reply-To: <1279120733-13584-1-git-send-email-msm@freescale.com>
References: <1279120733-13584-1-git-send-email-msm@freescale.com>
From: Tabi Timur-B04825 <B04825@freescale.com>
To: "McClintock Matthew-B29882" <msm@freescale.com>
Cc: Gala Kumar-B11780 <kumar.gala@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

------_=_NextPart_001_01CB2369.E0AC23B7
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Matthew McClintock wrote:

> +static struct property flat_dt_start_prop =3D {
> +	.name =3D "linux,devicetree-start",
> +	.length =3D sizeof(phys_addr_t),
> +	.value =3D&flat_dt_start,
> +};
> +
> +static struct property flat_dt_end_prop =3D {
> +	.name =3D "linux,devicetree-end",
> +	.length =3D sizeof(phys_addr_t),
> +	.value =3D&flat_dt_end,
> +};

I think Segher was suggesting that you use "linux,device-tree-xxx".

> +
> +static int __init export_flat_device_tree_phys_addr(void)
> +{
> +	struct property *prop;
> +	struct device_node *node;
> +
> +	node =3D of_find_node_by_path("/chosen");
> +	if (!node)
> +		return -ENOENT;
> +
> +	prop =3D of_find_property(node, "linux,devicetree-start", NULL);

Does this work?

prop =3D of_find_property(node, flat_dt_start_prop.name, NULL);

> +	if (prop)
> +		prom_remove_property(node, prop);
> +
> +	prop =3D of_find_property(node, "linux,devicetree-end", NULL);
> +	if (prop)
> +		prom_remove_property(node, prop);
> +
> +	flat_dt_start =3D virt_to_phys(initial_boot_params);
> +	flat_dt_end =3D virt_to_phys(initial_boot_params)
> +				+ initial_boot_params->totalsize;

This is better, I think:

	flat_dt_end =3D flat_dt_start + initial_boot_params->totalsize;

--=20
Timur Tabi
Linux kernel developer

------_=_NextPart_001_01CB2369.E0AC23B7
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7654.12">
<TITLE>Re: [PATCH V4] powerpc/prom: Export device tree physical address =
via proc</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Matthew McClintock wrote:<BR>
<BR>
&gt; +static struct property flat_dt_start_prop =3D {<BR>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; .name =3D =
&quot;linux,devicetree-start&quot;,<BR>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; .length =3D sizeof(phys_addr_t),<BR>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; .value =3D&amp;flat_dt_start,<BR>
&gt; +};<BR>
&gt; +<BR>
&gt; +static struct property flat_dt_end_prop =3D {<BR>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; .name =3D =
&quot;linux,devicetree-end&quot;,<BR>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; .length =3D sizeof(phys_addr_t),<BR>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; .value =3D&amp;flat_dt_end,<BR>
&gt; +};<BR>
<BR>
I think Segher was suggesting that you use =
&quot;linux,device-tree-xxx&quot;.<BR>
<BR>
&gt; +<BR>
&gt; +static int __init export_flat_device_tree_phys_addr(void)<BR>
&gt; +{<BR>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct property *prop;<BR>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct device_node *node;<BR>
&gt; +<BR>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; node =3D =
of_find_node_by_path(&quot;/chosen&quot;);<BR>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!node)<BR>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOENT;<BR>
&gt; +<BR>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; prop =3D of_find_property(node, =
&quot;linux,devicetree-start&quot;, NULL);<BR>
<BR>
Does this work?<BR>
<BR>
prop =3D of_find_property(node, flat_dt_start_prop.name, NULL);<BR>
<BR>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (prop)<BR>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prom_remove_property(node, =
prop);<BR>
&gt; +<BR>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; prop =3D of_find_property(node, =
&quot;linux,devicetree-end&quot;, NULL);<BR>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (prop)<BR>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prom_remove_property(node, =
prop);<BR>
&gt; +<BR>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; flat_dt_start =3D =
virt_to_phys(initial_boot_params);<BR>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; flat_dt_end =3D =
virt_to_phys(initial_boot_params)<BR>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; + =
initial_boot_params-&gt;totalsize;<BR>
<BR>
This is better, I think:<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flat_dt_end =3D flat_dt_start =
+ initial_boot_params-&gt;totalsize;<BR>
<BR>
--<BR>
Timur Tabi<BR>
Linux kernel developer<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CB2369.E0AC23B7--
