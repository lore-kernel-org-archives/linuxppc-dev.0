Return-Path: <linuxppc-dev+bounces-24992-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC54C53200
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 11:37:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h99Kp3cMXz2yDr;
	Wed, 29 Jul 2026 21:37:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.15.3
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785325038;
	cv=none; b=o02T/EUDVLTJeL7piecZNDKloQ45Z3UT9OwqPJj1dxxxQkYUzpphV117Actyk1ViGj96txmP0jmkW73sR6fRTTh8db5RuqAjEsPhSVtDQjD8vamv1vIUr60cR+cBkeqeYZHM0NaYUP578PogAh2St6uvGYZF4BnF3UMh0XinlUEm6aCZPD2Kh8zHe+Cj2glK8dMUshl6JqZAnokO6xo7V5+ux3NGHLhgdyNQZwgwEdKvIg8Hik1sr4AUXULSyR9Y+Z4u1Y81ubAMMQkX+0d2F9Y6/fvjRPQWToUA4XuMYrYYUgmnA1xGIwCNd9DgSDm40fA0hDXCgzwx1526gXXQ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785325038; c=relaxed/relaxed;
	bh=QKBjjNfQCqC61KXU3qhy/2fQbeIjNACPoi4zmkhWvXg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=gM+U0WhKxNqs5QtyaB8uPUYjkX2fenYUTMmV7lQqaMIM82f88OfuQeedI3ud58eQS89IpDQyS11cbNlzhZBB8owgB33D3wdqg5E+iilYHhqDHPFwOPTHM3qm7TfnAvcgj1xQ8AZ21e5xImjH5fqfWIDCE9yu7EeZI8wXrjvG/Tovd88jCy8tuQC1K/ABCJBqs3TtN0q8gtNK5NDz7kEH3ryaG97sIGDMzcpW/4YntQQeHJePXjQD4Smm7xnLnGnq0A7nSOHjZrEQ92tSibcL8Dr7xKHMfPNz2iy/P40A6mXKLNJvn67YPLilfWwGavE+INGZQw2V+ee1Z4uk1URyJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=GPIS/m2n; dkim-atps=neutral; spf=pass (client-ip=212.227.15.3; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org) smtp.mailfrom=web.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=GPIS/m2n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=web.de (client-ip=212.227.15.3; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org)
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h99Kl2xZMz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 21:37:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1785325025; x=1785929825; i=markus.elfring@web.de;
	bh=QKBjjNfQCqC61KXU3qhy/2fQbeIjNACPoi4zmkhWvXg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GPIS/m2nhSuaaqPlrox1ViWRxB+OuzBbi3AJ8wa1+SbqHn73KoIfnXYbda0Tzb51
	 qa7SFCdUbtQZc8r99MwLRHEU1/YHQQ/ooj7mXcxbuS2lEeEzN36VndbHRBb37BhOs
	 e4l/IPZyeAl2RDfD6aMwJaCNbfrXDs5lLMh/726Huv/1AzoCp+8+6FgEasVqkdJAM
	 fzdFJbRVfPAJGYAk3c4ZY72RpcjBVCOmXhvZY0C5flUYocacxxLlbHUDaCh4zcBXw
	 mVd5338DdOr2cB6lVWbTpKFO3mmuMRvarB+prtwoTCMBHlQbucl+h0E7SGjRZSalG
	 8wrXAufe50ZS0Vv9+w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MyNwm-1x9koX0prw-00uY7g; Wed, 29
 Jul 2026 13:37:05 +0200
Message-ID: <709fefd1-821a-4cd1-8598-b1179a95ce52@web.de>
Date: Wed, 29 Jul 2026 13:36:41 +0200
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
To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <chleroy@kernel.org>, Dan Carpenter <error27@gmail.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Roy Pledge <Roy.Pledge@nxp.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH v3 0/2] soc: fsl: dpio: Use scope-based resource management in
 two functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cIyitOfS/CV86i/5lq0H/fhteBuknVKV/ZoCOrSyWd4vw9OFgJw
 OWQ2st7ti//rtWQXqfr3Y7XcDE3VSNFAjKncaWebIxUBv/ylk9lHLOoNS+XHeA5XZlD8Ito
 KWNfkvSC1ABn+K95/OPyfFDE5ZHnWHyGw4na1ydJsl95YcPp9+I6/sam2Vao1cyfHqxc8Cm
 CmpkH+d4nmjVXiZrvL3Dw==
UI-OutboundReport: notjunk:1;M01:P0:lX9/bNPVHfs=;HP4BixMtBlBTbsyyX/lC9WQ14Kx
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 29 Jul 2026 13:28:09 +0200

Some adjustment opportunities were picked up.

Markus Elfring (2):
  Use scope-based resource management in dpaa2_io_store_create()
  Use scope-based resource management in dpaa2_io_create()


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


 drivers/soc/fsl/dpio/dpio-service.c | 37 ++++++++++-------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

=2D-=20
2.54.0


