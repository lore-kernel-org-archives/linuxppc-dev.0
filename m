Date: Mon, 14 Oct 2002 14:59:53 -0500
Subject: Re: Binary Compatibility of various flavors of PPC
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v546)
Cc: Mark Hatle <fray@mvista.com>,
	Bret Indrelee <Bret.Indrelee@qlogic.com>,
	Linux PPC Embedded mailing list <linuxppc-embedded@lists.linuxppc.org>
To: Matt Porter <porter@cox.net>
From: Kumar Gala <kumar.gala@motorola.com>
In-Reply-To: <20021014111547.A11259@home.com>
Message-Id: <816F7B3D-DFAF-11D6-A599-003065BFB10E@motorola.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Monday, October 14, 2002, at 01:15  PM, Matt Porter wrote:

>
> On Mon, Oct 14, 2002 at 12:13:52PM -0500, Mark Hatle wrote:
>>
>> Bret Indrelee wrote:
>>> We are trying to wade our way through the various processor choices
>>> and
>>> options available for PPC on Linux.
>>>
>>> One of our requirements is to be able to run the same binary image
>>> across
>>> a range of systems. The image can not change just because the
>>> processor
>>> does.
>>>
>>> We are currently looking at the 405GPX, 8250, 8245, and PowerQUIC
>>> III.
>>
>> (I am ONLY speaking of userspace! .. each system will require a
>> custom kernel)
>>
>> The 7xx (as well as 74xx if you avoid altivec) and 82xx are all
>> compatable in
>> userspace.  Those CPU families floating point units, the same cache
>> line size
>> and other commonalities.
>>
>> The 405 does not have an FPU.. If you enable the in kernel floating
>> point
>> emulator it will then be capable of running the same binaries as
>> above.. but do
>> to performance, personal preferance and other reasons I do not
>> recommend running
>> a non FPU machine with FPU emulation unless you need to.
>
> Working 40x libraries have some errata fixups in them IIRC, so running
> a complete classic PPC binary chain would have the possibility of
> exhibiting problems.
>
>> (Since we're on the topic) the PowerPC 403, and 8xx lines are binary
>> compatable
>> with each other.  Similar to the 405 they lack an FPU, but they also
>> use only
>> half the cacheline size of the above CPUs.  This (potentially) makes
>> the libc
>> incompatable, and many optimizations may not work as intended.
>>
>> There is still a question on wether or not the Book E stuff will be
>> user space
>> compatable with the current 7xx style binaries.  I wouldn't hold my
>> breath.. :P
>
> Oh good, another chance to point out that Book E isn't a unifying
> standard.
> The current IBM Book E implementation (PPC440) is binary compatible
> with PPC405.  Since 40x was a bastard hybrid of classic and Book E
> PPC, the 440 looks like a superset as far as userspace instructions.
> The Mot Book E implementation (e500) could be binary compatible
> with classic PPCs (perhaps Kumar will speak up on the direction here)
> except that it doesn't handle FP in a green book manner...well it's
> a more versatile SIMD implementation anyway.   One public mention of
> some pertinent e500 characteristics is here:
> http://gcc.gnu.org/ml/gcc/2002-07/msg01060.html
>
> In theory, one could use kernel FP emulation on e500 when not using
> SIMD instructions and run classic PPC binaries.  In practice, this may
> not be wise.

If one wants to run 82xx/7xx/74xx binaries on an e500 just like on
4xx/8xx, then kernel FP emulation is the way to go.

The e500 does provide the ability to handle simplified single precision
floating point instructions in the GPRs.  These instructions use
distinct opcodes from the classic FP instructions.

>> If I was building a range of systems that required varying PowerPC
>> CPUs with a
>> common userspace I would stick to the 82xx/7xx/74xx families today.
>
> I'd have to agree with that.  Classic PPC core implementations
> currently
> offer the broadest selection of userspace binary compatible processors.

I agree, but it depends on how important floating point is to ones
userspace.  If they do not care about FP then all of the PPC processors
4xx/8xx/82xx/7xx/74xx/e500 all provide a compatible integer instruction
set.

- kumar


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
