Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 4B6E267A7C
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jan 2005 05:58:30 +1100 (EST)
Message-ID: <41ED5C51.8020809@mvista.com>
Date: Tue, 18 Jan 2005 11:58:25 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
References: <41EC29A8.1040703@mvista.com>
	<20050118161515.GI28724@smtp.west.cox.net>
	<93780AB0-696D-11D9-81BE-003065F9B7DC@embeddededge.com>
	<20050118181330.GJ28724@smtp.west.cox.net>
In-Reply-To: <20050118181330.GJ28724@smtp.west.cox.net>
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

>On Tue, Jan 18, 2005 at 11:25:33AM -0500, Dan Malek wrote:
>  
>
>>On Jan 18, 2005, at 11:15 AM, Tom Rini wrote:
>>
>>    
>>
>>>On Mon, Jan 17, 2005 at 02:10:00PM -0700, Mark A. Greer wrote:
>>>      
>>>
>>>>There are 2 reasons to not use the ppc_md.get_rtc_time() et. al. 
>>>>interfaces:
>>>>1) They are called before the i2c driver is initialized and even 
>>>>loaded
>>>>if its a module.
>>>>        
>>>>
>>There are three reasons.  You don't want to use an I2c rtc clock at
>>all in these functions because they get can get called from the
>>clock interrupt to update the time in the rtc.  If it does happen to 
>>work,
>>it creates long latencies in the timer interrupt.  If the i2c requires 
>>an
>>interrupt, they system will crash or hang.
>>    
>>
>
>I think one of us wasn't clear.  I'm not arguing for nuking
>ppc_md.{get,set}_rtc_time(), I'm arguing for nuking
>get_rtc_time()/set_rtc_time() inlines from <asm-ppc/rtc.h> (which are
>used by drivers/char/genrtc.c) in favor of todc_time et al providing the
>functions for genrtc.  So all of the other places we use
>ppc_md.{get,set}_rtc_time() are unchanged.
>  
>

Ahh.  Okay, that's good but it should be done in drivers/rtc or 
something like and not just another arch specific solution.  I want to 
stress again that rtc chips typically have no care in the world what 
processor happens to be stuck on the board that they are also stuck on.  
There is no reason our software should either.

Mark
