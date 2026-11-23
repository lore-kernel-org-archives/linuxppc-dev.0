Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACCF606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 09:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=auLbbl2o;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=qMqMlGFZ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY1MN4kzDz3bh6;
	Mon, 23 Nov 2026 20:47:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795427264;
	cv=none; b=BQxfHr912Em9QOYQQzRqB7sq4WCqbbGZFKGtDytWJZErlW68o39V0yFm4ChoVrbn0EjcYd7XPpAhwa/S/oyB/qUoMxuT2SDjrMuNOgV/oFf6oq21zSquiplXucFCC1DikoCoQQjqKneKWXvG/Y+3vhn5et8HGtCQncC6C8dDZMzJfXLIiQz8E5HXzNr/b+4QH+WDsb060hE2jQEZNh1At1oWghZ1B9dRCeRMtgOiUKh/HVcgvon1U5TCQodFIbtt74K2sBHxTa3/qGJuMyXkee7vGBymIrMFLbrkuTLH0INpOnz5mbnBRGEZktFho/YvhvY3YD5u6QQC3en3kmN5lw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795427264; c=relaxed/relaxed;
	bh=YWYGWS4auZwM9Q07LV23QUYJ6/wrrSYEmZV3T9JL0KQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LmYFhbxfBfOTBWI6cMOv+LkkEeXyyw+0iK6u6PwbccJdVe7Gr96rSg5iKjqEkFYQcUMHOsLdR9ZAkcyI4HoKTwPZrIMUIgur85ihly2Fwn5tavYzFVVL+5jx0c9sbEw2DvheNCx4Iof3/oq4hrKeZe/WwGr4+kaIUWpwUGnGOo3MREyfCHjgzNi3dcog7BgzLql8Dr4TH0rJP2OWETj9bZNaX7jzoPN7gAWx7bXwf230zyO4nEAI8zDmMO26ss5bwEzomT+4Jjl86V53xC6RyAGIncMrH4irkMXjfpJnKcUTvGJe2le+uHo/zRaTk0IvWFFvboqXoSx73p+e1C2IPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=auLbbl2o; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=qMqMlGFZ; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=auLbbl2o;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=qMqMlGFZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY1MM3Fccz3bdQ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 20:47:43 +1100 (AEDT)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795426656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YWYGWS4auZwM9Q07LV23QUYJ6/wrrSYEmZV3T9JL0KQ=;
	b=auLbbl2oH4Ot5YpCeUEcYQ2dIFo74raPeSEpSgBeepfy72T3dv6ySqNZw8grm6xlh59KuT
	i7WWn60yQYtSqGOjySH/D5mPaenZdFLjQryxByxKOS8oKkotAVm++xQQ/BfFWq0WydplG7
	Bc3VI1YdNWooahhM59wa1198KWdmK1pmX5ZxVOlwkUPefFYYwSOgHhVMfbt1yaDxsxTQRw
	QvaT84wAf4K0nwWClg3Zan10Pwtp9aucgSxaEQ4bzDDgd19eRgjLZOyFQ8fPOY8Qe8yEg1
	B/xsSTsGNrZ0LAIMJP7x7jGA7J7+iD6ijUD8C4UHQUeo3CCHawC1aw7IuMaVeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795426656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YWYGWS4auZwM9Q07LV23QUYJ6/wrrSYEmZV3T9JL0KQ=;
	b=qMqMlGFZf4t4nwAx7Fj+UHvCQee1C2mTmihf6zAwsYxwJeLug2K+qgxMTQI0UA9bbmc37v
	oXm3bpJIAE5VGxDg==
Date: Mon, 23 Nov 2026 10:37:20 +0100
Subject: [PATCH v3 15/15] auxvec.h: Drop fallback AT_VECTOR_SIZE_ARCH
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261123-at-vector-size-arch-v3-15-d342dae9e843@linutronix.de>
References: <20261123-at-vector-size-arch-v3-0-d342dae9e843@linutronix.de>
In-Reply-To: <20261123-at-vector-size-arch-v3-0-d342dae9e843@linutronix.de>
To: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795426640; l=772;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=JAUB4d6w3tpvVvnJFyNZBhcXBgmmxi5dKlrBgo20+M4=;
 b=kCgAOd1xOlVd/uE/bDzZYB74ed4Qvm9zJWmY1xGZI3IKoxs4346rY6+SlaWFSlHZ/Fy/xnAaO
 7YsjYIIefxeCjUKx3kra6gHNuGjcu1KYMGOdN3sVIQWVAqnwsOe+Hdb
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

All asm headers now define this constant.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 include/linux/auxvec.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/auxvec.h b/include/linux/auxvec.h
index de1c33c4a256..f7ddea1dbc8e 100644
--- a/include/linux/auxvec.h
+++ b/include/linux/auxvec.h
@@ -9,10 +9,6 @@
 #define AT_VECTOR_SIZE_BASE 24 /* NEW_AUX_ENT entries in auxiliary table */
   /* number of "#define AT_.*" above, minus {AT_NULL, AT_IGNORE, AT_NOTELF} */
 
-#ifndef AT_VECTOR_SIZE_ARCH
-#define AT_VECTOR_SIZE_ARCH 0
-#endif
-
 #define AT_VECTOR_SIZE (2*(AT_VECTOR_SIZE_ARCH + AT_VECTOR_SIZE_BASE + 1))
 
 #endif /* _LINUX_AUXVEC_H */

-- 
2.56.1


