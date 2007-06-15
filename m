Return-Path: <vbuzov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 4384BDDFCD
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 18:42:50 +1000 (EST)
Message-ID: <467250E1.8040507@ru.mvista.com>
Date: Fri, 15 Jun 2007 12:42:09 +0400
From: "Vladislav D. Buzov" <vbuzov@ru.mvista.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH] powerpc: MPC7450 L2 HW cache flush feature utilization
References: <1181729973.25586.31.camel@dolphin.spb.rtsoft.ru>
	<db0d38e5b5e1a9a3a7fe35d25ebd357a@kernel.crashing.org>
	<467176EB.7060404@ru.mvista.com>
	<6c416bf9f79a648fc82f64619aca86de@kernel.crashing.org>
In-Reply-To: <6c416bf9f79a648fc82f64619aca86de@kernel.crashing.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>>> Are these errata 7448-only?  If not, I wonder what is
>>> done on PowerMacs?
>>
>> This is a errata for 7448 only. I've looked through errata for other 
>> 7450 processors (7450, 7457) and they contain the same erratum for L2 
>> cache: "L2 hardware flush may not flush every line from the L2 cache" 
>> The workaround for this problem is: "Set the IONLY and DONLY bits in 
>> the L2CR prior to the L2 hardware flush", and the projected solution 
>> is: "The workaround has been documented in the MPC7450 RISC 
>> Microprocessor Family User’s Manual as the correct way to flush the 
>> L2 cache"
>
> Okay, so it is for all members of the 7450 family.  Good :-)
>
>>> Looks reasonable enough to me...  if it works (on all
>>> things considered "7450" by the kernel).
>>
>> I've double checked this. All processors considered 7450 in the 
>> kernel are covered by MPC7450 RISC Microprocessor Family Reference 
>> Manual where hardware cache flushing procedure is described.
>
> Nice.  Now all that remains to be done is for the patch to
> be tested on actual hardware for at least a few of those
> other CPUs.  Any volunteers?
Unfortunately I have only 7448 on hand :(
>
>>>>      /* TODO: use HW flush assist when available */
>>>
>>> You want to get rid of this old comment though -- and
>>> perhaps branch over the non-hardware-assisted cache
>>> flushing code.
>>
>> Ok, I agree that the comment is obsolete now. Would you please 
>> explain why the branch over non-hardware-assisted code should be 
>> removed as well. Technically the cache is flushed and there is no 
>> need to use extra commands to fill and then re-flush the cache.
>
> I said such a branch should be added, not removed -- it
> appears from your reply that you are skipping it already
> and I just missed it?
I have a branch over a manual cache flushing code in the patch:

+	b	2f
 END_FTR_SECTION_IFSET(CPU_FTR_SPEC7450)

That is a branch to the next step after cache flushing - cache disabling and setting up all the L2CR configuration bits passed to _set_L2CR()

Vlad.


>
>
> Segher
>
