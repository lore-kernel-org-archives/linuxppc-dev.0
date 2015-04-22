Return-Path: <j.anaszewski81@gmail.com>
Received: from mail-wg0-x230.google.com (mail-wg0-x230.google.com
 [IPv6:2a00:1450:400c:c00::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 72D6E1A068E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 07:45:19 +1000 (AEST)
Received: by wgyo15 with SMTP id o15so261001927wgy.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 14:45:15 -0700 (PDT)
Date: Wed, 22 Apr 2015 23:45:09 +0200
From: Jacek Anaszewski <j.anaszewski81@gmail.com>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] leds/powernv: Add driver for PowerNV platform
Message-ID: <20150422234509.626d9dc7@ja.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

Hi Vasant,

On 20.04.2015 17:53, Vasant Hegde wrote:
> On 04/20/2015 08:50 PM, Jacek Anaszewski wrote:
>> On 04/20/2015 02:34 PM, Vasant Hegde wrote:
>>> On 04/20/2015 05:15 PM, Jacek Anaszewski wrote:
>>>> Hi Vasant,
>>>>
>>>> I'd like to clarify some details regarding your explanation.
>>>>
>>>> On 04/15/2015 12:15 PM, Vasant Hegde wrote:
>>>> [...]
>>>>>>>
>>>>>>> In Power Systems LEDs are overloaded (meaning same LED is used
>>>>>>> for identify and
>>>>>>> fault depending on their state  ---  blinking = identify and
>>>>>>> solid = fault). Hence here append LED type info.
>>>>>>
>>>>>> The label could be composed of segments and an ordinal number as
>>>>>> labels have to be unique, e.g. attn_ident_0, attn_ident_1.
>>>>>> The segments would have to be parsed by the driver to discover
>>>>>> all the LED's available modes.
>>>>>>
>>>>>> nitpicking: identify is a verb and is not a proper name for the
>>>>>> LED. Could you describe the purpose of this mode, so that we
>>>>>> could come up with a better name?
>>>>>
>>>>> Each component (Field Replacement Unit) will have service
>>>>> indicator (LEDS) which
>>>>> can have below states :
>>>>>      - OFF     : no action
>>>>>      - Identify: blinking state (user can use this state to
>>>>> identify particular component).
>>>>>           In Power Systems world we call it as "identify"
>>>>> indicator.. Hence I retained same name here.
>>>>>           How about just "ident" ?
>>>>>      - fault : solid state (when component goes bad, LED goes to
>>>>> solid state) Note that our FW is capable of isolating some of the
>>>>> issues and it can turn
>>>>> on LEDs without OS
>>>>>          interference.
>>>>>
>>>>> We have one more System level LED (System Attention Indicator)..
>>>>> This LED has two states:
>>>>>      - OFF : Everything is fine
>>>>>      - ON : Some component has issues and needs attention.
>>>>
>>>> We have three modes:
>>>> - identify        - blinking
>>>> - fault            - solid
>>>> - attention indicator    - solid
>>>>
>>>> How does LED operation differ for fault and attention modes?
>>>> Does a LED have different intensity?
>>>
>>> Jacek,
>>>
>>> System Attention LED is special LED and its single LED
>>> available/system. where as identify and fault is applicable to all
>>> field replaceable units in the system..
>>>
>>> So Typical server will have
>>>      1   System Attention LED
>>>       N  Identify/fault LED (N = Field Replaceable Unit).
>>>
>>> Apart from above two, we do have two more LEDs/Enclosure (external
>>> visible LEDs)
>>>     - Enclosure Identify
>>>     - Enclosure fault
>>>         These LEDs reflects state of all Field Replaceable Units
>>> (FRU) inside this enclosure
>>>          If any of FRU state is ON, this will become ON
>>>          Also we can independently enable this LED!!
>>>
>>>       But from kernel side implementation point of view, I just
>>> treat this as another LED.. as our platform code (OPAL firmware)
>>> takes care of roll up etc.
>>>
>>>
>>> Now our LED can operate in two mode (Depending on our service
>>> model, typically one/two socket servers are Light Path mode,
>>> whereas high end servers are Guiding Light Mode).
>>>
>>>    1.  Guiding Light
>>>        Only Identify indicator is support.. Fault is not supported
>>>        System attention indicator is used to point there is some
>>> problem in system and need attention
>>>     2. Light Path mode
>>>       Both identify and fault indicator is supported ..
>>>       Fault is ON whenever some component is faulty
>>>       System attention indicator is used to point that FW/OS is not
>>> able to isolate the problem and needs user to look into serviceable
>>> event (like syslog/ our agents like ESA which analyzes and reports
>>> events)
>>>
>>>
>>> Handling LED states :
>>>     - Though physically single LED is overloaded for identify and
>>> fault, logically (FW/OS level) we treat them as separate LED.
>>>     - We can enable both fault and identify simultaneously.
>>>     - Hardware decides physical LED state (rule : identify has
>>> priority over fault).
>>>        ex: Say location code 'X',
>>>              Identify = ON, fault = ON ,   state of 'X' = identify
>>> (blinking) Identify = OFF, fault = ON,   state of 'X'  = fault
>>> (solid) Identify = OFF, fault = ON,   state of 'X'  = identify
>>> (blinking) Identify = OFF, fault = OFF , state of 'X'  = OFF
>>>
>>> Since we have various above combinations, I thought its best to
>>> have separate class dev for each individual LEDs. That way we keep
>>> everything simple and let firmware handle all complexities.
>>>
>>> Hope this clarifies.
>>>
>>> I just posted v3 where I addressed your comments.
>>>      https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-April/127702.html
>>>
>>> Please let me know if you have any comments/suggestions.
> 
> Jacek,
> 
>>
>>  From what I can see from the driver code the LEDs are set with:
>>
>> opal_leds_set_ind(token, loc_code, led_mask, led_value,
>> &max_led_type);
>>
>> and their state can be read with:
>>
>> opal_leds_get_ind(loc_code, &led_mask, &led_value, &max_led_type)
>>
>>  From the kernel point of view these are very simple operations.
>>
>> All the logic you described should be handled by user space.
>> If you need to be able to specify the LED mode you want to set/read,
>> then additional 'mode' sysfs attribute should be added by the driver.
>> There would have to be also additional sysfs attribute
>> 'available_modes" provided. The ABI documentation should inform how
>> the mode identifiers map to the modes. I already explained how to
>> add it, when we were discussing about retaining led state on remove.
> 
> Sorry..My fault.. I should have elaborated mode operation...

What I was thinking about here was actually LED type, not mode in terms
of Guiding Light/Light Path. However, please look at the newest
approach in the end of this message.

> I forgot to mention that LED mode is static... meaning platform
> provides this information, but we cannot change during runtime..
> 
> Presently we have this information in Device Tree. Since this is
> static one (and also LED Mode is system wide.. nothing to do
> individual LED),  I didn't add it in LED driver code.. .Do you think
> we should add that property ?

The property shouldn't be documented at all if it isn't to be used.

>>
>>
>> I'd see following use cases.
>>
>> (let's assume that modes are defined as follows:
>> 0: ident, 1: attn, 2: fault)
> 
> Modes are : Guiding Light / Light Path ... which is static and
> platform provides this information.
>
> LED types : IDENT, FAULT and ATTN .... which can be get/set/reset by
> OS (kernel/userspace)
>
> Also only 1 LED can be ATTN ...
>
>> #cat available_modes
>> #0 1 2
>> #echo 0 > mode  //set ident mode
>> #echo 1 > brightness //set ident state
>> #echo 2 > mode  //set fault mode
>> #cat brightness //read fault state
>> #0
>> #echo 1 > attn //set attn mode
>> #echo 1 > brightness
>>
>> This would set the LED in blinking mode, so I am wondering if we
>> shouldn't employ timer trigger for this to keep the LED API
>> consistent.
>>
>> Can a single LED support other mode than 'attention'? I'd like to
>> know if a LED in attention mode (blinking), can be set to some solid
>> mode?
> 
> No.. Its always single attention LED/system ... which can be Set
> (Solid) / reset state.

I confused it with ident.

>>
>> Please let me know if such an approach would still not fit for your
>> requirements.
>>
> 
> Given above conditions, I think current approach (my v3 patchset) is
> simple and works better. What you say?

Yes, but we still have naming and blinking issues to solve.

Please look at this draft design of device tree node:

opal-leds {
        compatible = "ibm,opal-v3-led";

        U78C9.001.RST0027-P1-C1:attn {
        };

        U78C9.001.RST0027-P2-C1:identify:fault 
        };

        U78C9.001.RST0027-P3-C2:identify:fault {
        };
    };
};

The LED nodes could be empty as the name would convey all the
required information. The implications would be as follows:

1. Each LED would have one corresponding LED class device.

2. Operations on attn and fault LED types:
	turn on:
		echo 255 > brightness
	turn off:
		echo 0 > brightness
	get status
		cat brightness
	
3. Operations on identify LED:
	turn on:
		echo "timer" > trigger
		(blink_set op would have to be implemented in the
		driver)
	turn off:
		echo 0 > brightness
	get status:
		support for this would have to be added to the LED
		subsystem core

4. Since 'identify' is the platform specific name it could be preserved


Does it work for you?

-- 
Best Regards,
Jacek Anaszewski
