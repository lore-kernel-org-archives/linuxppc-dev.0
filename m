Return-Path: <rusty@ozlabs.org>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 3/9] powerpc: Add TIF_ELF2ABI flag.
In-Reply-To: <20131121115503.GD15913@concordia>
References: <1384946106-18200-1-git-send-email-anton@samba.org>
 <1384946106-18200-4-git-send-email-anton@samba.org>
 <20131121115503.GD15913@concordia>
Date: Sun, 01 Dec 2013 21:00:50 +1030
Message-ID: <874n6s3lt1.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: alistair@popple.id.au, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 Ulrich.Weigand@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:
> On Wed, Nov 20, 2013 at 10:15:00PM +1100, Anton Blanchard wrote:
>> From: Rusty Russell <rusty@rustcorp.com.au>
>> 
>> Little endian ppc64 is getting an exciting new ABI.  This is reflected
>> by the bottom two bits of e_flags in the ELF header:
>> 
>> 	0 == legacy binaries (v1 ABI)
>> 	1 == binaries using the old ABI (compiled with a new toolchain)
>> 	2 == binaries using the new ABI.
>
> Just to be ridiculously clear for stupid people like me, you refer here
> to the "v1 ABI" and "the old ABI" - they are the same thing - right?

Sorry for delay, was off for a week.

Yes, same thing.

>> diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
>> index ba7b197..05a3030 100644
>> --- a/arch/powerpc/include/asm/thread_info.h
>> +++ b/arch/powerpc/include/asm/thread_info.h
>> @@ -107,6 +107,9 @@ static inline struct thread_info *current_thread_info(void)
>>  #define TIF_EMULATE_STACK_STORE	16	/* Is an instruction emulation
>>  						for stack store? */
>>  #define TIF_MEMDIE		17	/* is terminating due to OOM killer */
>> +#if defined(CONFIG_PPC64)
>> +#define TIF_ELF2ABI		18	/* function descriptors must die! */
>> +#endif
>
> This is the first TIF flag we #ifdef for 32 vs 64, is that just because
> we don't want to waste a flag on 32 bit?

No, it's because I wanted to make damn sure that there wasn't anyone
testing this in 32-bit code, since ELF2 is currently a 64-bit only
option.

Cheers,
Rusty.
