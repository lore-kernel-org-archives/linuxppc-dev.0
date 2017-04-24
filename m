Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBTHW3sf1zDqH7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 00:29:11 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@ozlabs.org
Cc: bhsharma@redhat.com, keescook@chromium.org,
 kernel-hardening@lists.openwall.com
Subject: Re: [kernel-hardening] Re: [PATCH v2] powerpc/mm: Add support for
 runtime configuration of ASLR limits
In-Reply-To: <1492995750.2418.4.camel@gmail.com>
References: <1492698980-19510-1-git-send-email-mpe@ellerman.id.au>
 <1492995750.2418.4.camel@gmail.com>
Date: Tue, 25 Apr 2017 00:29:07 +1000
Message-ID: <8737cxswuk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

> On Fri, 2017-04-21 at 00:36 +1000, Michael Ellerman wrote:
>> Add powerpc support for mmap_rnd_bits and mmap_rnd_compat_bits, which are two
>> sysctls that allow a user to configure the number of bits of randomness used for
>> ASLR.
...
>
> Could we please suggest that this should not be sent to stable or back-ported
> as the 128T default is new?

I'm not sure I follow. I didn't tag it for stable. Do you mean we should
explicitly mark it as not-for-stable?

If someone sends it to stable@vger I'll be pinged before it goes in and
nak it, if someone wants to backport it (incorrectly) to their own tree
then good luck to them :)

>> diff --git a/arch/powerpc/mm/mmap.c b/arch/powerpc/mm/mmap.c
>> index a5d9ef59debe..6141cfff634e 100644
>> --- a/arch/powerpc/mm/mmap.c
>> +++ b/arch/powerpc/mm/mmap.c
>> @@ -59,13 +59,14 @@ static inline int mmap_is_legacy(void)
>>  
>>  unsigned long arch_mmap_rnd(void)
>>  {
>> -	unsigned long rnd;
>> +	unsigned long shift, rnd;
>>  
>> -	/* 8MB for 32bit, 1GB for 64bit */
>> +	shift = mmap_rnd_bits;
>> +#ifdef CONFIG_COMPAT
>>  	if (is_32bit_task())
>> -		rnd = get_random_long() % (1<<(23-PAGE_SHIFT));
>> -	else
>> -		rnd = get_random_long() % (1UL<<(30-PAGE_SHIFT));
>> +		shift = mmap_rnd_compat_bits;
>> +#endif
>> +	rnd = get_random_long() % (1 << shift);
>
> Nitpick, 1 should be 1UL?

No, shift can only be 29 at most IIRC?

But it's a bit fragile, so I'll change it.

cheers
