Return-Path: <SRS0=LDiU=PI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C663BC433EF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Oct 2021 13:30:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 336926128E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Oct 2021 13:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 336926128E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HZBMF5nkJz2ynf
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Oct 2021 00:30:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=c4avvLs2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=c4avvLs2; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HZBLY1gl7z2xsv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Oct 2021 00:30:13 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPS id 9CC2261361;
 Wed, 20 Oct 2021 13:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634736610;
 bh=6I3JhA8kct0T7Sf/e1uYQ89v6jVxVnPog828pVq1ED0=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=c4avvLs2rSalsFpmSKmdSBaqRxqgBM5BIxrKqqT0kKh1c44t0k1JlJN4MhU8SfXR/
 HPSgPQblA83SnofKc0ibeI1SnNikJKw63GjOtTixPN/ZFmVe9V4D4HpLYr7Jx3l7/S
 AqVXpgrZlIarVq4WgQETbOtxMmvyuepntD/rB7nfmIN2P/LpOp4rcxkQQLhv/jTIXg
 8VEbhFhYjrRG6rcUWhQw1at5ZFiIBPfqkKSLv5HpT2EWuJYSE2Q+O4nAEjpwAZ6dYz
 DmOlNCIH8nG3Yr0tkfe4BaA6NMVQtQkaBVlWeRmfF2xCnr7Acf0o9CtMCKRQKl4Il/
 0+Y2wCpnm1Kyw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2][net-next] soc: fsl: dpio: Unsigned compared against 0
 in qbman_swp_set_irq_coalescing()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <163473661056.3411.12683931306376167461.git-patchwork-notify@kernel.org>
Date: Wed, 20 Oct 2021 13:30:10 +0000
References: <20211019121925.8910-1-tim.gardner@canonical.com>
In-Reply-To: <20211019121925.8910-1-tim.gardner@canonical.com>
To: Tim Gardner <tim.gardner@canonical.com>
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
Cc: netdev@vger.kernel.org, Roy.Pledge@nxp.com, linux-kernel@vger.kernel.org,
 leoyang.li@nxp.com, ioana.ciornei@nxp.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello:

This patch was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Tue, 19 Oct 2021 06:19:25 -0600 you wrote:
> Coverity complains of unsigned compare against 0. There are 2 cases in
> this function:
> 
> 1821        itp = (irq_holdoff * 1000) / p->desc->qman_256_cycles_per_ns;
> 
> CID 121131 (#1 of 1): Unsigned compared against 0 (NO_EFFECT)
> unsigned_compare: This less-than-zero comparison of an unsigned value is never true. itp < 0U.
> 1822        if (itp < 0 || itp > 4096) {
> 1823                max_holdoff = (p->desc->qman_256_cycles_per_ns * 4096) / 1000;
> 1824                pr_err("irq_holdoff must be between 0..%dus\n", max_holdoff);
> 1825                return -EINVAL;
> 1826        }
> 1827
>     	unsigned_compare: This less-than-zero comparison of an unsigned value is never true. irq_threshold < 0U.
> 1828        if (irq_threshold >= p->dqrr.dqrr_size || irq_threshold < 0) {
> 1829                pr_err("irq_threshold must be between 0..%d\n",
> 1830                       p->dqrr.dqrr_size - 1);
> 1831                return -EINVAL;
> 1832        }
> 
> [...]

Here is the summary with links:
  - [v2,net-next] soc: fsl: dpio: Unsigned compared against 0 in qbman_swp_set_irq_coalescing()
    https://git.kernel.org/netdev/net-next/c/818a76a55d6e

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


