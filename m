Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 175ED67A79
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jan 2005 06:33:23 +1100 (EST)
Message-ID: <41ED6480.7060907@mvista.com>
Date: Tue, 18 Jan 2005 12:33:20 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
References: <41EC29A8.1040703@mvista.com>
	<20050118161515.GI28724@smtp.west.cox.net>
	<41ED5BBA.2090808@mvista.com>
	<20050118190514.GL28724@smtp.west.cox.net>
In-Reply-To: <20050118190514.GL28724@smtp.west.cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [RFC] Option to disable mapping genrtc calls to ppc_md calls
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tom Rini wrote:

>On Tue, Jan 18, 2005 at 11:55:54AM -0700, Mark A. Greer wrote:
>  
>
>>Tom Rini wrote:
>>    
>>
>[snip]
>  
>
>>>>Is there a better way to do this?
>>>>  
>>>>
>>>>        
>>>>
>>>How about we try borrowing the MIPS abstraction and force todc_time,
>>>pmac_time (any others?) to directly define (and EXPORT_SYMBOL)
>>>get_rtc_time / set_rtc_time / etc.
>>>
>>>      
>>>
>>Yep, MIPS has a solution...and so does ARM...and so does PPC.  This is 
>>sort of my point.
>>    
>>
>
>And my point was to use someone elses solution, 'cuz that's how we go
>from N to N-1 to 1 :)
>

If effort is going to be put into this then why not just go from N 
directly to 1?  BTW, I am not volunteering.  ;)

>
>  
>
>>If we really want to do it right then someone needs to architect a 
>>generic solution.  What I have done is generic but does not handle the 
>>case that Geert mentioned when you have one kernel binary and several 
>>possible rtc chips.  In the meantime, what I have done works fine for 
>>all but that case.
>>    
>>
>
>I guess there's two points:
>- How does your solution differ from what MIPS does, and probably ARM
>  does of saying the backend (todc_time, i2c-foo) provides
>  get_rtc_time/set_rtc_time?
>
First, I want to make sure we all on the same page.  There are really 
two issues being discussed and I think we're all swinging back and forth 
between the two.

Issue 1) -  My patch:

I had to write some support for an ST m41t00 rtc w/ an i2c interface.  I 
could have made it ppc only or generic with the same amount of effort so 
I chose the generic one.  The gereric one I chose was to use the code in 
genrtc and interface directly to the bottom of that code b/c that's 
where things become arch-specific.  However, that is where I collided 
with asm-ppc/rtc.h, hence the patch.

What I did is generic because genrtc.c is generic, the rtc "driver" is 
generic, and you can plug in any generic i2c algo/adapter driver 
underneath the entire thing.

Issue 2) - What should the *real* rtc architecture be?

RMK's solution may be fine, I'd have to look.  I think a discussion like 
this is good but I know I don't have the time right now to do it.

This is the one I think you, Tom, are talking about.  That's good but 
just understand that my patch has nothing to do with a generic solution 
for all rtc's.  I'm just trying to get this one to work (issue 1).

>- I horribly briefly talked with rmk about this a long time ago, and I
>  think he has the generic solution, siting in arch/arm/common/rtctime.c
>  (sure it would need to be moved to drivers/char/something, but..).
>

Yep, if it isn't in the right place, it doesn't help (for now anyway).

>- I lied, #3 how does ARM, which I think lets you select multiple
>  boards, and thus probably end up with multiple rtc chip choices, deal
>  with it.
>

Yep, ARM has  a reasonable solution but its ARM only and I'm not trying 
to rewrite anything at this point (see above).

Mark
