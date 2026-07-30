Return-Path: <linuxppc-dev+bounces-25082-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DEA2C55166
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 08:14:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9hnH265yz2ynn;
	Thu, 30 Jul 2026 18:14:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785399267;
	cv=none; b=VIwLQk/YcH4CJNukoKUgKZsRwtJOQuCubAMtEAFxBqQTvWM0fgCMFOxWLN6yb9airm6QMuCrGMcRS0E16tc59jI1ge1Zs9lH0jv1MHH7zFFaH2k0YJ2djoQy2eXlwR66at/m3r3RqAjYXSRon/wbctaDyXC3NBjG4UCgHSs/+FB/GbNWTAYLtwUyTiFS6oob/jWuO2WL3u4AD6rLzutHork615hAd5Yas/vzALXnjBSCq3N7v5+sHD6F0fQ9gLVq7zil+sYhZFvpjGm530stFWujQrFlBIJ3ZwuAgE3vL0NnwkaUzlo8+6asRgQU2xzVKRBDKuWl96M30e0R46RV7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785399267; c=relaxed/relaxed;
	bh=UuuLUuawaayCJVuDTZJqD2lNszQ3OigHxJNv3y24qV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RpHliT+NIv3m4qdhXgnmJ59lwSh+hW3QdQbfoEv0Z4rBrST5y8IF//sXqMTlu4CDEOkNyZFCWtzPByq/8HfrmGOZkMlmbguhdoE39joo8yQbq0RQMTBG8hgfbEaM+V67NZyyljJYax7AUCPT6gJWXCJGmyLfDcewt5vYdCQx8qJ6JzP2BEREUKTQy/ukidjc8qFbq67Q0oQ4mVrq5P22n90YMHXylHeTpDmZ2/3rpKK69YoykhDe9ThB7vzcMm76J/sqvsH1dKEMfhKGRIbNBYjd8lQ2H7GevyLbTYzNAryy7gb/4vbxbRmKL34byemAohJzCgDiAHYsJQq8178Qig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nxhmCqfP; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nxhmCqfP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9hnG5RDNz2yhb
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 18:14:26 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9CB8343BAC;
	Thu, 30 Jul 2026 08:14:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1241F000E9;
	Thu, 30 Jul 2026 08:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785399264;
	bh=UuuLUuawaayCJVuDTZJqD2lNszQ3OigHxJNv3y24qV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nxhmCqfPlK6UIWU1sS5+Y0VftkpBIE8Ngc3sN/jyWeajNWkVM92b4eVd5W3b0I2bu
	 Jvfx9dydDPVeP7cxzwIlz02k0S/VfP249AjJAXF/+uSa2SXRt0zK54bGV7a2wZ/Q8a
	 lAiHC3O6+PkkIH9PRWhpyValH149fYsCqMIfVRKRg6sPLcQGl8XDFQLQGwj/d12X+l
	 9bIiTPEEbealMSLyWzZ578tcajeDUSjdlLXN3sDQQg6Tzl2EzVsG7SrDdLIvyTe8di
	 QRkzR//8kMILjAXdfcdNzquVFiT6r9SjZ+Nwwmqs6N1VAC09tvgN+5kAnOcW+z+ZOS
	 OPUxFmFnDfppA==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Cc: Christophe Leroy <chleroy@kernel.org>,
	Li Yang <leoyang.li@nxp.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Frank Li <Frank.Li@nxp.com>,
	Guanhua Gao <guanhua.gao@nxp.com>,
	Roy Pledge <Roy.Pledge@nxp.com>
Subject: Re: [PATCH v3] soc: fsl: dpio: fix kernel-doc typos
Date: Thu, 30 Jul 2026 10:14:05 +0200
Message-ID: <178539922196.574381.15816296584474390241.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260728004938.905415-1-rdunlap@infradead.org>
References: <20260728004938.905415-1-rdunlap@infradead.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=291; i=chleroy@kernel.org; h=from:subject:message-id; bh=By2W1VB8mqUfqZp8DyWN2xoLqcwcwcJYHG2/1C1d5oE=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWRls1+UWSJ805g7qITJoCnmbiWjSpAi3/HSPyK6K1MTf K7PL+bqKGVhEONikBVTZDn+n3vXjK4vqflTd+nDzGFlAhnCwMUpABNpZGX4K+wTonSe05RLK3tD 2Yn9a3ZX8F5Us0rvWssfMnl7tu0dJ4b/oW3fy+cp79E3/PnQOnbR5ci5cqkHNs9v37Rh7y9vuTZ xZgA=
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Mon, 27 Jul 2026 17:49:38 -0700, Randy Dunlap wrote:
> Correct spelling of 2 words.
> 
> 

Applied, thanks!

[1/1] soc: fsl: dpio: fix kernel-doc typos
      commit: 13dadf4581f774180665083c3342a3928dbf677b

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>

