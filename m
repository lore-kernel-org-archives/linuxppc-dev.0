Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B068C1A0BDF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 22:34:35 +1000 (AEST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Mon, 20 Apr 2015 18:04:33 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 3EC7BE0067
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 18:07:07 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3KCYAac48234692
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 18:04:11 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3KCB49O024166
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 17:41:04 +0530
Message-ID: <5534F240.3020907@linux.vnet.ibm.com>
Date: Mon, 20 Apr 2015 18:04:08 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH v2 2/2] leds/powernv: Add driver for PowerNV platform
References: <20150320105921.14866.83209.stgit@localhost.localdomain>
 <20150320110328.14866.98225.stgit@localhost.localdomain>
 <552D303A.5080506@samsung.com> <552E049D.2030604@linux.vnet.ibm.com>
 <552E2480.9060102@samsung.com> <552E3A56.8030300@linux.vnet.ibm.com>
 <5534E6D9.6060804@samsung.com>
In-Reply-To: <5534E6D9.6060804@samsung.com>
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

On 04/20/2015 05:15 PM, Jacek Anaszewski wrote:
> Hi Vasant,
> 
> I'd like to clarify some details regarding your explanation.
> 
> On 04/15/2015 12:15 PM, Vasant Hegde wrote:
> [...]
>>>>
>>>> In Power Systems LEDs are overloaded (meaning same LED is used for identify and
>>>> fault depending on their state  ---  blinking = identify and solid = fault).
>>>> Hence here append LED type info.
>>>
>>> The label could be composed of segments and an ordinal number as
>>> labels have to be unique, e.g. attn_ident_0, attn_ident_1.
>>> The segments would have to be parsed by the driver to discover
>>> all the LED's available modes.
>>>
>>> nitpicking: identify is a verb and is not a proper name for the LED.
>>> Could you describe the purpose of this mode, so that we could come
>>> up with a better name?
>>
>> Each component (Field Replacement Unit) will have service indicator (LEDS) which
>> can have below states :
>>    - OFF     : no action
>>    - Identify: blinking state (user can use this state to identify particular
>> component).
>>         In Power Systems world we call it as "identify" indicator.. Hence I
>> retained same name here.
>>         How about just "ident" ?
>>    - fault : solid state (when component goes bad, LED goes to solid state)
>>       Note that our FW is capable of isolating some of the issues and it can turn
>> on LEDs without OS
>>        interference.
>>
>> We have one more System level LED (System Attention Indicator).. This LED has
>> two states:
>>    - OFF : Everything is fine
>>    - ON : Some component has issues and needs attention.
> 
> We have three modes:
> - identify        - blinking
> - fault            - solid
> - attention indicator    - solid
>
> How does LED operation differ for fault and attention modes?
> Does a LED have different intensity?

Jacek,

System Attention LED is special LED and its single LED available/system. where
as identify and fault is applicable to all field replaceable units in the system..

So Typical server will have
   1   System Attention LED
    N  Identify/fault LED (N = Field Replaceable Unit).

Apart from above two, we do have two more LEDs/Enclosure (external visible LEDs)
  - Enclosure Identify
  - Enclosure fault
      These LEDs reflects state of all Field Replaceable Units (FRU) inside this
enclosure
       If any of FRU state is ON, this will become ON
       Also we can independently enable this LED!!

    But from kernel side implementation point of view, I just treat this as
another LED.. as our platform code (OPAL firmware) takes care of roll up etc.


Now our LED can operate in two mode (Depending on our service model, typically
one/two socket servers are Light Path mode, whereas high end servers are Guiding
Light Mode).

 1.  Guiding Light
     Only Identify indicator is support.. Fault is not supported
     System attention indicator is used to point there is some problem in system
and need attention
  2. Light Path mode
    Both identify and fault indicator is supported ..
    Fault is ON whenever some component is faulty
    System attention indicator is used to point that FW/OS is not able to
isolate the problem and needs user to look into serviceable event (like syslog/
our agents like ESA which analyzes and reports events)


Handling LED states :
  - Though physically single LED is overloaded for identify and fault, logically
(FW/OS level) we treat them as separate LED.
  - We can enable both fault and identify simultaneously.
  - Hardware decides physical LED state (rule : identify has priority over fault).
     ex: Say location code 'X',
           Identify = ON, fault = ON ,   state of 'X' = identify (blinking)
           Identify = OFF, fault = ON,   state of 'X'  = fault  (solid)
           Identify = OFF, fault = ON,   state of 'X'  = identify (blinking)
	   Identify = OFF, fault = OFF , state of 'X'  = OFF

Since we have various above combinations, I thought its best to have separate
class dev for each individual LEDs. That way we keep everything simple and let
firmware handle all complexities.

Hope this clarifies.

I just posted v3 where I addressed your comments.
   https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-April/127702.html

Please let me know if you have any comments/suggestions.

-Vasant

> 
> I'd rather avoid creating separate LED class devices for each mode.
> 
> For blinking we could use existing timer trigger.
> 
