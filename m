Message-ID: <XFMail.990212142111.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <Pine.A41.3.95a.990212095621.87402B-100000@rsplus13.cern.ch>
Date: Fri, 12 Feb 1999 14:21:11 -0000 (GMT)
From: Gary Thomas <gdt@linuxppc.org>
To: Marc Dejardin <Marc.Dejardin@cern.ch>
Subject: RE: Problem with 2.2.1 compilation
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I don't want to get into or repeat a *very lengthy* discussion here, but this
is an artifact of EGCS and inline functions.  It basically boils down to the
fact that running without -On and inline functions (the way they are used
by the Linux kernel) just doesn't jive.

Is there some reason (other than your instability which I understand) that
you want to do this?  BTW - Linux 2.2.1 is incredibly stable on my PreP box,
so I have little fear in the compiler, at least for the non-PowerMac specific
stuff.

On 12-Feb-99 Marc Dejardin wrote:
> 
> Hello,
> 
> For a long time now I encountered regularly kernel panics with recent kernels.
> Every thing was incredibly stable with 2.1.24.
> 
> To make some tests I am trying to compile the kernel 2.2.1 with -O0 option
> instead of -O2. Then I got the message :
> 
> make[1]: Leaving directory `/mnt/extra2/scratch/linux-pmac/arch/ppc/lib'
> ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic arch/ppc/kernel/head.o
> init/main.o init/version.o \
>         --start-group \
>         arch/ppc/kernel/kernel.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o
> kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
>         fs/filesystems.a \
>         net/network.a \
>         drivers/block/block.a drivers/char/char.a drivers/misc/misc.a
> drivers/net/net.a drivers/scsi/scsi.a drivers/cdrom/cdrom.a
> drivers/sound/sound.a drivers/pci/pci.a drivers/macintosh/macintosh.a
> drivers/video/video.a \
>         /tmp/scratch/linux-pmac/lib/lib.a \
>         --end-group \
>         -o vmlinux
> init/main.o: In function `calibrate_delay':
> init/main.o(.text.init+0x608): undefined reference to `__delay'
> init/main.o(.text.init+0x6e4): undefined reference to `__delay'
> make: *** [vmlinux] Error 1
> 
> at the end ... I don't get such a message with -O2 or -O1 option.
> 
> Do I make a mistake somewhere ??? is it not possible to remove optimisation in
> kernel building ?
> 
> Thanks in advance,
>                                  Marc Dejardin
> 
> 

------------------------------------------------------------------------
Gary Thomas                              |
email: gdt@linuxppc.org                  | "Fine wine is a necessity of
   ... opinions expressed here are mine  |        life for me"
       and no one else would claim them! |
                                         |      Thomas Jefferson
------------------------------------------------------------------------



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
