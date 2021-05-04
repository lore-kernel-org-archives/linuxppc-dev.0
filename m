Return-Path: <SRS0=2Civ=J7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B8FC433ED
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 May 2021 10:41:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FD89613B4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 May 2021 10:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD89613B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FZGbZ6CcZz30F3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 May 2021 20:41:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FZGb66WzWz2yRK
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 May 2021 20:40:46 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4FZGZz2zDSz9sVs;
 Tue,  4 May 2021 12:40:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0E2klIs5KUQ6; Tue,  4 May 2021 12:40:43 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4FZGZz22Nyz9sVq;
 Tue,  4 May 2021 12:40:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 02E7E8B7A2;
 Tue,  4 May 2021 12:40:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id n--sAVAbfbtx; Tue,  4 May 2021 12:40:42 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 5A8FA8B7A1;
 Tue,  4 May 2021 12:40:42 +0200 (CEST)
Subject: Re: [PATCH 1/2] powerpc/asm-offset: Remove unused items related to
 paca
To: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
References: <f38728dbe96df5fef84c868640def5f6d7c114bc.1620060357.git.christophe.leroy@csgroup.eu>
 <1620121538.q0b7uiea5y.astroid@bobo.none>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <9b07e9c1-b004-a814-278b-c6a1f7b616e3@csgroup.eu>
Date: Tue, 4 May 2021 12:40:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <1620121538.q0b7uiea5y.astroid@bobo.none>
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



Le 04/05/2021 à 12:14, Nicholas Piggin a écrit :
> Excerpts from Christophe Leroy's message of May 4, 2021 2:46 am:
>> PACA_SIZE, PACACONTEXTID, PACALOWSLICESPSIZE, PACAHIGHSLICEPSIZE,
>> PACA_SLB_ADDR_LIMIT, MMUPSIZEDEFSIZE, PACASLBCACHE, PACASLBCACHEPTR,
>> PACASTABRR, PACAVMALLOCSLLP, MMUPSIZESLLP, PACACONTEXTSLLP,
>> PACALPPACAPTR, LPPACA_DTLIDX and PACA_DTL_RIDX are not used anymore
>> by ASM code.
> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> 
> Also I think SIGSEGV, NMI_MASK, THREAD_DBCR0, KUAP?, TI_FLAGS,
> TI_PREEMPT, [ID]CACHEL1*, STACK_REGS_KUAP, EXC_LVL_SIZE, KVM_NEED_FLUSH,
> KVM_FWNMI, VCPU_DEC, VCPU_SPMC, HSTATE_XICS_PHYS, HSTATE_SAVED_XIRR,
> PPC_DBELL_MSGTYPE I think. While we're cleaning it up.

Yes, thanks for checking.

I think we can safely remove KUAP.

But we can't remove EXC_LVL_SIZE, it is used in kernel/head_booke.h which is probably included in 
head_44x.S and head_fsl_booke.S

Christophe
