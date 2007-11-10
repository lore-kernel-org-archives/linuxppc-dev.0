Return-Path: <gvb.linuxppc.dev@gmail.com>
Received: from QMTA07.westchester.pa.mail.comcast.net
	(qmta07.westchester.pa.mail.comcast.net [76.96.62.64])
	by ozlabs.org (Postfix) with ESMTP id 9BEECDDE00
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 12:12:53 +1100 (EST)
Message-ID: <47350613.7000606@gmail.com>
Date: Fri, 09 Nov 2007 20:14:59 -0500
From: Jerry Van Baren <gvb.linuxppc.dev@gmail.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4] Use embedded libfdt in the bootwrapper
References: <20071108033241.GA11695@localhost.localdomain>	<20071108033603.8A29FDDE0F@ozlabs.org>	<20071108160839.GA4356@loki.buserror.net>	<20071108224051.GB18592@localhost.localdomain>
	<473392A3.4010203@freescale.com> <4733AF6B.60807@gmail.com>
	<473483DF.7060903@freescale.com>
In-Reply-To: <473483DF.7060903@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Jerry Van Baren wrote:
>> My concern from the u-boot side is that u-boot has to know exactly 
>> *where* to put the expanded blob because it has to pass it to linux 
>> and keep it out of linux' way so it doesn't get "stepped on."  Linux 
>> has an advantage in that it "owns" all of memory and can allocate and 
>> deallocate whatever and wherever and it won't step on itself (hopefully).
> 
> Linux is pretty careful not to step on the device tree; it marks the 
> area as reserved, and moves it if it really has to.  The only scenario I 
> think would be problematic is if the kernel is started somewhere other 
> than zero, and has to relocate itself, and the relocation clobbers the 
> device tree.  That's easily avoided by making sure the device tree is at 
> a higher address than the kernel -- and is really not much different 
> than the old bd_t mechanism, which didn't use a user provided address 
> AFAIK.

That is good to know, makes things much easier.

>> I'm assuming your boot wedge has the advantage of being able to use 
>> linux's malloc() and thus don't have to worry about coordinating with 
>> linux on memory allocation.
> 
> No, it uses its own malloc.
> 
>> With the current u-boot fdt command, you can resize the blob, and this 
>> can be done in a script with all the (somewhat limited) capabilities 
>> of the u-boot shell (an adaptation of hush).
> 
> OK, I'm just going by the behavior of the default boot commands on (at 
> least some of) our boards, which just give you an error if the blob 
> isn't already enlarged.
> 
> Maybe I should just poke Kim et al. about fixing our default environment 
> -- though I'm guessing it'd still have to know from the script how much 
> to enlarge the blob.

Currently it is a manual thing, my point was that it is potentially 
scriptable (but would probably take a genius or 3 days of 
experimentation to make the script work ;-).  If we can settle on a safe 
way to expand the blob automatically, I'm all for that.

>> In the u-boot world, we fixate on memory maps and putting things in 
>> specific places.
> 
> I've noticed. :-)
> 
> -Scott

Yeah, I had a ruder term than "fixate" but changed it for public 
consumption.  ;-)

Best regards,
gvb
