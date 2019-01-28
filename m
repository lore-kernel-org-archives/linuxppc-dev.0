Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CFAC282C8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 11:13:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68DD8214DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 11:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="mAcXrpZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68DD8214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43p6Sl2Q6MzDqG0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 22:13:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="mAcXrpZI"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43p6Pv21kfzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 22:11:15 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43p6Ph6Rx4z9v1q7;
 Mon, 28 Jan 2019 12:11:04 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=mAcXrpZI; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id vkPp0Jbr9ZME; Mon, 28 Jan 2019 12:11:04 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43p6Ph5KBsz9v1q3;
 Mon, 28 Jan 2019 12:11:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548673864; bh=ytLGkNdkHVKiARW7imqJr2f7rPUwr//KpcsmbGrquWU=;
 h=From:Subject:To:Cc:Date:From;
 b=mAcXrpZIjbZvndt8G7gBmiK/WZkXF9ZMYsH9jzzbD3AaVYyVSYX2hFy94uuBtkbwJ
 77f0l28xKTb1U27ESBD1bRM8acYOqU2APHqOaSQtBx4GzgP/bdlG06HSwYFqNPcJlU
 Apsj3aFrCllFZie4ngNgckcBqHl33Vhl/L64dGSo=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 300A28B79D;
 Mon, 28 Jan 2019 12:11:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id Q3Y0li4gsvBD; Mon, 28 Jan 2019 12:11:11 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 12FFB8B796;
 Mon, 28 Jan 2019 12:11:11 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 0518772DE6; Mon, 28 Jan 2019 11:11:10 +0000 (UTC)
Message-Id: <cover.1548673552.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 00/11] Refactor exception entry on 40x/6xx/8xx
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 28 Jan 2019 11:11:10 +0000 (UTC)
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

This serie refactors exception entry macros for 40x, 6xx and 8xx

This serie will benefit to the implementation of CONFIG_VMAP, and also
to Ben's serie on MSR_EE.

First patch of this serie is a part of the CONFIG_THREAD_INFO_IN_TASK serie.
This avoids a conflict between the two series.

Christophe Leroy (11):
  powerpc/32: Rename THREAD_INFO to TASK_STACK
  powerpc/32: Refactor EXCEPTION entry macros for head_8xx.S and
    head_32.S
  powerpc/32: Add a macro for setting MSR_RI in EXCEPTION_PROLOG_2
  powerpc/32: add CLR_MSR_WE() in EXCEPTION_PROLOG in head_32.h
  powerpc/32: add START_EXCEPTION() in head_32.h
  powerpc/32: move LOAD_MSR_KERNEL() into head_32.h and use it
  powerpc/40x: Don't use SPRN_SPRG_SCRATCH2 in EXCEPTION_PROLOG
  powerpc/40x: add exception frame marker
  powerpc/40x: Split and rename NORMAL_EXCEPTION_PROLOG
  powerpc/40x: Add EXC_XFER_TEMPLATE_CRITICAL()
  powerpc/40x: Refactor exception entry macros by using head_32.h

 arch/powerpc/kernel/asm-offsets.c    |   2 +-
 arch/powerpc/kernel/entry_32.S       |  11 +---
 arch/powerpc/kernel/head_32.S        | 101 ++--------------------------
 arch/powerpc/kernel/head_32.h        | 124 +++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/head_40x.S       | 120 ++++++++-------------------------
 arch/powerpc/kernel/head_8xx.S       | 103 ++---------------------------
 arch/powerpc/kernel/head_booke.h     |   4 +-
 arch/powerpc/kernel/head_fsl_booke.S |   2 +-
 8 files changed, 167 insertions(+), 300 deletions(-)
 create mode 100644 arch/powerpc/kernel/head_32.h

-- 
2.13.3

