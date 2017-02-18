Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vQMsR6S6wzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2017 19:06:03 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alan Modra <amodra@gmail.com>
Cc: linuxppc-dev@ozlabs.org, anton@samba.org
Subject: Re: [RFC PATCH] powerpc: Fix dubious r0 usage
In-Reply-To: <20170217132125.GV3731@bubble.grove.modra.org>
References: <1487333333-17221-1-git-send-email-mpe@ellerman.id.au>
 <20170217132125.GV3731@bubble.grove.modra.org>
Date: Sat, 18 Feb 2017 19:06:03 +1100
Message-ID: <87d1efj53o.fsf@concordia.ellerman.id.au>
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

Alan Modra <amodra@gmail.com> writes:

> On Fri, Feb 17, 2017 at 11:08:53PM +1100, Michael Ellerman wrote:
>> Bleeding edge binutils no longer accepts r0 in places where the CPU
>> interprets the value as a literal 0.
>
> Wow!  That was quite some cleanup.  I think I'd better turn the error
> into a warning..

That would be my preference :)

If it remains a hard error we'll need to backport this patch to multiple
stable versions so that people can build those older kernels with new
binutils. Which we can do, but it's a bit of a pain.

>> --- a/arch/powerpc/purgatory/trampoline.S
>> +++ b/arch/powerpc/purgatory/trampoline.S
>> @@ -67,7 +67,7 @@ master:
>>  	mr	%r16,%r3	/* save dt address in reg16 */
>>  	li	%r4,20
>>  	LWZX_BE	%r6,%r3,%r4	/* fetch __be32 version number at byte 20 */
>> -	cmpwi	%r0,%r6,2	/* v2 or later? */
>> +	cmpwi	0,%r6,2		/* v2 or later? */
>>  	blt	1f
>>  	li	%r4,28
>>  	STWX_BE	%r17,%r3,%r4	/* Store my cpu as __be32 at byte 28 */
>
> With this one, it would probably be better to omit the zero (BF
> field).

Yeah good point, thanks for reviewing.

cheers
