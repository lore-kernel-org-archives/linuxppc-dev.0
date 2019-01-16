Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC94C43444
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 13:44:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 840162082F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 13:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEE+NR6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840162082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fpNk1PBdzDqLH
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 00:44:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="vEE+NR6q"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fpBV5Pb4zDqfH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 00:36:02 +1100 (AEDT)
Received: from localhost (unknown [23.100.24.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BA78B2086D;
 Wed, 16 Jan 2019 13:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547645761;
 bh=X/DAXLw7/sg/0G1inZRVPjEB/phJVFGQj0oG7WJyfm8=;
 h=Date:From:To:To:To:Cc:Cc:Cc:Subject:In-Reply-To:References:From;
 b=vEE+NR6qiX9CAeqKPlVJ1SlPZchY6YZ2yKX3Q+dbSBMXPQzfQ44fGe+Qs7gMup/Sg
 YjfmGHDUFXdhPBhsgFSBmt8hvW0cBPE3oflwVoc4I9yh+BX9HnKknyBVFsrBrsgo16
 v8vKDbi6Svt7dcC/yOKc+dlZDMCTecSblQRL3ZS4=
Date: Wed, 16 Jan 2019 13:35:59 +0000
From: Sasha Levin <sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
To: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/tm: Limit TM code inside PPC_TRANSACTIONAL_MEM
In-Reply-To: <1547039805-7979-1-git-send-email-leitao@debian.org>
References: <1547039805-7979-1-git-send-email-leitao@debian.org>
Message-Id: <20190116133600.BA78B2086D@mail.kernel.org>
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
Cc: , mikey@neuling.org, stable@vger.kernel.org, gregkh@linuxfoundation.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag,
fixing commit: e1c3743e1a20 powerpc/tm: Set MSR[TS] just prior to recheckpoint.

The bot has tested the following trees: v4.20.2, v4.19.15, v4.14.93, v4.9.150.

v4.20.2: Failed to apply! Possible dependencies:
    Unable to calculate

v4.19.15: Failed to apply! Possible dependencies:
    Unable to calculate

v4.14.93: Failed to apply! Possible dependencies:
    0d60619e1c0c ("powerpc: Add missing prototype for sys_debug_setcontext()")
    67b464a89c21 ("powerpc/32: Mark both tmp variables as unused")
    6f5b9f018f4c ("powerpc/tm: Unset MSR[TS] if not recheckpointing")
    b53875c4b4f2 ("powerpc: Add missing prototypes for sys_sigreturn() & sys_rt_sigreturn()")
    bf7fb32dd5fc ("powerpc: Add missing prototypes for ppc_select() & ppc_fadvise64_64()")
    f3675644e172 ("powerpc/syscalls: signal_{32, 64} - switch to SYSCALL_DEFINE")

v4.9.150: Failed to apply! Possible dependencies:
    0d60619e1c0c ("powerpc: Add missing prototype for sys_debug_setcontext()")
    67b464a89c21 ("powerpc/32: Mark both tmp variables as unused")
    6f5b9f018f4c ("powerpc/tm: Unset MSR[TS] if not recheckpointing")
    b53875c4b4f2 ("powerpc: Add missing prototypes for sys_sigreturn() & sys_rt_sigreturn()")
    bf7fb32dd5fc ("powerpc: Add missing prototypes for ppc_select() & ppc_fadvise64_64()")
    f3675644e172 ("powerpc/syscalls: signal_{32, 64} - switch to SYSCALL_DEFINE")


How should we proceed with this patch?

--
Thanks,
Sasha
