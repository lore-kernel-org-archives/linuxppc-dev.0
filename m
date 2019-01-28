Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AD7C282C8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 14:58:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 682EA2084A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 14:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="nedk3FJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682EA2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43pCRr1HJ5zDqJ7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 01:58:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="nedk3FJ5"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43pCQ83YC4zDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 01:56:47 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43pCPx2Cl7z9v0Mg;
 Mon, 28 Jan 2019 15:56:37 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=nedk3FJ5; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id inWF-rAz_qX2; Mon, 28 Jan 2019 15:56:37 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43pCPx0Jbpz9v0Mb;
 Mon, 28 Jan 2019 15:56:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548687397; bh=FLvp/bKTeLYHGs24WUxEcxk6Pm2uztnrxe57PkMDNx0=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=nedk3FJ5LwK0TLAShrC2VBBDaGW5fRrqvg60nAf+/Dk+z3OIXi04is/rqUTPrNpqh
 nPwqxP7BfpW2CnOoOUTUMVA1Ka6c/z0e5TC3qPDJWztv74GV5bnLnT3XY6AEn2jaW2
 6OFMgCHNSPsRd/PG0EtqTw4nj/8WW8d6PUwtLFeo=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D7AF78B7AF;
 Mon, 28 Jan 2019 15:56:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id a7b2RxQNppbc; Mon, 28 Jan 2019 15:56:43 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B8F828B796;
 Mon, 28 Jan 2019 15:56:43 +0100 (CET)
Subject: Re: [PATCH 00/11] Refactor exception entry on 40x/6xx/8xx
To: Christoph Hellwig <hch@infradead.org>
References: <cover.1548673552.git.christophe.leroy@c-s.fr>
 <20190128141531.GA664@infradead.org>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <c272a092-cc84-b615-b7de-33c81b9c5bd3@c-s.fr>
Date: Mon, 28 Jan 2019 15:56:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190128141531.GA664@infradead.org>
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



Le 28/01/2019 à 15:15, Christoph Hellwig a écrit :
> On Mon, Jan 28, 2019 at 11:11:10AM +0000, Christophe Leroy wrote:
>> This serie refactors exception entry macros for 40x, 6xx and 8xx
>>
>> This serie will benefit to the implementation of CONFIG_VMAP, and also
>> to Ben's serie on MSR_EE.
> 
> We don't have a CONFIG_VMAP.  Do you mean CONFIG_VMAP_STACK ?
> 

Yes that's what I mean, sorry.
