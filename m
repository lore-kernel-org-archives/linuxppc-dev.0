Return-Path: <mgreer@mvista.com>
Date: Mon, 7 Aug 2006 17:15:21 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/6] bootwrapper: arch/powerpc/boot code reorg
Message-ID: <20060808001521.GC4582@mag.az.mvista.com>
References: <20060719230014.GB3887@mag.az.mvista.com>
	<17616.12251.339657.215571@cargo.ozlabs.ibm.com>
	<17616.17129.964122.125259@cargo.ozlabs.ibm.com>
	<20060803192629.GD25251@mag.az.mvista.com>
	<17622.57931.631871.287907@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17622.57931.631871.287907@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 07, 2006 at 04:48:43PM +1000, Paul Mackerras wrote:
> Mark A. Greer writes:
> 
> > I realize that I didn't really answer your question.  Its at least
> > possible that the console driver could not be known at link time.
> > 
> > An example I used in another email is a platform that has 4 serial
> > ports, 2-16550 and 2-mpsc, say.  The /chosen/linux,stdout-path could
> > pick any of the four so you would need to compile in a low-level
> > serial driver for both and hook the correct one up at runtime.
> > 
> > Same could be said for a serial vs. video console.
> 
> OK, that's reasonable.  Still would be nice not to have to do the
> double dereference though.

Yep, I'll get rid of the double dereference.

> I think that the platform_ops and the
> fw_ops could probably be combined.

Okay.

> Also, an init method for the
> platform/fw_ops would be useful

Hm, I don't understand what you mean here.  I already have
'platform_init()' called from start().  Is that not sufficient?

> - it would let us remove the kludge
> you have in the OF malloc implementation.

The OF malloc routine was a straight copy of what was already
in try_claim() in main.c.  As I look at try_claim() now, though,
I see that its changed.  I can get rid of that code inside the
"#if defined(PROG_START)".  Is that the kludge you were referring to?

> The OF malloc is currently applying a minimum address constraint for
> all platforms, where it used to apply it only for 64-bit platforms.
> We need to fix that up somehow too.

Okay. 

Mark
