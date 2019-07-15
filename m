Return-Path: <SRS0=O2mS=VM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03353C7618A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jul 2019 06:28:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF7D020838
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jul 2019 06:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7D020838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45nDBR0bl9zDqRF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jul 2019 16:28:47 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45nD8R5NzGzDqQb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jul 2019 16:27:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45nD8R095bz9sND;
 Mon, 15 Jul 2019 16:27:02 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Qian Cai <cai@lca.pw>
Subject: Re: [PATCH v3] powerpc/setup_64: fix -Wempty-body warnings
In-Reply-To: <1561730629-5025-1-git-send-email-cai@lca.pw>
References: <1561730629-5025-1-git-send-email-cai@lca.pw>
Date: Mon, 15 Jul 2019 16:27:00 +1000
Message-ID: <871ryrak3v.fsf@concordia.ellerman.id.au>
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
Cc: linux-kernel@vger.kernel.org, paulus@samba.org, tyreld@linux.vnet.ibm.com,
 joe@perches.com, Qian Cai <cai@lca.pw>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Qian Cai <cai@lca.pw> writes:
> At the beginning of setup_64.c, it has,
>
>   #ifdef DEBUG
>   #define DBG(fmt...) udbg_printf(fmt)
>   #else
>   #define DBG(fmt...)
>   #endif
>
> where DBG() could be compiled away, and generate warnings,
>
> arch/powerpc/kernel/setup_64.c: In function 'initialize_cache_info':
> arch/powerpc/kernel/setup_64.c:579:49: warning: suggest braces around
> empty body in an 'if' statement [-Wempty-body]
>     DBG("Argh, can't find dcache properties !\n");
>                                                  ^
> arch/powerpc/kernel/setup_64.c:582:49: warning: suggest braces around
> empty body in an 'if' statement [-Wempty-body]
>     DBG("Argh, can't find icache properties !\n");

Neither of those sites should use DBG(), that's not really early boot
code, they should just use pr_warn().

And the other uses of DBG() in initialize_cache_info() should just be
removed.

In smp_release_cpus() the entry/exit DBG's should just be removed, and
the spinning_secondaries line should just be pr_debug().

That would just leave the two calls in early_setup(). If we taught
udbg_printf() to return early when udbg_putc is NULL, then we could just
call udbg_printf() unconditionally and get rid of the DBG macro entirely.

cheers
