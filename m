Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C40EC07E85
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 13:26:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1AC020868
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 13:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1AC020868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43BCsk0svGzDsRQ
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 00:26:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43BCRT3wTLzDrh6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Dec 2018 00:07:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43BCRT1lMvz9s8J; Sat,  8 Dec 2018 00:07:01 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 8d4a862276a9c30a269d368d324fb56529e6d5fd
X-Patchwork-Hint: ignore
In-Reply-To: <1541697162-1926-1-git-send-email-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/xmon: Fix invocation inside lock region
Message-Id: <43BCRT1lMvz9s8J@ozlabs.org>
Date: Sat,  8 Dec 2018 00:07:01 +1100 (AEDT)
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
Cc: Breno Leitao <leitao@debian.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2018-11-08 at 17:12:42 UTC, Breno Leitao wrote:
> Currently xmon needs to get devtree_lock (through rtas_token()) during its
> invocation (at crash time). If there is a crash while devtree_lock is being
> held, then xmon tries to get the lock but spins forever and never get into
> the interactive debugger, as in the following case:
> 
> 	int *ptr = NULL;
> 	raw_spin_lock_irqsave(&devtree_lock, flags);
> 	*ptr = 0xdeadbeef;
> 
> This patch avoids calling rtas_token(), thus trying to get the same lock,
> at crash time. This new mechanism proposes getting the token at
> initialization time (xmon_init()) and just consuming it at crash time.
> 
> This would allow xmon to be possible invoked independent of devtree_lock
> being held or not.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8d4a862276a9c30a269d368d324fb5

cheers
