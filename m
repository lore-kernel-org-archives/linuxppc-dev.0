Return-Path: <linuxppc-dev+bounces-24873-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED94C531D0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 10:20:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7vjZ1d9dz2yhv;
	Mon, 27 Jul 2026 20:20:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785147602;
	cv=none; b=MEu0losB1KEPKlJZonv6DupXSAh1RUKE6Om2FmhQ9EcMRcBQzMZpBkM3cOBsn9XMpsYKSPtt+XMGss6NEP0fktG2Spqa2BHlXjBQGuMBNhgXN4/noFbswpsG6eypEMwCuI8vB3vE44kRegol5vsxAFPARZ9aAuMhqI9Sjcy1W0zKFBMgNVutXHUwKsviwzeybBoKOPMMPId9jujb0NYXFoFtC0nwkMy4mMjO203b4Bno8PChx2xGKQPNIkPn5QWTF/9ZHvgMfj9aLJlYM+yc8QM90SeDA1JrQYpj0R9Zsf/GOozzawcGamUsBB0WPumFaBL/KQf2qaETAA7KmGtGxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785147602; c=relaxed/relaxed;
	bh=bZ3fv38avmtIoGrI2bPGPb4oyGocD7VjuPGceXzIVEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gZt9BXFvcE1OmdI9Mybjz9unz0y3HPQuVraI4PlKUKQwlDry0wzZaPemvZVeP0Vm0Hx2LV/alDLinnDS/rSKm+zF+Qucqedbb5P+2WDpdJq/prF0EvR4ZK8h1TYGhWSBe5HIjm0qLFf2rJ86zUBdaij5i/QRTfC/OsVE2FIAqVog1UXKPPuF0WsPE5kov0xgu2F9+T5ZHqkGX2y8XiGnTkruoBh0peqxpzbqI4VvhUZNQjhyJ1ZMzqSgpj2/xEXx5/Okop2Ro8l4Zypeah22CLGNHRbqqYccVxCENWXXwxP2S3ZNBRVItyIiNaeU2nv7FLYTdTzSkBwhXx2dhFs/lw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KUozUGii; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KUozUGii;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7vjY3xBDz2yhY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 20:20:01 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 912CF601DE;
	Mon, 27 Jul 2026 10:19:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6494F1F000E9;
	Mon, 27 Jul 2026 10:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785147599;
	bh=bZ3fv38avmtIoGrI2bPGPb4oyGocD7VjuPGceXzIVEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KUozUGiiK5t+TuyPGT7xLlRpq4SrGC+bPmDggEaCkgyXLeyETGLOADhgbXSUrS1gC
	 +ToqUfvcHAa3eSzv5QOYckbqJhkjg4n3IeCa/Ls7pLfn48eYHuyFYEgFaUolqx45DE
	 gLHQnEzvyenPXzLyPsN9NxayGXjU1x3wQogsqTMl685hkDRLt4+fdTze9+XEZcT0Kv
	 c0khfbd8haTzAGzdEUpyb8hqkCkBTOKd8XqvPS2iMKh436d8FS6ux9dIZbcsjcuZPp
	 ax8L/X4aNnwUhwJU0efpSmCa7RowHv+PhkE9RESz1z5nrYwuLG+ClQxv2W25vNZVLb
	 6hfSbR5RImTZQ==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Qiang Zhao <qiang.zhao@nxp.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Paul Louvel <paul.louvel@bootlin.com>
Subject: Re: [PATCH 1/2] soc: fsl: qe_ports_ic: Use generic I/O helper instead of specific powerPC ones
Date: Mon, 27 Jul 2026 12:19:53 +0200
Message-ID: <178514758572.65824.17884292892664391060.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <b08f76c1d8ff864774246f1e2c2158c223c001be.1783435914.git.chleroy@kernel.org>
References: <b08f76c1d8ff864774246f1e2c2158c223c001be.1783435914.git.chleroy@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=508; i=chleroy@kernel.org; h=from:subject:message-id; bh=n/NvQ0oVtsmjhJMLoUInodMPJjVmFQM7q4EHR5DfIFg=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWSlG5w6rqzPkz115u9AkWmpn+8H3vffupT3e9PGkxHtU 94dXdIj3VHKwiDGxSArpshy/D/3rhldX1Lzp+7Sh5nDygQyhIGLUwAmkvCS4Z9Wtdr3yp5TZ70W PGVb9/2YwfJTjVpWXt2//h1Rdjlc8389I8OjI9IhC55ZHHee5B4o3L36wTLO66/cW2z1uFct552 x04QTAA==
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Tue, 07 Jul 2026 16:58:14 +0200, Christophe Leroy (CS GROUP) wrote:
> Use ioread32be() and iowrite32be() instead of in_be32() and out_be32()
> to allow build on other platforms than powerPC.
> 
> 

Applied, thanks!

[1/2] soc: fsl: qe_ports_ic: Use generic I/O helper instead of specific powerPC ones
      (no commit info)
[2/2] powerpc: Move CONFIG_QE_GPIO to SoC
      commit: 6599935a1e4be0354326086ea6c73dcb8f43b881

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>

