Message-ID: <41EA756DBC9FD0118CFC0020AFDB5C5A188D96@tcint1ntsrv>
From: Zehetbauer Thomas <TZ@link.topcall.co.at>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: booting HardHat on IBM 405GP
Date: Tue, 27 Mar 2001 22:51:29 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


It seems that execution stops when calling rfi in
arch/ppc/kernel/head_4xx.S. I have put the sample code provided to
output a single character on the serial port immediately before the rfi
call and after the after the start_here label. Only the first is beeing
executed. Any ideas?

Tom

> -----Original Message-----
> From: Ralph Blach [mailto:rcblach@raleigh.ibm.com]
>
> Hi,  This is a function call to sa, and if you look at the
> address of sa
> (the starting address) I'll bet it absoulte 0.  So, what
> happens is you
> get a jump to zero.
>
> Heres the boot process.
> 1)move the ramdisk to upper memory.
> 2)uncompress the kernel image starting a real 0.
> 3)Jump to 0.
>
> Chip Blach
>
> Zehetbauer Thomas wrote:
> >
> > My company is going to develop an embedded solution based
> on a IBM 406GP
> > processor.
> > We are in early development right now and I am trying to
> boot linux on a
> > > IBM 25 EB 405 P4 WIN WAL 00
> > evaluation kit (this is the information on the bill of delivery).
> >
> > Attempting to debug I've found
> linux/arch/ppc/boot/tree/main.c:start to
> > be the first function executed.
> > At the very last step this function calls
> > >    (*(void (*)())sa)(&board_info,
> > >                      initrd_start,
> > >                      initrd_start + initrd_size,
> > >                      cmdline,
> > >                      cmdline + strlen(cmdline));
> > and I can't find where execution goes on.
> >
> > PS: Does someone know how to determine the board's revision number?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
