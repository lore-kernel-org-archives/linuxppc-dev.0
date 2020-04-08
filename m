Return-Path: <SRS0=I3TE=5Y=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689F4C2BA1A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2020 13:34:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 187D12072A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2020 13:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="CvHc61oW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 187D12072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48y4xp1KYxzDqRN
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2020 23:34:22 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48y38K6STBzDqst
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2020 22:13:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=CvHc61oW; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 48y38J2kyXz9sRN;
 Wed,  8 Apr 2020 22:13:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1586348000;
 bh=ubGzeXSiVoqtebhTvEZLZD3GVQ6q7AW2piVuB1gAlBA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=CvHc61oW7tA7kZxZgTKRkrr72INdmtZmz5b2cWNfwTinUYYVcvgEHtnajpTiQwaWq
 RInLrTI9uvKzzCpougdbGohfsJjFL9K0UTwXHMbirkCHbfkqJOa8/JN++5teOhXBSi
 ecCRcm7DO8/gqeCaTulSq2i7bmpwZknTMxVoPQIiP0lShZubxMLu2lijoJj9lqco4o
 Y6W0UUEPlPu/GwkcXy4vdaYBunXvXJAF3QG/zXFcmdTK/HY2RGbe2nq+WKeqIZdQAu
 btwyGBcmhkxv9hZHS09dfisn+s8WtiOaESPca0aijOPTVwdEucrjnZ1wDkEHrqXuiy
 L/LyM6dfCLxpg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Leonardo Bras <leonardo@linux.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Enrico Weigelt <info@metux.net>, Thomas Gleixner <tglx@linutronix.de>,
 Allison Randal <allison@lohutok.net>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Leonardo Bras <leonardo@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/1] powerpc/crash: Use NMI context for printk after
 crashing other CPUs
In-Reply-To: <20200406174058.686436-1-leonardo@linux.ibm.com>
References: <20200406174058.686436-1-leonardo@linux.ibm.com>
Date: Wed, 08 Apr 2020 22:13:31 +1000
Message-ID: <87y2r6jhuc.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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

Leonardo Bras <leonardo@linux.ibm.com> writes:
> Currently, if printk lock (logbuf_lock) is held by other thread during
> crash, there is a chance of deadlocking the crash on next printk, and
> blocking a possibly desired kdump.
>
> After sending IPI to all other CPUs, make printk enter in NMI context,
> as it will use per-cpu buffers to store the message, and avoid locking
> logbuf_lock.
>
> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
> ---
>  arch/powerpc/kexec/crash.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
> index d488311efab1..9b73e3991bf4 100644
> --- a/arch/powerpc/kexec/crash.c
> +++ b/arch/powerpc/kexec/crash.c
> @@ -115,6 +115,7 @@ static void crash_kexec_prepare_cpus(int cpu)

Added context:

	printk(KERN_EMERG "Sending IPI to other CPUs\n");

	if (crash_wake_offline)
		ncpus = num_present_cpus() - 1;

>  
>  	crash_send_ipi(crash_ipi_callback);
>  	smp_wmb();
> +	printk_nmi_enter();
  
Why did you decide to put it there, rather than at the start of
default_machine_crash_shutdown() like I did?

The printk() above could have already deadlocked if another CPU is stuck
with the logbuf lock held.

cheers
