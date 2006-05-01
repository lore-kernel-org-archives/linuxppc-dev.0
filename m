Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 83FF567BB9
	for <linuxppc-dev@ozlabs.org>; Tue,  2 May 2006 06:28:44 +1000 (EST)
In-Reply-To: <20060501150728.04694488.kim.phillips@freescale.com>
References: <5CA113BC-1614-4551-87E5-6926E14C2225@kernel.crashing.org>
	<1146512012.24239.28.camel@cashmere.sps.mot.com>
	<695BB790-1E64-4B53-91DD-7DD88305F201@kernel.crashing.org>
	<1146512732.24239.34.camel@cashmere.sps.mot.com>
	<55FD11DB-54AF-4284-9E9A-C313F4232105@kernel.crashing.org>
	<20060501150728.04694488.kim.phillips@freescale.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <00CD15B8-F448-4985-8EEC-3BBF61C0110B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: DTC/dts modifications
Date: Mon, 1 May 2006 15:28:34 -0500
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 1, 2006, at 3:07 PM, Kim Phillips wrote:

> On Mon, 1 May 2006 14:52:23 -0500
> Kumar Gala <galak@kernel.crashing.org> wrote:
>
>> [snip]
>>
>>>> Try running a current .dts through cpp today.  You will get errors
>>>> like:
>>>>
>>>> oftree.dts:15:3: error: invalid preprocessing directive #address
>>>
>>>> Because of props like:
>>>>
>>>>        #cpus = <1>;
>>>>        #address-cells = <1>;
>>>>        #size-cells = <0>;
>>>>
>>>> If these used some other symbol instead of '#' cpp will be happy  
>>>> and
>>>> we can use it to create macros for us.
>>>
>>> Yeah, we're not going to be able to change those; they
>>> are "By The Book".
>>
>> By what book?  It would seem to me that BNF for dtc is completely
>> under our control and if we want to change it we can.  I understand
>> that there is some correspondence to Open Firmware, but it seems that
>> if its people are ok with the dts format changing that's a lot easier
>> than implementing tons of support in dtc for features that cpp  
>> gives us.
>>
>> [I'm also guessing no one's really got time to go and implement these
>> features in dtc]
>>
> cpp -x assembler-with-cpp seems to not produce the above errors,  
> and still honours preprocessing directives like #define.  Don't  
> know what else is messes with, and whether you want to add CPPFLAGS.

Cool, here's an invocation that seems to work well.  Not sure what  
causes linux = 1 (thus I need the -U linux).  Also address the line  
information that is normally spit out.

cpp -U linux -P -x assembler-with-cpp foo.dts

With a 8349 dts I'm using I'm able to run it through cpp then dts and  
get the exact same dtb.

- kumar
