Return-Path: <SRS0=Sd9m=2D=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04E1C43603
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Dec 2019 21:08:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C350024671
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Dec 2019 21:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="k23J/zLd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C350024671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47ZNZH20WqzDqwP
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Dec 2019 08:08:55 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47ZNWx4XZJzDr6d
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Dec 2019 08:06:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.b="k23J/zLd"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 47ZNWw2BJjz9sP6;
 Sat, 14 Dec 2019 08:06:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1576271213;
 bh=MGInI7+F0s7HGbUV0Xqx0TPozxlo/Am/To6UDohXxq4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=k23J/zLdvtKqBunmy1ixSs+42bGbHDuGSQCB6Ke7L4Uq+z+ldveUzevFgLwdpKq0d
 mkr6DDnR7H0smvCQcN+BM6T37JbnmqHD4/L9a/NkSKrjRcYPT2yHYyhdPyiEXPyrMB
 Efjh7qR7zHjSZA5mgVn0XUYlFLdEhavQXa026DnFJi45/5Ez7taLlBYjyOaBMxyE/b
 7GJ80E1SaCmTKU2aBFLDMNx1yGZX4v2RQz2d9xbDgYEA2gziROONKrvnz6W/pFOCgL
 jX4iWoccqf6+gYa3ICv0po4aLuXfa8qENKOix+W7EG9numuE+zbXEzjMmrCD9q6b2x
 GpuH9UJg8ssSA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
In-Reply-To: <20191213135353.GN3152@gate.crashing.org>
References: <87blslei5o.fsf@mpe.ellerman.id.au>
 <20191206131650.GM2827@hirez.programming.kicks-ass.net>
 <875zimp0ay.fsf@mpe.ellerman.id.au>
 <20191212080105.GV2844@hirez.programming.kicks-ass.net>
 <20191212100756.GA11317@willie-the-truck>
 <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <87pngso2ck.fsf@mpe.ellerman.id.au> <20191213135353.GN3152@gate.crashing.org>
Date: Sat, 14 Dec 2019 08:06:49 +1100
Message-ID: <87mubwndee.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Segher Boessenkool <segher@kernel.crashing.org> writes:
> Hi!
>
> On Fri, Dec 13, 2019 at 11:07:55PM +1100, Michael Ellerman wrote:
>> I tried this:
>> 
>> > @@ -295,6 +296,23 @@ void __write_once_size(volatile void *p, void *res, int size)
>> >   */
>> >  #define READ_ONCE_NOCHECK(x) __READ_ONCE(x, 0)
>> >  
>> > +#else /* GCC_VERSION < 40800 */
>> > +
>> > +#define READ_ONCE_NOCHECK(x)						\
>> > +({									\
>> > +	typeof(x) __x = *(volatile typeof(x))&(x);			\
>> 
>> Didn't compile, needed:
>> 
>> 	typeof(x) __x = *(volatile typeof(&x))&(x);			\
>> 
>> 
>> > +	smp_read_barrier_depends();					\
>> > +	__x;
>> > +})
>> 
>> 
>> And that works for me. No extra stack check stuff.
>> 
>> I guess the question is does that version of READ_ONCE() implement the
>> read once semantics. Do we have a good way to test that?
>> 
>> The only differences are because of the early return in the generic
>> test_and_set_bit_lock():
>
> No, there is another difference:
>
>>   30         ld      r10,560(r9)
>>   31         std     r10,104(r1)
>>   32         ld      r10,104(r1)
>>   33         andi.   r10,r10,1
>>   34         bne     <ext4_resize_begin_generic+0xd0>       29         bne     <ext4_resize_begin_ppc+0xd0>
>
> The stack var is volatile, so it is read back immediately after writing
> it, here.  This is a bad idea for performance, in general.

Argh, yuck. Thanks, I shouldn't try to read asm listings at 11pm.

So that just confirms what Will was saying further up the thread about
the volatile pointer, rather than READ_ONCE() per se.

cheers
