Return-Path: <linuxppc-dev+bounces-28094-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B502DC98314
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 07:21:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hr4ys66BKz2y24;
	Thu, 24 Sep 2026 17:21:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.17.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790234517;
	cv=none; b=ExVoqqgL7ZB3lY44dyLBoUMN+BbdHrL+GDlb0BVPJvXDh4IRAD6V3Jd8A6dFGug2WLq7oh5+BaDBkojU+n+VGexqtOgp09iSn5CPppHMYDq3Yc8MCXCwtSVN/ArUs8FIkPKZn0jZNCtnb0v5e5ZvdBdw8Q/SSpxTAVR+1Gg/toDn7EuSSIi6O2J+fkzQUVdvL4weIcj2/gggCBdaNHSZkR5Qy4+pRUrfC18IrmDd+31egrajG1c7ZxVsR2292m9yprtdn1pzOk7xTRywVQbZgMk1BkpTLBBrKTy6pjwEyxycAeNJm+w/qpEkX2keejKM5GDDUmt85b6Ziygk6o7xBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790234517; c=relaxed/relaxed;
	bh=jxxwLEo0BXdYM4pKyZTS7qZZG6NzOJDKgCdnSnZlcjs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=JBOEmR0e8v7bhPqXxE6lyqK3IK5DERjsdvhcfl0jXaNoXcpESaW774h1Dfp3QbKsH/cBuljVGuwwGXAnZtqTsGyZ+EuFkZPaIC+iIV2w9ZrGj8mEwIXQPnAQf51/VnfIiEQJ2cwbtFn6W0bv8J5h70MTKDobm6W2L4mNmpORbL25YFXGfQKkeiEilW6uussDyoFtUj3wnmh0c5gPG1D0pAJdhMPRTNrU2jEzf5JycE7XCejxud4zXHcSMzleH8LLHbQAbywMK3RZo0VudcUVBt3ULDlGF9QoCYiY2A9TyqFQLnuvUUiV86WYeVKdhurg5a2fEA6q3Nenp6CGCp58kg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=TEMYDwjv; dkim-atps=neutral; spf=pass (client-ip=212.227.17.12; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org) smtp.mailfrom=web.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=TEMYDwjv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=web.de (client-ip=212.227.17.12; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org)
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hr4yr0gPdz2xBK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 17:21:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1790234511; x=1790839311; i=markus.elfring@web.de;
	bh=jxxwLEo0BXdYM4pKyZTS7qZZG6NzOJDKgCdnSnZlcjs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TEMYDwjvZK2BCDbNWZvkn0VIPmq3Idb5EkgTDG8g6nOEkG5f5vaNIdXpl8QnK1pH
	 2xQbUw4t/1mmHcuUUXZteAl2F0L4rdFFxXLzKKldgz3fZk5j1GaAJSnXbfpjZYMws
	 HjupsShFBxmyQgq7gfooW1Z1jfdSRLoj9cett7tPi5vrJXnCk4MwgQEk1rjGqnAIg
	 29oy7dNDTcisINXcQZ9Bm6IdB0GKqynBrH3xBvqm4M6eUqmGIHXf9vMYp93aghF7f
	 OrxWmtKBzKx8L3awWK4LQQfBL9m2X4ziBvRdawzQq0XsLtR6DN+3A+dSBHM+xkzMs
	 kGNFRuiwkbJa19sCdA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M1JEu-1xCNVX1hl4-007wKk; Thu, 24
 Sep 2026 09:15:49 +0200
Message-ID: <6c08552a-49e9-4ee0-b1ba-b27e17ade9c5@web.de>
Date: Thu, 24 Sep 2026 09:15:36 +0200
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
Content-Language: en-GB, de-DE
To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <chleroy@kernel.org>, Dan Carpenter <error27@gmail.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Roy Pledge <Roy.Pledge@nxp.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH v4 0/2] soc: fsl: dpio: Use scope-based resource management in
 two functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fq6Aec0o7LQlVtxUXYTHaBJ017F9jCvZsB536K5W3pRurIze04G
 A7Vbqm6a4oM/TTS6B/MP1vR/aR/ZrkVaEAXQ7zPPTgZr2E47nn2iL46ugF8W+xwcLIyBaIX
 N7gO/ldyXV88oMwjdbZE9tNREkhubE1KzTWYeOjc2u3O1jzlLfVw8kbwaaHoH4nYU0hxnCx
 6AvrR4ArN5QWLFCu4U42Q==
UI-OutboundReport: notjunk:1;M01:P0:9PDwbgPzxMw=;Ax98iLBwtNMoa+EC40WlV12oKg+
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 24 Sep 2026 09:09:01 +0200

Some adjustment opportunities were picked up.

Markus Elfring (2):
  Use scope-based resource management in dpaa2_io_store_create()
  Use scope-based resource management in dpaa2_io_create()


v4:
Christophe Leroy pointed out that Sashiko provided hints for further
development considerations.
https://sashiko.dev/#/patchset/709fefd1-821a-4cd1-8598-b1179a95ce52@web.de
https://lore.kernel.org/kernel-janitors/59f78064-0e0d-4e3e-9ca3-f057e70b44=
eb@kernel.org/


v3:
* Dan Carpenter requested to add an #include directive.
  https://lore.kernel.org/kernel-janitors/amdBqQfIsAjxMsqX@stanley.mountai=
n/

* Ioana Ciornei requested to keep variable declarations at the start of
  function implementations.
  https://lore.kernel.org/kernel-janitors/6woig227u5snmdsrjfuw7gfcf3vk5iwa=
ap4yf7ow6b6s3pba7z@yg4vmdoaak3h/


v2:
Christophe Leroy requested to apply the attribute =E2=80=9C__free(kfree)=
=E2=80=9D.
https://lore.kernel.org/kernel-janitors/d95d2f4c-f3cf-44eb-b61b-79ba789167=
4d@kernel.org/


 drivers/soc/fsl/dpio/dpio-service.c | 97 +++++++++++++++--------------
 1 file changed, 51 insertions(+), 46 deletions(-)

=2D-=20
2.55.0


