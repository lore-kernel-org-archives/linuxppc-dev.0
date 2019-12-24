Return-Path: <SRS0=LneW=2O=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440B5C2D0CF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Dec 2019 11:56:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8C2B2053B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Dec 2019 11:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="N5E0i1vM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C2B2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47hvnh4TNSzDqNt
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Dec 2019 22:56:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="N5E0i1vM"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47hvkf39KfzDqLS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Dec 2019 22:53:46 +1100 (AEDT)
Received: from localhost (mailhub1-ext [192.168.12.233])
 by localhost (Postfix) with ESMTP id 47hvkY1zTbz9tyJk;
 Tue, 24 Dec 2019 12:53:41 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=N5E0i1vM; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id i2LrwXcch1pS; Tue, 24 Dec 2019 12:53:41 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 47hvkY0fjzz9tyJ9;
 Tue, 24 Dec 2019 12:53:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1577188421; bh=rousui2xUHlcbFiKZoeJNXCVvYL8EIhitr3EE5iNsjU=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=N5E0i1vMnuFkhimEvxDKS3DblFYQotEgh76DkZxU2ZMywBHeZ1wv1XGJkJ85Aq/zz
 YdDhdfSK48oQ6/n/AeOXYl4PbVsfl3G9hf7FTwjwhHF5PJsMiXWubwtYq+yTiLb67r
 of9z8utFkNutvRL1AHq56r3Ott4nHyaEOuTRYRe0=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 510518B783;
 Tue, 24 Dec 2019 12:53:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id FcS-Gk27Ac_t; Tue, 24 Dec 2019 12:53:42 +0100 (CET)
Received: from [192.168.232.53] (unknown [192.168.232.53])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 677C68B782;
 Tue, 24 Dec 2019 12:53:41 +0100 (CET)
Subject: Re: [RFC PATCH v2 04/10] lib: vdso: get pointer to vdso data from the
 arch
To: Andy Lutomirski <luto@kernel.org>
References: <cover.1577111363.git.christophe.leroy@c-s.fr>
 <02861d0a05c2d48db4e9ee9093e2e2598093c372.1577111366.git.christophe.leroy@c-s.fr>
 <CALCETrW9hsrVVzudvRY22AqakcsrVzqp=SdwOTwW2zRBK+kEaA@mail.gmail.com>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <de5273aa-69dc-8e37-c917-44708257d2ba@c-s.fr>
Date: Tue, 24 Dec 2019 12:53:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CALCETrW9hsrVVzudvRY22AqakcsrVzqp=SdwOTwW2zRBK+kEaA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Antivirus: Avast (VPS 191223-0, 23/12/2019), Outbound message
X-Antivirus-Status: Not-Tested
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
Cc: Arnd Bergmann <arnd@arndb.de>, X86 ML <x86@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "open list:MIPS" <linux-mips@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 24/12/2019 à 03:27, Andy Lutomirski a écrit :
> On Mon, Dec 23, 2019 at 6:31 AM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
>>
>> On powerpc, __arch_get_vdso_data() clobbers the link register,
>> requiring the caller to set a stack frame in order to save it.
>>
>> As the parent function already has to set a stack frame and save
>> the link register to call the C vdso function, retriving the
>> vdso data pointer there is lighter.
> 
> I'm confused.  Can't you inline __arch_get_vdso_data()?  Or is the
> issue that you can't retrieve the program counter on power without
> clobbering the link register?

Yes it can be inlined (I did it in V1 
https://patchwork.ozlabs.org/patch/1180571/), but you can't do it 
without clobbering the link register, because the only way to get the 
program counter is to do to as if you were calling another function but 
you call to the address which just follows where you are, so that it 
sets LR which the simulated return address which corresponds to the 
address following the branch.

static __always_inline
const struct vdso_data *__arch_get_vdso_data(void)
{
	void *ptr;

	asm volatile(
		"	bcl	20, 31, .+4;\n"
		"	mflr	%0;\n"
		"	addi	%0, %0, __kernel_datapage_offset - (.-4);\n"
		: "=b"(ptr) : : "lr");

	return ptr + *(unsigned long *)ptr;
}

> 
> I would imagine that this patch generates worse code on any
> architecture with PC-relative addressing modes (which includes at
> least x86_64, and I would guess includes most modern architectures).

Why ? Powerpc is also using PC-relative addressing for all calls but 
indirect calls.

As the other arch C VDSO callers are in C and written in such a way that 
callee is inlined into callers, and as __arch_get_vdso_data() is 
inlined, it should make no difference, shouldn't it ?

Christophe
