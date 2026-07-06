Return-Path: <linuxppc-dev+bounces-23597-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A633C43602
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 10:37:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gv14p6nMVz2xF8;
	Mon, 06 Jul 2026 20:36:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.72.192.78
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783334218;
	cv=none; b=JyWKZlamWIt3FK1J8nkBslIIK1s92gVxRAV/obOCInJ6JqLOwGFbQLSCL/oL3ONlsdhq9r2GsRRkhK38W6ovwC+ZVyOifeAgtgq0O4EwX1ES0z7iW1ERfwpuhqYHymo2HBGfqvy1kLWKOBWXMEuAMiMFgZgLj1ChoKed3FYZXk03YgM7XVJ+Nsm7J09VEkcyDWtz2SxwUloUv/sxTHllvYJzr2uHZb40Sv3iASnamhr45lGpGpFXeEcLzkSZriRE53f0U2gLo3CQUFqrv4Q1/rPcaXxr6zWgR/OjeZvUU32GnWvh4o3rR65BSTOjgo5AjbLspWubYbDduT2lyy/y5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783334218; c=relaxed/relaxed;
	bh=7A2rhBxioWj2PaxNXPn6yvk4GKrfsjbqJATcmAMau+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rl++VvaFnbQIrCWDDeCCakdOoX1N0mQVU79BttWUOilC803eTePy1aaeECp5B3w13eecJIunb9Y/T6DjcI5y8zKE3ixCs+Z1BGKN9yqJ1KZnickZthIwepnJ+s2a3HVAq7+J1rqc/FwXBaErPHsHas4sd6dWrWQ6+6GBiUBdFdSl/236BkYr8fqKh63JftxU8RXLsByfNRptT9WOdcO2VxdI3yScASyPAS6OSUz9MzHkMDUaCZ4IXc9DuJQazl3aJgqj81b4U0dNDiHreI8aQWR/LsTiyS8lwCkVgOT+gNBhRjrhQVe90jOyW9B6271HgPo9RaFBHW0NNjNx7xzgwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=I3Ic6LmS; dkim-atps=neutral; spf=pass (client-ip=217.72.192.78; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org) smtp.mailfrom=web.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=I3Ic6LmS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=web.de (client-ip=217.72.192.78; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org)
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gv14l2p09z2yVZ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 20:36:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1783334190; x=1783938990; i=markus.elfring@web.de;
	bh=7A2rhBxioWj2PaxNXPn6yvk4GKrfsjbqJATcmAMau+c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=I3Ic6LmST5IsPfhd8N9VoE9j3n7JStUVsPGJThbl6jM6jV81YEicD18UOmGc2/eZ
	 CbHlIlh2d74WIfog4heFyFbdGolZ1K1wjO6bjszl7rTc+U3BflkmwzjPl6SpnuHGm
	 VVQl6jr5ZXy7NbltZwahqzyASObZarO9gMCmiPuxwCJ8ikCSa9OMRQrzobKTwD7sh
	 5OlcKXi8RX7Q09GF+lVDJNIvJZd5slKDYPWMdhWQ1+kwsdJO7ADWwIestG8WtiR02
	 eAavxzzSUTefKNB+pXr8o/moGmbhknsu4MO5oDXcXt+EhYxiMQfh7jMhIqX4HQD+u
	 +9v51qUMPDQE+qMDrw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MUUAM-1wXzWY31Um-00Rnw1; Mon, 06
 Jul 2026 12:36:30 +0200
Message-ID: <d2e5df25-c8b7-4ee6-8ebf-1725542baabd@web.de>
Date: Mon, 6 Jul 2026 12:36:17 +0200
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
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 0/2] soc: fsl: dpio: Use scope-based resource management in
 two functions
To: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Christophe Leroy <chleroy@kernel.org>, Roy Pledge <Roy.Pledge@nxp.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <690827f2-e746-4378-bb7c-9948cd69dc15@web.de>
 <d95d2f4c-f3cf-44eb-b61b-79ba7891674d@kernel.org>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <d95d2f4c-f3cf-44eb-b61b-79ba7891674d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0OQRuWJtae2zVkW0PVzW+PKnWYTUxHEcU3fcy3wZIL0KDV9bffn
 ntMfzNgTSxTVCunDubUGx8lDXujsPdDx/5/UUTOmBy3+TWQZFqhlFmPyBiytPapVt4xjZIq
 tGYOczbzKGzzjFfx0fA3Usa/7wg7S37BXQzum5KfPk91xGt+xrok++tgnOL8L8g3i+MnNNW
 yHD4CNdtRXBk7ZZauGatQ==
UI-OutboundReport: notjunk:1;M01:P0:34DiuDybPuE=;B3EPflfJsRK2XZm3i0fBtKWReUV
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 6 Jul 2026 11:42:10 +0200

Some adjustment opportunities were picked up.

Markus Elfring (2):
  Use scope-based resource management in dpaa2_io_store_create()
  Use scope-based resource management in dpaa2_io_create()


v2:
Christophe Leroy requested to apply the attribute =E2=80=9C__free(kfree)=
=E2=80=9D.


 drivers/soc/fsl/dpio/dpio-service.c | 37 ++++++++++-------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

=2D-=20
2.54.0


