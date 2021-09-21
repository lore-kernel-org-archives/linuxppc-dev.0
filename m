Return-Path: <SRS0=NHc8=OL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6580BC433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Sep 2021 15:16:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 095D260F6D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Sep 2021 15:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 095D260F6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HDQ404hsWz308v
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Sep 2021 01:16:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HDQ3X5sSTz2xWc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Sep 2021 01:15:36 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4HDQ3T2Bvzz9sTJ;
 Tue, 21 Sep 2021 17:15:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SGxHaHHzvTVd; Tue, 21 Sep 2021 17:15:33 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4HDQ3Q5y23z9sSt;
 Tue, 21 Sep 2021 17:15:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B8DD48B765;
 Tue, 21 Sep 2021 17:15:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id GLz8YS2uY4_Y; Tue, 21 Sep 2021 17:15:30 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.127])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 29C6D8B763;
 Tue, 21 Sep 2021 17:15:30 +0200 (CEST)
Subject: Re: [PATCH v4 1/3] powerpc/bitops: Use immediate operand when possible
To: Segher Boessenkool <segher@kernel.crashing.org>
References: <db9d01d5c543c5add4b2beadb03d39e99c7ada2c.1632126669.git.christophe.leroy@csgroup.eu>
 <20210920212303.GZ1583@gate.crashing.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <917987b7-48fd-d2f6-cbe4-7f7442cf86de@csgroup.eu>
Date: Tue, 21 Sep 2021 17:15:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210920212303.GZ1583@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 20/09/2021 à 23:23, Segher Boessenkool a écrit :
> Hi!
> 
> On Mon, Sep 20, 2021 at 10:31:17AM +0200, Christophe Leroy wrote:
>> Today we get the following code generation for bitops like
>> set or clear bit:
>>
>> 	c0009fe0:	39 40 08 00 	li      r10,2048
>> 	c0009fe4:	7c e0 40 28 	lwarx   r7,0,r8
>> 	c0009fe8:	7c e7 53 78 	or      r7,r7,r10
>> 	c0009fec:	7c e0 41 2d 	stwcx.  r7,0,r8
>>
>> 	c000d568:	39 00 18 00 	li      r8,6144
>> 	c000d56c:	7c c0 38 28 	lwarx   r6,0,r7
>> 	c000d570:	7c c6 40 78 	andc    r6,r6,r8
>> 	c000d574:	7c c0 39 2d 	stwcx.  r6,0,r7
>>
>> Most set bits are constant on lower 16 bits, so it can easily
>> be replaced by the "immediate" version of the operation. Allow
>> GCC to choose between the normal or immediate form.
> 
> You can also handle the second sixteen bits (the "shifted" half), by
> using oris etc.  The "%eN" output modifier prints an "s" for this:
>    /* If the low 16 bits are 0, but some other bit is set, write 's'.  */
> But this doesn't handle non-constant arguments, so you're likely better
> off using what you have noe.
> 
>> For clear bits, on 32 bits 'rlwinm' can be used instead of 'andc' for
>> when all bits to be cleared are consecutive.
> 
> Or when all you want to keep are consecutive (you do handle that now :-) )
> 
>> On 64 bits we don't have any equivalent single operation for clearing,
>> single bits or a few bits, we'd need two 'rldicl' so it is not
>> worth it, the li/andc sequence is doing the same.
> 
> You can use rlwinm whenever you want to clear all top 32 bits.
> 
> A sometimes nice idiom is  ori x,x,N ; xori x,x,N  to clear the bits N
> (or oris/xoris).  But it's two insns no matter what (but no spare
> register is needed).

Could be a candidate for a follow-up change if someone want to focus on 
PPC64.

> 
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
>> +static inline unsigned long test_and_clear_bits(unsigned long mask, volatile unsigned long *_p)
>> +{
>> +	unsigned long old, t;
>> +	unsigned long *p = (unsigned long *)_p;
>> +
>> +	if (IS_ENABLED(CONFIG_PPC32) &&
>> +	    __builtin_constant_p(mask) && is_rlwinm_mask_valid(mask)) {
> 
> is_rlwinm_mask_valid(~mask)?  So that test_and_clear_bits(0, ...) will
> work with rlwinm, and test_and_clear_bits(0xffffffff, ...) will not make
> gas scream bloody murder ("illegal bitmask").  Tha mask you pass to the
> instruction is ~mask after all.

Ok, fixed in v5.

> 
> Looks great except that one nit.  Thanks :-)
> 
> Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>

Thanks

Christophe
