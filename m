Return-Path: <linuxppc-dev+bounces-22775-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A7ACD98F2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2026 19:23:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gh9cZ5yy7z2yRF;
	Fri, 19 Jun 2026 05:23:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.72.192.78
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781810606;
	cv=none; b=oqQT82pAv2fNWQtAte+Ym3iwGWjDqC3wNa33UnKqDtj6QCbkgszMp58Xn8rLGlnJGmlWkFekjx1w2dcwl64DsYHH7KpWS6/l4DaSxnn26xSf6KyqXIC7QgqA7FN+Gwd02K6zbeVSrta5a7otJholicQn9H2AJxBr+enYUbVeoXmO6kLlplZMzM0+iGKL7RGdzB7PHsbPifPGSSE2u/M5/T5ZDmqQ07Lcve63+3zYcVj90Jq5yZfuqLl4FjQA8KxjNG/BDOEjgDi4HntextW4qZT1fVp3tePt50wqTknncRlXwsfZGoNStz9YmuuxGe9rf2ImyhXjyHBpTRz9JcTx+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781810606; c=relaxed/relaxed;
	bh=Dav70Nu4vyRiOCJbNY0vTUPpnrS7bo+NxiQ5ypAh3jU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=gSZZHPz0/wFfOm5e1iyUob56Kl9Bh8rQFSgIN2pFUvCctCk5s7LZLamdZkIf2/EAu98XqB3wRre8R5ofqQvcQ2Zt7+g1cCAFG4Fv2ddQRcEONoK5BOyjrEdko58SoqAM3oM1Hrql5kKHjM0mronS8i/kCyZozLnwSFkz3Q9xAyqvo111vFBeulbtszdJaFSHv0UGJsNig7oxI702eB5+c8PikLC/t4W4FbP96vt8snuqbt6wmxmNGTKjPWxhlKoFATjQMlyRHh4yXFI9foOGGdawzbXTXGmtLveK5CYSEYLL1YY4RlnfL3y5A30QERZSF1EjR7EG1T/CHSTbPsbdLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=i/xmujtw; dkim-atps=neutral; spf=pass (client-ip=217.72.192.78; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org) smtp.mailfrom=web.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=i/xmujtw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=web.de (client-ip=217.72.192.78; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 335 seconds by postgrey-1.37 at boromir; Fri, 19 Jun 2026 05:23:18 AEST
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gh9cQ6c8rz2xlV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 05:23:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1781810586; x=1782415386; i=markus.elfring@web.de;
	bh=Dav70Nu4vyRiOCJbNY0vTUPpnrS7bo+NxiQ5ypAh3jU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=i/xmujtwtXX5AmOCSGWGtE4W1K4AJ6NXSLcnBUm4kg60WePRw8R61k8hwd+s2VYa
	 we450HrLK0QoawYEiPRJRy2Rhvawiv3yo6/JTxV6dxmqyDWisPEvtfo1V4vEPeGcj
	 Drfp48Arp7ai0BseKD1qKqYNMkrOZGeF4gM6RLZ7zMYsRUleEnLIBeKf3HF9aoBEZ
	 H6hAnR4JY86ZaxXo0l/ZxQ2qxU81WbFGl+TAW9WoXNtdGC3WPF2jxBfxGSu/JU9jz
	 289iODM0UzhbwRMF7Su6wymsZOG9yx6KbV47M42Gxc+ZV0TfYQp9dmY7GxWXijVGb
	 Uz3WH70bWqcoT5nUyw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MrwsB-1wveXp1y7R-00mh9R; Thu, 18
 Jun 2026 21:17:16 +0200
Message-ID: <8dd3e02a-9d4b-4633-a703-890d5d108318@web.de>
Date: Thu, 18 Jun 2026 21:17:13 +0200
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
To: linuxppc-dev@lists.ozlabs.org, Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Christophe Leroy <chleroy@kernel.org>, Kees Cook <kees@kernel.org>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] powerpc/powernv: Use more common error handling code in
 imc_pmu_create()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G4J+miUrK0mM1Pxj0Ufd3m+dHiupV0JoAuzf1PCuMz/SeivNXwS
 nnnisKcDN/+1fsNvd8yhpsSrpYFZGWY2+6TsPnyVEAkkRhD0WP3RIWuDzF6luBg9qB02sTp
 jgDjq+RIzU5qWZyQjLW4vAqyJp3WLRtretqGmoypXtMl7odRvvxGbdQMCErjMYHWSwNk6MK
 Kgt+WlIxS9J9lVycPH//Q==
UI-OutboundReport: notjunk:1;M01:P0:nJ3Qrh7thP4=;27rH07jPDI7fJBZSCDk3X2LuJnq
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 18 Jun 2026 21:04:51 +0200

Use an existing label once more so that a bit of exception handling can be
better reused at the end of this function implementation.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/powerpc/platforms/powernv/opal-imc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/plat=
forms/powernv/opal-imc.c
index b3fd5c648dea..522880d717f1 100644
=2D-- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -168,8 +168,8 @@ static struct imc_pmu *imc_pmu_create(struct device_no=
de *parent, int pmu_index,
 		kfree(pmu_ptr->pmu.name);
 		if (pmu_ptr->domain =3D=3D IMC_DOMAIN_NEST)
 			kfree(pmu_ptr->mem_info);
-		kfree(pmu_ptr);
-		return NULL;
+
+		goto free_pmu;
 	}
=20
 	return pmu_ptr;
=2D-=20
2.54.0


