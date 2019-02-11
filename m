Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE67AC169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 06:30:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57BC52070C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 06:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="UImav6xj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57BC52070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ybW240mrzDqMk
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 17:30:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="UImav6xj"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ybRP2FmRzDqNv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 17:26:55 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43ybR94nTDz9tyv7;
 Mon, 11 Feb 2019 07:26:45 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=UImav6xj; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id F0Uehg3cyFmr; Mon, 11 Feb 2019 07:26:45 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43ybR93m3Dz9tyv6;
 Mon, 11 Feb 2019 07:26:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1549866405; bh=pP+qBsacOc7BX7HqUMyCGXaWaf0LuL8H6j/y+Qb/DfE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=UImav6xj6WD5+YiGnMf9PKlhmQmGaSW/NOp2WOAyj/o6DenNrA1ZCb7uzh68UNLi3
 nsJhA3fjmmi+WsNS1TxBdxtCXwwtpOFKos3SjcfOnASGkjuZw6BaWHDYDFl34M0VXF
 oO3yLP/LXlBIW3OTMYvKhSkkWqwWVo5oz3E8ouKg=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B300C8B791;
 Mon, 11 Feb 2019 07:26:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id mQFX59vvXYKb; Mon, 11 Feb 2019 07:26:51 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 848E58B74C;
 Mon, 11 Feb 2019 07:26:51 +0100 (CET)
Subject: Re: [PATCH v1 03/16] powerpc/32: move LOAD_MSR_KERNEL() into
 head_32.h and use it
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
References: <cover.1549630193.git.christophe.leroy@c-s.fr>
 <1946d8ed86a92a9a6827ec260d0d9c99e0d88184.1549630193.git.christophe.leroy@c-s.fr>
 <749f719a0881531cad2071a7011dc5e894812d3d.camel@kernel.crashing.org>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <b074648b-8896-5591-16fe-3ecaf5c7553a@c-s.fr>
Date: Mon, 11 Feb 2019 07:26:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <749f719a0881531cad2071a7011dc5e894812d3d.camel@kernel.crashing.org>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 11/02/2019 à 01:21, Benjamin Herrenschmidt a écrit :
> On Fri, 2019-02-08 at 12:52 +0000, Christophe Leroy wrote:
>>   /*
>> + * MSR_KERNEL is > 0x8000 on 4xx/Book-E since it include MSR_CE.
>> + */
>> +.macro __LOAD_MSR_KERNEL r, x
>> +.if \x >= 0x8000
>> +       lis \r, (\x)@h
>> +       ori \r, \r, (\x)@l
>> +.else
>> +       li \r, (\x)
>> +.endif
>> +.endm
>> +#define LOAD_MSR_KERNEL(r, x) __LOAD_MSR_KERNEL r, x
>> +
> 
> You changed the limit from >= 0x10000 to >= 0x8000 without a
> corresponding explanation as to why...

Yes, the existing LOAD_MSR_KERNEL() was buggy because 'li' takes a 
signed u16, ie between -0x8000 and 0x7999.

By chance it was working because until now nobody was trying to set 
MSR_KERNEL | MSR_EE.

Christophe
