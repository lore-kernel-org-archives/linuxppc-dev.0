Return-Path: <linuxppc-dev+bounces-20649-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5A6CD343F
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2026 12:50:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gCQng1dRYz2xnK;
	Sat, 09 May 2026 22:50:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2404:9400:2221:ea00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778331031;
	cv=none; b=YpRpo7Bu8sNPJyIxrdKrS1K3DgkDV2mogfB35+drYHdsnpUECaR92DRcE/7srvJylOTNu3xTME0GZtO7hmnWcX0fo7DpEsWwIlqMrt7iZPYF+AXwpkk3FcokgLhkk2Fvk81bwoNVgezFJRHu46LDSg56KX1zLBd7XV6T4Yruq1HI/ieaqRX6OGIMLYkmDgCuoVz6lEFZ/5ZO4GaT8WYSoHRRNKMPyWjYyokDde5C9HVi6uQuLBId6kqpIbaVpwMudG5lrrlyZ/B0E9GGspy7QF7TGP1slkV8kMkrawk6jH01BUyETUlWn5lFRdkqzuWu/6aW4GxBJTPy/SuO06aOzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778331031; c=relaxed/relaxed;
	bh=2p3Gpic0RWFWMKVFJDJoAdkxuIeEMzLRVt3WXQ+0hEg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fr3MuavF/GKHrxikbyHbtlkZe13GC3lIrY9XPQd8RhK9rjSBk1tbb/DcGluHI6Mp2Zh0o5t241siLkPJzXI2B/HM/OVSxaJQUSJIs0SS61JjMgaI9mmOFbZlatBMudOKp26AzAyajTIBlQ9nujADoX/lCoSj7V946RjjlQLlQ8jQx/bJFh7BNYFV71xkQOoegxnjgl3YpY8mbY6CvvTzsHAX/gqsyeNRCM4dWxruOoVaeFcZVxK3JBnFm6tAl9Yb5ir7Vjm6esuCKHVKdtVLvfkM0umTjD13VecdXEz82tm6Gl2QlZqnyu2Pn2KMHe07O4ROINyI7X/iezc1sIjX5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=hv1svUMa; dkim-atps=neutral; spf=pass (client-ip=2404:9400:2221:ea00::3; helo=mail.ozlabs.org; envelope-from=mpe@ellerman.id.au; receiver=lists.ozlabs.org) smtp.mailfrom=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=hv1svUMa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ellerman.id.au (client-ip=2404:9400:2221:ea00::3; helo=mail.ozlabs.org; envelope-from=mpe@ellerman.id.au; receiver=lists.ozlabs.org)
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bit raw public key) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gCQnf09tCz2xf8
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 May 2026 22:50:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1778331029;
	bh=2p3Gpic0RWFWMKVFJDJoAdkxuIeEMzLRVt3WXQ+0hEg=;
	h=From:To:Subject:Date:From;
	b=hv1svUMaKGQ6LXL0WgTBN3xb+yfYKqt6dyUgDYe96Mnf7vHebXTWK6jLd2SaFnaFy
	 XIu+XUH0QSj2lw5gygXgmjpuVTuXDPfljhlaKK5CHx98VaXPnNfF8IXOtdTmjZwdYE
	 J61MCCGJy3nAuZ+F4nzfWpfLYtldRiJVOlgk127iMGt0uuydgAEhaRxmGMrk3mEdoz
	 9sZZBUBR32/CoPCxL2H8OK05TMALiyCxk4b3ohxQc4VXw3UUse1owNAZsCy7VYXsfu
	 17fwGSQjGmzIZVjReszSpTSFnxjrcaHfgTvT4wofLYhFPPfIV+rjEN1VFs6R9ViQCN
	 tNGsebL2l5k+g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4gCQnd0rfXz4wT4;
	Sat, 09 May 2026 22:50:29 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan
 <maddy@linux.ibm.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: [PATCH] MAINTAINERS: Demote myself to reviewer
Date: Sat, 09 May 2026 22:50:25 +1000
Message-ID: <87y0hspx0u.fsf@mpe.ellerman.id.au>
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
Content-Type: text/plain

I haven't been active enough lately to warrant an M: maintainer entry,
demote me to reviewer.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 882214b0e7db..7badd58ab1dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14736,7 +14736,7 @@ X:	drivers/macintosh/via-macii.c
 
 LINUX FOR POWERPC (32-BIT AND 64-BIT)
 M:	Madhavan Srinivasan <maddy@linux.ibm.com>
-M:	Michael Ellerman <mpe@ellerman.id.au>
+R:	Michael Ellerman <mpe@ellerman.id.au>
 R:	Nicholas Piggin <npiggin@gmail.com>
 R:	Christophe Leroy (CS GROUP) <chleroy@kernel.org>
 L:	linuxppc-dev@lists.ozlabs.org
-- 
2.53.0


