Date: Thu, 13 May 1999 21:02:45 -0700 (MST)
From: Jeff Rugen <jrugen@primenet.com>
To: Gary Thomas <gdt@linuxppc.org>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: RE: Motorola Powerstack Parallel Port
In-Reply-To: <XFMail.990513053536.gdt@linuxppc.org>
Message-ID: <Pine.BSI.3.96.990513205102.7117A-100000@usr07.primenet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 13 May 1999, Gary Thomas wrote:

> 
> 
> On 13-May-99 Jeff Rugen wrote:
> > 
> > Ok, according to the book that came with my Motorola PowerStack, I have a
> > parallel port that is compatible with IEEE standard 1284, including the
> > Extended Capability Port (ECP) and Enhanced Parallel Port (EPP).  However,
> > the driver (parport_pc) doesn't recognize it as ECP and EPP, and says its
> > only SPP.  I haven't played around the parallel port much, so I figured I'd

<snip -- context above>

> > I have one of the old 100MHz 604 machines.  I'm trying to get the quickcam
> > drivers working with the 2.2.x/2.3.x kernel (I had one of the drivers
> > working with the 2.0.x kernel, but I don't know if it was in EPP or SPP
> > mode).
> > 
> > Any help, pointers, or advice on this topic would be much appreciated.
> > If you know what specific chip is used to implement the parallel
> > port, I can look around for a data book on it as well.  Thanks for any help.
> >
> 
> The parallel port, along with most of the other devices in the system, are
> implemented in the PCI-bridge chip (82473 IIRC).

Ok, now flipping the book that came with the machine over to look at the
other page, I notice that it indicates the Paralell Port is part of the
National Semiconductor PC87303 "Super I/O" controller.  RTFM does wonders,
eh?

So I grabbed the documentation.  It looks like on reset, the parallel port
comes up in SPP mode.  I'd need to twiddle a register or two in the 87303 to
put it in either EPP or ECP mode.  Also, unlike some of the parallel ports
supported by parport_pc, the port can either be in EPP or ECP mode, but not
both (meaning only one of the two sets of additional registeres are
available).

Now, glancing through parport_ax (the Sun Ultra/AX paralell port file), I
notice some calls to ns87303_readb() and ns87303_writeb().  I'm staring to
think that (after some tweaking), the PowerStacks may want to be using that
parallel port driver.  However, I don't know how many of them actually use
the 87303.  Is it common enough that PReP would use it, or is it specific to
a few types of machines?  Or maybe it would be a configuration option.

The include/asm-sparc64/ns87303.h file does look generic enough to fit right
into the asm-ppc directory as well.  Anyone have any ideas on the numbers,
or know the direction the arch/ppc directories are heading well enough to
know if this would be something to pursue?

----------------------------------------------------------------------------
Jeff Rugen                      jrugen@primenet.com

..Had this been an actual emergency, we would have fled in terror, and you 
would not have been informed.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
