Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A1B2CDDE3F
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 05:07:13 +1000 (EST)
In-Reply-To: <46464F84-5040-4F37-B854-94378C9802AD@kernel.crashing.org>
References: <E1IAnwC-0003Xm-6U@jdl.com>
	<630B6BC9-389F-4F5C-AE8F-9C3131C4543E@kernel.crashing.org>
	<E1IAvVm-0005yQ-LO@jdl.com>
	<46464F84-5040-4F37-B854-94378C9802AD@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2A35E795-6F01-4A14-BE23-B46F110DBD60@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add StorCenter DTS first draft. 
Date: Wed, 18 Jul 2007 13:27:52 -0500
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 18, 2007, at 11:19 AM, Segher Boessenkool wrote:

>>>> +	compatible = "storcenter";
>>>
>>> Needs a manufacturer name in there.
>>
>> Right.  Will use:
>> 	compatible = "iomega,storcenter"
>
> Okido.
>
>>>> +		PowerPC,603e {			/* Really 8241 */
>>>
>>> So say "PowerPC,8241@0", or "PowerPC,e300@0" (or whatever
>>> the CPU core in there is), or simply "cpu@0", following
>>> the generic naming recommended practice.
>>
>> Well, its the 8241 SoC with a 603e core...  (This is
>> the same phrase currently being used on the Kurobox.)
>> I'll use:
>>
>> 	PowerPC,8241@0 }
>
> That might be best yes.
>
>>>> +	soc10x {
>>>
>>> Bad name.  Where is the binding for this?  I don't think
>>> I saw it before.
>>
>> It's what is being used, again, by the Kurobox.  I understand
>> that doesn't make it "right", just precedented by now.
>
> Sure, just trying to trick you into documenting it ;-)
>
>> How about "soc8241@80000000" instead?
>
> soc@ like suggested by Scott seems just fine.
>
>>>> +			compatible = "fsl-i2c";
>>>
>>> Needs to be more specific.
>>
>> Hmmm...  Not sure what to use here then.  There are many
>> existing examples using "fsl-i2c" already.  Granted, we've
>> established that they could be wrong...  Should this be
>> more like this?:
>>
>>     compatible = "fsl,mpc8241-i2c", "fsl-i2c";
>
> That looks good yes.  Or if the kernel side code for
> recognising fsl,mpc8241-i2c gets merged in time, you
> can leave out fsl-i2c from your device tree completely.

Hmm, there are really only two fsl,i2c controllers.  The one we call  
fsl-i2c, and the cpm-i2c controller.

So I'd prefer we don't use fsl,mpc8241-i2c.  I'd suggest fsl,ppc-i2c  
or something like that.

- k
