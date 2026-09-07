Return-Path: <linuxppc-dev+bounces-26695-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A057EC79F99
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 20:54:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdzpk5DgXz2xKN;
	Tue, 08 Sep 2026 06:54:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788814494;
	cv=none; b=ScdWrG7lwad0hb8pyVfQA3+1H38u8yVE4MRT6d4SyCdTDUQMpWDjZ8XphyNX8oP6cky3JSDPfzrqq4DfMkOpjGcuTJJ1ES4asHf3ubx39+WcMU9L1MJaMAXwg/z3DbXRLWJLYRaoUTEaMmqEQtTTr9d2Oa8mMckonRx07QeFaIakIkdrAXFVwyW1v7XuVOwrair6k+3ujes+6p+Z7Pg1SsqTt509GH1pPHGPAKROY2XNBWYp/JJ/puNVnQ8y9mf8ea4X3s4PfK5FJGF0AUuwFsZShh7Z0AAi6SGGhOryGZLTanW7xYPWugUOik8BHvJSS3y1LsQMIQGpFxkXLpG3ig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788814494; c=relaxed/relaxed;
	bh=xd5tQKQxHFRGotFcOXdpLOZw0W1C2jHEVuOQdyASEiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JgY/vBQgkpjCC8EaAPO8yMb5z/2dNtIGFTf6B7u6BJLzpt54RaSt27JV+4h//hoqd8lI1w4RVani0TD0BEBpsqM5W3Hlm1OOKmXKJsbnn+uihSxTVC+Y3WnD35GwoLqsAA0pVUruU7V3DDT6utDxxZiDU6JXwTi5OYkq9KG/DWXzDD+sp7gPHLNYR2dItQBi3WHrVpaLCvedmnjg5wTdvqwHi83mzFAaw0MxE5g1yXlGkgNmkkhgMdTXBNqFohdul4wbQ0/Fkdb8P/HYooS7KeAGQIgzag0TTmh9U+1nUhYLgWHo3TlrdHNQk2Ney7hPgqmJPybVIl9F08/XN1DHCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dRIpg4+c; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dRIpg4+c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdzpj40VXz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 06:54:53 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 97C67601DB;
	Mon,  7 Sep 2026 20:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63AC1F00A3A;
	Mon,  7 Sep 2026 20:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788814490;
	bh=xd5tQKQxHFRGotFcOXdpLOZw0W1C2jHEVuOQdyASEiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dRIpg4+cjz/LJPp8MxUEYl3ZCRk1kb+/hn7o8I3Rc1wGT/1J2IDbk56aw2K+lcBac
	 yafINQoKso2O6Q/7xNS4cbMVeKmgKpR3qfHSPYrxL/4/+TsLwDUiw3lU5lZdf+FQSZ
	 TKZnGZDqoaY9J8/k/mYa9qHtG71FFF0iDyH9O9gH0LKfTVdRET2SUkCn5mhuzKDJ6K
	 0SnAmUCtjFC/VxPqlUrqMpAH8Znz1bVd4yCuA9BnM2FyQy0loCHmm+j48ko7R2MRTw
	 LMnx/hVUyDicyrMmJODphzbjIwSoN8rGjkzUGA4CuCM74CRBxnXyeOij3pfIqHFlT7
	 Lsd0SKDWI2ilg==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Qiang Zhao <qiang.zhao@nxp.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] soc: fsl: qe: Fix sparse warnings in GPIO
Date: Mon,  7 Sep 2026 22:54:35 +0200
Message-ID: <178881446326.32908.2707847448430333820.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <6a84b38e766729676b375c93bf54c67ea455288d.1786080840.git.chleroy@kernel.org>
References: <6a84b38e766729676b375c93bf54c67ea455288d.1786080840.git.chleroy@kernel.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2343; i=chleroy@kernel.org; h=from:subject:message-id; bh=6z7FgiQsA83jfG1X90ruIg/3wydjhrS28CflV2+zQjk=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWTNV+n3Z41iYHt67/Gh932K3ulPhB07Lqy7cM195tIEM U3/3+8udpSyMIhxMciKKbIc/8+9a0bXl9T8qbv0YeawMoEMYeDiFICJvF7G8FcuXuXU+Ve+axhf 63c8L41hj42PT376i7mr7Z+DbHfVFS9GhinVXzsvdkidUdg9aVGx7K4Sjalf53MeLXHd5mFqEj3 /Nj8A
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Fri, 07 Aug 2026 07:35:52 +0200, Christophe Leroy (CS GROUP) wrote:
> A C=2 build on mpc83xx_defconfig provides following warnings:
> 
>   drivers/soc/fsl/qe/gpio.c:44:34: warning: incorrect type in assignment (different base types)
>   drivers/soc/fsl/qe/gpio.c:44:34:    expected restricted __be32 [usertype] cpdata
>   drivers/soc/fsl/qe/gpio.c:44:34:    got unsigned int [usertype] cpdata
>   drivers/soc/fsl/qe/gpio.c:45:34: warning: incorrect type in assignment (different base types)
>   drivers/soc/fsl/qe/gpio.c:45:34:    expected restricted __be32 [usertype] cpdir1
>   drivers/soc/fsl/qe/gpio.c:45:34:    got unsigned int
>   drivers/soc/fsl/qe/gpio.c:46:34: warning: incorrect type in assignment (different base types)
>   drivers/soc/fsl/qe/gpio.c:46:34:    expected restricted __be32 [usertype] cpdir2
>   drivers/soc/fsl/qe/gpio.c:46:34:    got unsigned int
>   drivers/soc/fsl/qe/gpio.c:47:34: warning: incorrect type in assignment (different base types)
>   drivers/soc/fsl/qe/gpio.c:47:34:    expected restricted __be32 [usertype] cppar1
>   drivers/soc/fsl/qe/gpio.c:47:34:    got unsigned int
>   drivers/soc/fsl/qe/gpio.c:48:34: warning: incorrect type in assignment (different base types)
>   drivers/soc/fsl/qe/gpio.c:48:34:    expected restricted __be32 [usertype] cppar2
>   drivers/soc/fsl/qe/gpio.c:48:34:    got unsigned int
>   drivers/soc/fsl/qe/gpio.c:49:33: warning: incorrect type in assignment (different base types)
>   drivers/soc/fsl/qe/gpio.c:49:33:    expected restricted __be32 [usertype] cpodr
>   drivers/soc/fsl/qe/gpio.c:49:33:    got unsigned int
>   drivers/soc/fsl/qe/gpio.c:297:17: warning: restricted __be32 degrades to integer
>   drivers/soc/fsl/qe/gpio.c:299:17: warning: restricted __be32 degrades to integer
>   drivers/soc/fsl/qe/gpio.c:302:17: warning: restricted __be32 degrades to integer
>   drivers/soc/fsl/qe/gpio.c:304:17: warning: restricted __be32 degrades to integer
>   drivers/soc/fsl/qe/gpio.c:308:18: warning: restricted __be32 degrades to integer
>   drivers/soc/fsl/qe/gpio.c:314:9: warning: restricted __be32 degrades to integer
> 
> [...]

Applied, thanks!

[1/1] soc: fsl: qe: Fix sparse warnings in GPIO
      commit: 5af2ccc8ec749d98d3d0bed4b9df25781d7f2d46

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>

