Return-Path: <SRS0=SG0q=ZT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C67C432C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Nov 2019 14:45:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DBD120678
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Nov 2019 14:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="hz2scKtZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DBD120678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47NNqX5kpzzDqtZ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Nov 2019 01:45:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="hz2scKtZ"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47NNmv6ZJLzDqsK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Nov 2019 01:43:27 +1100 (AEDT)
Received: from localhost (mailhub1-ext [192.168.12.233])
 by localhost (Postfix) with ESMTP id 47NNmn5ntbz9v0w7;
 Wed, 27 Nov 2019 15:43:21 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=hz2scKtZ; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id UFtiQgiiPNp0; Wed, 27 Nov 2019 15:43:21 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 47NNmn3FNHz9v0w6;
 Wed, 27 Nov 2019 15:43:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1574865801; bh=NA4XDMENdTgyTE7/eRNhB4x9XdgIeH45lbqXvTK24JM=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=hz2scKtZ199Hz7BZQrerYYi0WdQ/8f0XIlsvz5pLPEhSLi5vCmAEaF2dWPlVtY1G4
 bC+bb6WbtspaBpIV6uvAH2pLN0m+5NZh5yFzGM0Y2s5E5wmIdNpnFKbPPyBHgKCr8T
 ulJeT1AtJVxXwPADg1cL4DIjoQ+4qkPhLjoum3Ss=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D72E28B862;
 Wed, 27 Nov 2019 15:43:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ck_hcbGfimtV; Wed, 27 Nov 2019 15:43:22 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 477E38B85A;
 Wed, 27 Nov 2019 15:43:22 +0100 (CET)
Subject: Re: [PATCH v1 1/4] powerpc/fixmap: don't clear fixmap area in
 paging_init()
To: Michael Ellerman <patch-notifications@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, npiggin@gmail.com, hch@infradead.org
References: <47MQrc6TCxz9sPV@ozlabs.org>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <bedbd52f-9eea-7253-e28b-68e01a848405@c-s.fr>
Date: Wed, 27 Nov 2019 15:43:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <47MQrc6TCxz9sPV@ozlabs.org>
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



Le 26/11/2019 à 02:13, Michael Ellerman a écrit :
> On Thu, 2019-09-12 at 13:49:41 UTC, Christophe Leroy wrote:
>> fixmap is intended to map things permanently like the IMMR region on
>> FSL SOC (8xx, 83xx, ...), so don't clear it when initialising paging()
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> Applied to powerpc next, thanks.
> 
> https://git.kernel.org/powerpc/c/f2bb86937d86ebcb0e52f95b6d19aba1d850e601
> 

Hi,

What happened ?

It looks like it is gone in today's powerpc next.

Christophe
