Date: Sat, 13 Feb 1999 23:42:27 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: Gabriel Paubert <paubert@iram.es>
cc: Jeremy Fitzhardinge <jeremy@goop.org>, linuxppc-dev@lists.linuxppc.org,
        cort@cs.nmt.edu
Subject: Re: Interrupt routing in prep_pci.c
In-Reply-To: <Pine.HPP.3.96.990211100221.5352B-100000@gra-ux1.iram.es>
Message-ID: <Pine.LNX.4.04.9902132334480.4390-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


You may also find my patches for MTX SMP support usefull. It contains most
of the stuff in Geert's patches, with the addition that most all of the
architecture-dependent functions have been redone to be dispatched by a
structure of function pointers. (Thanks to Corey Minyard) This gets rid of
a great number of case statements, and what could be the framework for a
good cleaning up of the arch/ppc/kernel directory. I suspect it might make
porting to a yellowknife like board easier. If the yellowknife board
supports SMP and has an OpenPIC, my SMP patches might work also ;)

They can be found at:

	ftp://linuxppc.cs.nmt.edu/pub/linuxppc/patches/mtx-smp/
	ftp://ftp.microux.com/pub/linux/

(The latest is agains 2.2.0-pre9.. I need to update it ;)

On Thu, 11 Feb 1999, Gabriel Paubert wrote:

> 
> 
> 
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
> 	ftp://vcorr1.iram.es/pub/linux-2.2/mvm2600.generic-patch-2.2.1
> 
> > Background: I'm porting LinuxPPC to a Yellowknife-like board running Open
> > Firmware.  It works well except that the drivers can't find their interrupts.
> 
> Note that this patch includes a new bootloader for PreP machines, I'd like
> to extend it to support OF too but don't have te time right now.
> 
> 	Gabriel.
> 
> 
> 

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
