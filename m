Return-Path: <SRS0=IFvE=LU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C43C49EBC
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jun 2021 10:39:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7964B61998
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jun 2021 10:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7964B61998
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GBr2h57csz3bvm
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jun 2021 20:39:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GBr2K0tZpz2yQw
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Jun 2021 20:38:48 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4GBr2H5xmCz9sfG; Sat, 26 Jun 2021 20:38:47 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@kernel.org>
In-Reply-To: <20210429080708.1520360-1-arnd@kernel.org>
References: <20210429080708.1520360-1-arnd@kernel.org>
Subject: Re: [PATCH] powerpc: mark local variables around longjmp as volatile
Message-Id: <162470384692.3589875.5670173938477292479.b4-ty@ellerman.id.au>
Date: Sat, 26 Jun 2021 20:37:26 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 29 Apr 2021 10:06:38 +0200, Arnd Bergmann wrote:
> gcc-11 points out that modifying local variables next to a
> longjmp/setjmp may cause undefined behavior:
> 
> arch/powerpc/kexec/crash.c: In function 'crash_kexec_prepare_cpus.constprop':
> arch/powerpc/kexec/crash.c:108:22: error: variable 'ncpus' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbere
> d]
> arch/powerpc/kexec/crash.c:109:13: error: variable 'tries' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbere
> d]
> arch/powerpc/xmon/xmon.c: In function 'xmon_print_symbol':
> arch/powerpc/xmon/xmon.c:3625:21: error: variable 'name' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
> arch/powerpc/xmon/xmon.c: In function 'stop_spus':
> arch/powerpc/xmon/xmon.c:4057:13: error: variable 'i' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
> arch/powerpc/xmon/xmon.c: In function 'restart_spus':
> arch/powerpc/xmon/xmon.c:4098:13: error: variable 'i' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
> arch/powerpc/xmon/xmon.c: In function 'dump_opal_msglog':
> arch/powerpc/xmon/xmon.c:3008:16: error: variable 'pos' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
> arch/powerpc/xmon/xmon.c: In function 'show_pte':
> arch/powerpc/xmon/xmon.c:3207:29: error: variable 'tsk' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
> arch/powerpc/xmon/xmon.c: In function 'show_tasks':
> arch/powerpc/xmon/xmon.c:3302:29: error: variable 'tsk' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
> arch/powerpc/xmon/xmon.c: In function 'xmon_core':
> arch/powerpc/xmon/xmon.c:494:13: error: variable 'cmd' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
> arch/powerpc/xmon/xmon.c:860:21: error: variable 'bp' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
> arch/powerpc/xmon/xmon.c:860:21: error: variable 'bp' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
> arch/powerpc/xmon/xmon.c:492:48: error: argument 'fromipi' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: mark local variables around longjmp as volatile
      https://git.kernel.org/powerpc/c/a2305e3de819394a7adf68078964a92d06f9db33

cheers
