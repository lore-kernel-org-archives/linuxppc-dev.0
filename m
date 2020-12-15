Return-Path: <SRS0=AMrL=FT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD8AC4361B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Dec 2020 02:21:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B43C22078B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Dec 2020 02:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43C22078B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cw27Q45w6zDqNp
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Dec 2020 13:21:22 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cw20y1nZCzDqN6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2020 13:15:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=Yv2FoYZu; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 4Cw20x6HjXz9sTL; Tue, 15 Dec 2020 13:15:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1607998545; bh=2lgDKiBTAfEfH0fC4r8Kmj22YXnO34qEjBvuwUv+ofs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Yv2FoYZu9pG2zmCqdlHxwqktpHm+z40MP9k1xeOAN5+0xWYWVUcJKNyLecEy+szDx
 JXNZ5tTdhViXl1k4Pp3fB+IWwucG9Y7aQKynf0cEOO96oeb/2ogiSKb7yvnh2Hn3XM
 p9fgLVIALhZeClek9Onw/lj+RsZtXhX+3d8BHaulrerUcR4/lg03xAskroKhy44T26
 c+Y5prCjy51cCjnyKb3SVO/0xPsSwX5YLdlkXnLCuXqE5mJitIyFzOGn2L5MVaWq+A
 G20TC3lVWMipBTmyj6S8rNgKQ2yQsRwY4k75jPRCjddVjvB/kzA/oLUcd7GQNZpo50
 4ikACvhnC4G6g==
Date: Tue, 15 Dec 2020 13:14:15 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: xiakaixu1987@gmail.com
Subject: Re: [PATCH] KVM: PPC: fix comparison to bool warning
Message-ID: <20201215021415.GA2441086@thinks.paulus.ozlabs.org>
References: <1604764178-8087-1-git-send-email-kaixuxia@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604764178-8087-1-git-send-email-kaixuxia@tencent.com>
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
Cc: Kaixu Xia <kaixuxia@tencent.com>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Nov 07, 2020 at 11:49:38PM +0800, xiakaixu1987@gmail.com wrote:
> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> Fix the following coccicheck warning:
> 
> ./arch/powerpc/kvm/booke.c:503:6-16: WARNING: Comparison to bool
> ./arch/powerpc/kvm/booke.c:505:6-17: WARNING: Comparison to bool
> ./arch/powerpc/kvm/booke.c:507:6-16: WARNING: Comparison to bool
> 
> Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>

Acked-by: Paul Mackerras <paulus@ozlabs.org>
