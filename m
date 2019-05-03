Return-Path: <SRS0=37tr=TD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24734C43219
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 May 2019 07:37:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C89CF2075C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 May 2019 07:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C89CF2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44wP935YSFzDqWd
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 May 2019 17:37:11 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44wNKQ4WXlzDqTM
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2019 16:59:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44wNKP2y5Wz9sPR; Fri,  3 May 2019 16:59:21 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44wNKP138Cz9sD4; Fri,  3 May 2019 16:59:21 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 0acb5f64560a052fd66ab37b212a72964847160f
X-Patchwork-Hint: ignore
In-Reply-To: <20190416032638.3588-1-cmr@informatik.wtf>
To: "Christopher M. Riedl" <cmr@informatik.wtf>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH v4] powerpc/xmon: add read-only mode
Message-Id: <44wNKP138Cz9sD4@ozlabs.org>
Date: Fri,  3 May 2019 16:59:21 +1000 (AEST)
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
Cc: "Christopher M. Riedl" <cmr@informatik.wtf>, oohall@gmail.com,
 andrew.donnellan@au1.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2019-04-16 at 03:26:38 UTC, "Christopher M. Riedl" wrote:
> Operations which write to memory and special purpose registers should be
> restricted on systems with integrity guarantees (such as Secure Boot)
> and, optionally, to avoid self-destructive behaviors.
> 
> Add a config option, XMON_DEFAULT_RO_MODE, to set default xmon behavior.
> The kernel cmdline options xmon=ro and xmon=rw override this default.
> 
> The following xmon operations are affected:
> memops:
> 	disable memmove
> 	disable memset
> 	disable memzcan
> memex:
> 	no-op'd mwrite
> super_regs:
> 	no-op'd write_spr
> bpt_cmds:
> 	disable
> proc_call:
> 	disable
> 
> Signed-off-by: Christopher M. Riedl <cmr@informatik.wtf>
> Reviewed-by: Oliver O'Halloran <oohall@gmail.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0acb5f64560a052fd66ab37b212a7296

cheers
