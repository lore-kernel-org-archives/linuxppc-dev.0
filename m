Return-Path: <elohimes@gmail.com>
Received: from mail-oi0-x229.google.com (mail-oi0-x229.google.com
 [IPv6:2607:f8b0:4003:c06::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w5ywV4wGczDqG1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 16:27:06 +1000 (AEST)
Received: by mail-oi0-x229.google.com with SMTP id b187so133910676oif.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Apr 2017 23:27:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170414225452.GC5864@bhelgaas-glaptop.roam.corp.google.com>
References: <1491825494-19331-1-git-send-email-elohimes@gmail.com>
 <1491825494-19331-5-git-send-email-elohimes@gmail.com>
 <20170414225452.GC5864@bhelgaas-glaptop.roam.corp.google.com>
From: Yongji Xie <elohimes@gmail.com>
Date: Mon, 17 Apr 2017 14:27:02 +0800
Message-ID: <CAONzpcbKzLCgmX0Y6A0B2W_QvG=UTR9GB5VyAWXaq2ZLwJXgcA@mail.gmail.com>
Subject: Re: [PATCH v10 4/4] PCI: Don't extend device's size when using
 default alignment for all devices
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alex.williamson@redhat.com,
 gwshan@linux.vnet.ibm.com, aik@ozlabs.ru, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org, zhong@linux.vnet.ibm.com
Content-Type: multipart/alternative; boundary=001a1140f77e1b66e1054d56e1f5
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a1140f77e1b66e1054d56e1f5
Content-Type: text/plain; charset=UTF-8

2017-04-15 6:54 GMT+08:00 Bjorn Helgaas <helgaas@kernel.org>:

> On Mon, Apr 10, 2017 at 07:58:14PM +0800, Yongji Xie wrote:
> > Currently we reassign the alignment by extending resources' size in
> > pci_reassigndev_resource_alignment(). This could potentially break
> > some drivers when the driver uses the size to locate register
> > whose length is related to the size. Some examples as below:
> >
> > - misc/Hpilo.c:
>
> If you're going to quote filenames, they need to match the actual
> files in the tree.  In this case, "hpilo.c", not "Hpilo.c".  Also
> "Nes_hw.c" below is incorrect.
>
>
Will fix it.


> > off = pci_resource_len(pdev, bar) - 0x2000;
> >
> > - net/ethernet/chelsio/cxgb4/cxgb4_uld.h:
> > (pci_resource_len((pdev), 2) - roundup_pow_of_two((vres)->ocq.size))
> >
> > - infiniband/hw/nes/Nes_hw.c:
> > num_pds = pci_resource_len(nesdev->pcidev, BAR_1) >> PAGE_SHIFT;
>
> This BAR is apparently at least a page in size already, so this only
> breaks if we request alignment of more than a page size.
>
>
Oh, yes. I'll remove this one.

> This risk could be easily prevented before because we only had one way
> > (kernel parameter resource_alignment) to touch those codes. And even
> > some users may be happy to see the extended size.
>
> Currently, pci_reassigndev_resource_alignment() extends the size of
> some resources when we use "pci=resource_alignment=..."  That
> certainly breaks places like the ones above.
>
> What do you mean by "some users may be happy to see the extended
> size"?  We're increasing a resource size to something larger than what
> the BAR actually responds to.  I don't see how that can ever be an
> *improvement*.  I can see how most drivers won't care, and a few (like
> the ones you cite above) will break.  But I don't see how any driver
> could be *helped* by us making the resource larger.
>
>
>From commit 32a9a68 (PCI: allow assignment of memory resources with a
specified alignment), it seems that "pci=resource_alignment" was introduced
because we want to use PCI pass-through for some page-unaligned devices.

So there might be some cases that users use "pci=resource_alignment" to
extend the BAR's size then passthrough them. That's why I say "some users
may be happy to see the extended size". We are not able to passthrough
the device unless we extend its BARs to PAGE_SIZE.


> > But now we introduce pcibios_default_alignment() to set default alignment
> > for all PCI devices which would also touch those codes. It would be hard
> > to prevent the risk in this case. So this patch tries to use
> > START_ALIGNMENT to identify the resource's alignment without extending
> > the size when the alignment reassigning is caused by the default
> alignment.
> >
> > Signed-off-by: Yongji Xie <elohimes@gmail.com>
> > ---
> >  drivers/pci/pci.c |   34 ++++++++++++++++++++++++----------
> >  1 file changed, 24 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 02f1255..358366e 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -4959,11 +4959,13 @@ resource_size_t __weak
> pcibios_default_alignment(struct pci_dev *dev)
> >  /**
> >   * pci_specified_resource_alignment - get resource alignment specified
> by user.
> >   * @dev: the PCI device to get
> > + * @resize: whether or not to change resources' size when reassigning
> alignment
> >   *
> >   * RETURNS: Resource alignment if it is specified.
> >   *          Zero if it is not specified.
> >   */
> > -static resource_size_t pci_specified_resource_alignment(struct pci_dev
> *dev)
> > +static resource_size_t pci_specified_resource_alignment(struct pci_dev
> *dev,
> > +                                                     bool *resize)
> >  {
> >       int seg, bus, slot, func, align_order, count;
> >       unsigned short vendor, device, subsystem_vendor, subsystem_device;
> > @@ -5005,6 +5007,7 @@ static resource_size_t
> pci_specified_resource_alignment(struct pci_dev *dev)
> >                               (!device || (device == dev->device)) &&
> >                               (!subsystem_vendor || (subsystem_vendor ==
> dev->subsystem_vendor)) &&
> >                               (!subsystem_device || (subsystem_device ==
> dev->subsystem_device))) {
> > +                             *resize = true;
> >                               if (align_order == -1)
> >                                       align = PAGE_SIZE;
> >                               else
> > @@ -5030,6 +5033,7 @@ static resource_size_t
> pci_specified_resource_alignment(struct pci_dev *dev)
> >                               bus == dev->bus->number &&
> >                               slot == PCI_SLOT(dev->devfn) &&
> >                               func == PCI_FUNC(dev->devfn)) {
> > +                             *resize = true;
> >                               if (align_order == -1)
> >                                       align = PAGE_SIZE;
> >                               else
> > @@ -5062,6 +5066,7 @@ void pci_reassigndev_resource_alignment(struct
> pci_dev *dev)
> >       struct resource *r;
> >       resource_size_t align, size;
> >       u16 command;
> > +     bool resize = false;
> >
> >       /*
> >        * VF BARs are read-only zero according to SR-IOV spec r1.1, sec
> > @@ -5073,7 +5078,7 @@ void pci_reassigndev_resource_alignment(struct
> pci_dev *dev)
> >               return;
> >
> >       /* check if specified PCI is target device to reassign */
> > -     align = pci_specified_resource_alignment(dev);
> > +     align = pci_specified_resource_alignment(dev, &resize);
> >       if (!align)
> >               return;
> >
> > @@ -5101,15 +5106,24 @@ void pci_reassigndev_resource_alignment(struct
> pci_dev *dev)
> >               }
> >
> >               size = resource_size(r);
> > -             if (size < align) {
> > -                     size = align;
> > -                     dev_info(&dev->dev,
> > -                             "Rounding up size of resource #%d to
> %#llx.\n",
> > -                             i, (unsigned long long)size);
> > +             if (resize) {
> > +                     if (size < align) {
> > +                             size = align;
> > +                             dev_info(&dev->dev,
> > +                                     "Rounding up size of resource #%d
> to %#llx.\n",
> > +                                     i, (unsigned long long)size);
> > +                     }
> > +                     r->flags |= IORESOURCE_UNSET;
> > +                     r->start = 0;
> > +             } else {
> > +                     if (size < align) {
> > +                             r->flags &= ~IORESOURCE_SIZEALIGN;
> > +                             r->flags |= IORESOURCE_STARTALIGN |
> > +                                                     IORESOURCE_UNSET;
> > +                             r->start = align;
> > +                     }
>
> I'm still not happy about the fact that we now have these two cases:
>
>   1) If we increase resource alignment because of the
>      "pci=resource_alignment=" parameter, we increase the resource
>      size, and
>
>   2) If we increase resource alignment because of
>      pcibios_default_alignment(), we use IORESOURCE_STARTALIGN and do
>      not increase the resource size.
>
> This makes the code complicated and hard to maintain in the future.
> We talked about this earlier [1], but I'm not sure I've figured out
> the reason.  Here's my guess:
>
> Let's assume we have a 4K BAR and we're requesting alignment to 64K.
> In case 1, we're only changing the alignment for specified devices.
> If we used IORESOURCE_STARTALIGN, we would align that 4K BAR of the
> specified devices to 64K, but BARs of other devices could still be
> assigned in that same 64K page.  Therefore, we must increase the size
> to prevent other BARs in the page, even though this might break some
> drivers.
>
> But in case 2, we're changing the alignment for *all* devices.  In
> this case, we *can* use IORESOURCE_STARTALIGN because we're going to
> align *every* BAR of every device to 64K, so no other BARs will be put
> in the same page.  And since we didn't change the resource size, we
> avoid the problem of breaking drivers.
>
> If that's the reasoning, I'm not 100% sure that the complexity of this
> code is worth it.  It took me half a day to come up with this theory.
> If we do have to go this route, we *must* include comments along this
> line to make it easier next time.
>
>
Your guess is exactly correct. We have two problems when we need to change
one BAR's alignment:

1) If we extend the BAR's size, we may break the driver

2) If we only change the alignment without extending size, we have no way to
prevent other BARs being assigned into the same page.

I failed to come up with a way to use only one way to satisfy the two cases.
So I handle the two cases separately like those codes. But as you said, this
makes the code hard to maintain. I think what I can do next is to add some
comments to make the codes easier to read and maintain. Of course, if
anybody have a better idea, I'll be happy to see it.

Thanks,
Yongji

--001a1140f77e1b66e1054d56e1f5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">2017-04-15 6:54 GMT+08:00 Bjorn Helgaas <span dir=3D"ltr">=
&lt;<a href=3D"mailto:helgaas@kernel.org" target=3D"_blank">helgaas@kernel.=
org</a>&gt;</span>:<br><div class=3D"gmail_extra"><div class=3D"gmail_quote=
"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex"><span>On Mon, Apr 10, 2=
017 at 07:58:14PM +0800, Yongji Xie wrote:<br>
&gt; Currently we reassign the alignment by extending resources&#39; size i=
n<br>
&gt; pci_reassigndev_resource_align<wbr>ment(). This could potentially brea=
k<br>
&gt; some drivers when the driver uses the size to locate register<br>
&gt; whose length is related to the size. Some examples as below:<br>
&gt;<br>
&gt; - misc/Hpilo.c:<br>
<br>
</span>If you&#39;re going to quote filenames, they need to match the actua=
l<br>
files in the tree.=C2=A0 In this case, &quot;hpilo.c&quot;, not &quot;Hpilo=
.c&quot;.=C2=A0 Also<br>
&quot;Nes_hw.c&quot; below is incorrect.<br>
<span><br></span></blockquote><div><br></div><div>Will fix it.<br>=C2=A0<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex"><span>
&gt; off =3D pci_resource_len(pdev, bar) - 0x2000;<br>
&gt;<br>
&gt; - net/ethernet/chelsio/cxgb4/cxg<wbr>b4_uld.h:<br>
&gt; (pci_resource_len((pdev), 2) - roundup_pow_of_two((vres)-&gt;ocq<wbr>.=
size))<br>
&gt;<br>
&gt; - infiniband/hw/nes/Nes_hw.c:<br>
&gt; num_pds =3D pci_resource_len(nesdev-&gt;pcide<wbr>v, BAR_1) &gt;&gt; P=
AGE_SHIFT;<br>
<br>
</span>This BAR is apparently at least a page in size already, so this only=
<br>
breaks if we request alignment of more than a page size.<br>
<span><br></span></blockquote><div><br>Oh, yes. I&#39;ll remove this one.<b=
r><br> </div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><span>
&gt; This risk could be easily prevented before because we only had one way=
<br>
&gt; (kernel parameter resource_alignment) to touch those codes. And even<b=
r>
&gt; some users may be happy to see the extended size.<br>
<br>
</span>Currently, pci_reassigndev_resource_align<wbr>ment() extends the siz=
e of<br>
some resources when we use &quot;pci=3Dresource_alignment=3D...&quot;=C2=A0=
 That<br>
certainly breaks places like the ones above.<br>
<br>
What do you mean by &quot;some users may be happy to see the extended<br>
size&quot;?=C2=A0 We&#39;re increasing a resource size to something larger =
than what<br>
the BAR actually responds to.=C2=A0 I don&#39;t see how that can ever be an=
<br>
*improvement*.=C2=A0 I can see how most drivers won&#39;t care, and a few (=
like<br>
the ones you cite above) will break.=C2=A0 But I don&#39;t see how any driv=
er<br>
could be *helped* by us making the resource larger.<br>
<div><div class=3D"gmail-m_-839508379538751553h5"><br></div></div></blockqu=
ote><div><br><div>From commit 32a9a68 (PCI: allow assignment of memory reso=
urces with a<br>specified alignment), it seems that &quot;pci=3Dresource_al=
ignment&quot; was introduced<br>because we want to use PCI pass-through for=
 some page-unaligned devices.<br></div><div><br></div><div>So there might b=
e some cases that users use &quot;pci=3Dresource_alignment&quot; to<br></di=
v><div>extend the BAR&#39;s size then passthrough them. That&#39;s why I sa=
y &quot;some users<br>may be happy to see the extended size&quot;. We are n=
ot able to passthrough<br></div>the device unless we extend its BARs to PAG=
E_SIZE.<br>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><div><div class=3D"gmail-m_-839508379538751553h5">
&gt; But now we introduce pcibios_default_alignment() to set default alignm=
ent<br>
&gt; for all PCI devices which would also touch those codes. It would be ha=
rd<br>
&gt; to prevent the risk in this case. So this patch tries to use<br>
&gt; START_ALIGNMENT to identify the resource&#39;s alignment without exten=
ding<br>
&gt; the size when the alignment reassigning is caused by the default align=
ment.<br>
&gt;<br>
&gt; Signed-off-by: Yongji Xie &lt;<a href=3D"mailto:elohimes@gmail.com" ta=
rget=3D"_blank">elohimes@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/pci/pci.c |=C2=A0 =C2=A034 ++++++++++++++++++++++++-----=
-<wbr>----<br>
&gt;=C2=A0 1 file changed, 24 insertions(+), 10 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c<br>
&gt; index 02f1255..358366e 100644<br>
&gt; --- a/drivers/pci/pci.c<br>
&gt; +++ b/drivers/pci/pci.c<br>
&gt; @@ -4959,11 +4959,13 @@ resource_size_t __weak pcibios_default_alignme=
nt(stru<wbr>ct pci_dev *dev)<br>
&gt;=C2=A0 /**<br>
&gt;=C2=A0 =C2=A0* pci_specified_resource_alignme<wbr>nt - get resource ali=
gnment specified by user.<br>
&gt;=C2=A0 =C2=A0* @dev: the PCI device to get<br>
&gt; + * @resize: whether or not to change resources&#39; size when reassig=
ning alignment<br>
&gt;=C2=A0 =C2=A0*<br>
&gt;=C2=A0 =C2=A0* RETURNS: Resource alignment if it is specified.<br>
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Zero if it is not spec=
ified.<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -static resource_size_t pci_specified_resource_alignme<wbr>nt(struct p=
ci_dev *dev)<br>
&gt; +static resource_size_t pci_specified_resource_alignme<wbr>nt(struct p=
ci_dev *dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool *resize)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int seg, bus, slot, func, align_order, count=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned short vendor, device, subsystem_ven=
dor, subsystem_device;<br>
&gt; @@ -5005,6 +5007,7 @@ static resource_size_t pci_specified_resource_al=
ignme<wbr>nt(struct pci_dev *dev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(!device || (device =3D=3D dev-&gt=
;device)) &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(!subsystem_vendor || (subsystem_v=
endor =3D=3D dev-&gt;subsystem_vendor)) &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(!subsystem_device || (subsystem_d=
evice =3D=3D dev-&gt;subsystem_device))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*resize =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (align_order =3D=3D -1)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0align =
=3D PAGE_SIZE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
&gt; @@ -5030,6 +5033,7 @@ static resource_size_t pci_specified_resource_al=
ignme<wbr>nt(struct pci_dev *dev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bus =3D=3D dev-&gt;bus-&gt;number =
&amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0slot =3D=3D PCI_SLOT(dev-&gt;devfn=
) &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0func =3D=3D PCI_FUNC(dev-&gt;devfn=
)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*resize =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (align_order =3D=3D -1)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0align =
=3D PAGE_SIZE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
&gt; @@ -5062,6 +5066,7 @@ void pci_reassigndev_resource_align<wbr>ment(str=
uct pci_dev *dev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct resource *r;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0resource_size_t align, size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0u16 command;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bool resize =3D false;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * VF BARs are read-only zero according to S=
R-IOV spec r1.1, sec<br>
&gt; @@ -5073,7 +5078,7 @@ void pci_reassigndev_resource_align<wbr>ment(str=
uct pci_dev *dev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* check if specified PCI is target device t=
o reassign */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0align =3D pci_specified_resource_alignme<wbr>nt(d=
ev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0align =3D pci_specified_resource_alignme<wbr>nt(d=
ev, &amp;resize);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!align)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;<br>
&gt; @@ -5101,15 +5106,24 @@ void pci_reassigndev_resource_align<wbr>ment(s=
truct pci_dev *dev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size =3D resourc=
e_size(r);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (size &lt; align) =
{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0size =3D align;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0dev_info(&amp;dev-&gt;dev,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Rounding up size of resource #%d t=
o %#llx.\n&quot;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i, (unsigned long long)size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (resize) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (size &lt; align) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size =3D align;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info(&amp;dev-&gt;dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Roundi=
ng up size of resource #%d to %#llx.\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i, (unsigned=
 long long)size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0r-&gt;flags |=3D IORESOURCE_UNSET;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0r-&gt;start =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (size &lt; align) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r-&gt;flags &amp;=3D ~IORESOURCE_SIZEALI=
GN;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r-&gt;flags |=3D IORESOURCE_STARTALIGN |=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0IORESOURCE_UNSET;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r-&gt;start =3D align;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
<br>
</div></div>I&#39;m still not happy about the fact that we now have these t=
wo cases:<br>
<br>
=C2=A0 1) If we increase resource alignment because of the<br>
=C2=A0 =C2=A0 =C2=A0&quot;pci=3Dresource_alignment=3D&quot; parameter, we i=
ncrease the resource<br>
=C2=A0 =C2=A0 =C2=A0size, and<br>
<br>
=C2=A0 2) If we increase resource alignment because of<br>
=C2=A0 =C2=A0 =C2=A0pcibios_default_alignment(), we use IORESOURCE_STARTALI=
GN and do<br>
=C2=A0 =C2=A0 =C2=A0not increase the resource size.<br>
<br>
This makes the code complicated and hard to maintain in the future.<br>
We talked about this earlier [1], but I&#39;m not sure I&#39;ve figured out=
<br>
the reason.=C2=A0 Here&#39;s my guess:<br>
<br>
Let&#39;s assume we have a 4K BAR and we&#39;re requesting alignment to 64K=
.<br>
In case 1, we&#39;re only changing the alignment for specified devices.<br>
If we used IORESOURCE_STARTALIGN, we would align that 4K BAR of the<br>
specified devices to 64K, but BARs of other devices could still be<br>
assigned in that same 64K page.=C2=A0 Therefore, we must increase the size<=
br>
to prevent other BARs in the page, even though this might break some<br>
drivers.<br>
<br>
But in case 2, we&#39;re changing the alignment for *all* devices.=C2=A0 In=
<br>
this case, we *can* use IORESOURCE_STARTALIGN because we&#39;re going to<br=
>
align *every* BAR of every device to 64K, so no other BARs will be put<br>
in the same page.=C2=A0 And since we didn&#39;t change the resource size, w=
e<br>
avoid the problem of breaking drivers.<br>
<br>
If that&#39;s the reasoning, I&#39;m not 100% sure that the complexity of t=
his<br>
code is worth it.=C2=A0 It took me half a day to come up with this theory.<=
br>
If we do have to go this route, we *must* include comments along this<br>
line to make it easier next time.<br>
<br></blockquote><div><br><div>Your guess is=C2=A0<span class=3D"gmail-m_12=
55938235226888354gmail-op_dict3_font24 gmail-m_1255938235226888354gmail-op_=
dict3_marginRight">exactly correct. We have two problems when we need to ch=
ange<br>one BAR&#39;s alignment:<br><br></span></div><div><span class=3D"gm=
ail-m_1255938235226888354gmail-op_dict3_font24 gmail-m_1255938235226888354g=
mail-op_dict3_marginRight">1) If we extend the BAR&#39;s size, we may break=
 the driver<br><br></span></div><div><span class=3D"gmail-m_125593823522688=
8354gmail-op_dict3_font24 gmail-m_1255938235226888354gmail-op_dict3_marginR=
ight">2) If we only change the alignment without extending size, we have no=
 way to<br>prevent other BARs being assigned into the same page.<br><br>I f=
ailed to come up with a way to use only one way to satisfy the two cases.<b=
r></span></div><div><span class=3D"gmail-m_1255938235226888354gmail-op_dict=
3_font24 gmail-m_1255938235226888354gmail-op_dict3_marginRight">So I handle=
 the two cases </span><span class=3D"gmail-m_1255938235226888354gmail-op_di=
ct3_font24 gmail-m_1255938235226888354gmail-op_dict3_marginRight">separatel=
y like those codes. But as you said, this<br>makes the code hard to maintai=
n. I think what I can do next is to</span><span class=3D"gmail-m_1255938235=
226888354gmail-op_dict3_font24 gmail-m_1255938235226888354gmail-op_dict3_ma=
rginRight"><span class=3D"gmail-m_1255938235226888354gmail-op_dict3_font24 =
gmail-m_1255938235226888354gmail-op_dict3_marginRight"> add some<br>comment=
s</span><span class=3D"gmail-m_1255938235226888354gmail-op_dict3_font24 gma=
il-m_1255938235226888354gmail-op_dict3_marginRight"> to make the codes easi=
er to read and maintain.</span> Of course, if<br>anybody have a better idea=
, I&#39;ll be happy to see it. </span><span class=3D"gmail-m_12559382352268=
88354gmail-op_dict3_font24 gmail-m_1255938235226888354gmail-op_dict3_margin=
Right"></span><span class=3D"gmail-m_1255938235226888354gmail-op_dict3_font=
24 gmail-m_1255938235226888354gmail-op_dict3_marginRight"></span></div><br>=
<div class=3D"gmail_quote">Thanks,<br></div>Yongji <br></div></div></div></=
div>

--001a1140f77e1b66e1054d56e1f5--
