Mime-Version: 1.0
Message-Id: <v04210100b3b4a639e94b@193.250.81.35>
In-Reply-To: <199907150514.AAA14214@lists.linuxppc.org>
References: <199907150514.AAA14214@lists.linuxppc.org>
Date: Fri, 16 Jul 1999 11:10:40 +0200
To: linuxppc-dev@lists.linuxppc.org
From: Lucas Vergnettes <lucas@promac.org>
Subject: Kernel compilation problem on YDL
Content-Type: text/plain; charset="iso-8859-1" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

I just installed YDL 1.0 some weeks ago. I can comppile every sort of 
software really cleanly, but the kernnel compilation gives me this 
error :

ld  -r -o mm.o  fault.o init.o extable.o
make[2]: Leaving directory `/usr/src/linux/arch/ppc/mm'
make[1]: Leaving directory `/usr/src/linux/arch/ppc/mm'
make -C  arch/ppc/lib
make[1]: Entering directory `/usr/src/linux/arch/ppc/lib'
make all_targets
make[2]: Entering directory `/usr/src/linux/arch/ppc/lib'
gcc -D__KERNEL__ -I/usr/src/linux/include -D__ASSEMBLY__ -c checksum.S -o
checksum.o
gcc -D__KERNEL__ -I/usr/src/linux/include -D__ASSEMBLY__ -c string.S -o
string.o
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -D__powerpc__ -fsigned-char -msoft-float -pipe
-fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple -mstring   -c -o
strcase.o strcase.c
rm -f lib.o
ld  -r -o lib.o  checksum.o string.o strcase.o
make[2]: Leaving directory `/usr/src/linux/arch/ppc/lib'
make[1]: Leaving directory `/usr/src/linux/arch/ppc/lib'
ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic arch/ppc/kernel/head.o
init/main.o init/version.o \
         --start-group \
         arch/ppc/kernel/kernel.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o
kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
         fs/filesystems.a \
         net/network.a \
         drivers/block/block.a drivers/char/char.a drivers/misc/misc.a
drivers/net/net.a drivers/scsi/scsi.a drivers/cdrom/cdrom.a
drivers/sound/sound.a drivers/pci/pci.a drivers/macintosh/macintosh.a
drivers/video/video.a \
         /usr/src/linux/lib/lib.a \
         --end-group \
         -o vmlinux
arch/ppc/kernel/kernel.o: In function `sys_mmap':
arch/ppc/kernel/kernel.o(.text+0x4128): undefined reference to `fget'
make: *** [vmlinux] Error 1
root:/usr/src/linux#

This is a glibc 2.1.1 system.
I use make mrproper && make config, then make dep && make vmlinux.

I tried to update egcs but the version I tried was bad, so I 
reinstalled the YDL default.
I tried tu update binutils but apperently unsuccesfully ... :/

Can someone help me on this?

Thanks
Lucas
-- 
Lucas Vergnettes   --  Osteopathy Student  --  mailto:lucas@promac.org
LinuxPPC, Ostéopathie et Bidouilles Internet : http://lucas.promac.org
                 EMACS : Escape-Meta-Alt-Control-Shift        

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
