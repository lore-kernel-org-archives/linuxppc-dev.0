Return-Path: <SRS0=+9Gk=I2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78282C433C1
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Mar 2021 11:07:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B66961949
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Mar 2021 11:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B66961949
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F7Xwr18PJz30FK
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Mar 2021 22:07:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F7XwS5T0kz2xYy
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Mar 2021 22:07:00 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4F7XwK2Cwzz9tyJY;
 Sun, 28 Mar 2021 13:06:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id X7bzXoFdbBWq; Sun, 28 Mar 2021 13:06:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4F7XwK1C6Rz9tyJV;
 Sun, 28 Mar 2021 13:06:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id BE4098B782;
 Sun, 28 Mar 2021 13:06:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id EfLRhhLErgBp; Sun, 28 Mar 2021 13:06:57 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0EEB08B75F;
 Sun, 28 Mar 2021 13:06:57 +0200 (CEST)
Subject: Re: [PATCH] powerpc: Fix HAVE_HARDLOCKUP_DETECTOR_ARCH build
 configuration
To: Chen Huang <chenhuang5@huawei.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
References: <20210327094900.938555-1-chenhuang5@huawei.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <dd6b25d3-006b-be1e-9c4f-89e66aefb519@csgroup.eu>
Date: Sun, 28 Mar 2021 13:06:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210327094900.938555-1-chenhuang5@huawei.com>
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
Cc: Don Zickus <dzickus@redhat.com>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Hulk Robot <hulkci@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 27/03/2021 à 10:49, Chen Huang a écrit :
> When compiling the powerpc with the SMP disabled, it shows the issue:
> 
> arch/powerpc/kernel/watchdog.c: In function ‘watchdog_smp_panic’:
> arch/powerpc/kernel/watchdog.c:177:4: error: implicit declaration of function ‘smp_send_nmi_ipi’; did you mean ‘smp_send_stop’? [-Werror=implicit-function-declaration]
>    177 |    smp_send_nmi_ipi(c, wd_lockup_ipi, 1000000);
>        |    ^~~~~~~~~~~~~~~~
>        |    smp_send_stop
> cc1: all warnings being treated as errors
> make[2]: *** [scripts/Makefile.build:273: arch/powerpc/kernel/watchdog.o] Error 1
> make[1]: *** [scripts/Makefile.build:534: arch/powerpc/kernel] Error 2
> make: *** [Makefile:1980: arch/powerpc] Error 2
> make: *** Waiting for unfinished jobs....
> 
> We found that powerpc used ipi to implement hardlockup watchdog, so the
> HAVE_HARDLOCKUP_DETECTOR_ARCH should depend on the SMP.
> 
> Fixes: 2104180a5369 ("powerpc/64s: implement arch-specific hardlockup watchdog")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Chen Huang <chenhuang5@huawei.com>
> ---
>   arch/powerpc/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 764df010baee..2d4f37b117ce 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -225,7 +225,7 @@ config PPC
>   	select HAVE_LIVEPATCH			if HAVE_DYNAMIC_FTRACE_WITH_REGS
>   	select HAVE_MOD_ARCH_SPECIFIC
>   	select HAVE_NMI				if PERF_EVENTS || (PPC64 && PPC_BOOK3S)
> -	select HAVE_HARDLOCKUP_DETECTOR_ARCH	if (PPC64 && PPC_BOOK3S)
> +	select HAVE_HARDLOCKUP_DETECTOR_ARCH	if PPC64 && PPC_BOOK3S && SMP

While modifying this line, you should restore the alphabetic order by moving it up.

You can use PPC_BOOK3S_64 instead of PPC64 && PPC_BOOK3S

>   	select HAVE_OPTPROBES			if PPC64
>   	select HAVE_PERF_EVENTS
>   	select HAVE_PERF_EVENTS_NMI		if PPC64
> 
