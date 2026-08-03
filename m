Return-Path: <linuxppc-dev+bounces-25262-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102FCC55184
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 13:05:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDH3B2tt4z30FB;
	Mon, 03 Aug 2026 23:05:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785762326;
	cv=none; b=WGq0SgUBK7050CqKQ9+Afezthn0wKIpL5x2udS7Z2RrAVLLdg+aowgSpjEoWmXTNr1kF6BHMEORpgsWjqYc1T5im5Fy7DOB+Q0mIHd8wiSWm/KhKQSPxXMUq9IgbxvPUNSVxFUpccou2yjT872G35DLdZubAcQuD0QBJKgnW8szZgCd2YqxImC1c1wAkmA11fTzO9uQOIy7B9tUnPjyYjpO1hWzoS4rQ+jkFYzw4HeQICOGCxe5nLpoHP8+lTtwU4+OQBtVMuVUnZVL5Om6xEeSXQRn1rA2shlOleBezC+fz4yBRczvc9cqdBiEGPZwOkuRkAwuf73iCTUxBwTVzfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785762326; c=relaxed/relaxed;
	bh=7hDoNt/IcI8UVVVhiKmtR1oyxN5TwwRmY+NA64nR1NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/SIra6UvYJGS5rPL2JWrB5xfGy+sxllGOgYAz6pIRi9JV8xsox/FBtsahaCKxCwHzdwGX8XU7g/kA5+e2t06VJqeLtB71mtIDpmqTgbhN7fcJ39hOo83tKWQliKMIu1vNpl4jQZyR4lPmbYbYIdGHlAxbGC7yieP3LCsaaIAx6XTM/9e82HC8z3tCXPDibJSiXvhgwt1/NazRHf0lPeiunVRPnN5U26hPyykWwIgorw+lEKJL8MbWuYSdD2vTQsDBXJOjqM4VzakOX8d2JNGXqIe563THzJmVjucTu+L0ZPFUWnx9BrLV4NVZv8q/J1I08Rg1l4qKEosrRvu1+UUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eI1wyjTy; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eI1wyjTy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDH394z4Xz30DH
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 23:05:25 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6A4C840972;
	Mon,  3 Aug 2026 13:05:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4751F00A3A;
	Mon,  3 Aug 2026 13:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785762323;
	bh=7hDoNt/IcI8UVVVhiKmtR1oyxN5TwwRmY+NA64nR1NI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eI1wyjTyDaq+cllojo2voNxq3bu5QnmjEDXc4NG4TZQPFi0s0UANd85KOnW+maRRG
	 e/2O0I3bo0jengfKVSlJRVi4dbABu9MU+VIsqMMfbMBLyijc6net4bkn9NT0y0nbSc
	 uZG4dsQ/ls2zwl5y6CSM6gygxmxb1MMYVdOdYpqFWoGWVsQ+QA8s+p+vx9F4C1J1Bw
	 ucUgNRmoHAVluJsf8+imsxxWx5VyXHTmqQMwvtpr7Z9L3dP8dj5Su9tS6uMaJGyS+G
	 1Ut/7tndLob2Nd4QjLrXEzJaKNNPTOPGUmgH704MvX/NCePT+R7H/sJ2nB1lehEX7G
	 1HiUDuN9Qcpsg==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Paul Louvel <paul.louvel@bootlin.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2] soc: fsl: qe: properly scan GPIO nodes at startup
Date: Mon,  3 Aug 2026 15:05:02 +0200
Message-ID: <178576221779.155079.3783262414291581671.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <a1db12ef75bf881dd5fba893a37db0c8517eca1b.1785414349.git.chleroy@kernel.org>
References: <a1db12ef75bf881dd5fba893a37db0c8517eca1b.1785414349.git.chleroy@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=666; i=chleroy@kernel.org; h=from:subject:message-id; bh=C36mAtGFRBt/txt5qECqtJJPOORfncKwPxMA1G8HePA=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWQVTGJlkJj8ePrJ83c+ac112PQswufDnWz2u1+l9tbsD XHS3Z+R21HKwiDGxSArpshy/D/3rhldX1Lzp+7Sh5nDygQ2hItTACYytYuR4bytl/Fm//wjEywq eD4+v+YzI/J+2fZTM1+dK1/EOcsubT0jQ78cl3/8Qt9j/9fO9dDr/dRv+sto9w5b1rzl24WyxZf qcAMA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Thu, 30 Jul 2026 14:29:36 +0200, Christophe Leroy (CS GROUP) wrote:
> Before commit 156460811def ("soc: fsl: qe: Change GPIO driver to a
> proper platform driver") qe_add_gpiochips() was walking the device
> tree to find all nodes with compatible "fsl,mpc8323-qe-pario-bank".
> 
> After that commit the discovery is handled by the platform core,
> therefore it is necessary to call of_platform_default_populate() on
> the par_io node.
> 
> [...]

Applied, thanks!

[1/1] soc: fsl: qe: properly scan GPIO nodes at startup
      commit: e2414b289c2b68afab361def612ca3791cd70d12

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>

