Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 811721A026E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 01:53:52 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Mon, 20 Apr 2015 21:23:49 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id DC6721258044
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 21:25:42 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3KFrkos59965660
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 21:23:46 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3KFrjRw025385
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 21:23:45 +0530
Message-ID: <55352107.4080901@linux.vnet.ibm.com>
Date: Mon, 20 Apr 2015 21:23:43 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH v2 2/2] leds/powernv: Add driver for PowerNV platform
References: <20150320105921.14866.83209.stgit@localhost.localdomain>
 <20150320110328.14866.98225.stgit@localhost.localdomain>
 <552D303A.5080506@samsung.com> <552E049D.2030604@linux.vnet.ibm.com>
 <552E2480.9060102@samsung.com> <552E3A56.8030300@linux.vnet.ibm.com>
 <5534E6D9.6060804@samsung.com> <5534F240.3020907@linux.vnet.ibm.com>
 <5535195B.5010101@samsung.com>
In-Reply-To: <5535195B.5010101@samsung.com>
Content-Type: text/plain; charset=utf-8
Cc: stewart@linux.vnet.ibm.com, cooloney@gmail.com, rpurdie@rpsys.net,
 linuxppc-dev@lists.ozlabs.org, linux-leds@vger.kernel.org,
 khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/20/2015 08:50 PM, Jacek Anaszewski wrote:
> On 04/20/2015 02:34 PM, Vasant Hegde wrote:
>> On 04/20/2015 05:15 PM, Jacek Anaszewski wrote:
>>> Hi Vasant,
>>>
>>> I'd like to clarify some details regarding your explanation.
>>>
>>> On 04/15/2015 12:15 PM, Vasant Hegde wrote:
>>> [...]
>>>>>>
>>>>>> In Power Systems LEDs are overloaded (meaning same LED is used for
>>>>>> identify and
>>>>>> fault depending on their state  ---  blinking = identify and solid = fault).
>>>>>> Hence here append LED type info.
>>>>>
>>>>> The label could be composed of segments and an ordinal number as
>>>>> labels have to be unique, e.g. attn_ident_0, attn_ident_1.
>>>>> The segments would have to be parsed by the driver to discover
>>>>> all the LED's available modes.
>>>>>
>>>>> nitpicking: identify is a verb and is not a proper name for the LED.
>>>>> Could you describe the purpose of this mode, so that we could come
>>>>> up with a better name?
>>>>
>>>> Each component (Field Replacement Unit) will have service indicator (LEDS)
>>>> which
>>>> can have below states :
>>>>     - OFF     : no action
>>>>     - Identify: blinking state (user can use this state to identify particular
>>>> component).
>>>>          In Power Systems world we call it as "identify" indicator.. Hence I
>>>> retained same name here.
>>>>          How about just "ident" ?
>>>>     - fault : solid state (when component goes bad, LED goes to solid state)
>>>>        Note that our FW is capable of isolating some of the issues and it
>>>> can turn
>>>> on LEDs without OS
>>>>         interference.
>>>>
>>>> We have one more System level LED (System Attention Indicator).. This LED has
>>>> two states:
>>>>     - OFF : Everything is fine
>>>>     - ON : Some component has issues and needs attention.
>>>
>>> We have three modes:
>>> - identify        - blinking
>>> - fault            - solid
>>> - attention indicator    - solid
>>>
>>> How does LED operation differ for fault and attention modes?
>>> Does a LED have different intensity?
>>
>> Jacek,
>>
>> System Attention LED is special LED and its single LED available/system. where
>> as identify and fault is applicable to all field replaceable units in the
>> system..
>>
>> So Typical server will have
>>     1   System Attention LED
>>      N  Identify/fault LED (N = Field Replaceable Unit).
>>
>> Apart from above two, we do have two more LEDs/Enclosure (external visible LEDs)
>>    - Enclosure Identify
>>    - Enclosure fault
>>        These LEDs reflects state of all Field Replaceable Units (FRU) inside this
>> enclosure
>>         If any of FRU state is ON, this will become ON
>>         Also we can independently enable this LED!!
>>
>>      But from kernel side implementation point of view, I just treat this as
>> another LED.. as our platform code (OPAL firmware) takes care of roll up etc.
>>
>>
>> Now our LED can operate in two mode (Depending on our service model, typically
>> one/two socket servers are Light Path mode, whereas high end servers are Guiding
>> Light Mode).
>>
>>   1.  Guiding Light
>>       Only Identify indicator is support.. Fault is not supported
>>       System attention indicator is used to point there is some problem in system
>> and need attention
>>    2. Light Path mode
>>      Both identify and fault indicator is supported ..
>>      Fault is ON whenever some component is faulty
>>      System attention indicator is used to point that FW/OS is not able to
>> isolate the problem and needs user to look into serviceable event (like syslog/
>> our agents like ESA which analyzes and reports events)
>>
>>
>> Handling LED states :
>>    - Though physically single LED is overloaded for identify and fault, logically
>> (FW/OS level) we treat them as separate LED.
>>    - We can enable both fault and identify simultaneously.
>>    - Hardware decides physical LED state (rule : identify has priority over
>> fault).
>>       ex: Say location code 'X',
>>             Identify = ON, fault = ON ,   state of 'X' = identify (blinking)
>>             Identify = OFF, fault = ON,   state of 'X'  = fault  (solid)
>>             Identify = OFF, fault = ON,   state of 'X'  = identify (blinking)
>>        Identify = OFF, fault = OFF , state of 'X'  = OFF
>>
>> Since we have various above combinations, I thought its best to have separate
>> class dev for each individual LEDs. That way we keep everything simple and let
>> firmware handle all complexities.
>>
>> Hope this clarifies.
>>
>> I just posted v3 where I addressed your comments.
>>     https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-April/127702.html
>>
>> Please let me know if you have any comments/suggestions.

Jacek,

> 
> From what I can see from the driver code the LEDs are set with:
> 
> opal_leds_set_ind(token, loc_code, led_mask, led_value, &max_led_type);
> 
> and their state can be read with:
> 
> opal_leds_get_ind(loc_code, &led_mask, &led_value, &max_led_type)
> 
> From the kernel point of view these are very simple operations.
> 
> All the logic you described should be handled by user space.
> If you need to be able to specify the LED mode you want to set/read,
> then additional 'mode' sysfs attribute should be added by the driver.
> There would have to be also additional sysfs attribute 'available_modes"
> provided. The ABI documentation should inform how the mode identifiers
> map to the modes. I already explained how to add it, when we were
> discussing about retaining led state on remove.

Sorry..My fault.. I should have elaborated mode operation...

I forgot to mention that LED mode is static... meaning platform provides this
information, but we cannot change during runtime..

Presently we have this information in Device Tree. Since this is static one (and
also LED Mode is system wide.. nothing to do individual LED),  I didn't add it
in LED driver code.. .Do you think we should add that property ?

> 
> 
> I'd see following use cases.
> 
> (let's assume that modes are defined as follows:
> 0: ident, 1: attn, 2: fault)

Modes are : Guiding Light / Light Path ... which is static and platform provides
this information.

LED types : IDENT, FAULT and ATTN .... which can be get/set/reset by OS
(kernel/userspace)

Also only 1 LED can be ATTN ...
> 
> #cat available_modes
> #0 1 2
> #echo 0 > mode  //set ident mode
> #echo 1 > brightness //set ident state
> #echo 2 > mode  //set fault mode
> #cat brightness //read fault state
> #0
> #echo 1 > attn //set attn mode
> #echo 1 > brightness
> 
> This would set the LED in blinking mode, so I am wondering if we
> shouldn't employ timer trigger for this to keep the LED API consistent.
> 
> Can a single LED support other mode than 'attention'? I'd like to know
> if a LED in attention mode (blinking), can be set to some solid
> mode?

No.. Its always single attention LED/system ... which can be Set (Solid) / reset
state.

> 
> Please let me know if such an approach would still not fit for your
> requirements.
> 

Given above conditions, I think current approach (my v3 patchset) is simple and
works better. What you say?

-Vasant
