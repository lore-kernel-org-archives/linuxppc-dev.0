Return-Path: <acurtis@onz.com>
Received: from dell2650.onz.com (onz.com [67.121.61.113])
	by ozlabs.org (Postfix) with ESMTP id D7ED5679E1
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Jun 2005 14:41:07 +1000 (EST)
In-Reply-To: <a38c1fefe53947c6b80ec3d6b4ffd09e@freescale.com>
References: <42eb0bacadb197b42502ac1828450843@onz.com>
	<a38c1fefe53947c6b80ec3d6b4ffd09e@freescale.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c2628642aad8b8107d0e9db84535ea0c@onz.com>
From: Allen Curtis <acurtis@onz.com>
Date: Tue, 14 Jun 2005 21:41:05 -0700
To: Kumar Gala <kumar.gala@freescale.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: RFC: cpm2_devices.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>> I've also included our version of this patch for commentary. Did you
>>> see a
>>> need for the following to actually be devices? (DMA, CPM, SI1, SIC2).
>>>
>> The good thing about them actually being devices is that you can find
>> them and the IO resources had already been remapped. You don't need a
>> device driver for them but they are resources used by other device
>> drivers.
>
> Not sure I follow.  The IO resources are not mapped by anything until 
> some piece of code does an explicit ioremap().  How do you plan on 
> finding them?  I've got now issue adding them, I just want to 
> understand how you see us using them.  A simple code example might be 
> helpful.
>

See below...

>>> I can provide feedback on all the issues I had with you patch, but
>>> would
>>> prefer to start with ours (let me know).
>>>
>> Comments:
>> 1. You removed the other PRAM definition from this FCC definition, 
>> this
>> is good.
>>
>> 2. I am torn about using numeric IMMR offsets vs. the structure member
>> approach. The good thing is that you can create all the devices in a
>> single table even if they overlay depending on processor. The question
>> is, will the IMMAP structure become obsolete? If not, then you will
>> still need the conditional compiles in immap_cpm2.h.
>
> I'm trying to stay away from basing things on the structure.  Since 
> the offsets are truly fixed I see not reason to try to make sure that 
> the immap structure is always correct for all cases.  Hopefully this 
> will end up removing the need to ifdef the immap structure as we go 
> forward.
>

I am not sure I understand the purpose of each access method. How is 
the immap structure used vs. the platform resources list? Going half 
way without a clear distinction of purpose will just confuse the 
matter. (my opinion)

>> 3. Naming convention, are all these devices just in the MPC82xx 
>> family?
>> If the CPM is a general FSL co-processor, used across many processor
>> families, then I like the CPM2 naming convention.
>
> The key there is the driver name not the enum name.  If you look the 
> driver name field matches 85xx.  These files might be better of called 
> pq2_* instead of mpc82xx_ (8240/1/5 is not handled here) or cpm2_ 
> (85xx has cpm2).
>

I used the name CPM2 because that is how all the files are now renamed. 
Based on the #ifdef in your patch, you can see that 82xx and 83xx use 
the same device definitions. Lets change the name.

>> 4. What about PCI?
>
> What about it, none of the busses have specific drivers at this point 
> so they haven't been added.
>
>> 5. This patch does not address the platform specific device 
>> structures.
>> How do you want to handle these?
>
> I want to do that as a second pass every we close on this.  Since the 
> platform specific device structs are going to be based on what is 
> needed for the drivers.
>
That is true but a good example is the FCC definition. You removed one 
IORESOURCE from the sample you provided earlier because it changed 
based on processor. (8260 vs 8272) It would have been beneficial to see 
this in your patch as an example.

-- Allen
