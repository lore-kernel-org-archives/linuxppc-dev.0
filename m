Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DBDC4360F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 20:38:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D20A42075E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 20:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="XwSO9UiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D20A42075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Ygyh1VDCzDqPk
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 07:38:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="XwSO9UiH"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Ygwy3xWhzDqDf
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 07:36:49 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44Ygwr5PLKz9v0Vr;
 Tue,  2 Apr 2019 22:36:44 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=XwSO9UiH; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id yyUnmaIc8DNn; Tue,  2 Apr 2019 22:36:44 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44Ygwr3nJYz9v0Vq;
 Tue,  2 Apr 2019 22:36:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1554237404; bh=BwooMA22qN5MVKhV+b35SP+1LDZWopZGd8mOz82SGGY=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=XwSO9UiHs7eDKhbgCafzeJv3wWzgWvMT2DlYlpZEUflcR82p5RjBXhqv1B+ZBZ/qz
 PoHCRyburOnl9/TcAZbdfUDX10m3l+OZInCgSAJ3kqvNEXuvVWndlKUIWdEw59AzAH
 3Tipq4va5XI4jqdbpACigBrudGGvi4yNapNBGy+4=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id ACB2C8B8D2;
 Tue,  2 Apr 2019 22:36:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id x1CuPvs9w0Vs; Tue,  2 Apr 2019 22:36:44 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 6B8D38B8CD;
 Tue,  2 Apr 2019 22:36:43 +0200 (CEST)
Subject: Re: [RFC PATCH v2 3/3] kasan: add interceptors for all string
 functions
To: Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Daniel Axtens <dja@axtens.net>
References: <f13944c4e99ec2cef6d93d762e6b526e0335877f.1553785019.git.christophe.leroy@c-s.fr>
 <51a6d9d7185de310f37ccbd7e4ebfdd6c7e9791f.1553785020.git.christophe.leroy@c-s.fr>
 <3211b0f8-7b52-01b7-8208-65d746969248@c-s.fr>
 <ae9262e5-0917-b7c9-52c7-fe21db2ecacb@virtuozzo.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <d5d2fa6f-c2ba-8234-e412-9c4ccd6cc4c6@c-s.fr>
Date: Tue, 2 Apr 2019 22:36:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ae9262e5-0917-b7c9-52c7-fe21db2ecacb@virtuozzo.com>
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 02/04/2019 à 18:14, Andrey Ryabinin a écrit :
> 
> 
> On 4/2/19 12:43 PM, Christophe Leroy wrote:
>> Hi Dmitry, Andrey and others,
>>
>> Do you have any comments to this series ?
>>
> 
> I don't see justification for adding all these non-instrumented functions. We need only some subset of these functions
> and only on powerpc so far. Arches that don't use str*() that early simply doesn't need not-instrumented __str*() variant.
> 
> Also I don't think that auto-replace str* to __str* for all not instrumented files is a good idea, as this will reduce KASAN coverage.
> E.g. we don't instrument slub.c but there is no reason to use non-instrumented __str*() functions there.

Ok, I didn't see it that way.

In fact I was seeing the opposite and was considering it as an 
opportunity to increase KASAN coverage. E.g.: at the time being things 
like the above (from arch/xtensa/include/asm/string.h) are not covered 
at all I believe:

#define __HAVE_ARCH_STRCPY
static inline char *strcpy(char *__dest, const char *__src)
{
	register char *__xdest = __dest;
	unsigned long __dummy;

	__asm__ __volatile__("1:\n\t"
		"l8ui	%2, %1, 0\n\t"
		"s8i	%2, %0, 0\n\t"
		"addi	%1, %1, 1\n\t"
		"addi	%0, %0, 1\n\t"
		"bnez	%2, 1b\n\t"
		: "=r" (__dest), "=r" (__src), "=&r" (__dummy)
		: "0" (__dest), "1" (__src)
		: "memory");

	return __xdest;
}

In my series, I have deactivated optimised string functions when KASAN 
is selected like arm64 do. See https://patchwork.ozlabs.org/patch/1055780/
But not every arch does that, meaning that some string functions remains 
not instrumented at all.

Also, I was seeing it as a way to reduce impact on performance with 
KASAN. Because instrumenting each byte access of the non-optimised 
string functions is a performance genocide.

> 
> And finally, this series make bug reporting slightly worse. E.g. let's look at strcpy():
> 
> +char *strcpy(char *dest, const char *src)
> +{
> +	size_t len = __strlen(src) + 1;
> +
> +	check_memory_region((unsigned long)src, len, false, _RET_IP_);
> +	check_memory_region((unsigned long)dest, len, true, _RET_IP_);
> +
> +	return __strcpy(dest, src);
> +}
> 
> If src is not-null terminated string we might not see proper out-of-bounds report from KASAN only a crash in __strlen().
> Which might make harder to identify where 'src' comes from, where it was allocated and what's the size of allocated area.
> 
> 
>> I'd like to know if this approach is ok or if it is better to keep doing as in https://patchwork.ozlabs.org/patch/1055788/
>>
> I think the patch from link is a better solution to the problem.
> 

Ok, I'll stick with it then. Thanks for your feedback

Christophe
