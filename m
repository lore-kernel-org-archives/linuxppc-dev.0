Message-ID: <36D03ACA.F8626298@phx.mcd.mot.com>
Date: Sun, 21 Feb 1999 09:56:43 -0700
From: Johnnie Peters <jpeters@phx.mcd.mot.com>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
CC: Jeremy Fitzhardinge <jeremy@goop.org>, linuxppc-dev@lists.linuxppc.org,
        cort@cs.nmt.edu
Subject: Re: Interrupt routing in prep_pci.c
References: <Pine.HPP.3.96.990211100221.5352B-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Gabriel

I would like to try your stuff out but I have not been able to get to your site.  Do
you have it anywhere else I can retrieve it from?

I tried a version of it a while back and it did not seem to compile with the standard
R4 compiler.  At that time I tried to compile and use the latest egcs and binutils
stuff and it seemed to work for the kernel but when I tried compiling user level
stuff it gave me several problems.  I have asked several people on the net and have
not got a good answer as to what compiler I should be using with R4.  Can you tell me
the combination you are using?

Thanks for your time,

Johnnie


Gabriel Paubert wrote:

> On Wed, 10 Feb 1999, Jeremy Fitzhardinge wrote:
>
> >
> > Hi Cort/all,
> >
> > I'm trying to work out what kernel/prep_pci.c is doing with interrupt routing.
> > I'm looking at the stuff in the standard 2.2 kernel, so perhaps there's a better
> > place for me to look.
> >
> > Firstly, in route_pci_interrupts it does an inb(0x800) to get something to
> > determine the interrupt architecture of the board.  What is this value, and
> > where does it come from?
>
> It's a value which give sthe board type on rather old IBM/Motorola boards.
>
> > Rather than having hard-coded tables, can't the interrupt routing be determined
> > from either firmware or the interrupt controller itself?  The comment at the
> > top of the file is that this will go away soon.  What are you planning to
> > replace it?
>
> Indeed, that's what I do from residual data on PreP machines and it seems
> to work on several kinds of boards. You'll find it embedded somewhere
> in the patch file at:
>
>         ftp://vcorr1.iram.es/pub/linux-2.2/mvm2600.generic-patch-2.2.1
>
> > Background: I'm porting LinuxPPC to a Yellowknife-like board running Open
> > Firmware.  It works well except that the drivers can't find their interrupts.
>
> Note that this patch includes a new bootloader for PreP machines, I'd like
> to extend it to support OF too but don't have te time right now.
>
>         Gabriel.




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
