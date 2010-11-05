Return-Path: <tmarri@apm.com>
Received: from exprod5og110.obsmtp.com (exprod5og110.obsmtp.com [64.18.0.20])
	by ozlabs.org (Postfix) with SMTP id 707FCB70DE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  5 Nov 2010 12:58:11 +1100 (EST)
Received: by qwg5 with SMTP id 5so2169515qwg.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 04 Nov 2010 18:58:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1288786293.989.65.camel@concordia>
References: <1288306514-9769-1-git-send-email-tmarri@apm.com>
	<1288786293.989.65.camel@concordia>
Date: Thu, 4 Nov 2010 18:58:08 -0700
Message-ID: <AANLkTikhM4QZ6NdgpH7PVmKdTq1y6ryCPdHP3=DSZv6+@mail.gmail.com>
Subject: Re: [PATHC v1] PPC4xx: Adding PCI(E) MSI support
From: Tirumala Marri <tmarri@apm.com>
To: michael@ellerman.id.au
Content-Type: multipart/alternative; boundary=00163646d6a82a40b60494449bef
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--00163646d6a82a40b60494449bef
Content-Type: text/plain; charset=ISO-8859-1

Appreciate your review.
 > +     static int int_no = 0;  /* To remember last used interrupt */

>
> This is a worry. There is nothing AFAIK to stop two drivers (eg. network
> & scsi) calling into here at the same time, which could lead to
> corrupting int_no. If you just want a global counter you need a lock.
>
> But, AFAICS this is broken anyway. You never free the interrupt numbers,
> so you're going to run out. Some of your device tree entries only have 3
> (!!), so ifup/ifdown x 3 will exhaust the supply, won't it?
>
> I realise I never replied to your mail the other week about the bitmap
> code, so perhaps it's my fault :)
>
> [Marri] Good point.I will come up with a global array to see if the
interrupt nos are free
and use them.

 > +     return;

> > +}
> > +
> > +static int ppc4xx_msi_check_device(struct pci_dev *pdev, int nvec, int
> type)
> > +{
> > +     dev_dbg(&pdev->dev, "PCIE-MSI:%s called. vec %x type %d\n",
> > +             __func__, nvec, type);
>
> No constraints at all? What about MSI-X ?
> [marri] That will be another patch as it is only specific to some SoCs
>


> > +     msi_virt = dma_alloc_coherent(&dev->dev, 64, &msi_phys,
> GFP_KERNEL);
> > +     msi->msi_addr_hi = 0x0;
> > +     msi->msi_addr_lo = (u32) msi_phys;
> > +     dev_dbg(&dev->dev, "PCIE-MSI: msi address 0x%x \n",
> msi->msi_addr_lo);
>
> So your MSI is a write to just some arbitrary address?
>
> [Marri] We choose a arbitrary address and pass that to msi APIs which would
write
to endpoint device config space. If endpoint wants to cause an MSI it just
generates
memory transaction to this address, as soon as it is on system bus PCI-E
handler
will snoop this address and cause interrupt to CPU.




> > +     /* Progam the Interrupt handler Termination addr registers */
> > +     out_be32(msi->msi_regs + PEIH_TERMADH, msi->msi_addr_hi);
> > +     out_be32(msi->msi_regs + PEIH_TERMADL, msi->msi_addr_lo);
>
> And the hardware detects it by catching writes to that address? But the
> write still lands?
>
> [marri] write still happens to memory but we do't need need to wait for it
to complete.
So the termination would avoid un-necessary delay in acking the write or
race condition
to that particular address.


>
>

--00163646d6a82a40b60494449bef
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><div>Appreciate your review.</div><div>=A0&gt; +=
 =A0 =A0 static int int_no =3D 0; =A0/* To remember last used interrupt */<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex;">
<div class=3D"im">
<br>
</div>This is a worry. There is nothing AFAIK to stop two drivers (eg. netw=
ork<br>
&amp; scsi) calling into here at the same time, which could lead to<br>
corrupting int_no. If you just want a global counter you need a lock.<br>
<br>
But, AFAICS this is broken anyway. You never free the interrupt numbers,<br=
>
so you&#39;re going to run out. Some of your device tree entries only have =
3<br>
(!!), so ifup/ifdown x 3 will exhaust the supply, won&#39;t it?<br>
<br>
I realise I never replied to your mail the other week about the bitmap<br>
code, so perhaps it&#39;s my fault :)<br>
<div class=3D"im"><br>
</div></blockquote><div>[Marri] Good point.I will come up with a global arr=
ay to see if the interrupt nos are free</div><div>and use them.</div><div><=
br></div><div>=A0&gt; + =A0 =A0 return;</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;=
">
<div class=3D"im">
&gt; +}<br>
&gt; +<br>
&gt; +static int ppc4xx_msi_check_device(struct pci_dev *pdev, int nvec, in=
t type)<br>
&gt; +{<br>
&gt; + =A0 =A0 dev_dbg(&amp;pdev-&gt;dev, &quot;PCIE-MSI:%s called. vec %x =
type %d\n&quot;,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 __func__, nvec, type);<br>
<br>
</div>No constraints at all? What about MSI-X ?<br>
<div class=3D"im">[marri] That will be another patch as it is only specific=
 to some SoCs</div></blockquote><div>=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
;">
<div class=3D"im">&gt; + =A0 =A0 msi_virt =3D dma_alloc_coherent(&amp;dev-&=
gt;dev, 64, &amp;msi_phys, GFP_KERNEL);</div><div class=3D"im">
&gt; + =A0 =A0 msi-&gt;msi_addr_hi =3D 0x0;<br>
&gt; + =A0 =A0 msi-&gt;msi_addr_lo =3D (u32) msi_phys;<br>
&gt; + =A0 =A0 dev_dbg(&amp;dev-&gt;dev, &quot;PCIE-MSI: msi address 0x%x \=
n&quot;, msi-&gt;msi_addr_lo);<br>
<br>
</div>So your MSI is a write to just some arbitrary address?<br>
<div class=3D"im"><br></div></blockquote><div>[Marri] We choose a=A0arbitra=
ry=A0address and pass that to msi APIs which would write</div><div>to endpo=
int device config space. If endpoint wants to cause an MSI it just generate=
s</div>
<div>memory transaction to this address, as soon as it is on system bus PCI=
-E handler</div><div>will snoop this address and cause interrupt to CPU.</d=
iv><div><br></div><div><br></div><div>=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x;">
<div class=3D"im">
&gt; + =A0 =A0 /* Progam the Interrupt handler Termination addr registers *=
/<br>
&gt; + =A0 =A0 out_be32(msi-&gt;msi_regs + PEIH_TERMADH, msi-&gt;msi_addr_h=
i);<br>
&gt; + =A0 =A0 out_be32(msi-&gt;msi_regs + PEIH_TERMADL, msi-&gt;msi_addr_l=
o);<br>
<br>
</div>And the hardware detects it by catching writes to that address? But t=
he<br>
write still lands?<br>
<div class=3D"im"><br></div></blockquote><div>[marri] write still happens t=
o memory but we do&#39;t need need to wait for it to complete.</div><div>So=
 the termination would avoid un-necessary delay in acking the write or race=
 condition</div>
<div>to that particular address.</div><div>=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex;"><div class=3D"im"><br></div></blockquote></div><br>

--00163646d6a82a40b60494449bef--
