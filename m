Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E452EC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 10:02:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 603B52086C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 10:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 603B52086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445Rhw6r05zDqP3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 21:02:24 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445RMt49kkzDqB3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 20:47:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 445RMt27gbz9sDX; Fri, 22 Feb 2019 20:47:38 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 445RMs4hVcz9sBR; Fri, 22 Feb 2019 20:47:37 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 81dac817786263bb44cd5a200a07eff346f78e31
X-Patchwork-Hint: ignore
In-Reply-To: <20190115063736.3679-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/64: Make sys_switch_endian() traceable
Message-Id: <445RMs4hVcz9sBR@ozlabs.org>
Date: Fri, 22 Feb 2019 20:47:37 +1100 (AEDT)
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

On Tue, 2019-01-15 at 06:37:36 UTC, Michael Ellerman wrote:
> We weren't using SYSCALL_DEFINE for sys_switch_endian(), which means
> it wasn't able to be traced by CONFIG_FTRACE_SYSCALLS.
> 
> By using the macro we create the right metadata and the syscall is
> visible. eg:
> 
>   # cd /sys/kernel/debug/tracing
>   # echo 1 | tee events/syscalls/sys_*_switch_endian/enable
>   # ~/switch_endian_test
>   # cat trace
>   ...
>   switch_endian_t-3604  [009] ....   315.175164: sys_switch_endian()
>   switch_endian_t-3604  [009] ....   315.175167: sys_switch_endian -> 0x5555aaaa5555aaaa
>   switch_endian_t-3604  [009] ....   315.175169: sys_switch_endian()
>   switch_endian_t-3604  [009] ....   315.175169: sys_switch_endian -> 0x5555aaaa5555aaaa
> 
> Fixes: 529d235a0e19 ("powerpc: Add a proper syscall for switching endianness")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/81dac817786263bb44cd5a200a07eff3

cheers
