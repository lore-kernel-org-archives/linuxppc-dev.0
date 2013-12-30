Return-Path: <robherring2@gmail.com>
Received: from mail-ob0-x22f.google.com (mail-ob0-x22f.google.com
 [IPv6:2607:f8b0:4003:c01::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BCBC12C00BB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Dec 2013 13:42:26 +1100 (EST)
Received: by mail-ob0-f175.google.com with SMTP id uz6so11126676obc.20
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Dec 2013 18:42:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1388371049.4373.22.camel@pasglop>
References: <1387301573-30502-1-git-send-email-clg@fr.ibm.com>
 <1388371049.4373.22.camel@pasglop>
Date: Sun, 29 Dec 2013 20:42:21 -0600
Message-ID: <CAL_JsqJRtk+U4nA7hh9Kh2C4UgbWP6V7sYMnTpAooR_zaySZaw@mail.gmail.com>
Subject: Re: [PATCH] of/irq: Fix device_node refcount in of_irq_parse_raw()
From: Rob Herring <robherring2@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: multipart/alternative; boundary=047d7b33cad2a31d1604eeb76455
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Grant Likely <grant.likely@linaro.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@fr.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--047d7b33cad2a31d1604eeb76455
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 29, 2013 at 8:37 PM, Benjamin Herrenschmidt <
benh@kernel.crashing.org> wrote:

> On Tue, 2013-12-17 at 18:32 +0100, C=E9dric Le Goater wrote:
> > Commit 2361613206e6, "of/irq: Refactor interrupt-map parsing" changed
> > the refcount on the device_node causing an error in of_node_put():
>
> Grant, Thierry, this is a regression, please send to Linus ASAP...
>
>
I'm working on doing that right this moment.

Rob


> Cheers,
> Ben.
>
> > ERROR: Bad of_node_put() on /pci@800000020000000
> > CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.13.0-rc3-dirty #2
> > Call Trace:
> > [c00000003e403500] [c0000000000144fc] .show_stack+0x7c/0x1f0 (unreliabl=
e)
> > [c00000003e4035d0] [c00000000070f250] .dump_stack+0x88/0xb4
> > [c00000003e403650] [c0000000005e8768] .of_node_release+0xd8/0xf0
> > [c00000003e4036e0] [c0000000005eeafc] .of_irq_parse_one+0x10c/0x280
> > [c00000003e4037a0] [c0000000005efd4c] .of_irq_parse_pci+0x3c/0x1d0
> > [c00000003e403840] [c000000000038240] .pcibios_setup_device+0xa0/0x2e0
> > [c00000003e403910] [c0000000000398f0]
> .pcibios_setup_bus_devices+0x60/0xd0
> > [c00000003e403990] [c00000000003b3a4] .__of_scan_bus+0x1a4/0x2b0
> > [c00000003e403a80] [c00000000003a62c] .pcibios_scan_phb+0x30c/0x410
> > [c00000003e403b60] [c0000000009fe430] .pcibios_init+0x7c/0xd4
> >
> > This patch adjusts the refcount in the walk of the interrupt tree.
> > When a match is found, there is no need to increase the refcount
> > on 'out_irq->np' as 'newpar' is already holding a ref. The refcount
> > balance between 'ipar' and 'newpar' is maintained in the skiplevel:
> > goto label.
> >
> > This patch also removes the usage of the device_node variable 'old'
> > which seems useless after the latest changes.
> >
> > Signed-off-by: C=E9dric Le Goater <clg@fr.ibm.com>
> > ---
> >
> > This patch was tested on powerpc, pseries and powernv. This is a
> > new area for me so I might have missed a path. Please take a look.
> >
> > We could now introduce an helper routine to look for #address-cells in
> > of_irq_parse_raw(). This can be the subject of another patch.
> >
> > Thanks,
> >
> > C.
> >
> >  drivers/of/irq.c |    5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> > index 786b0b47fae4..27212402c532 100644
> > --- a/drivers/of/irq.c
> > +++ b/drivers/of/irq.c
> > @@ -165,7 +165,6 @@ int of_irq_parse_raw(const __be32 *addr, struct
> of_phandle_args *out_irq)
> >               if (of_get_property(ipar, "interrupt-controller", NULL) !=
=3D
> >                               NULL) {
> >                       pr_debug(" -> got it !\n");
> > -                     of_node_put(old);
> >                       return 0;
> >               }
> >
> > @@ -250,8 +249,7 @@ int of_irq_parse_raw(const __be32 *addr, struct
> of_phandle_args *out_irq)
> >                * Successfully parsed an interrrupt-map translation; cop=
y
> new
> >                * interrupt specifier into the out_irq structure
> >                */
> > -             of_node_put(out_irq->np);
> > -             out_irq->np =3D of_node_get(newpar);
> > +             out_irq->np =3D newpar;
> >
> >               match_array =3D imap - newaddrsize - newintsize;
> >               for (i =3D 0; i < newintsize; i++)
> > @@ -268,7 +266,6 @@ int of_irq_parse_raw(const __be32 *addr, struct
> of_phandle_args *out_irq)
> >       }
> >   fail:
> >       of_node_put(ipar);
> > -     of_node_put(out_irq->np);
> >       of_node_put(newpar);
> >
> >       return -EINVAL;
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--047d7b33cad2a31d1604eeb76455
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:courier =
new,monospace"><span style=3D"font-family:arial">On Sun, Dec 29, 2013 at 8:=
37 PM, Benjamin Herrenschmidt </span><span dir=3D"ltr" style=3D"font-family=
:arial">&lt;<a href=3D"mailto:benh@kernel.crashing.org" target=3D"_blank">b=
enh@kernel.crashing.org</a>&gt;</span><span style=3D"font-family:arial"> wr=
ote:</span><br>
</div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex"><div class=3D"im">On Tue, 2013-12-17 at 18:32 +0100, C=E9dr=
ic Le Goater wrote:<br>

&gt; Commit 2361613206e6, &quot;of/irq: Refactor interrupt-map parsing&quot=
; changed<br>
&gt; the refcount on the device_node causing an error in of_node_put():<br>
<br>
</div>Grant, Thierry, this is a regression, please send to Linus ASAP...<br=
>
<br></blockquote><div><br></div><div class=3D"gmail_default" style=3D"font-=
family:&#39;courier new&#39;,monospace">I&#39;m working on doing that right=
 this moment.</div><div class=3D"gmail_default" style=3D"font-family:&#39;c=
ourier new&#39;,monospace">
<br></div><div class=3D"gmail_default" style=3D"font-family:&#39;courier ne=
w&#39;,monospace">Rob</div><div class=3D"gmail_default" style=3D"font-famil=
y:&#39;courier new&#39;,monospace"></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

Cheers,<br>
Ben.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; ERROR: Bad of_node_put() on /pci@800000020000000<br>
&gt; CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.13.0-rc3-dirty #2<br>
&gt; Call Trace:<br>
&gt; [c00000003e403500] [c0000000000144fc] .show_stack+0x7c/0x1f0 (unreliab=
le)<br>
&gt; [c00000003e4035d0] [c00000000070f250] .dump_stack+0x88/0xb4<br>
&gt; [c00000003e403650] [c0000000005e8768] .of_node_release+0xd8/0xf0<br>
&gt; [c00000003e4036e0] [c0000000005eeafc] .of_irq_parse_one+0x10c/0x280<br=
>
&gt; [c00000003e4037a0] [c0000000005efd4c] .of_irq_parse_pci+0x3c/0x1d0<br>
&gt; [c00000003e403840] [c000000000038240] .pcibios_setup_device+0xa0/0x2e0=
<br>
&gt; [c00000003e403910] [c0000000000398f0] .pcibios_setup_bus_devices+0x60/=
0xd0<br>
&gt; [c00000003e403990] [c00000000003b3a4] .__of_scan_bus+0x1a4/0x2b0<br>
&gt; [c00000003e403a80] [c00000000003a62c] .pcibios_scan_phb+0x30c/0x410<br=
>
&gt; [c00000003e403b60] [c0000000009fe430] .pcibios_init+0x7c/0xd4<br>
&gt;<br>
&gt; This patch adjusts the refcount in the walk of the interrupt tree.<br>
&gt; When a match is found, there is no need to increase the refcount<br>
&gt; on &#39;out_irq-&gt;np&#39; as &#39;newpar&#39; is already holding a r=
ef. The refcount<br>
&gt; balance between &#39;ipar&#39; and &#39;newpar&#39; is maintained in t=
he skiplevel:<br>
&gt; goto label.<br>
&gt;<br>
&gt; This patch also removes the usage of the device_node variable &#39;old=
&#39;<br>
&gt; which seems useless after the latest changes.<br>
&gt;<br>
&gt; Signed-off-by: C=E9dric Le Goater &lt;<a href=3D"mailto:clg@fr.ibm.com=
">clg@fr.ibm.com</a>&gt;<br>
&gt; ---<br>
&gt;<br>
&gt; This patch was tested on powerpc, pseries and powernv. This is a<br>
&gt; new area for me so I might have missed a path. Please take a look.<br>
&gt;<br>
&gt; We could now introduce an helper routine to look for #address-cells in=
<br>
&gt; of_irq_parse_raw(). This can be the subject of another patch.<br>
&gt;<br>
&gt; Thanks,<br>
&gt;<br>
&gt; C.<br>
&gt;<br>
&gt; =A0drivers/of/irq.c | =A0 =A05 +----<br>
&gt; =A01 file changed, 1 insertion(+), 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/of/irq.c b/drivers/of/irq.c<br>
&gt; index 786b0b47fae4..27212402c532 100644<br>
&gt; --- a/drivers/of/irq.c<br>
&gt; +++ b/drivers/of/irq.c<br>
&gt; @@ -165,7 +165,6 @@ int of_irq_parse_raw(const __be32 *addr, struct of=
_phandle_args *out_irq)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (of_get_property(ipar, &quot;interrupt-=
controller&quot;, NULL) !=3D<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL) {<br=
>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug(&quot; -&gt; got =
it !\n&quot;);<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(old);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt;<br>
&gt; @@ -250,8 +249,7 @@ int of_irq_parse_raw(const __be32 *addr, struct of=
_phandle_args *out_irq)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Successfully parsed an interrrupt-map=
 translation; copy new<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* interrupt specifier into the out_irq =
structure<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(out_irq-&gt;np);<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 out_irq-&gt;np =3D of_node_get(newpar);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 out_irq-&gt;np =3D newpar;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 match_array =3D imap - newaddrsize - newin=
tsize;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i &lt; newintsize; i++)<br>
&gt; @@ -268,7 +266,6 @@ int of_irq_parse_raw(const __be32 *addr, struct of=
_phandle_args *out_irq)<br>
&gt; =A0 =A0 =A0 }<br>
&gt; =A0 fail:<br>
&gt; =A0 =A0 =A0 of_node_put(ipar);<br>
&gt; - =A0 =A0 of_node_put(out_irq-&gt;np);<br>
&gt; =A0 =A0 =A0 of_node_put(newpar);<br>
&gt;<br>
&gt; =A0 =A0 =A0 return -EINVAL;<br>
<br>
<br>
--<br>
</div></div><div class=3D"HOEnZb"><div class=3D"h5">To unsubscribe from thi=
s list: send the line &quot;unsubscribe devicetree&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-info.=
html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><br>
</div></div></blockquote></div><br></div></div>

--047d7b33cad2a31d1604eeb76455--
