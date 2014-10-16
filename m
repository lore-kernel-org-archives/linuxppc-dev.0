Return-Path: <arnd@arndb.de>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 000231A0313
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Oct 2014 01:05:58 +1100 (AEDT)
Date: Thu, 16 Oct 2014 16:05:44 +0200 (CEST)
From: "arnd@arndb.de" <arnd@arndb.de>
Reply-To: "arnd@arndb.de" <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Message-ID: <279386619.169619.1413468344794.JavaMail.open-xchange@oxbsltgw00.schlund.de>
In-Reply-To: <1413429775-716-1-git-send-email-mpe@ellerman.id.au>
References: <1413429775-716-1-git-send-email-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pci: Fix IO space breakage after
 of_pci_range_to_resource() change
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: bhelgaas@google.com, linus.walleij@linaro.org, Liviu.Dudau@arm.com,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(hope my email makes it everywhere, using a webmail client at the moment as=
 I'm
at plumbersconf

Michael Ellerman <mpe@ellerman.id.au> hat am 16. Oktober 2014 um 05:22
geschrieben:
>
>
> Commit 0b0b0893d49b "of/pci: Fix the conversion of IO ranges into IO
> resources" changed the behaviour of of_pci_range_to_resource().

I just looked at this after benh mentioned the problem on IRC, here's a log=
 dump

:26 AM   <benh> argh =20
9:27 AM   <benh> the whole ARM OF PCI rework seems to completely break PIO =
on
powerpc =20
9:30 AM   =E2=86=92 willy <willy> joined (^willy@62.156.150.204) =20
9:35 AM   <benh> and reverting it would mean reverting all of ARM new PCI s=
tuff
=20
9:35 AM   <benh> crap =20
9:35 AM   <benh> that business with IO space allocation taking over our cod=
e
without understanding what it does =20
9:35 AM   <benh> yuck =20
9:41 AM     =E2=86=92 markf <markf> , olaf <olaf> , sarnold <sarnold> , gos=
po <gospo> ,
cmarinas <cmarinas> , Mahesh1 <Mahesh1> , joern <joern> , clark_ <clark_> a=
nd
benhjoined  =E2=87=90 gcl <gcl> and clark <clark> quit  =E2=86=94 willy <wi=
lly> , jbarnes
<jbarnes> , jbrandeb_ <jbrandeb_> and Mahesh <Mahesh> popped in  =E2=86=94 =
sameo <sameo>
, jbrandeb <jbrandeb> , steved <steved> and jj <jj> nipped out  =E2=80=A2  =
srikar =E2=86=92
srikar_away <srikar_away> , raghu =E2=86=92 raghu_away <raghu_away> =20
Thursday, October 16th, 2014 =20
12:06 AM     =E2=86=92 fweisbec <fweisbec> , Mahesh <Mahesh> , kamalesh <ka=
malesh> ,
heiko <heiko> , olaf <olaf> , riel <riel> and willy <willy> joined  =E2=87=
=90 shaggy
<shaggy> , sammj <sammj> , sameo <sameo> , clark_ <clark_> , lenb <lenb> an=
d jj
<jj> quit  =E2=86=94 jbrandeb <jbrandeb> , cdub <cdub> , Mahesh1 <Mahesh1> =
and gcl <gcl>
popped in  =E2=86=94 jbrandeb_ <jbrandeb_> , benh, joern <joern> and BenC <=
BenC> nipped
out  =E2=80=A2  mpe|away =E2=86=92 mpe|away <mpe%7Caway> , raghu_away =E2=
=86=92 raghu <raghu> ,
srikar_away =E2=86=92 srikar <srikar> =20
10:16 AM   <arnd_> benh: is it the of_pci_range_to_resource change? =20
10:17 AM   <arnd_> the new pci_ioremap_iospace logic should not get used on
powerpc at all, so I didn't expect any breakage =20
10:18 AM   <arnd_> I wasn't too happy with all the details of Liviu's serie=
s,
bit in the end it seemed reasonable enough =20
10:20 AM   <arnd_> he really wanted to use the pci_address_to_pio code from
powerpc and in the end I stopped complaining =20
10:21 AM   <arnd_> the new code can do a few things that simpler versions c=
ould
not, e.g. handling multiple host bridges getting registered when they have =
the
same I/O space window =20
10:23 AM   =E2=86=92 jj <jj> joined (^jj@static-50-53-60-87.bvtn.or.frontie=
rnet.net) =20
10:33 AM   <arnd_> benh: I can see how it breaks your
pci_process_bridge_OF_ranges, we had the same problem in some of the ARM
platforms and Liviu fixed those but apparently didn't realize he had to cha=
nge
the ppc implementation (and get your ack) too =20
10:35 AM   <arnd_> the good news is that it should in fact simplify your co=
de to
fix it, but the fact that this bug got into the kernel in the first place i=
s
extremely annoying =20
10:39 AM   <arnd_> benh: the fixup that is done in your
pcibios_reserve_legacy_regions is now already performed in
of_pci_range_to_resource =20
10:39 AM   <arnd_> we had duplicated the same thing in each pci host driver=
 (and
they all got it wrong), so the intent was to move it into a common place =
=20
10:40 AM   <arnd_> but of course it's a bug to do it twice =20
10:43 AM   <arnd_> pci_register_io_range is trying to do a more generalized
version of how you assign hose->io_base_virt, you should probably override =
that
to keep the current behavior =20
10:45 AM   <arnd_> pcibios_map_phb_io_space I mean, for ppc64 =20
10:52 AM   =E2=86=92 cmarinas <cmarinas> joined (~cmarinas@fw-tnat.cambridg=
e.arm.com) =20
10:53 AM   <arnd_> benh: for 3.18, the best approach is likely to #ifdef
<%23ifdef> PCI_IOBASE the changes in of_pci_range_to_resource =20
10:54 AM   <arnd_> I suspect you are fine with effectively reverting Liviu'=
s
changes that way, and you can decide whether or not you want to later make =
the
powerpc code use the common logic =20
11:01 AM     =E2=86=92 cdub <cdub> and sarnold <sarnold> joined  =E2=87=90 =
cmarinas <cmarinas>
quit =20
11:28 AM   <benh> arnd_: can you shoot the above in an email CCed to mpe ? =
=20
11:28 AM   <benh> arnd_: he did a band aid that works =20
11:28 AM   <benh> arnd_: and see the comment I made today about using his s=
tuff
if I can specify where I want the IO ranges =20
11:28 AM   <benh> arnd_: I want to keep the way I do the layout on ppc64 =
=20

> Previously it simply populated the resource based on the arguments. Now
> it calls pci_register_io_range() and pci_address_to_pio(). These both
> have two implementations depending on whether PCI_IOBASE is defined,
> which it is not for powerpc.
>
> Further complicating matters, both routines are weak, and powerpc
> implements it's own version of one - pci_address_to_pio(). However
> powerpc's implementation depends on other initialisations which are done
> later in boot.

Right, sorry for missing this during the last review of the broken patches.

> The end result is incorrectly initialised IO space. Often we can get
> away with that, because we don't make much use of IO space. However
> virtio requires it, so we see eg:
>
> pci_bus 0000:00: root bus resource [io 0xffff] (bus address
> [0xffffffffffffffff-0xffffffffffffffff])
> PCI: Cannot allocate resource region 0 of device 0000:00:01.0, will remap
> virtio-pci 0000:00:01.0: can't enable device: BAR 0 [io size 0x0020] not
> assigned
>
> The simplest fix for now is to just stop using of_pci_range_to_resource()=
,
> and open-code the original imp`lementation, that's all we want it to do.

The same bug is likely to be present on microblaze and mips, which may or m=
ay
not
care about it. I'll ask Michal about whether microblaze actually has any
I/O space, otherwise we have to fix it too for 3.18.

I believe for 3.19, we should probably migrate microblaze over to use the s=
ame
code
as ARM.

> Fixes: 0b0b0893d49b ("of/pci: Fix the conversion of IO ranges into IO
> resources")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
> arch/powerpc/kernel/pci-common.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/pci-common.c
> b/arch/powerpc/kernel/pci-common.c
> index bd70a51d5747..e5dad9a9edc0 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -747,7 +747,11 @@ void pci_process_bridge_OF_ranges(struct pci_control=
ler
> *hose,
> break;
> }
> if (res !=3D NULL) {
> - of_pci_range_to_resource(&range, dev, res);
> + res->name =3D dev->full_name;
> + res->flags =3D range.flags;
> + res->start =3D range.cpu_addr;
> + res->end =3D range.cpu_addr + range.size - 1;
> + res->parent =3D res->child =3D res->sibling =3D NULL;
> }
> }

This looks reasonable to me as a hack to work around the breakage. It would=
 be
good
to work together on this for 3.19 to move on to the a common implementation=
 that
works on both ARM and PowerPC. This might be possibly by removing a lot of =
code
for PowerPC (at least 64-bit) that is now present in common code, but it wi=
ll
change the structure of the powerpc implementation significantly, since the
returned numbers are now in different memory spaces (logical I/O space rath=
er
than physical). The PowerPC _IO_BASE is the equivalent of the now generic
PCI_IOBASE,
but it's used slightly differently. If you want to use the generic code,=20
you should probably change host->io_base_virt to host->io_base in logical
space (i.e. removing the _IO_BASE offset), or using hose->io_resource.start
instead.

       Arnd
