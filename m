Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id C5E3A67A65
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jan 2005 06:43:16 +1100 (EST)
Message-ID: <41ED66D0.2090506@mvista.com>
Date: Tue, 18 Jan 2005 12:43:12 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
References: <41EC29A8.1040703@mvista.com>
	<20050118161515.GI28724@smtp.west.cox.net>
	<93780AB0-696D-11D9-81BE-003065F9B7DC@embeddededge.com>
	<20050118181330.GJ28724@smtp.west.cox.net>
	<41ED5C51.8020809@mvista.com>
	<20050118190848.GM28724@smtp.west.cox.net>
In-Reply-To: <20050118190848.GM28724@smtp.west.cox.net>
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

>On Tue, Jan 18, 2005 at 11:58:25AM -0700, Mark A. Greer wrote:
>  
>
>>Tom Rini wrote:
>>
>>    
>>
>>>I think one of us wasn't clear.  I'm not arguing for nuking
>>>ppc_md.{get,set}_rtc_time(), I'm arguing for nuking
>>>get_rtc_time()/set_rtc_time() inlines from <asm-ppc/rtc.h> (which are
>>>used by drivers/char/genrtc.c) in favor of todc_time et al providing the
>>>functions for genrtc.  So all of the other places we use
>>>ppc_md.{get,set}_rtc_time() are unchanged.
>>>      
>>>
>>Ahh.  Okay, that's good but it should be done in drivers/rtc or 
>>something like and not just another arch specific solution.
>>    
>>
>
>It's not an arch specific solution today.
>

Okay, I see what you mean and yes moving that up (or something 
equivalent) would be a good idea.

That's not what my patch is about though.  My patch is just so I can 
provide a generic solution with what is there today.  Its not 
redesigning anything, its just getting asm-ppc/rtc.h out of the way so I 
can make my own, generic get_rtc_time(), etc.

>  It's just that no one that's
>written an rtc chip library (*cough* todc_time.c *cough*)
>

Heh!

> has placed one
>in drivers/char/ and let the chips (or the file) be selected.  genrtc.c
>already says "someone else tell me how to get the time".  I kinda sorta
>think arch/arm/common/rtctime.c does too, except it has hooks for alarm.
>

Yeah, its probably time for a better solution to what's there today...  
Maybe I can get to it but it won't be for a while.

Mark
