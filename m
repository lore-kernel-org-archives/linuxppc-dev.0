Return-Path: <linuxppc-dev+bounces-18181-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BA3107BCD9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Mar 2026 19:47:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXZkj1Rvcz3cKj;
	Sat, 14 Mar 2026 06:47:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773431229;
	cv=none; b=kNaqM2qEY4DfqgYaFMVMo/pdGNmerpLjWyepyEwBIsS6Hzaug+vEZCvx53vS8LTe/db5onkr8tKvZ9YxGSLUeLohMA/n2gPPBROobIOR7Jlzs8//5gFSTZTE30UtGWQUjR9vrum24hH0DuG1HsPJI6EOLdOzUikOIsK06/ui99r71kN+eHOXHODzAmCKiRPM57+263KJwXBQoz96iD6Fcjw5h+CQ6WQul0UuoWqJBeC8DHKAaovQSmETjBXrcCEDX/dagHzXYAQ26FD8DxqspS6430/rLA/CSEi8vpGF3MbdfKVRcMuVa5AjW1AePmWfJ9K5iL8+Rwo/Dr9sk/q4BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773431229; c=relaxed/relaxed;
	bh=3vbHkXm6YucaUug5QLVsucBr5KBaEF651XPFSizy2K0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k3mW3ysQ0p7CunPKSCO7HBd9uoYtWuBBF+ib1xB8Ikg1w2jU7yInUoRyC1b6U+vWRuMM6DZko9hDOkZNyuFRL0R3kW7z78ruh5J6YD9/X1hhXUfDSreR4GJtzPWkT+05Iz0mZGruYpa+o4TluH9wI/maqIB4mrwyFNIzNuzgRwUERUxZFdCCq24eW8K/Ci99yA08d7fg1RRSidB7HsPkXzpy2f6HjlN71aOuHwL9CUunnfYMIg47w3fSVpyqC6yJckYWyP3r5+IVjJ97pbUFhYN9e0Cu8gDm/ccxZRgJ8/83ToLW1/Qsvr3TFvwIgyphC5eU+Glz/M8uiN+r21soqQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=acm.org; dkim=pass (2048-bit key; unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=IjZC4Yx8; dkim-atps=neutral; spf=pass (client-ip=199.89.1.16; helo=013.lax.mailroute.net; envelope-from=bvanassche@acm.org; receiver=lists.ozlabs.org) smtp.mailfrom=acm.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=IjZC4Yx8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=acm.org (client-ip=199.89.1.16; helo=013.lax.mailroute.net; envelope-from=bvanassche@acm.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 136 seconds by postgrey-1.37 at boromir; Sat, 14 Mar 2026 06:47:07 AEDT
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXZkg4QTbz3cKT
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2026 06:47:07 +1100 (AEDT)
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fXZh06ZSJzlfdfH;
	Fri, 13 Mar 2026 19:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1773431083; x=1776023084; bh=3vbHkXm6YucaUug5QLVsucBr5KBaEF651XP
	FSizy2K0=; b=IjZC4Yx8BeuQWVTDoiYzT3bzdeMLYpqE1g2v7cP4zLEyHpDLfJQ
	Pw/+bGI5b5XrNP+ohTDotaYg7+JNCpYKUF1HU66GBaZkmJyKnfNeKmbEl8mx6Qir
	XXmmS6Jy+KcKHrIIz8HP1UYannj8CNNzQc66CqX1+v8Fbt64e4Qiz3BekvExZe6Y
	EIamYgMnb9betK6tbb/Y+HbnLWYYNKU+8/Fvu3J3xjCeuXD+oKRhoutzKjwaqK6Q
	sIVWxaQvVw0kdNej5UFWhddrcBiT5GHZsg35txadiRsdZDcIG2yEFjgF12Fo7Vy8
	hhFzC1aQ7w+jgmgR1jUH26rIVzABWuu5+dQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id wsNbLTG3q3vo; Fri, 13 Mar 2026 19:44:43 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fXZgs3ZGSzlfl5l;
	Fri, 13 Mar 2026 19:44:41 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	Bart Van Assche <bvanassche@acm.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH] powerpc/powermac: Remove pmac_low_i2c_{lock,unlock}()
Date: Fri, 13 Mar 2026 12:44:26 -0700
Message-ID: <20260313194430.2396286-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
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
Content-Transfer-Encoding: quoted-printable

I haven't been able to find any callers of the functions mentioned in
the subject in the kernel tree nor in the history of the kernel tree.
Hence, remove these two functions.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 arch/powerpc/include/asm/pmac_low_i2c.h   |  4 ---
 arch/powerpc/platforms/powermac/low_i2c.c | 34 -----------------------
 2 files changed, 38 deletions(-)

diff --git a/arch/powerpc/include/asm/pmac_low_i2c.h b/arch/powerpc/inclu=
de/asm/pmac_low_i2c.h
index 21bd7297c87f..fead8fae08ab 100644
--- a/arch/powerpc/include/asm/pmac_low_i2c.h
+++ b/arch/powerpc/include/asm/pmac_low_i2c.h
@@ -79,10 +79,6 @@ extern int pmac_i2c_match_adapter(struct device_node *=
dev,
 				  struct i2c_adapter *adapter);
=20
=20
-/* (legacy) Locking functions exposed to i2c-keywest */
-extern int pmac_low_i2c_lock(struct device_node *np);
-extern int pmac_low_i2c_unlock(struct device_node *np);
-
 /* Access functions for platform code */
 extern int pmac_i2c_open(struct pmac_i2c_bus *bus, int polled);
 extern void pmac_i2c_close(struct pmac_i2c_bus *bus);
diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/pla=
tforms/powermac/low_i2c.c
index 73b7f4e8c047..da72a30ab865 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -1058,40 +1058,6 @@ int pmac_i2c_match_adapter(struct device_node *dev=
, struct i2c_adapter *adapter)
 }
 EXPORT_SYMBOL_GPL(pmac_i2c_match_adapter);
=20
-int pmac_low_i2c_lock(struct device_node *np)
-{
-	struct pmac_i2c_bus *bus, *found =3D NULL;
-
-	list_for_each_entry(bus, &pmac_i2c_busses, link) {
-		if (np =3D=3D bus->controller) {
-			found =3D bus;
-			break;
-		}
-	}
-	if (!found)
-		return -ENODEV;
-	return pmac_i2c_open(bus, 0);
-}
-EXPORT_SYMBOL_GPL(pmac_low_i2c_lock);
-
-int pmac_low_i2c_unlock(struct device_node *np)
-{
-	struct pmac_i2c_bus *bus, *found =3D NULL;
-
-	list_for_each_entry(bus, &pmac_i2c_busses, link) {
-		if (np =3D=3D bus->controller) {
-			found =3D bus;
-			break;
-		}
-	}
-	if (!found)
-		return -ENODEV;
-	pmac_i2c_close(bus);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pmac_low_i2c_unlock);
-
-
 int pmac_i2c_open(struct pmac_i2c_bus *bus, int polled)
 {
 	int rc;

