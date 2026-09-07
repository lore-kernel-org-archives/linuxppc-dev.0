Return-Path: <linuxppc-dev+bounces-26696-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F21C79F9E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 20:55:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdzpn5KZYz2y83;
	Tue, 08 Sep 2026 06:54:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788814497;
	cv=none; b=H2X4WG5g/ysqpj57vOVbyfX2uJTGOtmAQ4+D/oCEvyB8hAy2agjFcTkGRxt2hfRMRwuMy6lslLR6HJSJ0v6JDXZ/iQzfHNnaKAp1BKH5ER/Y7YRb7sacqI+X92Bb+6Q8PFoSWF9JkZyQU+abuXrjN7+7FIiHoaDFUZuN7+sI0FjG/ws4gMNFKkxrg3+vq7jusb6qEHqbLtLgnl+Zohnv7L5iiTrJa4FFYkxyjbXexFr/ujX0nh4h7Zm4q65YPzuNSrmgsMQ5T22+TcgT29GuzWwcsgGBbuw7ElS0gdZblIT324S4xL5Tf9EHsZvjJXRDOOpaEqnu6zWgSWhvdRpLVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788814497; c=relaxed/relaxed;
	bh=FgoYoVZdcP9kjl2wNHg9gnlsTZhvaykO0axbADxgLJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gWizjxT2F/Nmsii1OhcpItE9dx80zX1XoZnSD1XjFwVTtjl6GuP8HCVzOVRQHxEFD8U/DhjYte1cYLBimKGVHbArBKPcZOyaLWCkbANuLzHJBLaj47rOfr5PEXWxYGrrE7z1O5/UpHRhMWxoLwsrBnzGMoWN/vq6sV/zMQzSG5HbOUVQM3jGYfLqeUzyDe9r860zICjslVP4ta9o7ndI94/yBH/qtPNFlheh+ZOwcgLta/aTgRFcZiZDwlEdhZj/0hHAs/NTOAz7fcx47mOqlM9HSwL6aX2oSHShYcLJG0nDjMjEZgBglE6Cy6/qrenGQtyxyoYm7ubaRp8C6fp0MQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z4FETxB0; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z4FETxB0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdzpn0CCwz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 06:54:56 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 530EF601FB;
	Mon,  7 Sep 2026 20:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D451F00A3D;
	Mon,  7 Sep 2026 20:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788814493;
	bh=FgoYoVZdcP9kjl2wNHg9gnlsTZhvaykO0axbADxgLJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z4FETxB0RgG54eaNNPhjCZ7ewA2helATk7xF4l4Ulxg1+f6KPsttv+y5GMJlao3Cv
	 IwQtVkNSyB8wYkQUCibA7FJqcy+7Fp+qwjfBtKt22/akKKh0+53IA4BlRehlJrWxF2
	 /j8x7W01gEM5cqb2DaECFoO4UdXHuKCPReXftDbQLfSuoQxLxXnhPyZzf5Ig4bKSDf
	 hXr6IWcl2iTJOtpf8QkJQt0VR6q/79OSjPbj4EOoh5xjhT1eXqCO7Y7lu3CYP6Pfml
	 CZohrRzSSNPcTfasUyJLKNgTvRyX2yVX0kbSSGgGdFeS0GaOHDMC+yF/+bsVCzia2l
	 gN4lhThYKK9WA==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Hemanth Selam <hemanth.selam@gmail.com>
Cc: Christophe Leroy <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] bus: fsl-mc: fix repeated word 'for' in comment
Date: Mon,  7 Sep 2026 22:54:36 +0200
Message-ID: <178881446327.32908.13049803708638296590.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260904124540.7652-3-hemanth.selam@gmail.com>
References: <20260904124540.7652-1-hemanth.selam@gmail.com> <20260904124540.7652-3-hemanth.selam@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=397; i=chleroy@kernel.org; h=from:subject:message-id; bh=kKWlvlmIFd+90igX+YxUUgDgdw4Cabj9IAKtxaYDjek=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWTNV5my/lfYVy/FnxwSn/p2agbNO/l8yRSF1VlKNecMN kovtPQ411HKwiDGxSArpshy/D/3rhldX1Lzp+7Sh5nDygQyhIGLUwAm8teOkeHalh+Ftb4CL02l TndrVlVp5ESGMmbfmsejtzto/dWkKWqMDBNc5ltX9O7WOtErrOE398Ql6eUtk+U+PJ/LdOTK4xu xnuwA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Fri, 04 Sep 2026 18:15:36 +0530, Hemanth Selam wrote:
> Drop the second 'for', reported by checkpatch.pl as a possible repeated
> word.  Only touches a comment, no code changes.
> 
> 

Applied, thanks!

[2/3] bus: fsl-mc: fix repeated word 'for' in comment
      commit: bada60f2d98c7cf252b1f8214e5b6ec96c429588

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>

