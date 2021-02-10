Return-Path: <SRS0=uerg=HM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DAAC433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 09:23:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AB7564E2F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 09:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB7564E2F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DbDpN0D7pzDvZV
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 20:23:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DbDm71nYdzDspk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2021 20:21:37 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4DbDlw3fDsz9v029;
 Wed, 10 Feb 2021 10:21:32 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id uKO9VpJbiV8l; Wed, 10 Feb 2021 10:21:32 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4DbDlw2r4rz9v02B;
 Wed, 10 Feb 2021 10:21:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7F2408B7FC;
 Wed, 10 Feb 2021 10:21:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id iKBIBiuUitKC; Wed, 10 Feb 2021 10:21:33 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4158C8B75F;
 Wed, 10 Feb 2021 10:21:33 +0100 (CET)
To: Nicholas Piggin <npiggin@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: interrupt_exit_kernel_prepare() on booke/32 has a useless 'mfmsr' and
 two 'wrteei 0'
Message-ID: <f143d4a9-bb8f-82d6-8b17-c39aff486caa@csgroup.eu>
Date: Wed, 10 Feb 2021 10:21:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 7bit
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

44x/bamboo_defconfig

For the mfmsr, that's because mfmsr is defined as 'asm volatile'. Is that correct ? Reading MSR 
doesn't have any side effects as far as I know, should we remove the volatile ?

For the wrteei, that's because we are calling __hard_EE_RI_disable() after local_irq_save(). On 
booke those two fonctions do exactly the same because RI doesn't exist. Could we replace that by a 
__hard_RI_disable() that would be a nop on booke ?


00000364 <interrupt_exit_kernel_prepare>:
  364:	81 23 00 84 	lwz     r9,132(r3)
  368:	55 29 04 62 	rlwinm  r9,r9,0,17,17
  36c:	0f 09 00 00 	twnei   r9,0
  370:	81 22 00 4c 	lwz     r9,76(r2)
  374:	75 23 00 01 	andis.  r3,r9,1
  378:	40 82 00 14 	bne     38c <interrupt_exit_kernel_prepare+0x28>
  37c:	7d 20 00 a6 	mfmsr   r9
  380:	7c 00 01 46 	wrteei  0
  384:	7c 00 01 46 	wrteei  0
  388:	4e 80 00 20 	blr
  38c:	38 e2 00 4c 	addi    r7,r2,76
  390:	3d 20 00 01 	lis     r9,1
  394:	7c c0 38 28 	lwarx   r6,0,r7
  398:	7c c6 48 78 	andc    r6,r6,r9
  39c:	7c c0 39 2d 	stwcx.  r6,0,r7
  3a0:	40 a2 ff f4 	bne     394 <interrupt_exit_kernel_prepare+0x30>
  3a4:	38 60 00 01 	li      r3,1
  3a8:	4b ff ff d4 	b       37c <interrupt_exit_kernel_prepare+0x18>
