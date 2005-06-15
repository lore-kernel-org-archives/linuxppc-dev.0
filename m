Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 31543679E1
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Jun 2005 14:13:10 +1000 (EST)
In-Reply-To: <42eb0bacadb197b42502ac1828450843@onz.com>
References: <42eb0bacadb197b42502ac1828450843@onz.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a38c1fefe53947c6b80ec3d6b4ffd09e@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 14 Jun 2005 23:13:03 -0500
To: "Allen Curtis" <acurtis@onz.com>
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


On Jun 14, 2005, at 10:57 PM, Allen Curtis wrote:

>> I've also included our version of this patch for commentary. Did you
>> see a
>> need for the following to actually be devices? (DMA, CPM, SI1, SIC2).
>>
> The good thing about them actually being devices is that you can find
> them and the IO resources had already been remapped. You don't need a
> device driver for them but they are resources used by other device
> drivers.

Not sure I follow.  The IO resources are not mapped by anything until 
some piece of code does an explicit ioremap().  How do you plan on 
finding them?  I've got now issue adding them, I just want to 
understand how you see us using them.  A simple code example might be 
helpful.

>> I can provide feedback on all the issues I had with you patch, but
>> would
>> prefer to start with ours (let me know).
>>
> Comments:
> 1. You removed the other PRAM definition from this FCC definition, this
> is good.
>
> 2. I am torn about using numeric IMMR offsets vs. the structure member
> approach. The good thing is that you can create all the devices in a
> single table even if they overlay depending on processor. The question
> is, will the IMMAP structure become obsolete? If not, then you will
> still need the conditional compiles in immap_cpm2.h.

I'm trying to stay away from basing things on the structure.  Since the 
offsets are truly fixed I see not reason to try to make sure that the 
immap structure is always correct for all cases.  Hopefully this will 
end up removing the need to ifdef the immap structure as we go forward.

> 3. Naming convention, are all these devices just in the MPC82xx family?
> If the CPM is a general FSL co-processor, used across many processor
> families, then I like the CPM2 naming convention.

The key there is the driver name not the enum name.  If you look the 
driver name field matches 85xx.  These files might be better of called 
pq2_* instead of mpc82xx_ (8240/1/5 is not handled here) or cpm2_ (85xx 
has cpm2).

> 4. What about PCI?

What about it, none of the busses have specific drivers at this point 
so they haven't been added.

> 5. This patch does not address the platform specific device structures.
> How do you want to handle these?

I want to do that as a second pass every we close on this.  Since the 
platform specific device structs are going to be based on what is 
needed for the drivers.

- kumar
