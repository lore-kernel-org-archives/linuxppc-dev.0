Return-Path: <paulfax@conspiracy.net>
Received: from ns.seriouslyclued.net (ns.seriouslyclued.net [209.189.226.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "", Issuer "My Company Ltd" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 9EFCDDE0C1
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2009 13:05:21 +1100 (EST)
Message-ID: <497FBD51.8090202@conspiracy.net>
Date: Tue, 27 Jan 2009 20:05:05 -0600
From: paulfax <paulfax@conspiracy.net>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/cpm2 Fix set interrupt type
References: <497EC957.2050205@conspiracy.net>	<07B22E7C-2C6F-43FB-84FB-EE5CC9FCE74A@kernel.crashing.org>	<20090127181414.GA23299@oksana.dev.rtsoft.ru>
	<58058585-0740-4EC1-9E18-7EE5F101D186@kernel.crashing.org>
In-Reply-To: <58058585-0740-4EC1-9E18-7EE5F101D186@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Jan 27, 2009, at 12:14 PM, Anton Vorontsov wrote:
> 
>> On Tue, Jan 27, 2009 at 08:31:16AM -0600, Kumar Gala wrote:
>>>
>>> On Jan 27, 2009, at 2:44 AM, paulfax wrote:
>>>
>>>> This is a simple change to correct problems when using set_irq_type on
>>>> platforms using CPM2.
>>>> This code correct the problem on most platform but still fails on 8272
>>>> derived platforms for some interrupts.
>>>> On 8272 PC2 & 3 are missing and PC 23 & 29 are added, which this patch
>>>> does not address.
>>
>> This is the same as in MPC8555.
> 
> I guess I'm concerned about Paul's comments related to 8272 still
> failing and the patch not addressing PC2/3.
> 
>>>> Signed-off-by: Paul Bilke <paul at conspiracy.net>
>>>> ---
>>>
>>> Anton,
>>>
>>> Is this something you can review
>>
>> Sure. According to MPC8555 and MPC8272 reference manuals,
>> current code indeed has the issue, and the patch correctly
>> fixes it. SIEXR register map looks like this (bits are in
>> big-endian numbering scheme):
>>
>> [0:1] - PC0..PC1
>> [2:13] - PC4..PC15
>> [14:15] - PC23 and PC29
>>
>> Let's look into fixed version, assuming we got src 48 (PC29):
>>
>> edibit = (31 - (CPM2_IRQ_PORTC0 - src));
>> edibit = (31 - (63 - 48)) = 16
>>
>> 1 << 16 points to PC29 (bit 15 in big-endian bit numbering scheme),
>> just as it should be.
>>
>> The same code should work for MPC8560 too (where there are no
>> PC23 & PC29, but PC2 and PC3).
>>
>>> and look into the 8272 issue?
>>
>> I don't actually see any issues wrt 8272. To me, it looks like
>> the fixed code should work fine...
> 
> Paul?
> 
> - k
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
It does actually produce the right bit pattern for the SIUEXR based on the
interrupt being passed in even on the 8272 family as Anton point out.

My concern is that throughout the tree there are defines made based on the code's
8260 lineage that are confusing to anyone trying to discern functionality on
slightly different processor families.  In this case the define for CPM_IRQ_PORTC15 &
CPM_IRQ_PORTC0 are isolated within the cpm2_pic source file instead of a public header
which presents less of a problem.  Of course port c 15's interrupt on the 8272 is 50 not
48 as the define states.  Not sure making the defines generic will make it any clearer, just
force the person to dig deeper to see exactly what is going on.
I am trying to avoid the situation like the one where we don't
have defines in cpm2.h for the 8272's variations in SIUMCR.  We have code that looks like it
changing external cache configuration but its really setting where the burst addresses appear on a 8272.
Don't know the "right" way to make the code obvious, but this patch does fix a long lingering
problem.  My thought is to apply it as is, its better than what is there.

I suspect the the right fix for all the minor variations in the CPM on different
devices will never happen.  I don't want to go ifdef crazy for sure, but in my u-boot tree
I have them around the bits that differ between devices.  This allows me to find errors caused by unknown
routines setting hardware functions that are invalid at compile time.
Can't wait for all the surprises in this area on my next project, an 8568.
Paul
