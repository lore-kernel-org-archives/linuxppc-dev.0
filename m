Return-Path: <SRS0=F8gr=WY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB05C3A5A1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Aug 2019 09:09:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C287320856
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Aug 2019 09:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="uqxBGM9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C287320856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46JKgh1v4mzDqjb
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Aug 2019 19:09:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="uqxBGM9G"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46JKbs1wR7zDr6T
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2019 19:06:17 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 46JKbm1kHWz9tyhj;
 Wed, 28 Aug 2019 11:06:12 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=uqxBGM9G; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id SSbRipgF6EDz; Wed, 28 Aug 2019 11:06:12 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 46JKbm0h9Qz9tyhc;
 Wed, 28 Aug 2019 11:06:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1566983172; bh=nagaHD0sZ3xgVcoKQlUSdBKe+qRM5Xi/q6YAvnN2r/s=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=uqxBGM9GRjJXfxbM19P0auDIM6DtIfWvdfLZDvNPBBM4l94zpRNmVAgsSGtTYEfEA
 0q2FA60+wfpqbC+e/uN71ugwXG1+U7oc39CvZ1CV1L1fvBAd6opCpYY1dXZxErJ3Fg
 2Ido5kvCN7gpqwr3dO5ZBM+3FQt7IHCgdK+O0Z5w=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 22E2B8B877;
 Wed, 28 Aug 2019 11:06:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id uP7-qADHyNNV; Wed, 28 Aug 2019 11:06:13 +0200 (CEST)
Received: from [172.25.230.105] (po15451.idsi0.si.c-s.fr [172.25.230.105])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 041AA8B856;
 Wed, 28 Aug 2019 11:06:13 +0200 (CEST)
Subject: Re: [PATCH v2 0/4] powerpc/64: syscalls in C
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20190827135548.21457-1-npiggin@gmail.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <5ecd9d1a-d35e-dc8c-9ad4-a830a8b1a952@c-s.fr>
Date: Wed, 28 Aug 2019 11:06:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827135548.21457-1-npiggin@gmail.com>
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



Le 27/08/2019 à 15:55, Nicholas Piggin a écrit :
> Accounted for some feedback.
> 
> Nicholas Piggin (4):
>    powerpc: convert to copy_thread_tls
>    powerpc/64: remove support for kernel-mode syscalls
>    powerpc/64: system call remove non-volatile GPR save optimisation
>    powerpc/64: system call implement the bulk of the logic in C

Would it be possible to split in the following parts:

1/ Implement in C whatever can be implemented without removing 
non-volatile GPR save optimisation
2/ Remove non-volatile GPR save optimisation
3/ Implement in C everything else

Christophe

> 
>   arch/powerpc/Kconfig                          |   1 +
>   arch/powerpc/include/asm/asm-prototypes.h     |  11 -
>   .../powerpc/include/asm/book3s/64/kup-radix.h |  12 +-
>   arch/powerpc/include/asm/cputime.h            |  22 +
>   arch/powerpc/include/asm/ptrace.h             |   3 +
>   arch/powerpc/include/asm/signal.h             |   2 +
>   arch/powerpc/include/asm/switch_to.h          |   5 +
>   arch/powerpc/include/asm/time.h               |   3 +
>   arch/powerpc/kernel/Makefile                  |   3 +-
>   arch/powerpc/kernel/entry_64.S                | 421 +++---------------
>   arch/powerpc/kernel/exceptions-64s.S          |   2 -
>   arch/powerpc/kernel/process.c                 |   9 +-
>   arch/powerpc/kernel/signal.h                  |   2 -
>   arch/powerpc/kernel/syscall_64.c              | 177 ++++++++
>   arch/powerpc/kernel/syscalls/syscall.tbl      |  22 +-
>   15 files changed, 307 insertions(+), 388 deletions(-)
>   create mode 100644 arch/powerpc/kernel/syscall_64.c
> 
