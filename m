Return-Path: <linuxppc-dev+bounces-27178-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C43C88E59
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Sep 2026 17:35:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhz8d6vZ0z2yDr;
	Sun, 13 Sep 2026 03:35:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789234545;
	cv=none; b=LIVa+Pa2IAwZw3IoRPnWPoNneJo9Mll0qBSE6CxY/b+dm+Xlxjqnnidseee4IGdmh+9hAe9JEASRK6TjlY4lNhkZPd2ahydxLCBu2zI07iYtDRRT4affHLjbVNWTIXSEEz+Tl870VS8dfNXaxsC00/lx6MlEqb4zBuedFaw6nwVY56/725Rg5K05HO5D/J1+fDcJMQ2FhYN/AGnQHISuZEifkEzcceVK4oT9bVPseRjDhWbQan/iozg/By6QzrzdOiXmne/7MjgltXoEeoW2KsDIKIZ8r3k4YTS+anpkD/itbUnyxhivBf1GUR6EezeKqpnwJDVJB69yAv7lluCayA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789234545; c=relaxed/relaxed;
	bh=FEe2Rz/fJk3PRB8Q54ex0lMJG3zWYPZcQ6tk6AJ+7bM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HUnZJQwIs3u1oj+4AGPj0lpKgkrvzfLlqrvIQCXkNMbrNEhT2yuKBwJ/XuJOljOmXdSIo/wtYvCYfgDpRiJfvhZsSGutW6sqZBlAZAhUAhQ24pYQo1fTFo5goTmDntIrS4zM15/xUusL3NMY6EA2i0XA5JdWZIOjfHlp61pxOZLC9QW4qnztgq0jfyItFxlOjdGKMqB4bmuRpCqdTCvfcl15oCYolgslCTAvZOj9CRMVEvyXEJXiO8PxCzKnrZrjCrQWKp8pvvhCnSfTNX1IwjinTcCPLHJ24x9JcBFAODcCEQSQ9wWDyd7fN/p8BwckA2LtWtRr1/ibRxzJlM6ZpA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZnOqyl6v; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZnOqyl6v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhz8c62MQz2xqM
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Sep 2026 03:35:44 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3A5DC43577;
	Sat, 12 Sep 2026 17:35:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62881F000FF;
	Sat, 12 Sep 2026 17:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789234542;
	bh=FEe2Rz/fJk3PRB8Q54ex0lMJG3zWYPZcQ6tk6AJ+7bM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZnOqyl6v9PbbDHzpeQJgveszxX+jf5S3lSl4fMfQ4GjvBrx4cJuFGj+sWIOoWuEPr
	 fn4KU2Tgfa4EbJ5rfAPuwcFZy2b2kbA0GrJyVRgCp1QkusaINVsMg6kHErg5XT0sR1
	 9xKSCUyr099vOGbZGSg0TRO/oKJctUIHx70GYg4bLfhh114E4UGedrqfOD9phAMOk8
	 /AuO8o+L27Jpex/YN3LQ38a+bI7Mg35se0vL5D1LHbEJcz/mWObblcJ9mxX9vbBZqB
	 f64Jr7q2qjcUE8udHCH7EADU5/TSqzhwKnK4rKnc+ahgFBKTXn6ivAsOZp4kzsyJ8G
	 oN6kJadLFLLSw==
Message-ID: <2dedc7a9-95f5-4a7f-8d38-6b9351db402f@kernel.org>
Date: Sat, 12 Sep 2026 19:35:32 +0200
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/kasan: require memintrinsic prefix support for
 KASAN
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
 dvyukov@google.com, vincenzo.frascino@arm.com, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, kees@kernel.org,
 amachhiw@linux.ibm.com, ritesh.list@gmail.com, robh@kernel.org,
 sayalip@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
 linux-riscv@lists.infradead.org, linux-hardening@vger.kernel.org,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>
References: <20260908064948.999530-1-mkchauras@gmail.com>
 <b3b1fa5a-c836-447f-a658-ad66183c23c5@kernel.org>
 <aqOrCdvUB5lFjNsS@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <aqOrCdvUB5lFjNsS@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Mukesh,

Le 11/09/2026 à 19:39, Mukesh Kumar Chaurasiya a écrit :
> 
> [...]
>>> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
>>> index 6f6801da9dc1..44115f904c2c 100644
>>> --- a/arch/powerpc/kernel/cputable.c
>>> +++ b/arch/powerpc/kernel/cputable.c
>>> @@ -36,8 +36,8 @@ void __init set_cur_cpu_spec(struct cpu_spec *s)
>>>    	t = PTRRELOC(t);
>>>    	/*
>>> -	 * use memcpy() instead of *t = *s so that GCC replaces it
>>> -	 * by __memcpy() when KASAN is active
>>> +	 * use memcpy() instead of *t = *s so that the compiler replaces it
>>> +	 * by __asan_memcpy() when KASAN is active
>>>    	 */
>>
>> Does the initial problem still exist with the new __asan_memcpy() approach ?
>> If not the comment should be removed.
>>
> Hey Christophe,
> 
> Thanks for pointing it out, i took a deeper look into this, here's my
> understanding on it.
> 
> On PowerPC during very early boot the kernel is loaded by the
> bootloader/firmware at some physical address, but the kernel was linked
> expecting it to run at KERNELBASE(virtual address like
> 0xc000000000000000). The MMU mapping that makes that virtual address
> valid hasn't been set up yet. So far for a window of early boot, code is
> executing at the physical load address while all symbol addresses in the
> binary refer to the virtual linked address. reloc_offset() computes the
> gap between these two and PTRRELOC applies it to any pointer.
> 
> So PTRRELOC(&the_cpu_spec) gives the physical address where the struct
> actually lives in memory right now, not where the linker thinks it lives.
> 
> Why *t = *s would be wrong?
> 
> In set_cur_cpu_spec:
> 
> struct cpu_spec *t = &the_cpu_spec;  // linked (virtual) address
> t = PTRRELOC(t);                     // physical address — where it actually is
> memcpy(t, s, sizeof(*t));            // copy into the right place
> 
> If you wrote *t = *s instead, the compiler generates a struct assignment.
> For a large struct like cpu_spec, GCC is free to implement that however
> it likes — including emitting a call to memcpy(). But crucially, a
> compiler-generated memcpy call resolves through the GOT/PLT or direct
> symbol — which points to the linked virtual address of memcpy, not the
> physical address. At this point in boot, calling through the wrong
> address would jump to garbage or an unmapped page.
> 
> memcpy(t, s, sizeof(*t)) written explicitly is different: t is already
> the corrected physical address, s points into the cpu_specs table which
> has also been PTRRELOC'd. The explicit call goes through the normal
> early-boot call mechanism which is safe.
> 
> The original comment said:
> 
> "use memcpy() instead of *t = *s so that GCC replaces it by __memcpy()
> when KASAN is active"
> 
> This was added because under the old KASAN scheme
> (!CC_HAS_KASAN_MEMINTRINSIC_PREFIX), KASAN overrode the memset/memcpy
> linker symbols globally with C wrappers that called kasan_check_range().
> If the compiler turned *t = *s into an implicit memcpy(), that would hit
> the KASAN wrapper — calling kasan_check_range() at a point in early boot
> where the KASAN shadow isn't mapped yet, causing a crash.
> 
> Writing memcpy(t, s, sizeof(*t)) explicitly made GCC emit __memcpy()
> (the raw assembly alias exposed by _GLOBAL_KASAN) instead of the
> KASAN-wrapped memcpy(), bypassing the shadow check.
> 
> That was the secondary reason. The primary reason that t is a
> PTRRELOC-adjusted physical pointer and the copy must go through it
> correctly was never stated.
> 
> So the KASAN comment is not required but i think we still need to state
> why memcpy is required. For PTRRELOC adjustment, comment should reflect
> that.
> 
> I'll update the comment and commit message and send out a new version.

Explanation based on kernel v5.10

The problem was not linked to PTRRELOC, the t = PTRRELOC(t) followed by 
*t = *s works well in term of adressing, regardless of whether 
CONFIG_KASAN is enabled or not.

The problem is that with *t = *s, gcc emits a call to memcpy(). When 
CONFIG_KASAN is enabled, memcpy() is instrumented. But we don't want 
cputable.o instrumented as we have KASAN_SANITIZE_cputable.o := n in 
Makefile.

In asm/string.h we have:

#if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
/*
  * For files that are not instrumented (e.g. mm/slub.c) we
  * should use not instrumented version of mem* functions.
  */
#define memcpy(dst, src, len) __memcpy(dst, src, len)
#define memmove(dst, src, len) __memmove(dst, src, len)
#define memset(s, c, n) __memset(s, c, n)

Because in non-instrumented files like cputable.o we want memcpy() to be 
replaced at buildtime by __memcpy() to skip KASAN instrumentation. But 
this is resolved by pre-processing, and pre-processor doesn't know that 
the compiler will emit a call to memcpy().

By replacing *t = *s by the memcpy(), the pre-processor replaces 
memcpy() by __memcpy() when CONFIG_KASAN is enabled.

See the difference:

This is v5.10

00000000 <set_cur_cpu_spec>:
    0:	94 21 ff e0 	stwu    r1,-32(r1)
    4:	7c 69 1b 78 	mr      r9,r3
    8:	bf c1 00 18 	stmw    r30,24(r1)
    c:	3f e0 00 00 	lis     r31,0
			e: R_PPC_ADDR16_HA	.data..read_mostly
   10:	3b ff 00 00 	addi    r31,r31,0
			12: R_PPC_ADDR16_LO	.data..read_mostly
   14:	7c 08 02 a6 	mflr    r0
   18:	7d 3e 4b 78 	mr      r30,r9
   1c:	7f e3 fb 78 	mr      r3,r31
   20:	90 01 00 24 	stw     r0,36(r1)
   24:	48 00 00 01 	bl      24 <set_cur_cpu_spec+0x24>
			24: R_PPC_REL24	add_reloc_offset
   28:	7f c4 f3 78 	mr      r4,r30
   2c:	38 a0 00 58 	li      r5,88
   30:	48 00 00 01 	bl      30 <set_cur_cpu_spec+0x30>
			30: R_PPC_REL24	__memcpy
   34:	38 7f 00 58 	addi    r3,r31,88
   38:	48 00 00 01 	bl      38 <set_cur_cpu_spec+0x38>
			38: R_PPC_REL24	add_reloc_offset
   3c:	93 e3 00 00 	stw     r31,0(r3)
   40:	80 01 00 24 	lwz     r0,36(r1)
   44:	83 c1 00 18 	lwz     r30,24(r1)
   48:	83 e1 00 1c 	lwz     r31,28(r1)
   4c:	7c 08 03 a6 	mtlr    r0
   50:	38 21 00 20 	addi    r1,r1,32
   54:	4e 80 00 20 	blr

This is v5.10 with commit adcf59187e270 reverted:

00000000 <set_cur_cpu_spec>:
    0:	94 21 ff e0 	stwu    r1,-32(r1)
    4:	7c 69 1b 78 	mr      r9,r3
    8:	bf c1 00 18 	stmw    r30,24(r1)
    c:	3f e0 00 00 	lis     r31,0
			e: R_PPC_ADDR16_HA	.data..read_mostly
   10:	3b ff 00 00 	addi    r31,r31,0
			12: R_PPC_ADDR16_LO	.data..read_mostly
   14:	7c 08 02 a6 	mflr    r0
   18:	7d 3e 4b 78 	mr      r30,r9
   1c:	7f e3 fb 78 	mr      r3,r31
   20:	90 01 00 24 	stw     r0,36(r1)
   24:	48 00 00 01 	bl      24 <set_cur_cpu_spec+0x24>
			24: R_PPC_REL24	add_reloc_offset
   28:	7f c4 f3 78 	mr      r4,r30
   2c:	38 a0 00 58 	li      r5,88
   30:	48 00 00 01 	bl      30 <set_cur_cpu_spec+0x30>
			30: R_PPC_REL24	memcpy
   34:	38 7f 00 58 	addi    r3,r31,88
   38:	48 00 00 01 	bl      38 <set_cur_cpu_spec+0x38>
			38: R_PPC_REL24	add_reloc_offset
   3c:	93 e3 00 00 	stw     r31,0(r3)
   40:	80 01 00 24 	lwz     r0,36(r1)
   44:	83 c1 00 18 	lwz     r30,24(r1)
   48:	83 e1 00 1c 	lwz     r31,28(r1)
   4c:	7c 08 03 a6 	mtlr    r0
   50:	38 21 00 20 	addi    r1,r1,32
   54:	4e 80 00 20 	blr

So my question is ? Do we still have this issue nowadays ?

Christophe

