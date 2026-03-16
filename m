Return-Path: <linuxppc-dev+bounces-18275-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6511F53D7F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 17:48:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZMxw3nJ4z2yh4;
	Tue, 17 Mar 2026 04:48:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773683284;
	cv=none; b=M+CyjBXFfLPGlWfZ5WzJ6bAW24A63AjP11/jS47fwVWylvhwn303N/QxPWzlosJUyPzz81yUYXkxxJlOmi+kKF+yuwWNWf78nq8+S6zs1Upq7HwHiMmrNumbaNAu4WdcH+Z3ACr+UzM+IjkM8slaCWH7YGA0qmAL0iVL05ZWxg9ydwkp6SKzp9v/baar/8CxqegydnmZWT+8ZhGsm05fvcq39cI8pAljyiMRj6TFbP2T6dF+cREHR1BknBrNWMA147hP6I9cMJiVt7SfiZBLeFpOFRtMDRWxvauA9rnjb+GCucxfxnUmy08cAlzUWcA2F0xjJ8mFsSn60MtUjOxd1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773683284; c=relaxed/relaxed;
	bh=f7ucoLGhvULKEeflgeJvGOLrdGggYqtY1tW+f5+pHSk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=na48kP7viWtX/Ll3nErhpAmDEfGg/NVV2CPFHkFbelXPIA0NMGJ8KV6WAuvPlvVhqbk/2r1gvP+IMw9d+Ru+NImucFfpsoa1hA1ic7mfVVBmnM9GIHLeJDrblNTO78uc1qmJgz7LVd6hTtuKRjXzNoAeb1pi/MtfChDut+PySnucN0nFp08R9ABARJLpXdYHYw73zrifoimnCopx4hWaW2vK7YWs2NnQf8xGdE2xYbvVYqxAD3Ct2LJcxj5KCmgePSAl1U/Mn+ogmIRYzwFCxGWzoianpY6GZmi65SGA3h1Cs2fEQWACV5QRSvatsGR8z8Xe6c2O8PnRVN7QgsBolQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=acm.org; dkim=pass (2048-bit key; unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=EomC7BfE; dkim-atps=neutral; spf=pass (client-ip=199.89.1.16; helo=013.lax.mailroute.net; envelope-from=bvanassche@acm.org; receiver=lists.ozlabs.org) smtp.mailfrom=acm.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=EomC7BfE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=acm.org (client-ip=199.89.1.16; helo=013.lax.mailroute.net; envelope-from=bvanassche@acm.org; receiver=lists.ozlabs.org)
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZMxv1pmNz2ygn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 04:48:03 +1100 (AEDT)
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fZMxs32ZHzlfl5P;
	Mon, 16 Mar 2026 17:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1773683275; x=1776275276; bh=f7ucoLGhvULKEeflgeJvGOLrdGggYqtY1tW
	+f5+pHSk=; b=EomC7BfEkFJoWCI6sKmOXzpAuHoN+AWU1qp9yDbf2/LwQ+6XkpF
	0DKTjYKa8sy0L+sq1D7XrwXDJ+bHcVRbPTwP4KYZOuH8UVEZ+ZrH8gg1YArqj3sc
	zUfFjcZpMYyH8qp55YspOTM0VCZH9WoFjwCIc2NFtv3s2J+n+WtFpSM3YBGOb7JK
	1bWPskZsezW5LYb++HclYNBbQhCz7LUqwDE5vCya0x10lbtZgo6eYw1n2QlCJW3m
	bhSSdwHyktaPlUBHy2iPScEPPjuPewQhMMaq7nZz873RxdFqqDBL/fy9UewLATdQ
	21WTxR1/4TXcmd6q4JCBpp1zofWrOqJwXiQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id cUV4WgTR3u6F; Mon, 16 Mar 2026 17:47:55 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fZMxj5mRdzlfvpK;
	Mon, 16 Mar 2026 17:47:53 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	Bart Van Assche <bvanassche@acm.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH v2] powerpc/powermac: Remove pmac_low_i2c_{lock,unlock}()
Date: Mon, 16 Mar 2026 10:47:42 -0700
Message-ID: <20260316174747.3871924-1-bvanassche@acm.org>
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

Commit a28d3af2a26c ("[PATCH] 2/5 powerpc: Rework PowerMac i2c part 2")
removed the last calls to the pmac_low_i2c_{lock,unlock}() functions.
Hence, remove these two functions.

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---

Changes compared to v1: corrected the description of the history of the r=
emoved
  functions and added Christophe's Reviewed-by tag.

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

