Return-Path: <glikely@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.200])
	by ozlabs.org (Postfix) with ESMTP id 3C2F368883
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Dec 2005 08:13:06 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id f1so167682nzc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 06 Dec 2005 13:13:05 -0800 (PST)
Message-ID: <4395FED2.8000003@gmail.com>
Date: Tue, 06 Dec 2005 14:12:50 -0700
From: Grant Likely <glikely@gmail.com>
MIME-Version: 1.0
To: Rick Moleres <rick.moleres@xilinx.com>
References: <689CB232690D8D4E97DA6C76DA098E6C017395E1@XCO-EXCHVS1.xlnx.xilinx.com>
In-Reply-To: <689CB232690D8D4E97DA6C76DA098E6C017395E1@XCO-EXCHVS1.xlnx.xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 1/2] Move Virtex-II Pro / ML300 port over to the platform
 bus.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Rick Moleres wrote:

>Grant,
>
>Would it be possible for me to take a closer look at the work you're
>doing in this regard?  We've been hatching some ideas around with ways
>to separate the dependency on xparamters.h/_g.c files to accommodate
>run-time configuration, but our workload and priorities haven't allowed
>us to spend much time here.
>  
>
Certainly.  I'm getting my env cleaned up today, and I'll be sending
patches to the mailing list shortly.

Essentially what I'm doing is making any non-xilinx code get parameters
from platform bus devices instead of xparameters.h (Things like
processor speed, interrupts, etc).  This of course is only a first
step.  It allows xparameters to change w/o recompiling the world.

Xilinx drivers are another matter since each of them include xparameters
directly.

>We're taking a baby step towards that by just moving _LookupConfig out
>of the main driver .c file and adding a new _Init function that takes a
>_Config structure as an argument rather than depend internally on the
>_g.c table.
>
You're making me happy here.  :)

>  It would be nice to know, though, that work we're doing
>won't completely conflict with work others like yourself are doing.
>  
>
It doesn't sound like it will.  A _Config struct could be built up from
data in the platform device (or embedded in the platform device
itself).  Once the flattened device tree work is in, we could build up
the whole thing from data provided by the bootloader.  No recompile
needed at all.  :)

g.

>-----Original Message-----
>From: linuxppc-embedded-bounces@ozlabs.org
>[mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of Grant Likely
>Sent: Monday, December 05, 2005 9:52 AM
>To: Peter Korsgaard; linuxppc-embedded
>Subject: Re: [PATCH 1/2] Move Virtex-II Pro / ML300 port over to the
>platform bus.
>
>Peter Korsgaard wrote:
>
>  
>
>>On 9/20/05, Grant Likely <glikely@gmail.com> wrote:
>> 
>>
>>    
>>
>>>On 9/20/05, Peter Korsgaard <jacmet@sunsite.dk> wrote:
>>>   
>>>
>>>      
>>>
>>>>>>>>>" " == Grant Likely <glikely@gmail.com> writes:
>>>>>>>>>               
>>>>>>>>>
>>>>>>>>>                  
>>>>>>>>>
>>>>Hi,
>>>>
>>>>        
>>>>
>>>>>This is a large patch that moves the ML300 to the platform bus.
>>>>>It also isolates most of the linux tree from changes to the
>>>>>xparameters.h file.  Ultimately, the goal is to move everything
>>>>>over to the flattened device tree for telling the kernel about
>>>>>devices.  That way xparameters.h can go away entirely for the
>>>>>kernel proper.  (Isolated to the bootloader)
>>>>>          
>>>>>
>>>>     
>>>>
>>>>        
>>>>
>>Hi,
>>
>>Any news on submitting this to mainline?
>> 
>>
>>    
>>
>
>Yeah, I'm back working on it again after being pulled away on consulting
>priorities.  I hope to have a public git tree up soon, and I'll be
>sending patches to mainline shortly thereafter.
>
>Cheers
>g.
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
>
>  
>
