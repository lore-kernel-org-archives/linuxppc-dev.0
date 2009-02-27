Return-Path: <tiejun.china@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.173])
	by ozlabs.org (Postfix) with ESMTP id B65BFDDDA0
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Feb 2009 12:55:52 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 27so895275wfd.15
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Feb 2009 17:55:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1235680139.7388.15.camel@pasglop>
References: <1235642785-9684-1-git-send-email-tiejun.chen@windriver.com>
	<7a800c8d0902260208g4a65b07fi1bb287910c51b342@mail.gmail.com>
	<1235680139.7388.15.camel@pasglop>
Date: Fri, 27 Feb 2009 09:55:51 +0800
Message-ID: <7a800c8d0902261755s203ef8a1n52ffa12b51a5a12@mail.gmail.com>
Subject: Re: [PATCH 1/1] Fix 64bit Mapple Host Bridge Address and Size Nodes
From: Tiejun Chen <tiejun.china@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: multipart/mixed; boundary=005045029ff8b798260463dcc484
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--005045029ff8b798260463dcc484
Content-Type: multipart/alternative; boundary=005045029ff8b798200463dcc482

--005045029ff8b798200463dcc482
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

2009/2/27 Benjamin Herrenschmidt <benh@kernel.crashing.org>

> On Thu, 2009-02-26 at 18:08 +0800, Tiejun Chen wrote:
> > In the DTB tree created by firmware on Maple 64bit target, host bridge
> > parent
> > node has specified both of these two properties to be 2. However, the
> > actual
> > "cell" value for host bridge node is 1. we have to provide one fixup
> > function.
>
> Hi !
>
> Thanks for the patch. A couple of things tho: Can you make it a bit
> more robust by properly checking the board type first ?


That is ATCA 6101 and the following is from the MOTLoad firmware.
------
Copyright Motorola Inc. 1999-2006, All Rights Reserved
MOTLoad RTOS Version 2.0,  PAL Version 1.1 RM01
Built on Tue Jun 13 10:31:56 EDT 2006 by q3316c
bbs 2.0 build 38

Part Number          =01-W3930F04A
Serial Number        =0000001

MPU-Type             =PPC970FX DD3.1
MPU-Int Clock Speed  =1800MHz
Memory Speed         =333MHz

PCI bus instance 1   =64 bit, 100 MHz, PCI-X
PCI bus instance 2   =64 bit, 100 MHz, PCI-X
PCI bus instance 3   =64 bit, 100 MHz, PCI-X
PCI bus instance 4   =64 bit, 100 MHz, PCI-X
PCI bus instance 5   =32 bit, 33 MHz, PCI

HT Link instance 1   =16 bit, 400 MHz
HT Link instance 2   = 8 bit, 600 MHz
HT Link instance 3   = 8 bit, 200 MHz

MOTLoad FLASH Image  =FLASH Bank A

Local Memory Found   =080000000 (&2147483648)
User Download Buffer =0611A5000:0613A4FFF
------

Here is some board information I can know:
------
Board revision: 01
Boot loader version: 2.0
Silicon revision: 3.1 (pvr 003c 0301)
------


>
> Also, what is this "hostbridge" node ? ie, what does it represent ?


 That means IBM CPC925 system controller resided on the ATCA 6101.


>
> Can you send me a full dump of /proc/device-tree from the machine ?
> (ie tar it up)
>

See the attachment.


>
> Finally, it looks like your patch was whitespace damaged by your mailer.
>

After you confirm others is ok I will send v2 improved patch.

Thanks & Best Regards
Tiejun


>
> Cheers,
> Ben.
>
>
> > Signed-off-by: Tiejun Chen <tiejun.china@gmail.com>
> > ---
> >  arch/powerpc/kernel/prom_init.c |   42
> > +++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 42 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/prom_init.c
> > b/arch/powerpc/kernel/prom_init.c
> > index 2445945..9cd23b6 100644
> > --- a/arch/powerpc/kernel/prom_init.c
> > +++ b/arch/powerpc/kernel/prom_init.c
> > @@ -1948,8 +1948,49 @@ static void __init
> > fixup_device_tree_maple(void)
> >        prom_setprop(isa, name, "ranges",
> >                        isa_ranges, sizeof(isa_ranges));
> >  }
> > +
> > +/* On Maple 64bit target host bridge parent node has specified
> > address and
> > + * size properties to be 2. But the actual "cell" value for host
> > bridge node
> > + * is 1 since early MOTLoad internal bug. */
> > +static void __init fixup_device_tree_maple_hb(void)
> > +{
> > +       phandle hb;
> > +       u32 hb_ranges[4];
> > +       u32 size_cell, addr_cell;
> > +       struct prom_t *_prom = &RELOC(prom);
> > +       char *name;
> > +
> > +       name = "/hostbridge@f8000000";
> > +       hb = call_prom("finddevice", 1, 1, ADDR(name));
> > +       if (!PHANDLE_VALID(hb))
> > +               return;
> > +
> > +       if (prom_getproplen(hb, "reg") != 8)
> > +               return;
> > +
> > +       if (prom_getprop(hb, "reg", hb_ranges, (sizeof(hb_ranges))/2)
> > +               == PROM_ERROR)
> > +               return;
> > +
> > +       prom_getprop(_prom->root, "#address-cells", &addr_cell,
> > sizeof(addr_cell));
> > +       prom_getprop(_prom->root, "#size-cells", &size_cell,
> > sizeof(size_cell));
> > +
> > +       if ((addr_cell != 2) || (size_cell != 2) ||
> > +               (hb_ranges[0] != 0xf8000000))
> > +               return;
> > +
> > +       prom_printf("Fixing up bogus HOSTBRIDGE reg on
> > Maple/Apache...\n");
> > +
> > +       hb_ranges[3] = hb_ranges[1];
> > +       hb_ranges[1] = hb_ranges[0];
> > +       hb_ranges[0] = hb_ranges[2] = 0;
> > +       prom_setprop(hb, name, "reg",
> > +               hb_ranges, sizeof(hb_ranges));
> > +}
> > +
> >  #else
> >  #define fixup_device_tree_maple()
> > +#define fixup_device_tree_maple_hb()
> >  #endif
> >
> >  #ifdef CONFIG_PPC_CHRP
> > @@ -2190,6 +2231,7 @@ static void __init fixup_device_tree_efika(void)
> >  static void __init fixup_device_tree(void)
> >  {
> >        fixup_device_tree_maple();
> > +       fixup_device_tree_maple_hb();
> >        fixup_device_tree_chrp();
> >        fixup_device_tree_pmac();
> >        fixup_device_tree_efika();
> > --
> > 1.5.6
> >
> >
> >
>
>

--005045029ff8b798200463dcc482
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2009/2/27 Benjamin Herrenschmidt <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:benh@kernel.crashing.org">benh@kernel.cras=
hing.org</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"borde=
r-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-le=
ft: 1ex;">
<div class=3D"Ih2E3d">On Thu, 2009-02-26 at 18:08 +0800, Tiejun Chen wrote:=
<br>
&gt; In the DTB tree created by firmware on Maple 64bit target, host bridge=
<br>
&gt; parent<br>
&gt; node has specified both of these two properties to be 2. However, the<=
br>
&gt; actual<br>
&gt; &quot;cell&quot; value for host bridge node is 1. we have to provide o=
ne fixup<br>
&gt; function.<br>
<br>
</div>Hi !<br>
<br>
Thanks for the patch. A couple of things tho: Can you make it a bit<br>
more robust by properly checking the board type first ?</blockquote><div><b=
r>That is ATCA 6101 and the following is from the MOTLoad firmware.<br>----=
--<br>Copyright Motorola Inc. 1999-2006, All Rights Reserved<br>MOTLoad RTO=
S Version 2.0,=A0 PAL Version 1.1 RM01<br>
Built on Tue Jun 13 10:31:56 EDT 2006 by q3316c<br>bbs 2.0 build 38<br><br>=
Part Number=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D01-W3930F04A<br>Serial Number=A0=
=A0=A0=A0=A0=A0=A0 =3D0000001<br><br>MPU-Type=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 =3DPPC970FX DD3.1<br>MPU-Int Clock Speed=A0 =3D1800MHz<br>
Memory Speed=A0=A0=A0=A0=A0=A0=A0=A0 =3D333MHz<br><br>PCI bus instance 1=A0=
=A0 =3D64 bit, 100 MHz, PCI-X<br>PCI bus instance 2=A0=A0 =3D64 bit, 100 MH=
z, PCI-X<br>PCI bus instance 3=A0=A0 =3D64 bit, 100 MHz, PCI-X<br>PCI bus i=
nstance 4=A0=A0 =3D64 bit, 100 MHz, PCI-X<br>
PCI bus instance 5=A0=A0 =3D32 bit, 33 MHz, PCI<br><br>HT Link instance 1=
=A0=A0 =3D16 bit, 400 MHz<br>HT Link instance 2=A0=A0 =3D 8 bit, 600 MHz<br=
>HT Link instance 3=A0=A0 =3D 8 bit, 200 MHz<br><br>MOTLoad FLASH Image=A0 =
=3DFLASH Bank A<br><br>Local Memory Found=A0=A0 =3D080000000 (&amp;21474836=
48)<br>
User Download Buffer =3D0611A5000:0613A4FFF<br>------<br><br>Here is some b=
oard information I can know:<br>------<br>Board revision: 01<br>Boot loader=
 version: 2.0<br>Silicon revision: 3.1 (pvr 003c 0301) <br>------<br><br>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<br>
Also, what is this &quot;hostbridge&quot; node ? ie, what does it represent=
 ?</blockquote><div><br>=A0That means IBM CPC925 system controller resided =
on the ATCA 6101.<br><br></div><blockquote class=3D"gmail_quote" style=3D"b=
order-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; paddin=
g-left: 1ex;">
<br>
<br>
Can you send me a full dump of /proc/device-tree from the machine ?<br>
(ie tar it up)<br>
</blockquote><div><br>See the attachment.<br>=A0<br></div><blockquote class=
=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin=
: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
Finally, it looks like your patch was whitespace damaged by your mailer.<br=
>
</blockquote><div><br>After you confirm others is ok I will send v2 improve=
d patch.<br><br>Thanks &amp; Best Regards<br>Tiejun<br>=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); =
margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
Cheers,<br>
Ben.<br>
<div><div></div><div class=3D"Wj3C7c"><br>
<br>
&gt; Signed-off-by: Tiejun Chen &lt;<a href=3D"mailto:tiejun.china@gmail.co=
m">tiejun.china@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; =A0arch/powerpc/kernel/prom_init.c | =A0 42<br>
&gt; +++++++++++++++++++++++++++++++++++++++<br>
&gt; =A01 files changed, 42 insertions(+), 0 deletions(-)<br>
&gt;<br>
&gt; diff --git a/arch/powerpc/kernel/prom_init.c<br>
&gt; b/arch/powerpc/kernel/prom_init.c<br>
&gt; index 2445945..9cd23b6 100644<br>
&gt; --- a/arch/powerpc/kernel/prom_init.c<br>
&gt; +++ b/arch/powerpc/kernel/prom_init.c<br>
&gt; @@ -1948,8 +1948,49 @@ static void __init<br>
&gt; fixup_device_tree_maple(void)<br>
&gt; =A0 =A0 =A0 =A0prom_setprop(isa, name, &quot;ranges&quot;,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0isa_ranges, sizeof(isa_=
ranges));<br>
&gt; =A0}<br>
&gt; +<br>
&gt; +/* On Maple 64bit target host bridge parent node has specified<br>
&gt; address and<br>
&gt; + * size properties to be 2. But the actual &quot;cell&quot; value for=
 host<br>
&gt; bridge node<br>
&gt; + * is 1 since early MOTLoad internal bug. */<br>
&gt; +static void __init fixup_device_tree_maple_hb(void)<br>
&gt; +{<br>
&gt; + =A0 =A0 =A0 phandle hb;<br>
&gt; + =A0 =A0 =A0 u32 hb_ranges[4];<br>
&gt; + =A0 =A0 =A0 u32 size_cell, addr_cell;<br>
&gt; + =A0 =A0 =A0 struct prom_t *_prom =3D &amp;RELOC(prom);<br>
&gt; + =A0 =A0 =A0 char *name;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 name =3D &quot;/hostbridge@f8000000&quot;;<br>
&gt; + =A0 =A0 =A0 hb =3D call_prom(&quot;finddevice&quot;, 1, 1, ADDR(name=
));<br>
&gt; + =A0 =A0 =A0 if (!PHANDLE_VALID(hb))<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 if (prom_getproplen(hb, &quot;reg&quot;) !=3D 8)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 if (prom_getprop(hb, &quot;reg&quot;, hb_ranges, (sizeof=
(hb_ranges))/2)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=3D PROM_ERROR)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 prom_getprop(_prom-&gt;root, &quot;#address-cells&quot;,=
 &amp;addr_cell,<br>
&gt; sizeof(addr_cell));<br>
&gt; + =A0 =A0 =A0 prom_getprop(_prom-&gt;root, &quot;#size-cells&quot;, &a=
mp;size_cell,<br>
&gt; sizeof(size_cell));<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 if ((addr_cell !=3D 2) || (size_cell !=3D 2) ||<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (hb_ranges[0] !=3D 0xf8000000))<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 prom_printf(&quot;Fixing up bogus HOSTBRIDGE reg on<br>
&gt; Maple/Apache...\n&quot;);<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 hb_ranges[3] =3D hb_ranges[1];<br>
&gt; + =A0 =A0 =A0 hb_ranges[1] =3D hb_ranges[0];<br>
&gt; + =A0 =A0 =A0 hb_ranges[0] =3D hb_ranges[2] =3D 0;<br>
&gt; + =A0 =A0 =A0 prom_setprop(hb, name, &quot;reg&quot;,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hb_ranges, sizeof(hb_ranges));<br>
&gt; +}<br>
&gt; +<br>
&gt; =A0#else<br>
&gt; =A0#define fixup_device_tree_maple()<br>
&gt; +#define fixup_device_tree_maple_hb()<br>
&gt; =A0#endif<br>
&gt;<br>
&gt; =A0#ifdef CONFIG_PPC_CHRP<br>
&gt; @@ -2190,6 +2231,7 @@ static void __init fixup_device_tree_efika(void)=
<br>
&gt; =A0static void __init fixup_device_tree(void)<br>
&gt; =A0{<br>
&gt; =A0 =A0 =A0 =A0fixup_device_tree_maple();<br>
&gt; + =A0 =A0 =A0 fixup_device_tree_maple_hb();<br>
&gt; =A0 =A0 =A0 =A0fixup_device_tree_chrp();<br>
&gt; =A0 =A0 =A0 =A0fixup_device_tree_pmac();<br>
&gt; =A0 =A0 =A0 =A0fixup_device_tree_efika();<br>
&gt; --<br>
&gt; 1.5.6<br>
&gt;<br>
&gt;<br>
&gt;<br>
<br>
</div></div></blockquote></div><br>

--005045029ff8b798200463dcc482--

--005045029ff8b798260463dcc484
Content-Type: application/x-gzip; name="maple.dts.gz"
Content-Disposition: attachment; filename="maple.dts.gz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fro7c9ji0

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
--005045029ff8b798260463dcc484--
