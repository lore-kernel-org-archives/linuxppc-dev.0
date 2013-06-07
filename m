Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0186.outbound.messaging.microsoft.com [213.199.154.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A56682C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Jun 2013 08:02:40 +1000 (EST)
Date: Fri, 7 Jun 2013 17:02:20 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: FSL 64-bit DMA window question
To: Scott Wood <scottwood@freescale.com>
References: <1370606960.3766.381.camel@pasglop> <1370642488.6813.15@snotra>
In-Reply-To: <1370642488.6813.15@snotra> (from scottwood@freescale.com on
 Fri Jun  7 17:01:28 2013)
Message-ID: <1370642540.6813.16@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Xie Shaohui-B21989 <B21989@freescale.com>,
 Zang Roy-R61911 <r61911@freescale.com>, Timur Tabi <timur@tabi.org>,
 "tiejun.chen" <tiejun.chen@windriver.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 Bhushan Bharat-R65777 <R65777@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/07/2013 05:01:28 PM, Scott Wood wrote:
> On 06/07/2013 07:09:20 AM, Benjamin Herrenschmidt wrote:
>> On Fri, 2013-06-07 at 09:44 +0000, Zang Roy-R61911 wrote:
>> >
>> > > -----Original Message-----
>> > > From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]
>> > >
>> > > On Fri, 2013-06-07 at 07:58 +0000, Zang Roy-R61911 wrote:
>> > > >
>> > > > > -----Original Message-----
>> > > > > From: Benjamin Herrenschmidt =20
>> [mailto:benh@kernel.crashing.org]
>> > > > >
>> > > > > Hi Folks !
>> > > > >
>> > > > > Is there any specific reason why you chose 1T (40 bit) as the
>> > > location of
>> > > > > the 64-bit DMA window ?
>> > > > >
>> > > > > It happens that most current radeon adapters cannot DMA =20
>> there, they
>> > > have
>> > > > > a 40-bit DMA limit. I seem to be getting things to work fine =20
>> using a
>> > > 39-
>> > > > > bit window, but I suppose that might collide with something =20
>> else ?
>> > > > T4240 has 40bit physical address ability.
>> > > > "
>> > > > This chip's 40-bit, physical address map consists of local =20
>> space and
>> > > external address
>> > > > space. For the local address map, 32 local access windows =20
>> (LAWs) define
>> > > mapping
>> > > > within the local 40-bit (1 TB) address space. Inbound and =20
>> outbound
>> > > translation windows
>> > > > can map the chip into a larger system address space such as =20
>> the RapidIO
>> > > or PCIe 64-bit
>> > > > address environment. This functionality is included in the =20
>> address
>> > > translation and
>> > > > mapping units (ATMUs).
>> > > >
>> > > > "
>> > > > That should be the reason to set the DMA window to 40-bit.
>> > > I see. However if the top half of that space isn't used by =20
>> default with
>> > > whatever is our current setup, it makes sense to move down the =20
>> 64-bit
>> > > DMA window to allow those adapters to function don't you think ?
>> > Good to me.
>> > 40 bit DMA will prevent your radeon video card from working. Right?
>> > Your P5020 DS system only support 36 bit physical address.
>>=20
>> We should probably put the "64-bit DMA" address in the device-tree,
>> that way if somebody wish to do differently they can.
>=20
> I thought the device tree was for describing the hardware, rather =20
> than configuration? :-)
> A kernel command line option might be more appropriate, unless you =20
> just mean describing the difference between e6500 (which supports 40 =20
> bit addresses) and previous chips (which support 36 bits), rather =20
> than an ability to move it earlier even on e6500.
>=20
> That said, the current code looks broken -- it checks whether a card =20
> can do 40-bit DMA, and if it can, it sets the DMA offset to (1ULL << =20
> 40), thus requiring 41-bit DMA.  It should be > instead of >=3D in =20
> fsl_pci_dma_set_mask.
>=20
> Maybe we could by default use the size of actual RAM, rather than the =20
> physical address space.  Then only odd scenarios such as DMA to =20
> non-kernel-owned RAM would need manual adjustment (MSIs would still =20
> go through the special window below 4G).
>=20
> -Scott
=
