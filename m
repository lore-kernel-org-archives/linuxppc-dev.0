Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id B61C167A72
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jan 2005 05:56:07 +1100 (EST)
Message-ID: <41ED5BBA.2090808@mvista.com>
Date: Tue, 18 Jan 2005 11:55:54 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
References: <41EC29A8.1040703@mvista.com>
	<20050118161515.GI28724@smtp.west.cox.net>
In-Reply-To: <20050118161515.GI28724@smtp.west.cox.net>
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

>On Mon, Jan 17, 2005 at 02:10:00PM -0700, Mark A. Greer wrote:
>
>  
>
>><snip>
>>
>>There are 2 reasons to not use the ppc_md.get_rtc_time() et. al. interfaces:
>>1) They are called before the i2c driver is initialized and even loaded 
>>if its a module.
>>    
>>
>
>But they check if it's set, so they can be assigned later and this is
>OK.
>

But looking at ppc_md.<anything> automatically makes it ppc only.  
Pretty much any of the rtc chips that we use on ppc platforms could 
appear on almost any other platform with a different processor 
architecture.  So the question is, why do we keep adding ppc-only 
support for rtc chips?  Why are we not putting our effort into making 
code that works on all architectures?  Its easy enough to do...

>>2) Its ppc-specific.  Implementing get_rtc_time() et. al. directly makes 
>>it generic across all architectures.
>>    
>>
>
>Guessing, this is for a marvell chipset that's found on MIPS too.
>

That's an example but like I said above rtc chips are not tied to any 
particular processor architecture.

>>Is there a better way to do this?
>>    
>>
>
>How about we try borrowing the MIPS abstraction and force todc_time,
>pmac_time (any others?) to directly define (and EXPORT_SYMBOL)
>get_rtc_time / set_rtc_time / etc.
>

Yep, MIPS has a solution...and so does ARM...and so does PPC.  This is 
sort of my point.

If we really want to do it right then someone needs to architect a 
generic solution.  What I have done is generic but does not handle the 
case that Geert mentioned when you have one kernel binary and several 
possible rtc chips.  In the meantime, what I have done works fine for 
all but that case.

Mark
