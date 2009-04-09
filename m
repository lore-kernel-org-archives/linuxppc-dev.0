Return-Path: <tmarri@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.73])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 2367ADDF92
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Apr 2009 16:45:00 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9B8DE.B01CB67A"
Subject: RE: tracking of PCI address space
Date: Wed, 8 Apr 2009 23:44:53 -0700
Message-ID: <AC5E1C3367E37D44970B81A6ADD1DA2C0534AB79@SDCEXCHANGE01.ad.amcc.com>
References: <E942C580-7C39-44AB-B207-C65CDE0B5292@kernel.crashing.org>
	<1239258091.7279.22.camel@pasglop>
From: "Tirumala Reddy Marri" <tmarri@amcc.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"Kumar Gala" <galak@kernel.crashing.org>
Cc: linux-pci@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9B8DE.B01CB67A
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I agree. Every processor(SOC) has unique of setting inbound window. What =
I noticed is Inbound regions are created big enough to map whole DDR =
region.  And uses physical address of ram as a source/destination =
address.  For example if a PCI-E SATA card wants to do DMA transfers to =
DDR region. It will create dma_alloc_noncoherent() region and uses =
physical address as source/destination address for data transfers.=20

________________________________

From: linuxppc-dev-bounces+tmarri=3Damcc.com@ozlabs.org on behalf of =
Benjamin Herrenschmidt
Sent: Wed 4/8/2009 11:21 PM
To: Kumar Gala
Cc: linux-pci@vger.kernel.org; Linux Kernel Mailing List; Jesse Barnes; =
Linux/PPC Development
Subject: Re: tracking of PCI address space



On Wed, 2009-04-08 at 15:53 -0500, Kumar Gala wrote:
> I was wondering if we have anything that tracks regions associated=20
> with the "inbound" side of a pci_bus.
>
> What I mean is on embedded PPC we have window/mapping registers for=20
> both inbound (accessing memory on the SoC) and outbound (access PCI=20
> device MMIO, IO etc).  The combination of the inbound & outbound=20
> convey what exists in the PCI address space vs CPU physical address=20
> space (and how to map from one to the other).  Today in the PPC land=20
> we only attach outbound windows to the pci_bus.  So technically the=20
> inbound side information (like what subset of physical memory is=20
> visible on the PCI bus) seems to be lost.

On powerpc, we do keep track of the offset, but that's about it.

Tracking inbound ranges is very platform specific though. You can have
multiple inbound windows with different translations, in some cases some
via iommu and some not, or windows aliasing the same target memory but
with different attributes, etc...

I don't think there's that much interest in trying to create generic
code to keep track.

Ben.


_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev



------_=_NextPart_001_01C9B8DE.B01CB67A
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML dir=3Dltr><HEAD><TITLE>Re: tracking of PCI address space</TITLE>=0A=
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dunicode">=0A=
<META content=3D"MSHTML 6.00.2900.3492" name=3DGENERATOR></HEAD>=0A=
<BODY>=0A=
<DIV id=3DidOWAReplyText68685 dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>I agree. =
Every processor(SOC) has unique of setting inbound window. What I =
noticed is Inbound regions are created big enough to map whole DDR =
region.&nbsp; And&nbsp;uses physical address of ram as a =
source/destination address. &nbsp;For example if a PCI-E SATA card wants =
to do DMA transfers to DDR region. It will create =
dma_alloc_noncoherent() region and uses physical address as =
source/destination address for data transfers. </FONT></DIV></DIV>=0A=
<DIV dir=3Dltr><BR>=0A=
<HR tabIndex=3D-1>=0A=
<FONT face=3DTahoma size=3D2><B>From:</B> =
linuxppc-dev-bounces+tmarri=3Damcc.com@ozlabs.org on behalf of Benjamin =
Herrenschmidt<BR><B>Sent:</B> Wed 4/8/2009 11:21 PM<BR><B>To:</B> Kumar =
Gala<BR><B>Cc:</B> linux-pci@vger.kernel.org; Linux Kernel Mailing List; =
Jesse Barnes; Linux/PPC Development<BR><B>Subject:</B> Re: tracking of =
PCI address space<BR></FONT><BR></DIV>=0A=
<DIV>=0A=
<P><FONT size=3D2>On Wed, 2009-04-08 at 15:53 -0500, Kumar Gala =
wrote:<BR>&gt; I was wondering if we have anything that tracks regions =
associated&nbsp;<BR>&gt; with the "inbound" side of a =
pci_bus.<BR>&gt;<BR>&gt; What I mean is on embedded PPC we have =
window/mapping registers for&nbsp;<BR>&gt; both inbound (accessing =
memory on the SoC) and outbound (access PCI&nbsp;<BR>&gt; device MMIO, =
IO etc).&nbsp; The combination of the inbound &amp; =
outbound&nbsp;<BR>&gt; convey what exists in the PCI address space vs =
CPU physical address&nbsp;<BR>&gt; space (and how to map from one to the =
other).&nbsp; Today in the PPC land&nbsp;<BR>&gt; we only attach =
outbound windows to the pci_bus.&nbsp; So technically the&nbsp;<BR>&gt; =
inbound side information (like what subset of physical memory =
is&nbsp;<BR>&gt; visible on the PCI bus) seems to be lost.<BR><BR>On =
powerpc, we do keep track of the offset, but that's about =
it.<BR><BR>Tracking inbound ranges is very platform specific though. You =
can have<BR>multiple inbound windows with different translations, in =
some cases some<BR>via iommu and some not, or windows aliasing the same =
target memory but<BR>with different attributes, etc...<BR><BR>I don't =
think there's that much interest in trying to create generic<BR>code to =
keep =
track.<BR><BR>Ben.<BR><BR><BR>___________________________________________=
____<BR>Linuxppc-dev mailing list<BR>Linuxppc-dev@ozlabs.org<BR><A =
href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-dev">https://ozlabs.=
org/mailman/listinfo/linuxppc-dev</A><BR></FONT></P></DIV></BODY></HTML>
------_=_NextPart_001_01C9B8DE.B01CB67A--
