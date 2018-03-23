Return-Path: <jared.bents@rockwellcollins.com>
Received: from ch3vs01.rockwellcollins.com (smtpimr.rockwellcollins.com
 [205.175.226.27])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4073851xsKzF1dH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 23:41:54 +1100 (AEDT)
Received: by mail-yw0-f199.google.com with SMTP id y196so5059083ywg.19
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 05:41:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOSf1CFHSnfBgnkyFi1o3SQp7pJvQBk64eAv+SPmOmMVzzQC3w@mail.gmail.com>
References: <CAM=7fbcynhZ3iPtCGpVCgDmw7OU6SQcucZDm1kUdv=soky9RJQ@mail.gmail.com>
 <CAOSf1CGqc9=QnrChOY_+YL0v8TALQ+pH8u1e26Q--0PS4CGm2g@mail.gmail.com>
 <CAM=7fbdN=sLncGK2hgq2fNWeULdff8opViD9UQ3qj29KTG5tNQ@mail.gmail.com>
 <CAOSf1CFHSnfBgnkyFi1o3SQp7pJvQBk64eAv+SPmOmMVzzQC3w@mail.gmail.com>
From: Jared Bents <jared.bents@rockwellcollins.com>
Date: Fri, 23 Mar 2018 07:41:50 -0500
Message-ID: <CAM=7fberG6pwy5kz1h=xnNWO4AeSbCR-N-Yw079qMB1tnhSzvQ@mail.gmail.com>
Subject: Re: DMA Mapping Error in ppc64
To: Oliver <oohall@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: multipart/alternative; boundary="001a114d6e6e945c5e056813bf75"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a114d6e6e945c5e056813bf75
Content-Type: text/plain; charset="UTF-8"

Thank you for the advice.  Looks like I get to try to rewrite the ath9k and
ath10k drivers to use dma_alloc_coherent() instead of kmemdup() and
dev_alloc_skb()

On Thu, Mar 22, 2018 at 8:19 PM, Oliver <oohall@gmail.com> wrote:

> On Fri, Mar 23, 2018 at 1:37 AM, Jared Bents
> <jared.bents@rockwellcollins.com> wrote:
> > Thank you for the response but unfortunately, it looks like I already
> > have that and it is being used.  To verify, I commented that out and
> > got the failure "dma_direct_alloc_coherent: No suitable zone for pfn
> > 0xe0000".  Below is the code flow for function
> > ath10k_pci_hif_exchange_bmi_msg which is showing the first dma mapping
> > error.
> >
> > ath10k_pci_hif_exchange_bmi_msg -> dma_map_single ->
> > dma_map_single_attrs -> swiotlb_map_page -> dma_capable (returns
> > false)
> >
> >
> > dma_capable is what reports the failure in that flow.
> >
> > static inline bool dma_capable(struct device *dev, dma_addr_t addr,
> size_t size)
> > {
> > #ifdef CONFIG_SWIOTLB
> >     struct dev_archdata *sd = &dev->archdata;
> >
> >    if (sd->max_direct_dma_addr && addr + size > sd->max_direct_dma_addr)
> >         return false;
> > #endif
> >
> >     if (!dev->dma_mask)
> >         return false;
> >
> >     return addr + size - 1 <= *dev->dma_mask;
> > }
> > Getting the below values:
> > addr = 1ee376218
> > size = 4
> > sd->max_direct_dma_addr = e0000000 which is I believe DMA window size
> (e0000000)
> >
> > when executed sd->max_direct_dma_addr(e0000000) && addr(1ee376218) +
> > size(4) becomes e0000004 which is > sd->max_direct_dma_addr (e0000000)
> >
> >
> > So even though limit_zone_pfn(ZONE_DMA32, 1UL << (31 - PAGE_SHIFT)) is
> > being used in arch/powerpc/platforms/85xx/corenet_generic.c,
>
> > kmemdup(req, req_len, GFP_KERNEL) is returning an address that when
> > sent to dma_map_single(), results in a bad map.
>
> You need to use (GFP_KERNEL | GFP_DMA32) to constrain the allocations
> to ZONE_DMA32. Without that the kmemdup() will allocate from any zone
> so you'll probably get an unmappable address.
>
> That said, the driver probably shouldn't be using kmemdup() here.
> DMA-API.txt pretty explicitly says that drivers should not assume that
> dma_map_single() will work with arbitrary memory. It should be using
> dma_alloc_coherent() or a dma pool here.
>
> > - Jared
> >
> > On Wed, Mar 21, 2018 at 11:54 PM, Oliver <oohall@gmail.com> wrote:
> >> On Thu, Mar 22, 2018 at 8:00 AM, Jared Bents
> >> <jared.bents@rockwellcollins.com> wrote:
> >>> Hi all,
> >>>
> >>> Apologies for the amount of information but we've been debugging this
> >>> for a while and I wanted to get what we are seeing captured as much as
> >>> possible.  We are a T1042 processor and have a total 8GB DDR and our
> >>> kernel version is fsl-sdk-v2.0-1703 (linux v4.1.35) as that is the
> >>> latest version supplied by NXP.
> >>>
> >>> A while ago we ported from 32 bit to 64 bit.  Everything continued to
> >>> work except the ath10k module we have.  So as a first step, we checked
> >>> to see if an ath9k module also failed to work and it was also no
> >>> longer working.  The ath10k is working fine on a 32 bit system but
> >>> it's not working on 64 bit system as we are getting dma mapping errors
> >>> when trying to initialize the wifi modules.
> >>>
> >>> pci_bus 0002:01: bus scan returning with max=01
> >>> pci_bus 0002:01: busn_res: [bus 01] end is updated to 01
> >>> pci_bus 0002:00: bus scan returning with max=01
> >>> ath10k_pci 0000:01:00.0: unable to get target info from device
> >>> ath10k_pci 0000:01:00.0: could not get target info (-5)
> >>> ath10k_pci 0000:01:00.0: could not probe fw (-5)
> >>> ath10k_pci 0001:01:00.0: Direct firmware load for
> >>> ath10k/cal-pci-0001:01:00.0.bin failed with error -2
> >>>
> >>>
> >>> First, we have tried the mainline kernel (v4.15)  to see if that would
> >>> fix the issue, it did not.  So I made a patch for the ath10k driver to
> >>> restrict to just GFP_DMA areas when allocating memory or creating
> >>> sk_buffs and have attached it.  The ath10k wifi modules now initialize
> >>> correctly but when I try to connect them and send traffic, they get a
> >>> DMA mapping error from the sk_buff that it receives from elsewhere in
> >>> the kernel.  So while the driver appears to be fixable with the patch,
> >>> the modules are still unusable due to data being sent to the driver
> >>> when ath10k_tx is called and it tries to dma map with the provided
> >>> skb.  Also, according to the ath10k mailing list, GFP_DMA is not
> >>> supposed to be used in general.  The error below is the same sort of
> >>> dma mapping error that is seen when initializing the modules without
> >>> the patch to OR with GFP_DMA.
> >>>
> >>> ath10k_pci 0001:01:00.0: failed to transmit packet, dropping: -5
> >>>
> >>>
> >>> We asked on the ath10k mailing list if anyone else is having this
> >>> problem and no one else seems to have the issue but they are using
> >>> different architectures (ARM or X86). As a result, it does not seem to
> >>> be a driver issue to us but something within the PowerPC arch.  So we
> >>> dug a little deeper to try to find what addresses being mapped are
> >>> working and what address being mapped are not working.
> >>>
> >>> We found that when the virtual address of data pointer (a member of
> >>> sk_buff) is above ~3.7 GB RAM address range then return address from
> >>> dma_map_single API is failed to validate in dma_mapping_error
> >>> function.
> >>>
> >>> We also noticed that in a 64bit machine sometimes ping is working and
> >>> because of the virtual address is under ~3.7GAM RAM address range.  So
> >>> if we set mem=2048M in the bootargs, the ath10k module works
> >>> perfectly, however this isn't a real solution since it cuts our
> >>> available RAM from 8GB to 2GB.
> >>
> >> I think there's a known issue with the freescale PCIe root complex
> >> where it can't DMA beyond the 4GB mark. There's a workaround in
> >> the form of limit_zone_pfn() which you can use to put the lower 4GB into
> >> ZONE_DMA32 and allocate from there rather than ZONE_NORMAL.
> >> For details of how to use it have a look at corenet_gen_setup_arch() in
> >> arch/powerpc/platforms/85xx/corenet_generic.c
> >>
> >> Hope that helps,
> >> Oliver
>

--001a114d6e6e945c5e056813bf75
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you for the advice.=C2=A0 Looks like I get to try to=
 rewrite the ath9k and ath10k drivers to use=C2=A0<span style=3D"color:rgb(=
34,34,34);font-family:arial,sans-serif;font-size:12.8px;font-style:normal;f=
ont-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;lette=
r-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white=
-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decor=
ation-style:initial;text-decoration-color:initial;float:none;display:inline=
">dma_alloc_coherent() instead of kmemdup() and dev_alloc_skb()</span></div=
><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, Mar 22, =
2018 at 8:19 PM, Oliver <span dir=3D"ltr">&lt;<a href=3D"mailto:oohall@gmai=
l.com" target=3D"_blank">oohall@gmail.com</a>&gt;</span> wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On Fri, Mar =
23, 2018 at 1:37 AM, Jared Bents<br>
&lt;<a href=3D"mailto:jared.bents@rockwellcollins.com">jared.bents@rockwell=
collins.<wbr>com</a>&gt; wrote:<br>
&gt; Thank you for the response but unfortunately, it looks like I already<=
br>
&gt; have that and it is being used.=C2=A0 To verify, I commented that out =
and<br>
&gt; got the failure &quot;dma_direct_alloc_coherent: No suitable zone for =
pfn<br>
&gt; 0xe0000&quot;.=C2=A0 Below is the code flow for function<br>
&gt; ath10k_pci_hif_exchange_bmi_<wbr>msg which is showing the first dma ma=
pping<br>
&gt; error.<br>
&gt;<br>
&gt; ath10k_pci_hif_exchange_bmi_<wbr>msg -&gt; dma_map_single -&gt;<br>
&gt; dma_map_single_attrs -&gt; swiotlb_map_page -&gt; dma_capable (returns=
<br>
&gt; false)<br>
&gt;<br>
&gt;<br>
&gt; dma_capable is what reports the failure in that flow.<br>
&gt;<br>
&gt; static inline bool dma_capable(struct device *dev, dma_addr_t addr, si=
ze_t size)<br>
&gt; {<br>
&gt; #ifdef CONFIG_SWIOTLB<br>
&gt;=C2=A0 =C2=A0 =C2=A0struct dev_archdata *sd =3D &amp;dev-&gt;archdata;<=
br>
&gt;<br>
&gt;=C2=A0 =C2=A0 if (sd-&gt;max_direct_dma_addr &amp;&amp; addr + size &gt=
; sd-&gt;max_direct_dma_addr)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
&gt; #endif<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (!dev-&gt;dma_mask)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0return addr + size - 1 &lt;=3D *dev-&gt;dma_mask;<b=
r>
&gt; }<br>
&gt; Getting the below values:<br>
&gt; addr =3D 1ee376218<br>
&gt; size =3D 4<br>
&gt; sd-&gt;max_direct_dma_addr =3D e0000000 which is I believe DMA window =
size (e0000000)<br>
&gt;<br>
&gt; when executed sd-&gt;max_direct_dma_addr(<wbr>e0000000) &amp;&amp; add=
r(1ee376218) +<br>
&gt; size(4) becomes e0000004 which is &gt; sd-&gt;max_direct_dma_addr (e00=
00000)<br>
&gt;<br>
&gt;<br>
&gt; So even though limit_zone_pfn(ZONE_DMA32, 1UL &lt;&lt; (31 - PAGE_SHIF=
T)) is<br>
&gt; being used in arch/powerpc/platforms/85xx/<wbr>corenet_generic.c,<br>
<br>
&gt; kmemdup(req, req_len, GFP_KERNEL) is returning an address that when<br=
>
&gt; sent to dma_map_single(), results in a bad map.<br>
<br>
</div></div>You need to use (GFP_KERNEL | GFP_DMA32) to constrain the alloc=
ations<br>
to ZONE_DMA32. Without that the kmemdup() will allocate from any zone<br>
so you&#39;ll probably get an unmappable address.<br>
<br>
That said, the driver probably shouldn&#39;t be using kmemdup() here.<br>
DMA-API.txt pretty explicitly says that drivers should not assume that<br>
dma_map_single() will work with arbitrary memory. It should be using<br>
dma_alloc_coherent() or a dma pool here.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; - Jared<br>
&gt;<br>
&gt; On Wed, Mar 21, 2018 at 11:54 PM, Oliver &lt;<a href=3D"mailto:oohall@=
gmail.com">oohall@gmail.com</a>&gt; wrote:<br>
&gt;&gt; On Thu, Mar 22, 2018 at 8:00 AM, Jared Bents<br>
&gt;&gt; &lt;<a href=3D"mailto:jared.bents@rockwellcollins.com">jared.bents=
@rockwellcollins.<wbr>com</a>&gt; wrote:<br>
&gt;&gt;&gt; Hi all,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Apologies for the amount of information but we&#39;ve been deb=
ugging this<br>
&gt;&gt;&gt; for a while and I wanted to get what we are seeing captured as=
 much as<br>
&gt;&gt;&gt; possible.=C2=A0 We are a T1042 processor and have a total 8GB =
DDR and our<br>
&gt;&gt;&gt; kernel version is fsl-sdk-v2.0-1703 (linux v4.1.35) as that is=
 the<br>
&gt;&gt;&gt; latest version supplied by NXP.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; A while ago we ported from 32 bit to 64 bit.=C2=A0 Everything =
continued to<br>
&gt;&gt;&gt; work except the ath10k module we have.=C2=A0 So as a first ste=
p, we checked<br>
&gt;&gt;&gt; to see if an ath9k module also failed to work and it was also =
no<br>
&gt;&gt;&gt; longer working.=C2=A0 The ath10k is working fine on a 32 bit s=
ystem but<br>
&gt;&gt;&gt; it&#39;s not working on 64 bit system as we are getting dma ma=
pping errors<br>
&gt;&gt;&gt; when trying to initialize the wifi modules.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; pci_bus 0002:01: bus scan returning with max=3D01<br>
&gt;&gt;&gt; pci_bus 0002:01: busn_res: [bus 01] end is updated to 01<br>
&gt;&gt;&gt; pci_bus 0002:00: bus scan returning with max=3D01<br>
&gt;&gt;&gt; ath10k_pci 0000:01:00.0: unable to get target info from device=
<br>
&gt;&gt;&gt; ath10k_pci 0000:01:00.0: could not get target info (-5)<br>
&gt;&gt;&gt; ath10k_pci 0000:01:00.0: could not probe fw (-5)<br>
&gt;&gt;&gt; ath10k_pci 0001:01:00.0: Direct firmware load for<br>
&gt;&gt;&gt; ath10k/cal-pci-0001:01:00.0.<wbr>bin failed with error -2<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; First, we have tried the mainline kernel (v4.15)=C2=A0 to see =
if that would<br>
&gt;&gt;&gt; fix the issue, it did not.=C2=A0 So I made a patch for the ath=
10k driver to<br>
&gt;&gt;&gt; restrict to just GFP_DMA areas when allocating memory or creat=
ing<br>
&gt;&gt;&gt; sk_buffs and have attached it.=C2=A0 The ath10k wifi modules n=
ow initialize<br>
&gt;&gt;&gt; correctly but when I try to connect them and send traffic, the=
y get a<br>
&gt;&gt;&gt; DMA mapping error from the sk_buff that it receives from elsew=
here in<br>
&gt;&gt;&gt; the kernel.=C2=A0 So while the driver appears to be fixable wi=
th the patch,<br>
&gt;&gt;&gt; the modules are still unusable due to data being sent to the d=
river<br>
&gt;&gt;&gt; when ath10k_tx is called and it tries to dma map with the prov=
ided<br>
&gt;&gt;&gt; skb.=C2=A0 Also, according to the ath10k mailing list, GFP_DMA=
 is not<br>
&gt;&gt;&gt; supposed to be used in general.=C2=A0 The error below is the s=
ame sort of<br>
&gt;&gt;&gt; dma mapping error that is seen when initializing the modules w=
ithout<br>
&gt;&gt;&gt; the patch to OR with GFP_DMA.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; ath10k_pci 0001:01:00.0: failed to transmit packet, dropping: =
-5<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; We asked on the ath10k mailing list if anyone else is having t=
his<br>
&gt;&gt;&gt; problem and no one else seems to have the issue but they are u=
sing<br>
&gt;&gt;&gt; different architectures (ARM or X86). As a result, it does not=
 seem to<br>
&gt;&gt;&gt; be a driver issue to us but something within the PowerPC arch.=
=C2=A0 So we<br>
&gt;&gt;&gt; dug a little deeper to try to find what addresses being mapped=
 are<br>
&gt;&gt;&gt; working and what address being mapped are not working.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; We found that when the virtual address of data pointer (a memb=
er of<br>
&gt;&gt;&gt; sk_buff) is above ~3.7 GB RAM address range then return addres=
s from<br>
&gt;&gt;&gt; dma_map_single API is failed to validate in dma_mapping_error<=
br>
&gt;&gt;&gt; function.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; We also noticed that in a 64bit machine sometimes ping is work=
ing and<br>
&gt;&gt;&gt; because of the virtual address is under ~3.7GAM RAM address ra=
nge.=C2=A0 So<br>
&gt;&gt;&gt; if we set mem=3D2048M in the bootargs, the ath10k module works=
<br>
&gt;&gt;&gt; perfectly, however this isn&#39;t a real solution since it cut=
s our<br>
&gt;&gt;&gt; available RAM from 8GB to 2GB.<br>
&gt;&gt;<br>
&gt;&gt; I think there&#39;s a known issue with the freescale PCIe root com=
plex<br>
&gt;&gt; where it can&#39;t DMA beyond the 4GB mark. There&#39;s a workarou=
nd in<br>
&gt;&gt; the form of limit_zone_pfn() which you can use to put the lower 4G=
B into<br>
&gt;&gt; ZONE_DMA32 and allocate from there rather than ZONE_NORMAL.<br>
&gt;&gt; For details of how to use it have a look at corenet_gen_setup_arch=
() in<br>
&gt;&gt; arch/powerpc/platforms/85xx/<wbr>corenet_generic.c<br>
&gt;&gt;<br>
&gt;&gt; Hope that helps,<br>
&gt;&gt; Oliver<br>
</div></div></blockquote></div><br></div>

--001a114d6e6e945c5e056813bf75--
