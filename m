Return-Path: <SRS0=ebxO=4H=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E41CC34047
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Feb 2020 12:47:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB10A24654
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Feb 2020 12:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB10A24654
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48MyD712lrzDqD1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Feb 2020 23:47:19 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48My3Y2hFczDq7j
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2020 23:39:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 48My3X74HJz9sSM; Wed, 19 Feb 2020 23:39:52 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: d4f194ed9eb9841a8f978710e4d24296f791a85b
In-Reply-To: <0547e82dbf90ee0729a2979a8cac5c91665c621f.1581051445.git.sbobroff@linux.ibm.com>
To: Sam Bobroff <sbobroff@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH 1/1] powerpc/eeh: fix deadlock handling dead PHB
Message-Id: <48My3X74HJz9sSM@ozlabs.org>
Date: Wed, 19 Feb 2020 23:39:52 +1100 (AEDT)
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
Cc: fbarrat@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2020-02-07 at 04:57:31 UTC, Sam Bobroff wrote:
> Recovering a dead PHB can currently cause a deadlock as the PCI
> rescan/remove lock is taken twice.
> 
> This is caused as part of an existing bug in
> eeh_handle_special_event(). The pe is processed while traversing the
> PHBs even though the pe is unrelated to the loop. This causes the pe
> to be, incorrectly, processed more than once.
> 
> Untangling this section can move the pe processing out of the loop and
> also outside the locked section, correcting both problems.
> 
> Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/d4f194ed9eb9841a8f978710e4d24296f791a85b

cheers
