Date: Thu, 2 Dec 1999 15:49:43 -0500 (EST)
From: "Mark S. Mathews" <mark@absoval.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: RPXLite 823 PCMCIA troubles
In-Reply-To: <38449F54.D6E1FC5@netx4.com>
Message-ID: <Pine.LNX.3.96.991202153547.27124H-100000@tristar.cc.absoval.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Howdy Folks,

Ok, the wlan PCMCIA card is working....but only after an ugly hack.
Basically, I modified
the MachineCheck function to ignore the exception (just return) if the
faulting address (contents of DAR) falls in the iomapped range we've
established for the PCMCIA card.

Any opinions on our solution?

I'd still like to know what's causing these exceptions, but that's for
another day.

-Mark

On Tue, 30 Nov 1999, Dan Malek wrote:

> 
> Mark S. Mathews wrote:
> 
> 
> > Hmmmm.  The way ours "works for awhile", I'm wondering if there's a
> > problem w/ the way the 8xx is handling the WAIT# when the MMU is enabled
> > (?)
> 
> Shouldn't be the problem.  The MMU appears (on block diagrams
> anyway :-) to be far enough removed from the memory controller
> for this to happen.
> 
> 
> > This is good to know.  Our card supports I/O or memory access to the
> > shared memory.  We'll shift over to the I/O and try that.
> 
> The version I have running on my PowerBook only uses I/O.....
> or am I mistaken?
> 
> 
> > We've been running _lots_ of experiments with the timing settings.  So far
> > 3,10,6 seems to work best....but it still fails.
> 
> Thanks.  I'll keep those numbers around.....there are others
> I would rather see.....:-).
> 
> 
> > I've seen the 'guarded' thing around in the sources, but I'm not sure what
> > it's all about.  Guess I should look. ;-)
> 
> I just fixed it.  I'll send it to you privately as well as
> post it on the ppc.kernel.org server.  I hope it corrects
> something.
> 
> 
> 
> 	-- Dan
> 


Mark S. Mathews

AbsoluteValue Software     Web:    http://www.absoval.com
P.O. Box 941149            e-mail: mark@absoval.com
Maitland, FL 32794-1149    Phone:  407.644.8582
USA                        Fax:    407.539.1294


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
