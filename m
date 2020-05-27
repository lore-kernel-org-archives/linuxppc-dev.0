Return-Path: <SRS0=LEFZ=7J=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921BDC433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2020 01:15:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4C0F206F1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2020 01:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="hE+HTJKZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4C0F206F1
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49WtDm4Wd8zDqHP
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2020 11:15:36 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49WtBJ4ZTTzDqHP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2020 11:13:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=hE+HTJKZ; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 49WtBJ2Wtrz9sSc; Wed, 27 May 2020 11:13:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1590542008; bh=oddGijCvExLxTfctJGGD9faXPFlbhlo4btxKmUAaMow=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hE+HTJKZuQThboNSOyOWBAMAbuRtHu/qjydVkBKv5fwsvg7H33Z41hsFgLn705RR2
 p5iC6HJKAsGc4YRrVHXrkU57BEUiLMPSb+zyFtOr6Jx8zMG6yMYK+tQfi8l2QB94Iy
 efb+d6hLwlDZ0NDfuDmn/Tv0+jDgwMdkthW4oqUcHj8csSOQVmFn9iAL44LjRBMl9A
 9qcwOsNSib1t24NzuhOqXcMfchtYRmDr6lyZS/5MZ+tsQr0MfBdorH38Z4sTSCbpMT
 bsdQfqhKwizsDYOMjZsaKIq8YxTQF6902dA9AV/odVIfNtORjw+DwUMDiubOP6ZLqT
 bgJus6Q/e4pZg==
Date: Wed, 27 May 2020 11:13:23 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Qian Cai <cai@lca.pw>
Subject: Re: [PATCH] powerpc/kvm/book3s64/vio: fix some RCU-list locks
Message-ID: <20200527011323.GA293451@thinks.paulus.ozlabs.org>
References: <20200510051834.2011-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510051834.2011-1-cai@lca.pw>
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
Cc: paulmck@kernel.org, aik@ozlabs.ru, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, May 10, 2020 at 01:18:34AM -0400, Qian Cai wrote:
> It is unsafe to traverse kvm->arch.spapr_tce_tables and
> stt->iommu_tables without the RCU read lock held. Also, add
> cond_resched_rcu() in places with the RCU read lock held that could take
> a while to finish.

This mostly looks fine.  The cond_resched_rcu() in kvmppc_tce_validate
doesn't seem necessary (the list would rarely have more than a few
dozen entries) and could be a performance problem given that TCE
validation is a hot-path.

Are you OK with me modifying the patch to take out that
cond_resched_rcu(), or is there some reason why it's essential that it
be there?

Paul.
