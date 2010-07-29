Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) by ozlabs.org (Postfix) with ESMTP id B80461007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Jul 2010 17:28:35 +1000 (EST)
Received: by iwn39 with SMTP id 39so48765iwn.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Jul 2010 00:28:34 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <201007291408499573189@gmail.com>
References: <201007291408499573189@gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 29 Jul 2010 01:28:14 -0600
Message-ID: <AANLkTindWKCyFzm2hwR+2K6KihkvWqXjPjsyD2M6ukwq@mail.gmail.com>
Subject: Re: i meet some surprising things,when i modify the dts file
To: hacklu <embedway.test@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 29, 2010 at 12:08 AM, hacklu <embedway.test@gmail.com> wrote:
> =A0localbus@f0010100=A0{
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0....
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ranges=A0=3D=A0<
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A00=A00=A0FC000000=A01000000
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A02=A00=A0FA000000=A01000000
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A01=A00=A070000000=A01000000
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0>;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0flash@0,0{
>
> .....
> }
>
> flash@2,0{
>
> ....
> }
>
> =A0=A0=A0=A0=A0=A0=A0=A0=A0board-control@1,0{
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .....
> }
>
> }
>
> this is part of my dts files. I don't kown what each field means in the
> config rangs.
> for instance, 2=A00=A0FA000000=A01000000=A0.
> I only konw this:
> "2" is means chip selects.
> "0" is what?
> "Fa00000" means the start address.
> "1000000" means the range of the device

Ranges translates from the child address domain to the parent address
domain.  It consists of 3 fields; The child base address, the parent
base address, and the size.  In this case:

child base address :=3D 2 0  (#address-cells =3D <2> in this node)
parent base address :=3D 0xfa000000 (#address-cells =3D <1> in parent node)
and length =3D 0x1000000 (16MB)

For the child address, #address-cells is set to 2, meaning 1 cell for
the chip select #, and 1 cell for an offset into the chip select
range.  In most cases the offset will be zero in a ranges property.

So in this case, the ranges property states that chip select 2 is a
16MB region mapped to base address 0xfa000000.

>
> but ,I got some puzzled.
> when I set the two flash in the 0,1 chips select or 0,2 chips select my
> linux works well.
> and, the board-control only can be set at 1 chis select,otherwise the pci
> doesn't be detected.

Unless the bus controller hardware needs to know the chip select
number for another purpose (ie. setting up a local bus DMA transfer),
you could really use any number for the chip select as long as it is
consistent between the child node and the ranges property.

>
> so , what is the chips select? is it based on hardware?

Yes, it is based on hardware.  The .dts file is describing which CS
line each external device is attached to.

 but my flash can use
> 0,1,2 chips select.
> or it is just set by software? but my pci devece can only work in 1 chips
> select.
>
>
> BTW:
> I also want to know how to write the dts file. I want to understand each
> node in the dts files.
> but I can't get enough documents. I have readed the linux/document/...
> could you privode me some useful information?

See here:

http://www.devicetree.org/Device_Tree_Usage

g.
