Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 601D41A0D66
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2015 15:31:36 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Fri, 24 Apr 2015 15:31:34 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7C4213578047
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2015 15:31:33 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3O5VPlm16253074
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2015 15:31:33 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3O5Uxcq011515
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2015 15:30:59 +1000
Message-ID: <5539D501.3040601@linux.vnet.ibm.com>
Date: Fri, 24 Apr 2015 11:00:41 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Jacek Anaszewski <j.anaszewski81@gmail.com>
Subject: Re: [PATCH v2 2/2] leds/powernv: Add driver for PowerNV platform
References: <20150422234509.626d9dc7@ja.home>
 <55388254.4000606@linux.vnet.ibm.com> <20150423161342.55e9ac8f@ja.home>
In-Reply-To: <20150423161342.55e9ac8f@ja.home>
Content-Type: text/plain; charset=windows-1252
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

On 04/23/2015 07:43 PM, Jacek Anaszewski wrote:
> On Thu, 23 Apr 2015 10:55:40 +0530
> Vasant Hegde <hegdevasant@linux.vnet.ibm.com> wrote:
> 

Hi Jacek,

.../...

>>
>> These device tree comes from out firmware ... which is immutable .
> 
> How the firmware is related to kernel? These bindings are for kernel,
> not for the firmware.
> 
> DT bindings are compiled to *.dtb file which is concatenated with
> zImage. During system boot device drivers are matched with DT bindings
> through 'compatible' property. A driver should have single matching DT
> node, i.e. no other driver can probe with the same DT node.
> This implies that the node should contain only the properties required
> for configuring the related device.
> 

As Stewart mentioned, its not .dtb file in our case.. we pass flattened device
tree .. which is built by OPAL.

>> We can use LED node name + led-type property for naming...which is
>> what I do currently (v4.. which I haven't posted)
>>
>>
>>> 1. Each LED would have one corresponding LED class device.
>>>
>>> 2. Operations on attn and fault LED types:
>>> 	turn on:
>>> 		echo 255 > brightness
>>> 	turn off:
>>> 		echo 0 > brightness
>>> 	get status
>>> 		cat brightness
>>> 	
>>> 3. Operations on identify LED:
>>> 	turn on:
>>> 		echo "timer" > trigger
>>> 		(blink_set op would have to be implemented in the
>>> 		driver)
>>> 	turn off:
>>> 		echo 0 > brightness
>>> 	get status:
>>> 		support for this would have to be added to the LED
>>> 		subsystem core
>>
>> I see few issues here.
>>   - Overloading same LED device with multiple opeartion complicates
>> things .. as these operations can be done independently (say user is
>> allowed to enable both identify and fault simultaneously)
> 
> I agree, it would be hard to distinguish whether by executing
> `echo 0 > brightness` we want to turn off identify or fault function.
> 
>>   - point 3: IIUC after duration value expires identify indicator
>> reverts.. we don't want to revert until user asks .
> 
> From what you shared, blinking has hardware acceleration on OPAL side.
> At first timer trigger tries to use HW accelerated blinking by
> calling blink_set op and resorts to using software fallback only if
> the op fails or is not defined.

Blinking is the physical state of LED to represent "identify" state. which is
taken care by hardware. and OS doesn't have control on this ..

>From software point of view its just another LED with two state (ON and OFF).

> 
> BTW timer trigger re-sets blink after timer expires, unless
> LED_BLINK_ONESHOT flag is set by LED class device.

In my case, I want to retain the state.'

> 
>>   - point 3: if I use brightness for both identify/fault, how to
>> disable these LEDs independently?
> 
> Another sysfs attribute would be required, but it would be ugly.

yeah.


>>   - Also how to use trigger property for each LED (if at all we want
>> to use them later)?
>>
> 
> After analyzing pros and cons I think that separate LED class devices
> for each LED type would be most suitable solution in this case.

Agree.

> 
> For 'identify' LED the operation would be:
> 
> #echo "timer" > trigger		//set 'identify' (blinking)
> #cat trigger			//check "identify" state
> #none [timer]			//'identify' is ON
> #echo 0 > brightness		//unset 'identify
> #cat trigger
> #[none] timer			//'identify' is OFF
> 
> You would have to implement blink_set op
> (see Documentation/leds/leds-class.txt and other LED class drivers for
> reference).

Implementing another op should be fine.. I can try to implement it.

But from user perspective identify is just another LED. Hence can we just use
"brightness" property itself?


> 
> For attention and fault LEDs only brightness attribute would matter.
> 

Sure.

> DT bindings would look as follows:
> 
> opal-leds {
>         compatible = "ibm,opal-leds";
> 
>         U78C9.001.RST0027-P1-C1:fault {
>         };
> 
>         U78C9.001.RST0027-P1-C1:indent {
>         };
> 
>         U78C9.001.RST0027-P2-C1:attn
>         };
>     }
> }
> 

As mentioned earlier DT is coming from our firmware. For now I will respin
another round of patches by using led-types property and run it through DT
experts (DT mailing list). If they insist this method is better than what I
already have , then will work with my firmware folks to see what we can do better.

Thanks
Vasant
