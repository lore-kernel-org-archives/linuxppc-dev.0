Return-Path: <linuxppc-dev+bounces-25083-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF315C531D0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 08:14:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9hnL3Tdcz2ykc;
	Thu, 30 Jul 2026 18:14:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785399270;
	cv=none; b=g2imawglFBEGNrSk3CnwXDDU2ZO0yE9ZWNu2aUm3PHZ/wwpiJOKDVWdAu2XueGLKfUpuTlbfkfmjUMAXD22TiwoeoHDk4hqiWElepsvr3xjfUfPK464XLBrjBhAPpAvXNILyGOjYclfqCi3YV5SwyUyziXV1xPb3aOGj+YEvkuZD+gOptmdwaNq26qymJ7jWwvpQv6mWKCurFiD3701i88ga6m2rg2T666Y62r97+xZfTe35Vcv+d/Wj6L+OsXcQ/1hBkWdVWPqK6vsMcoL2Uk8bhBsM53k4PxV3EvPGB1HA1wlveyb0sCznSPgHZBEIah8N8+q9v7hjC9b85OyTwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785399270; c=relaxed/relaxed;
	bh=0awF699iaHXQ7IDP9u+2DZ5xUbh+hdWpBExaW+7TnD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9PvlSPOqd/H8mrdtINlR2hh/DXse0ZvBhJamAl+ahu7B5ptUaJqj8m4eCJ4PiTOh0pctjTDEly/y8+yaYl0a9TImTf4cgiK4TpMxU/0wX9L/Ii5905UgZPJQDKo+wftezC1Whq6OqZDeva5jNeIa68RRDkdvmLNJWQbUlQXYXGFmqxQD32giJPTu6rfHXvrKBstHWijvaRLqYr8dUvs/6iVipT4gONdowVpdst6rkYSd9KN9oBOTGJ57CVA6+IGBb00UVNueRXKFT5yYa/LyGcZ0MeWhDt/pi1/OfNTrEsBxOAJVnI9ZyvvWFKs2+ckGPZMgooXFKZ9uZR95c3iLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IB1TnayQ; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IB1TnayQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9hnK67bMz2yhb
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 18:14:29 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 04FA760A66;
	Thu, 30 Jul 2026 08:14:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9F31F00A3A;
	Thu, 30 Jul 2026 08:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785399267;
	bh=0awF699iaHXQ7IDP9u+2DZ5xUbh+hdWpBExaW+7TnD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IB1TnayQfKNzUBaSupyZ7MbfBAz01gulj3TLGj1Bwuo4lKgvGx8YHjzyhU7ohC1kS
	 IS88Pw70g5y+I9jLmZT91QNmESlJBNxSu0zH/VT1xxEWzs89EDXC5aUlGJdEZjpiHZ
	 2kPipfvUf37NzHe25mNccY87yYPhFmtmBhEOFQpEksjdwAOrbf4qO8gI+/C9U2vO5K
	 czZeIivdczFZV4tqWglofYax+GUGs98XDNzAfkz3zqQb5Zo+kS4Km3mcnfcv2uaofp
	 CS0Gkaz6+wykuKKCRzrrk8b5zbcD0diDq00k4NbwstNy/xnb7Xtx21NmXNH7IWkUCZ
	 e0CFmtwgUK6fw==
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
Subject: Re: [PATCH v3] soc: fsl: fix kernel-doc warnings and typos
Date: Thu, 30 Jul 2026 10:14:06 +0200
Message-ID: <178539922195.574381.190484277984136967.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260728004924.904210-1-rdunlap@infradead.org>
References: <20260728004924.904210-1-rdunlap@infradead.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=498; i=chleroy@kernel.org; h=from:subject:message-id; bh=GI9klVCerpi1vEXP4vDD3h3VHIlMwDNSBV979hEqBaU=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWRls1/0MLJUPOaxyOX63Zkt59eFN55O/r8tTufmET4Ny V8SDaxrOkpZGMS4GGTFFFmO/+feNaPrS2r+1F36MHNYmUCGMHBxCsBEtucx/I++s8h3SvAv8YjJ wnmKN/nLDd9XFkjr8KVsWyAvNTN7zRFGhr1nagQ0Ni0IerpH/tCDr2/Mbiw6+0tWlblvyYlPFxf 7iHEAAA==
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Mon, 27 Jul 2026 17:49:24 -0700, Randy Dunlap wrote:
> Correct spelling of "list".
> 
> Fix a kernel-doc warning by describing the nested structure completely:
> 
> include/soc/fsl/dpaa2-fd.h:52: warning: Function parameter or member 'simple' not described in 'dpaa2_fd'
> 
> 
> [...]

Applied, thanks!

[1/1] soc: fsl: fix kernel-doc warnings and typos
      commit: 2c1e7396f54c39ff0591b15fede6813cc85f5f9f

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>

