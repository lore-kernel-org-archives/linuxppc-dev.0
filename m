Date: Tue, 5 Jan 1999 10:05:39 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Dan Malek <dmalek@jlc.net>
cc: Cort Dougan <cort@persephone.cs.nmt.edu>,
        Paul Mackerras <paulus@cs.anu.edu.au>, bh40@calva.net,
        tmrini@ntplx.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: irq cleanup
In-Reply-To: <3691A41B.5BB09E15@jlc.net>
Message-ID: <Pine.LNX.4.03.9901051001440.28240-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 5 Jan 1999, Dan Malek wrote:
> Cort Dougan wrote:
> > Right, that's the plan.
> >
> > }To support PCI or ISA devices that interrupt on the MBX
> > }you would need to modify irq.c to support a multilevel interrupt
> > }scheme.  The 8259 would interrupt on one of the 8xx interrupt
> > }controller levels, then you would have to process all 8259
> > }interrupts.
> 
> Are there other systems designed like this with a multilevel
> interrupt controller?  It's not hard to imagine, although I have
> never seen one before the MBX.  This is one reason I didn't
> spend any effort when I did the iniitial port.  It seemed like
> lots of work for a single board not likely to use them

LongTrail CHRP has the output of the master i8259 routed through the OpenPIC.
So it has 3 interrupt controllers:

  - irq 0-7: master i8259	-> irq 16
  - irq 8-15: slave i8259	-> irq 2
  - irq 16-35: OpenPIC in Hydra	-> CPU

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
