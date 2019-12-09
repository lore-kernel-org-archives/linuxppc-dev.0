Return-Path: <SRS0=oaAR=Z7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56945C43603
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Dec 2019 05:48:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F689206D3
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Dec 2019 05:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F689206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47WXL26bSJzDqJX
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Dec 2019 16:48:26 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47WXGG0KXrzDqHJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Dec 2019 16:45:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 47WXGF5D4Xz9sR0; Mon,  9 Dec 2019 16:45:09 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 48e626ac85b43cc589dd1b3b8004f7f85f03544d
In-Reply-To: <20191127072035.4283-1-anju@linux.vnet.ibm.com>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH v3] platforms/powernv: Avoid re-registration of imc
 debugfs directory
Message-Id: <47WXGF5D4Xz9sR0@ozlabs.org>
Date: Mon,  9 Dec 2019 16:45:09 +1100 (AEDT)
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
Cc: linuxppc-dev@lists.ozlabs.org, anju@linux.vnet.ibm.com, nasastry@in.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2019-11-27 at 07:20:35 UTC, Anju T Sudhakar wrote:
> export_imc_mode_and_cmd() function which creates the debugfs interface for
> imc-mode and imc-command, is invoked when each nest pmu units is
> registered.
> When the first nest pmu unit is registered, export_imc_mode_and_cmd()
> creates 'imc' directory under `/debug/powerpc/`. In the subsequent
> invocations debugfs_create_dir() function returns, since the directory
> already exists.
> 
> The recent commit <c33d442328f55> (debugfs: make error message a bit more
> verbose), throws a warning if we try to invoke `debugfs_create_dir()`
> with an already existing directory name.
> 
> Address this warning by making the debugfs directory registration
> in the opal_imc_counters_probe() function, i.e invoke
> export_imc_mode_and_cmd() function from the probe function.
> 
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/48e626ac85b43cc589dd1b3b8004f7f85f03544d

cheers
