Return-Path: <gerhard_pircher@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C8FD51A0318
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 22:57:37 +1100 (AEDT)
MIME-Version: 1.0
Message-ID: <trinity-ec0d2d46-6887-49a0-aa66-47aad4c93969-1455018735101@3capp-gmx-bs34>
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
To: Mike <michael.heltne@gmail.com>
Cc: =?UTF-8?Q?=22Michel_D=C3=A4nzer=22?= <michel@daenzer.net>, "Boris
 Reinhard" <reinhard.boris@googlemail.com>, "Pranith Kumar"
 <bobby.prani@gmail.com>, "open list:LINUX FOR POWERPC..."
 <linuxppc-dev@lists.ozlabs.org>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: PowerPC agpmode issues
Content-Type: text/plain; charset=UTF-8
Date: Tue, 9 Feb 2016 12:52:15 +0100
In-Reply-To: <CANtoAtNUbSdS0GgoSGUPK4sRsXOhLtNmPqbFFaQ0xW0gGecCRA@mail.gmail.com>
References: <CANtoAtPSgkxEvAdOs-gZGOECYN8OFTvwRrsg+US41ji1fGEDLA@mail.gmail.com>
 <56B865A0.4060707@daenzer.net>
 <CAK90Sjk-AXekt_WKSk53GUeUZk-T4WhrwoNuwPA5N4pX2OPceA@mail.gmail.com>
 <CANtoAtPoYodsC3u-BOi8HM=ew03CX32BBKvFXwZJ4wbSkMWRZQ@mail.gmail.com>
 <56B943E3.1010407@daenzer.net>,
 <CANtoAtNUbSdS0GgoSGUPK4sRsXOhLtNmPqbFFaQ0xW0gGecCRA@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On 9 Feb 2016 03:27, "Mike" <michael=2Eheltne@gmail=2Ecom> wrote:
> Ok, so its quirks to be added then? Something not implemented in KMS
> that was in UMS?
> Reports are that the same issue exsist on PPC Amiga Ones with a VIA
> chipset, and the Pegasos 2 with the Artica s chipset, i posted a
> mail from detailiing that=2E
Just to avoid some confusion:
Old long story short: the issues for AmigaOnes and the Pegasos _1_ with
ArticiaS northbridge and VIA southbridge are that:
1=2E the AGP controller corrupts data transfers in AGP mode (also dependin=
g
on the AGP HW request queue size)=2E So there is no official AGP driver th=
at
would require radeon=2Eagpmode=3D-1=2E The microA1 is supposed to have a f=
ix
for this HW data corruption, but I yet have to dig out my ArticiaS AGP
driver code for some test runs=2E=2E=2E
2=2E At least the AmigaOne with ArticiaS chip need non-coherent DMA
allocations and/or proper cache flushes to avoid corrupted DMA transfers=
=2E

Nonetheless I had DRI1 working _only_ on my A1SE under Debian Squeeze (i=
=2Ee=2E
glxgears could run on the desktop with hardware acceleration), but DRI2
with its very dynamic GART mapping is a no-go on every first-gen AmigaOne
machine, even if the GART driver test (radeon=2Etest=3D1) runs through in
PCIGART mode (could it be that it uses a more or less static GART mapping
for the test?)=2E

> Sure that might be it, but i get different results trying agpmode=3D1-2-=
4,
> 2 gave a noisy screen before the hard crash=2E i find it rather impossib=
le
> to debug at all as the crash happens so fast no logs seem to be written=
=2E=2E
> I think i would need serial=2E=2E=2E
> I'd personally love nothing more then to see support restored and a
> default as expected working condition ought be the minimum requirement=
=2E
> I use a powerbook a1106, 5,6=2E With a 5,8 on the way=2E Those are the l=
ast
> two revision powerbooks in the 15" series=2E In swrast they become usele=
ss,
> impossible to use for any productivity=2E Most people trying to use linu=
x
> on ppc for personal use come in macs, with the exception of the Amiga PP=
C
> crowd now running their amcc 440/460ex or e600 based x500/5000, all of
> which have of course pci-e more cores and more threads=2E Yet struggle e=
ven
> with regressions left and right to keep up with the single core performa=
nce
> of the G4's=2E Sure it's pushing 10 years , but it's the only alternativ=
e
> if one wishes to remain mobile=2E
swrast definitely isn't fun on 10 years old PPC machines=2E Current Firefo=
x
is already slow enough on these machines=2E=2E=2E :-)

> On 9 Feb 2016 02:41, "Michel D=C3=A4nzer" <michel@daenzer=2Enet> wrote:
> > On 08=2E02=2E2016 22:28, Mike wrote:
> > Certainly 750~800 fps in glxgears vs 3000+ in debian squeeze, i cant
> > bring myself to say that it's an acceptable situation no matter how
> > tired i am of the problem knowing how well the setup could do=2E It's
> > clear that the implementation is broken for everything but x86, [=2E=
=2E=2E]
>=20
> Why is that? It was working fine on my last-gen PowerBook=2E AFAIK Darwi=
n
> / OS X never used anything but a static AGP GART mapping though, so it
> seems very likely that the issues with older UniNorth revisions are
> simply due to the hardware being unable to support the usage patterns of
> modern GPU drivers=2E
>=20
> That said, if you guys have specific suggestions for a "proper"
> solution, nobody's standing in your way=2E
I have to admit that I lack the knowledge of the inner workings of the
TTM/radeon code (and its TTM AGP backend) to do any useful work here=2E
I was hoping that the TMA DMA allocator could be of any help at least for
non-cache coherent machines given that (IIRC) ARM is using it together
with the nuoveau driver on the TEGRA platform, but I guess that would need
some modifications also on the powerpc architecture side (maybe a new
non-coherent DMA allocator that is not limited to 2M virtual address space
for mappings)=2E Thus I guess a lot of things could be improved/fixed, but
nowadays Linux code doesn't seem to be something for the "occasional hobby
hacker"=2E :-)

regards,
Gerhard
