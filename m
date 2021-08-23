Return-Path: <SRS0=9U3E=NO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470FAC4338F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Aug 2021 18:49:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69A9261222
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Aug 2021 18:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 69A9261222
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gth9t5KMyz2ynF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Aug 2021 04:49:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4Gth9R4pmHz2xY5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Aug 2021 04:49:13 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 17NIktDE030226;
 Mon, 23 Aug 2021 13:46:55 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 17NIksWh030223;
 Mon, 23 Aug 2021 13:46:54 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Mon, 23 Aug 2021 13:46:48 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32: Don't use lmw/stmw for saving/restoring non
 volatile regs
Message-ID: <20210823184648.GY1583@gate.crashing.org>
References: <316c543b8906712c108985c8463eec09c8db577b.1629732542.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <316c543b8906712c108985c8463eec09c8db577b.1629732542.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Aug 23, 2021 at 03:29:12PM +0000, Christophe Leroy wrote:
> Instructions lmw/stmw are interesting for functions that are rarely
> used and not in the cache, because only one instruction is to be
> copied into the instruction cache instead of 19. However those
> instruction are less performant than 19x raw lwz/stw as they require
> synchronisation plus one additional cycle.

lmw takes N+2 cycles for loading N words on 603/604/750/7400, and N+3 on
7450.  stmw takes N+1 cycles for storing N words on 603, N+2 on 604/750/
7400, and N+3 on 7450 (load latency is 3 instead of 2 on 7450).

There is no synchronisation needed, although there is some serialisation,
which of course doesn't mean much since there can be only 6 or 8 or so
insns executing at once anyway.

So, these insns are almost never slower, they can easily win cycles back
because of the smaller code, too.

What 32-bit core do you see where load/store multiple are more than a
fraction of a cycle (per memory access) slower?

> SAVE_NVGPRS / REST_NVGPRS are used in only a few places which are
> mostly in interrupts entries/exits and in task switch so they are
> likely already in the cache.

Nothing is likely in the cache on the older cores (except in
microbenchmarks), the caches are not big enough for that!

> Using standard lwz improves null_syscall selftest by:
> - 10 cycles on mpc832x.
> - 2 cycles on mpc8xx.

And in real benchmarks?

On mpccore both lmw and stmw are only N+1 btw.  But the serialization
might cost another cycle here?


Segher
