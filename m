Return-Path: <SRS0=sQnj=EY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924F1C5519F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2020 04:34:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0AA4208DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2020 04:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="H4Ag7cfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0AA4208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CbVMB3BmFzDqP9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2020 15:34:14 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CbVJk0J1hzDqdr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2020 15:32:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=H4Ag7cfv; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4CbVJj3rdMz9sSn;
 Wed, 18 Nov 2020 15:32:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1605673925;
 bh=PYR7b1kkiqpNipD37uav8ZocbQLlVtUNySl0le8zHGI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=H4Ag7cfvaD4eSyBsoQaS44SI3sbTZjeiyv3fdlPEFVR55NgxG62vtW1gE5PViqG8X
 1ywpvEU1ekdXwZUYpQ5h9Iguhz7Z4gfTqPE1GYMdU18IVoN8JJYIHIt8IHJOGDjI1z
 bIIdwZ8pGTCmKZXWq/vLm50E9CfwU3oVy0+yKzSNViDYzUkIdlReGVAbK+Gv5L29hG
 RcN5jc9V5jbSH2tgSJrthgeZfS3uF9E61K8gjELgL1Xz7+Veqt6MlNvxSSdYXHbB1u
 s+k5ij7hKCxPOooIM/2pOVf3PzzRXAvNSN2A4FnusTOoduDg2/9Mxo6pXq1JL6XrQE
 PV/iRez0endyA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/4] powerpc/perf: Update the PMU group constraints for
 l2l3 and threshold events in power10
In-Reply-To: <1605069189-2740-3-git-send-email-atrajeev@linux.vnet.ibm.com>
References: <1605069189-2740-1-git-send-email-atrajeev@linux.vnet.ibm.com>
 <1605069189-2740-3-git-send-email-atrajeev@linux.vnet.ibm.com>
Date: Wed, 18 Nov 2020 15:32:04 +1100
Message-ID: <878saz2sl7.fsf@mpe.ellerman.id.au>
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
Cc: mikey@neuling.org, maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Athira Rajeev <atrajeev@linux.vnet.ibm.com> writes:
> In Power9, L2/L3 bus events are always available as a
> "bank" of 4 events. To obtain the counts for any of the
> l2/l3 bus events in a given bank, the user will have to
> program PMC4 with corresponding l2/l3 bus event for that
> bank.
>
> Commit 59029136d750 ("powerpc/perf: Add constraints for power9 l2/l3 bus events")
> enforced this rule in Power9. But this is not valid for
> Power10, since in Power10 Monitor Mode Control Register2
> (MMCR2) has bits to configure l2/l3 event bits. Hence remove
> this PMC4 constraint check from power10.
>
> Since the l2/l3 bits in MMCR2 are not per-pmc, patch handles
> group constrints checks for l2/l3 bits in MMCR2.

> Patch also updates constraints for threshold events in power10.

That should be done in a separate patch please.

cheers
