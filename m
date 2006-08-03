Return-Path: <mgreer@mvista.com>
Date: Thu, 3 Aug 2006 12:26:29 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/6] bootwrapper: arch/powerpc/boot code reorg
Message-ID: <20060803192629.GD25251@mag.az.mvista.com>
References: <20060719230014.GB3887@mag.az.mvista.com>
	<17616.12251.339657.215571@cargo.ozlabs.ibm.com>
	<17616.17129.964122.125259@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17616.17129.964122.125259@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 02, 2006 at 04:15:05PM +1000, Paul Mackerras wrote:
> I wrote:
> 
> > The ops structure seems like a reasonable concept, but I question
> > whether we need to have platform_ops separate from fw_ops, since the
> > firmware is essentially part of the implementation of the platform.
> > Also I don't see why we need to do a double indirection to get to each
> > ops function.
> 
> Thinking about this a bit more, why do we need the indirect function
> calls at all?  Do we ever want to be able to choose (e.g.) one of
> several possible console implementations at runtime?  Don't we know at
> compile time which one we will be using, and thus can't we use the
> linker to make the necessary linkages?

Hi Paul,

I realize that I didn't really answer your question.  Its at least
possible that the console driver could not be known at link time.

An example I used in another email is a platform that has 4 serial
ports, 2-16550 and 2-mpsc, say.  The /chosen/linux,stdout-path could
pick any of the four so you would need to compile in a low-level
serial driver for both and hook the correct one up at runtime.

Same could be said for a serial vs. video console.

At least for now, I'd like to keep the flexibility.  Once things
settle down we can take another look to see what was is really
necessary and what's overkill.

Mark
