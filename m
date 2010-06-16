Return-Path: <wmb@firmworks.com>
Received: from rs35.luxsci.com (rs35.luxsci.com [66.216.127.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C3D5E1007F4
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jun 2010 17:41:15 +1000 (EST)
Message-ID: <4C187FF0.5020806@firmworks.com>
Date: Tue, 15 Jun 2010 21:40:32 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Mike Rapoport <mike@compulab.co.il>
Subject: Re: Request review of device tree documentation
References: <4C13430B.5000907@firmworks.com>	<1276339529.1962.184.camel@pasglop>	<1276339684.1962.186.camel@pasglop>	<4C13B618.1030006@firmworks.com>	<1276383132.1962.195.camel@pasglop>	<AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>	<4C146F18.9030008@firmworks.com>	<AANLkTikls3hjXOmKFqG2D_9GaJSjOXNuuRXPlanAjo5E@mail.gmail.com>	<20100614124438.GF9323@yookeroo>	<alpine.LFD.2.00.1006141044510.13427@xanadu.home>	<20100614160201.GD9550@shareable.org>
	<4C165FD1.6080505@firmworks.com> <4C186AA8.4040709@compulab.co.il>
	<4C186B7B.1060308@firmworks.com> <4C186C72.2020506@compulab.co.il>
	<4C187013.5000400@firmworks.com> <4C18738C.4090809@compulab.co.il>
In-Reply-To: <4C18738C.4090809@compulab.co.il>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Nicolas Pitre <nico@fluxnic.net>, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	Jamie Lokier <jamie@shareable.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Dan Malek <ppc6dev@digitaldans.com>,
	Jeremy Kerr <jeremy.kerr@canonical.com>,
	linux-arm-kernel@lists.infradead.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mike Rapoport wrote:
> Mitch Bradley wrote:
>> Mike Rapoport wrote:
>>> Mitch Bradley wrote:
>>>> Mike Rapoport wrote:
>>>>> Mitch Bradley wrote:
>>>>>
>>>>>> The second topic is the hypothetical use of OFW as a HAL. That 
>>>>>> will not happen for several reasons.  The opposition to the idea 
>>>>>> is widespread and deeply held, and there are good arguments to 
>>>>>> support that opposition.   Furthermore, the economic conditions 
>>>>>> necessary for the creation of such a HAL do not exist in the ARM 
>>>>>> world, nor indeed in the Linux world in general.  (The necessary 
>>>>>> condition is the ability for one company to impose a substantial 
>>>>>> change by fiat - essentially a monopoly position.)
>>>>>>
>>>>>> Shall we agree, then, that any further discussion of the HAL 
>>>>>> issue is "just for fun", and that nobody needs to feel threatened 
>>>>>> that it would actually happen?
>>>>>
>>>>> I've recently worked with vendor versions of U-Boot for advanced 
>>>>> ARM SoCs. There is already *huge* chunk of HAL code in those 
>>>>> versions. And if there would be possibility to have callbacks into 
>>>>> the firmware these chunks would only grow, IMHO.
>>>>
>>>> How can there be HAL code in U-Boot unless there is already the 
>>>> possibility to have callbacks into the firmware?
>>>
>>> Currently it aims to abstract hardware from U-Boot and reuse the 
>>> same HW access code across operating systems and bootloaders. If 
>>> this code would have callbacks I afraid the things would became worse.
>>
>> The only way I can understand what you said is if I assume that by 
>> "callback", you mean the following sequence:
>>
>> a) U-boot loads and executes the OS, providing to the OS the address 
>> of some HW access routines that it can use
>> b) The OS calls one of those HW access routines
>> c) During the execution of that HW access routine, that routine calls 
>> "back" into the OS, before returning.  So a call into the OS is 
>> nested inside a call into U-boot resident code.
>>
>> If that is what you are worried about, it is not what we were 
>> discussing.  We were discussing - and many people were against - step 
>> (b).
>>
>> Are you saying that step (b) - the OS calling into routines provided 
>> by U-Boot - is already the status quo?
>
> I'm also objecting the step (b) and, fortunately, it's not yet the 
> status quo.
> Current U-Boot/kernel implementations I've encountered still do not 
> have OS calls to resident HW access routines. But if such calls would 
> be allowed, my impression is that SoC vendors would make extensive use 
> of them.

One could argue that a feature that vendors would use extensively is one 
that is sorely needed from their point of view.

One counterargument, of course, is that "there is a better way".  But it 
is only "better" under a cost function that values things differently 
than the vendors value them.  Were that not so, the vendors would gladly 
use the "better" way and not be tempted to use the objectionable 
feature. (Unless, of course, the vendors are just ignorant or unskilled 
- but I generally find that different cost functions cause more 
disconnects than lack of ability.)

Which of course raises the question:  How does the Linux community view 
such SoC vendors?  Are they embraced and eagerly supported, or (either 
openly or secretly) viewed as a nuisance?  How does the widespread 
objection to something that such vendors "would make extensive use of" 
mesh with that view?

>
>>>
>>>> It is not HAL if it can't be called.
>>>>
>>>>>
>>>>>
>>>>>> The potential for "vendors breaking out of the debugging use case 
>>>>>> and turning it into a HAL" is miniscule, because
>>>>>>
>>>>>> a) The callback is disabled by default
>>>>>> b) The technical challenges of the callback interface limit its 
>>>>>> applicability to specific "wizard user" scenarios
>>>>>> c) OFW is unlikely to achieve sufficient market penetration for 
>>>>>> the HAL thing to be worth doing
>>>>>>
>>>>>>
>>>>>> _______________________________________________
>>>>>> linux-arm-kernel mailing list
>>>>>> linux-arm-kernel@lists.infradead.org
>>>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>>>
>>>>>
>>>
>>>
>
>
