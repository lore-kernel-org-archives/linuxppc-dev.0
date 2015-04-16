Return-Path: <j.anaszewski@samsung.com>
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E885A1A0021
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 18:51:24 +1000 (AEST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NMW004CQ645LV20@mailout2.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Thu, 16 Apr 2015 09:55:18 +0100 (BST)
Message-id: <552F7807.9080605@samsung.com>
Date: Thu, 16 Apr 2015 10:51:19 +0200
From: Jacek Anaszewski <j.anaszewski@samsung.com>
MIME-version: 1.0
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] leds/powernv: Add driver for PowerNV platform
References: <20150320105921.14866.83209.stgit@localhost.localdomain>
 <20150320110328.14866.98225.stgit@localhost.localdomain>
 <552D303A.5080506@samsung.com> <552E049D.2030604@linux.vnet.ibm.com>
 <552E2480.9060102@samsung.com> <552E3A56.8030300@linux.vnet.ibm.com>
 <552E63D2.4070209@samsung.com> <552F5C1A.3060701@linux.vnet.ibm.com>
In-reply-to: <552F5C1A.3060701@linux.vnet.ibm.com>
Content-type: text/plain; charset=UTF-8; format=flowed
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

On 04/16/2015 08:52 AM, Vasant Hegde wrote:
> On 04/15/2015 06:42 PM, Jacek Anaszewski wrote:
>> On 04/15/2015 12:15 PM, Vasant Hegde wrote:
>>> On 04/15/2015 02:12 PM, Jacek Anaszewski wrote:
>>>> Hi Vasant,
>
> Hi Jacek,
>
> .../...
>
>>>>>>
>>>>>
>>>>> I mean, we have to retain the state of LED across system reboot.
>>>>
>>>> Static variables are reinitialized on system reboot, aren't they?
>>>
>>> Sorry. I think comment was confusing..
>>>
>>> As I understood, classdev_unregister call resets all LEDs state. However in our
>>> case, we don't
>>> want to change the LED state during system shutdown/reboot.
>>>
>>> Hence I have introduced state variable here. So during register call, I just
>>> disable LEDs so that any further call will just return. That way we retain LED
>>> state even after unloading module.
>>>
>>> Please let me know if there is any better way to achieve this.
>>
>> Since this is not a feature of the device, but rather a use case, then
>> it cannot be hard coded in the driver this way. The solution I see is
>> introducing a sysfs attribute that would determine if we want the
>> LED to be turned off on unregistration or not.
>
> Hmmm. I thought having simple various is enough ..
>
> I don't know the usage of other LED drivers .. Just a thought .. How about
> enabling this feature in LED class itself ...Something like:
>    - Add new attribute to generic LED class (say persistent)?
>    - If drivers wants to retain LED state across reboot, then enable this option
>    - During unregister call check for this attribute
>
>>
>> You can refer to the following driver to find out how to add the
>> sysfs attribute:
>>
>> drivers/leds/leds-lm3533.c
>>
>> The attribute will also have to be documented, similarly to these:
>>
>> Documentation/ABI/testing/sysfs-class-led-driver-lm3533
>>
>> Currently I don't have a good candidate for attribute
>> name, so feel free to propose one.
>
> If you don't like generic attribute, then shall I introduce "persistent"
> attribute inside my driver. ?
>    - By default this attribute is ON and if user wants he can disable this .
>    - And I will have another variable (say op_support).. which I will disable in
> unload path..
> .../...
>
>>>>
>>>> The label could be composed of segments and an ordinal number as
>>>> labels have to be unique, e.g. attn_ident_0, attn_ident_1.
>>>> The segments would have to be parsed by the driver to discover
>>>> all the LED's available modes.
>>>>
>>>> nitpicking: identify is a verb and is not a proper name for the LED.
>>>> Could you describe the purpose of this mode, so that we could come
>>>> up with a better name?
>>>
>>> Each component (Field Replacement Unit) will have service indicator (LEDS) which
>>> can have below states :
>>>     - OFF     : no action
>>>     - Identify: blinking state (user can use this state to identify particular
>>> component).
>>>          In Power Systems world we call it as "identify" indicator.. Hence I
>>> retained same name here.
>>>          How about just "ident" ?
>>
>> Sounds good.
>>
>>>     - fault : solid state (when component goes bad, LED goes to solid state)
>>>        Note that our FW is capable of isolating some of the issues and it can turn
>>> on LEDs without OS
>>>         interference.
>>
>> Does it mean that the LED can be controlled from hardware?
>> If so, what would be software use cases then? The same question is
>> related to the attn and indent states.
>
> - Identify LEDs:
>    We have service processor interface to set/reset this LEDs.. Similar operation
> can be done from inband interface as well (via user space tools in Linux)..
> Later management layer can make use of this.
>
> - Fault / Attention :
>    FW can SET these LEDs if its capable of isolating problem.
>    Similarly host/user space can SET these LEDs if then can do fine grained
> problem isolation etc.
>    Host/user space can RESET these LEDs.
>
> Hence we are adding host support to all the LEDs which can be modified by host.
>
> Hope this clarifies.

Thanks for this explanation.

I am changing my mind about these LEDs. Since they can be controlled
from hardware without any system interaction, then turning them off
on driver removal makes no sense. The LEDs could be turned on again even
if the driver is unloaded.
Since the driver doesn't perform any initialization of the LEDs,
neither should it turn them off on removal.

If I understand this correctly, then the solution with variable would
do and no sysfs attribute would be required.

-- 
Best Regards,
Jacek Anaszewski
