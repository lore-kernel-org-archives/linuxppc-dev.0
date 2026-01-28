Return-Path: <linuxppc-dev+bounces-16354-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B44D3569F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Jan 2026 11:04:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f1KCc5vy3z2xjK;
	Wed, 28 Jan 2026 22:04:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769598252;
	cv=none; b=G5IWi7aKdG9qIKC6C2GTftwZ2XOyjajEnt3aQzpHDNfHK4+yccCwJbUiZYUlYeqIeD1P+cGNux5lhAwai9YmslENVWTDO1Mu1Y5W1+Vja5Dpr6V3L3ojkCzOo6XBQ46nqRo6Smaz/mU+oP9Tl8DVIUNXZglIvriJlb1SnDI69RyUP/4T719D360yLfzuw/GHG1igrUvdxkCG1VG0LbvAj/Eu6Nu02yyrzF8kcybXuNvF8WJkF170LRQhT0NIImPS3lXaQkZgPi9AogV9lkpwk55h5XAV8sQVMHjA8Oz6z857yFmidLCjxsZdBRGqW7jqvI423JEb37QWUB3npyDSBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769598252; c=relaxed/relaxed;
	bh=s7LeXVP7XAGNaq3kzCC9n1xMAwM3zSZ7L4N8NPlKf2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cmKPVaDHuTrAVmfBwkIQfDT4Tnler0ZUo9o/1aXticItvlvR/HfqejmFbkBmGfGJ7TIUOdflk+sltti/05Oo3TIMS6Dk8y/yaIq7PjNApXQp5gb/XabTSMnrSV2lhwcTwe5O9E8gBe+jq1DnmtpRVl/bdjiIRn7iR9/zMNQ3FfkcLBjcvecxm8MqWGwMu87YfCeviWri01qSUpm3nGJygww4LLaYKgqf4zPeUKPKEvLe/xDkJ8haOzlhx3JC6ZYWFYfoGLJOf8eKb4jWqVYQ1Zb8ohZvCQ5t/sRSBCuAJ75y8Mgcb0vSWF/rN76dU1uFJg41B+FEh7sQzYzodkzERw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RkUk405v; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RkUk405v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f1KCc1gTrz2xMY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2026 22:04:12 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3E2956001A;
	Wed, 28 Jan 2026 11:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31454C4CEF1;
	Wed, 28 Jan 2026 11:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769598249;
	bh=g+DcgaV9vvajzIjNngoxQZBjOrt714zE+t0gjBetTQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RkUk405vHf2xBFoT/TUH5O1r0/VcIUy5lvckzSbRkQ5wmvNzLw/9bCxUsbVn5BDJ/
	 Ig8Sn6SwqT1wR9/FijXtQBpZzQBdx3uvq1AVBeNL82EKaRAgBJOdBQM5CzTtVn7K2J
	 yCx6nZRUxqj7+rRAcRI2G2sGn2CWpIRHa9G+tPl+XAgdYUB4a2ceZgpqimGHPJ5ReV
	 JkzAKWhToYM4q4C0ZC7+quoWk+yi7oSYEueF/zs+yYkFESlUYLEUtA07bxBCFCtxIo
	 EKSjgSTMELRCCrbRpiaxrPo1bBsnSmyz5/U6BThs2WP6WLiH0OEsiQ+Vl+wyYLUEPo
	 pqBJTTXh7Ffbw==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Qiang Zhao <qiang.zhao@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] soc: fsl: qe: Add an interrupt controller for QUICC Engine Ports
Date: Wed, 28 Jan 2026 12:04:04 +0100
Message-ID: <176959816683.2069840.8945134159377635375.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <63f19db21a91729d91b3df336a56a7eb4206e561.1767804922.git.chleroy@kernel.org>
References: <63f19db21a91729d91b3df336a56a7eb4206e561.1767804922.git.chleroy@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=622; i=chleroy@kernel.org; h=from:subject:message-id; bh=XGgvbaf5H9k+ateqB29Q3mR73UZredPzMwVmw4XGytU=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWRWvlU5F3urWPzNmlPsYTkWh2/ovPF+vkpiKi+zdejEI 0HS8w2cOkpZGMS4GGTFFFmO/+feNaPrS2r+1F36MHNYmUCGMHBxCsBEvn5mZHh2d1bp5UnpBq4B LW6rlqz6VfdIquXBrdC5H1Yv1HZRv3SCkeFNa9Svrk2rHq0suegcUaAu9VfmfYDsKpfszhwJ4/x 3+TwA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Wed, 07 Jan 2026 17:59:09 +0100, Christophe Leroy (CS GROUP) wrote:
> The QUICC Engine provides interrupts for a few I/O ports. This is
> handled via a separate interrupt ID and managed via a triplet of
> dedicated registers hosted by the SoC.
> 
> Implement an interrupt driver for it so that those IRQs can then
> be linked to the related GPIOs.
> 
> [...]

Applied, thanks!

[1/2] soc: fsl: qe: Add an interrupt controller for QUICC Engine Ports
[2/2] dt-bindings: soc: fsl: qe: Add an interrupt controller for QUICC Engine Ports

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>

