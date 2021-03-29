Return-Path: <SRS0=Xl/Y=I3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7B7C433DB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Mar 2021 09:05:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3AA361581
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Mar 2021 09:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3AA361581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F86B10mLxz30GW
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Mar 2021 20:05:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F869f4RvGz2yR0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Mar 2021 20:05:23 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4F869T4f99z9tyQt;
 Mon, 29 Mar 2021 11:05:17 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 8AG1W_2EjOtl; Mon, 29 Mar 2021 11:05:17 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4F869T3TxXz9tyQn;
 Mon, 29 Mar 2021 11:05:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9FB2F8B7B1;
 Mon, 29 Mar 2021 11:05:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 1aJzAZDAS8fr; Mon, 29 Mar 2021 11:05:18 +0200 (CEST)
Received: from [172.25.230.100] (unknown [172.25.230.100])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 696898B79A;
 Mon, 29 Mar 2021 11:05:18 +0200 (CEST)
Subject: Re: [PATCH] powerpc/64s: power4 nap fixup in C
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20210312012044.3660743-1-npiggin@gmail.com>
 <a01d923737cb1d4a603dc5046b67787233051c12.camel@kernel.crashing.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <236a67a4-1609-5fec-3c68-41db02cd1a4c@csgroup.eu>
Date: Mon, 29 Mar 2021 11:04:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <a01d923737cb1d4a603dc5046b67787233051c12.camel@kernel.crashing.org>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 29/03/2021 à 10:33, Benjamin Herrenschmidt a écrit :
> On Fri, 2021-03-12 at 11:20 +1000, Nicholas Piggin wrote:
>>
>> +static inline void nap_adjust_return(struct pt_regs *regs)
>>
>> +{
>>
>> +#ifdef CONFIG_PPC_970_NAP
>>
>> +       if (unlikely(test_thread_local_flags(_TLF_NAPPING))) {
>> +               /* Can avoid a test-and-clear because NMIs do not call this */
>> +               clear_thread_local_flags(_TLF_NAPPING);
>> +               regs->nip = (unsigned long)power4_idle_nap_return;
>> +       }
> 
> Is this a pointer to a function descriptor or the actual code ?
> 

--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -209,4 +209,8 @@ _GLOBAL(power4_idle_nap)
  	mtmsrd	r7
  	isync
  	b	1b
+
+	.globl power4_idle_nap_return
+power4_idle_nap_return:
+	blr
  #endif

