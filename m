Return-Path: <jaf@lcsaudio.com>
Received: from elasmtp-mealy.atl.sa.earthlink.net
	(elasmtp-mealy.atl.sa.earthlink.net [209.86.89.69])
	by ozlabs.org (Postfix) with ESMTP id F373B67EC8
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Feb 2006 04:03:52 +1100 (EST)
In-Reply-To: <3c13d56389dfcf9f45ca87167295e933@embeddedalley.com>
To: Dan Malek <dan@embeddedalley.com>
Subject: Re: Floating point math in kernel interrupt -- am I doing this right?
	(repost)
From: "Jeremy Friesner" <jaf@lcsaudio.com>
Date: Mon, 06 Feb 2006 08:55:22 PST (-0800)
Message-Id: <1644783017-BeMail@jeremy.lcsaudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> 
> On Feb 5, 2006, at 9:29 PM, Jeremy Friesner wrote:
> 
> > ....   and the mixing is done inside an
> > interrupt routine that runs 6000 times per second, and calculates 8 
> > samples
> > per interrupt.
> 
> Bad news.  No Floating Point allowed in the kernel.

I'm aware of that rule, and also why -- because the Linux kernel doesn't want to have to save and restore the state of the floating point registers on every context switch.  I'm also aware that it is nonetheless possible to use floating point in the kernel if you are careful to manually save and restore the proper state yourself, and that in fact floating point is sometimes used in the kernel as a means of doing 64-bit writes, as mentioned here:

http://www.tldp.org/LDP/cpg/html/x295.html

So it seems to me that it is possible to do floating point in the kernel, if you are careful to save and restore the proper context/state before and afterwards.  But if it isn't, can you explain to me why it can't be made to work=3F
 
> > In order to do the necessary floating point math, without corrupting 
> > the state
> > of any other processes that might be using the FPU, the interrupt 
> > routine
> > first saves the state of the FPU registers to the stack, then does the 
> > math,
> > then restores FPU registers again, before returning.
> 
> Not on 82xx.  All floating point is done in hardware.

Right; it is the hardware registers' state that I am saving to the stack, and then restoring afterwards.
 
> > So my question is, is there some minor detail that my 
> > FPU-state-save/restore
> > code is missing, that would cause these sort of symptoms=3F
> 
> Just get all of this out of the kernel.  If you used the standard ALSA
> drivers and framework, lots of mixing features are available to you.
> If you need some custom mixing, just write a plug-in to do it.
> Your data rates are so low they don't justify making any hacks
> like this.

I suppose that is an option, but I'd rather understand why my hack isn't working before I give up and redesign my application, which is already working the way I want it to, 99.9999% of the time.

Jeremy
