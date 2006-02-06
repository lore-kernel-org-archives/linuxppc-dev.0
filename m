Return-Path: <dan@embeddedalley.com>
Received: from smtp103.biz.mail.re2.yahoo.com (smtp103.biz.mail.re2.yahoo.com
	[68.142.229.217]) by ozlabs.org (Postfix) with SMTP id 6BA49689D9
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Feb 2006 23:34:24 +1100 (EST)
In-Reply-To: <200602051829.47824.jaf@lcsaudio.com>
References: <200602051829.47824.jaf@lcsaudio.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3c13d56389dfcf9f45ca87167295e933@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: Floating point math in kernel interrupt -- am I doing this right?
	(repost)
Date: Mon, 6 Feb 2006 07:27:43 -0500
To: Jeremy Friesner <jaf@lcsaudio.com>
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


On Feb 5, 2006, at 9:29 PM, Jeremy Friesner wrote:

> ....   and the mixing is done inside an
> interrupt routine that runs 6000 times per second, and calculates 8 
> samples
> per interrupt.

Bad news.  No Floating Point allowed in the kernel.

> In order to do the necessary floating point math, without corrupting 
> the state
> of any other processes that might be using the FPU, the interrupt 
> routine
> first saves the state of the FPU registers to the stack, then does the 
> math,
> then restores FPU registers again, before returning.

Not on 82xx.  All floating point is done in hardware.

> ....  The oops
> looks like this:

These aren't helpful without some supporting information, like
symbols, or learn to use ksymoops.

> So my question is, is there some minor detail that my 
> FPU-state-save/restore
> code is missing, that would cause these sort of symptoms?

Just get all of this out of the kernel.  If you used the standard ALSA
drivers and framework, lots of mixing features are available to you.
If you need some custom mixing, just write a plug-in to do it.
Your data rates are so low they don't justify making any hacks
like this.

Thanks.

	-- Dan
