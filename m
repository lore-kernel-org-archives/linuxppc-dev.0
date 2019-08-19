Return-Path: <SRS0=1Kal=WP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73021C3A5A0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Aug 2019 15:12:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA73920651
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Aug 2019 15:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Vo54OfXd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA73920651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46By8r1vb0zDqT6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Aug 2019 01:12:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="Vo54OfXd"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46By1D5QW7zDqdw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2019 01:06:08 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 46By115JXKz9v0lZ;
 Mon, 19 Aug 2019 17:05:57 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=Vo54OfXd; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id YETEQXL8UOQ4; Mon, 19 Aug 2019 17:05:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 46By113ycpz9v0lV;
 Mon, 19 Aug 2019 17:05:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1566227157; bh=Pvy/uoRwlQzhWtYHMcSAvYxmZskqAfrju91PELbG3jg=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Vo54OfXdn5bt4A2X0NgPS36957r7xxFqdm+9+B/RCCVRDEmMGxy2+ENKEV639kUsc
 WsnZID5Z6b1qlVQvNgEm62YtbGLfjOXbAEMnqTBKGIR+/JOBqkdWJVAjFUOzp7Hwli
 sXVUmYV3Xta9PkMtsRDzG4XtyWybzIWupfBIntt0=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2F8048B7BC;
 Mon, 19 Aug 2019 17:06:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id aOMEMrlxlL8H; Mon, 19 Aug 2019 17:06:03 +0200 (CEST)
Received: from [172.25.230.101] (po15451.idsi0.si.c-s.fr [172.25.230.101])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id F29A58B7B9;
 Mon, 19 Aug 2019 17:06:02 +0200 (CEST)
Subject: Re: [PATCH 3/3] powerpc: use __builtin_trap() in BUG/WARN macros.
To: Segher Boessenkool <segher@kernel.crashing.org>
References: <a6781075192afe0c909ce7d091de7931183a5d93.1566219503.git.christophe.leroy@c-s.fr>
 <20510ce03cc9463f1c9e743c1d93b939de501b53.1566219503.git.christophe.leroy@c-s.fr>
 <20190819132313.GH31406@gate.crashing.org>
 <dbafc03a-6eda-d9a3-c451-d242f03b01d9@c-s.fr>
 <20190819143700.GK31406@gate.crashing.org>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <44a19633-f2a9-79f9-da7c-16ba64a66600@c-s.fr>
Date: Mon, 19 Aug 2019 17:05:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819143700.GK31406@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 19/08/2019 à 16:37, Segher Boessenkool a écrit :
> On Mon, Aug 19, 2019 at 04:08:43PM +0200, Christophe Leroy wrote:
>> Le 19/08/2019 à 15:23, Segher Boessenkool a écrit :
>>> On Mon, Aug 19, 2019 at 01:06:31PM +0000, Christophe Leroy wrote:
>>>> Note that we keep using an assembly text using "twi 31, 0, 0" for
>>>> inconditional traps because GCC drops all code after
>>>> __builtin_trap() when the condition is always true at build time.
>>>
>>> As I said, it can also do this for conditional traps, if it can prove
>>> the condition is always true.
>>
>> But we have another branch for 'always true' and 'always false' using
>> __builtin_constant_p(), which don't use __builtin_trap(). Is there
>> anything wrong with that ?:
> 
> The compiler might not realise it is constant when it evaluates the
> __builtin_constant_p, but only realises it later.  As the documentation
> for the builtin says:
>    A return of 0 does not indicate that the
>    value is _not_ a constant, but merely that GCC cannot prove it is a
>    constant with the specified value of the '-O' option.

So you mean GCC would not be able to prove that 
__builtin_constant_p(cond) is always true but it would be able to prove 
that if (cond)  is always true ?

And isn't there a away to tell GCC that '__builtin_trap()' is 
recoverable in our case ?

> 
> (and there should be many more and more serious warnings here).
> 
>> #define BUG_ON(x) do {						\
>> 	if (__builtin_constant_p(x)) {				\
>> 		if (x)						\
>> 			BUG();					\
>> 	} else {						\
>> 		if (x)						\
>> 			__builtin_trap();			\
>> 		BUG_ENTRY("", 0);				\
>> 	}							\
>> } while (0)
> 
> I think it may work if you do
> 
> #define BUG_ON(x) do {						\
> 	if (__builtin_constant_p(x)) {				\
> 		if (x)						\
> 			BUG();					\
> 	} else {						\
> 		BUG_ENTRY("", 0);				\
> 		if (x)						\
> 			__builtin_trap();			\
> 	}							\
> } while (0)

It doesn't work:

void test_bug1(unsigned long long a)
{
	BUG_ON(a);
}

00000090 <test_bug1>:
   90:	7c 63 23 78 	or      r3,r3,r4
   94:	0f 03 00 00 	twnei   r3,0
   98:	4e 80 00 20 	blr

RELOCATION RECORDS FOR [__bug_table]:
OFFSET   TYPE              VALUE
00000084 R_PPC_ADDR32      .text+0x00000090

As you see, the relocation in __bug_table points to the 'or' and not to 
the 'twnei'.

> 
> or even just
> 
> #define BUG_ON(x) do {						\
> 	BUG_ENTRY("", 0);					\
> 	if (x)							\
> 		__builtin_trap();				\
> 	}							\
> } while (0)
> 
> if BUG_ENTRY can work for the trap insn *after* it.
> 
>>> Can you put the bug table asm *before* the __builtin_trap maybe?  That
>>> should make it all work fine...  If you somehow can tell what machine
>>> instruction is that trap, anyway.
>>
>> And how can I tell that ?
> 
> I don't know how BUG_ENTRY works exactly.

It's basic, maybe too basic: it adds an inline asm with a label, and 
adds a .long in the __bug_table section with the address of that label.

When putting it after the __builtin_trap(), I changed it to using the 
address before the one of the label which is always the twxx instruction 
as far as I can see.

#define BUG_ENTRY(insn, flags, ...)			\
	__asm__ __volatile__(				\
		"1:	" insn "\n"			\
		".section __bug_table,\"aw\"\n"		\
		"2:\t" PPC_LONG "1b, %0\n"		\
		"\t.short %1, %2\n"			\
		".org 2b+%3\n"				\
		".previous\n"				\
		: : "i" (__FILE__), "i" (__LINE__),	\
		  "i" (flags),				\
		  "i" (sizeof(struct bug_entry)),	\
		  ##__VA_ARGS__)

Christophe
