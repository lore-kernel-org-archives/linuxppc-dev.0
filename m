Date: Fri, 26 Feb 1999 10:18:58 -0500 (EST)
From: satadru pramanik <satadru@umich.edu>
To: Martin Costabel <costabel@wanadoo.fr>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.2 compilation errors
In-Reply-To: <36D685FD.1E07A1DE@wanadoo.fr>
Message-ID: <Pine.LNX.4.10.9902261014540.1439-100000@beer.pub.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks again for all of the useful suggestions.  Further along the
compilation chain, i came across this fatal error with the pmac_ide stuff.
Luckily, since I have a 7600, w/o ide, i could just disable this, but it
would be nice to get this working in Linus' tree, since his tree is
mirrored everywhere.
-sat.
---compilation output---
t/net.a drivers/scsi/scsi.a drivers/cdrom/cdrom.a drivers/sound/sound.a
drivers/pci/pci.a drivers/macintosh/macintosh.a drivers/video/video.a \
        /mnt/ibm/sin/src/kernel/linux/lib/lib.a \
        --end-group \
        -o vmlinux
arch/ppc/kernel/kernel.o: In function `find_ide_boot':
arch/ppc/kernel/kernel.o(.text.init+0x18e2): undefined reference to
`pmac_ide_count'
arch/ppc/kernel/kernel.o(.text.init+0x18e6): undefined reference to
`pmac_ide_count'
arch/ppc/kernel/kernel.o(.text.init+0x18fe): undefined reference to
`pmac_ide_node'
arch/ppc/kernel/kernel.o(.text.init+0x1902): undefined reference to
`pmac_ide_node'
arch/ppc/kernel/kernel.o(.text.init+0x1936): undefined reference to
`pmac_ide_count'
make: *** [vmlinux] Error 1




On Fri, 26 Feb 1999, Martin Costabel wrote:

This bug was introduced deliberately by Linus.
It was fixed for ppc yesterday by Paul Mackerras and Gary Thomas.

When the gods are busy, it's time for the prophets (self-proclaimed and
unauthorized as always). So here we go:

Today (tomorrow all this may have changed) you have two possibilities to
compile 2.2.2 on a ppc: Downgrade or upgrade.

1) Downgrade. Take the 2 files kernel/ksyms.c and kernel/sched.c from a
previous version. For your convenience, I have put them on my site
http://www.maths.univ-rennes1.fr/~costabel/linux/boot/

2) Upgrade. Take the 2 files include/asm-ppc/semaphore.h and
include/asm-ppc/semaphore-helper.h from the cvs tree at samba.anu.edu.au
(or take the whole tree; it contains many other bug fixes). On my Web
site, I have a file kernel222-samba.diff that patches these 2 files. It
is only 5kB, so this is the simplest way to go.

--
Martin (LinuxPPC prophet)

satadru pramanik wrote:
> 
> I have a compilation failure on a lppc rel 4.1 system  Here's the "make
> vmlinux dying output"  any hints?  please cc to me directly, as I am no
> longer on the list .
> (my dot.config is an adaptaion of the linux-pmac 2.2.1 kernel config,
> enclosed)
> -thanks!
> 
> gcc -D__KERNEL__ -I/mnt/ibm/sin/src/kernel/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -D__powerpc__ -fsigned-char -msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple -mstring  -c -o init/main.o init/main.c
> gcc -D__KERNEL__ -I/mnt/ibm/sin/src/kernel/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -D__powerpc__ -fsigned-char -msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -DUTS_MACHINE='"ppc"' -c -o init/version.o init/version.c
> make -C  kernel
> make[1]: Entering directory `/mnt/ibm/sin/src/kernel/linux/kernel'
> make all_targets
> make[2]: Entering directory `/mnt/ibm/sin/src/kernel/linux/kernel'
> gcc -D__KERNEL__ -I/mnt/ibm/sin/src/kernel/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -D__powerpc__ -fsigned-char -msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple -mstring   -DEXPORT_SYMTAB -c ksyms.c
> ksyms.c:375: `__down_trylock' undeclared here (not in a function)
> ksyms.c:375: initializer element for `__ksymtab___down_trylock.value' is not constant
> make[2]: *** [ksyms.o] Error 1
> make[2]: Leaving directory `/mnt/ibm/sin/src/kernel/linux/kernel'
> make[1]: *** [first_rule] Error 2
> make[1]: Leaving directory `/mnt/ibm/sin/src/kernel/linux/kernel'
> make: *** [_dir_kernel] Error 2
> 
> --=
> satadru pramanik `satadru@umich.edu' www.umich.edu/~satadru
> MIS, Student Publications
> "I'm old enough to be living in the future I was warned about."
>   - Myron Krueger
> =--
> 
>   ------------------------------------------------------------------------
>                  Name: dot.config
>    dot.config    Type: Plain Text (TEXT/PLAIN)
>              Encoding: BASE64


--=
satadru pramanik `satadru@umich.edu' www.umich.edu/~satadru
MIS, Student Publications
"I'm old enough to be living in the future I was warned about."
  - Myron Krueger
=--



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
