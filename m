Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3A4C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 09:15:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FDA021720
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 09:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FDA021720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43L5hg2cdfzDrQR
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 20:15:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43L5736sRWzDrBG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 19:50:07 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43L56z0y9kz9tyfP;
 Thu, 20 Dec 2018 09:50:03 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id oF7vHVdQOlGZ; Thu, 20 Dec 2018 09:50:03 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43L56z0SJ4z9tyfN;
 Thu, 20 Dec 2018 09:50:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E0C038B7A1;
 Thu, 20 Dec 2018 09:50:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 8KG58wi7QfFd; Thu, 20 Dec 2018 09:50:03 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 86BFC8B7AD;
 Thu, 20 Dec 2018 09:50:03 +0100 (CET)
Subject: Re: [PATCH] powerpc/8xx: Map a second 8M text page at startup when
 needed.
To: Christoph Hellwig <hch@infradead.org>
References: <27edd227d3b9dcda4e2ce7d00d9fddeb7a5520a1.1545241146.git.christophe.leroy@c-s.fr>
 <20181220082403.GA25436@infradead.org>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <49bf27a4-b0b1-27e1-78f1-a5d55c720d91@c-s.fr>
Date: Thu, 20 Dec 2018 09:50:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181220082403.GA25436@infradead.org>
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



Le 20/12/2018 à 09:24, Christoph Hellwig a écrit :
> On Thu, Dec 20, 2018 at 05:48:25AM +0000, Christophe Leroy wrote:
>> Some debug setup like CONFIG_KASAN generate huge
>> kernels with text size over the 8M limit.
>>
>> This patch maps a second 8M page when _einittext is over 8M.
> 
> Do we also need a check to generate a useful warning if we ever overflow
> the 16MB?
> 

I don't think any other platform does that (the 40x also maps 16Mb, 
book3s/601 maps 24Mb)

But why not, could do that in another patch.

Is there an easy way to get the link to fail when CONFIG_PIN_TLB_TEXT is 
set and _einittext is higher than 16Mb ?

Or should we just map up to 24Mb on the 8xx and consider we are on the 
safe side with that much ?

Christophe
