Message-ID: <38BBEA5F.99B71571@chpc.utah.edu>
Date: Tue, 29 Feb 2000 08:48:48 -0700
From: Lou Langholtz <ldl@chpc.utah.edu>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: problem building 2.3.47: no macintosh.a file
References: <Pine.LNX.3.96L.1000228205949.7447A-100000@unix48.andrew.cmu.edu> <38BB3177.822E5778@chpc.utah.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Lou Langholtz wrote:

> Hollis R Blanchard wrote:
>
> > . . .
> > I would recommend not using kernel.org sources for a while. Paul's tree seems
> > to be the favorite for Macs right now.
> >
> > -Hollis
>
> Thanks for responding so quickly. I feel so close now to actually getting the
> 2.3.47 sources to fully link. I'm down to just a multiple definitions error. Do
> you suspect I'll still have lots of trouble with the 2.3.47 sources if I get
> them to build on my PowerMac 7500? . . .

Argh! I've gotten now to the point that 2.3.47 builds all the way then the linker
barfs with two "multiple definition of" errors. In part in frustration, I thought
I'd do the smart thing and try patching to 2.3.48 to see if that'll compile
better. Quite the opposite. 2.3.48's build doesn't get nearly as far for me so I'm
hoping now to get rid of these last two linker errors for 2.3.47. Unfortunately I
did a recursive grep for these symbols which didn't find either of them and now
I'm at a loss of where to check next in getting rid of these last errors. Here's
what I see:

ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic arch/ppc/kernel/head.o
init/main.o init/version.o \
 --start-group \
 arch/ppc/kernel/kernel.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o arch/ppc/xmon/x.o \
 drivers/block/block.a drivers/char/char.o drivers/misc/misc.o drivers/net/net.o
drivers/parport/parport.a drivers/scsi/scsi.a drivers/cdrom/cdrom.a
drivers/sound/sounddrivers.o drivers/pci/pci.a drivers/macintosh/macintosh.a
drivers/video/video.o \
 net/network.a \
 /usr/src/linux/lib/lib.a \
 --end-group \
 -o vmlinux
kernel/kernel.o(.kstrtab+0x1f44): multiple definition of `__kstrtab_strspn'
arch/ppc/kernel/kernel.o(.kstrtab+0x4a4): first defined here
kernel/kernel.o(__ksymtab+0x9e0): multiple definition of `__ksymtab_strspn'
arch/ppc/kernel/kernel.o(__ksymtab+0x178): first defined here
make: *** [vmlinux] Error 1

Can anyone help me with these definition errors?

I feel so close with kernel.org's 2.3.47 kernel. Should I just byte the bullet and
use Paul's tree as Hollis suggests? Biggest problem with using another tree is
that I've got a very slow network pipe (a 28.8 modem and I already have
kernel.org's 2.3.47 + 2.3.48 sources). I also don't actually know anymore where to
get Paul's source tree. So in the end, kernel.org's 2.3.47 kernel still feels
closest to working for me.

Thanks!!!


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
