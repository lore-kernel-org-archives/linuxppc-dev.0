Return-Path: <linuxppc-dev+bounces-26050-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966C1C5B572
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Aug 2026 10:23:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hRtYJ2FZJz2xWt;
	Sat, 22 Aug 2026 20:23:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787386387;
	cv=none; b=ZBKSezivqWqzSo7Zbz4n9JrJ1mlxjRDHGn6rLt097hDvh/aKMTXD4BzOc65AZEcqyJ4NcPfcyaywCPu9u/WXZe30rrVyCBh57FdCy4HOirLz4fjsoYyiS+j9yC5qXSo/IbGYy3yQSzU5teOSpI9WeFS9fxREydDS/NddunZIrH50TXG1jSOXGV23vL+xVnOb5bthUSVCrDp1qaEvI2vjcm5tOi8/UG915qnhQBqTDgbKpbIQEI3MI/3qFlfLKTrmFK9eaWx/5uLzTHkc/FZx18UQRTAjegdoAjBxuutGLI2XhygvcVhjAQ++Gqaru/8iIn0e+07QlxjCAIJc2umY/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787386387; c=relaxed/relaxed;
	bh=zwEIS2oNhlS94NpqTVNlX4vjoUate0GZ1KJzlmPoGkk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QDH9EgrfTLSMO9icEAnPR6wiEadIaTqyJ4fCQKNMw8HsazxAKTrXiAagvXh3OCYYKGpHZaLO4plkanyQNkGW8FXld8W8jQVhKucLTVmppYKCuekZLvzhf+3y6Bbn02MjujPbw3Cp7GxWsMtAIRMDrErSy301r8jDj3BgNLIs+hlL3VywQYcLehmH6C/HiW1QubjsW2lJFc4WBsrSdoaH5dfoT6RC+3EKaoPmaz07ppZq7DnBG6MXbuL1N5fAcb0NTyTIrmkARGJFboQ24UfDAeoE4GMQs+8pd+n1d97v+efWROi/uu0YzpCtrmS01MiGRI7aeKGVga+Ipuxk8q6o8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sB6IrkfX; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=kmehltretter@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sB6IrkfX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=kmehltretter@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hRqg60RTxz2xQ7
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Aug 2026 18:13:05 +1000 (AEST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-c15cb6f5c12so324251066b.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Aug 2026 01:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787386382; x=1787991182; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zwEIS2oNhlS94NpqTVNlX4vjoUate0GZ1KJzlmPoGkk=;
        b=sB6IrkfXPi0rqIsAZ2QTKDXfkeEYH8lGQHZvCjEJCTWtJiXSDBn/zPo8puv0VMwRB/
         aYGOASzOfVfoMrhkNgr7/sihLOzC/5w8eb52x51cA+pdFRgAHWBbaEJxmlAEia/lpCF4
         cmZq3MvTvzZ1rdpQ5N4XmE7yIG1wMGR77RXMQqzP1l387A00HxsNcaZsW4l/9dkaSD2Y
         b/bmxqczJxGQoKinqHM4vMhuwVKqbgAKvfHTP9k8/dazi5VauiKr7D2n2UNXC8G2kiXK
         MIAIniItak5ZDTc1KELxR0U5+MJ+gnr49uZnPywUhY2AKaIpi1DBgrpxYkHvg6kseI48
         HTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787386382; x=1787991182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zwEIS2oNhlS94NpqTVNlX4vjoUate0GZ1KJzlmPoGkk=;
        b=Jn+jhUVtahsN15dSibREZ2r3/odY/xGxuOY9E7hSCrGaj+0YLDCNfWPMiotyVy62gU
         x3YH7z5Tn60vBxqF9BePG8t+MX7xRBkoJlTDSmX5qHDrp+JluJx4sdWHrbMAnWWLe1Sl
         vQi9vA+tkvji5E6dWmSVC3aTvSS3L+zLwth+6gY4aOX+66c6CS88EaYbR6Cve448C00b
         9LkNKQkPbM6jlulTxbDAPFUXlZg6OsxeNG77AkPi9vEul9DRyPSjoT3sQnxza6lpRvK5
         HmiGZv+C1RSsBJiLA874OpkZaRayfKhB4EMWlQ0efCjL8ITe+asJzc6lSdaV18HdgFAY
         QOdw==
X-Forwarded-Encrypted: i=1; AHgh+RrDZU7NYw8E29syYz6FpqHKZU9J42UiikpryHQTwhKfrOZAQSMqWW8NoxV5TqpidVEhn0SK5XPpAy+xe5U=@lists.ozlabs.org
X-Gm-Message-State: AFuF++k0/tb01+4drIZBquCgDsHxGPfr6k0dyeky44G7aehn3gOhZKna
	f48yoSArpz8vxFygDw/nPRwkkjDPWLM7iJPz9RxaZlJ524kn8aQ4mz+z
X-Gm-Gg: AR+sD12I8sPF8vCrl0pDuZ1dnsb2o0S1JpkYrpaMOkADZepqVdu2MhWabHGXwBTfanQ
	YZ8adb81KHObCyCA0MCRk6QV2wUnPJmmzbdE24dfGA8nUkuXKWdzPJ3hKY9o/tESL602Hibjnzo
	fqxcInTu4X8DVZRoIXi392WEA5eOfKAG9H0ZD+K0c+a4pK7cV6TOHQEslQu5GlzJYlQzRMF6V8B
	pLxQc4XRbQi6lQ88C7t30DP05tcVd6lcsF8wuGkuoZBxv4pXI0Oee6nlUTj+gtEZjOGTkIXjGvL
	CUYguI5FMrS7HF2nciH3UBKa+wOmvRODs+GTPFVT4q9pPck9ColkRM1hLRtVsDxcYH2zAiUTfdr
	a1M2bbR5yuqy868McWhJiaG1gc1ud/zjKM21tsSOdqPXhJt0SR6pBIy+CVTBt2ui5HMu+kA36BO
	xXtV94zMnldCVMynCiHW/O1BY68Yw6U+9GfbLWinAZUGVzZBhmqPDufybJxVPm6vHY8TkDErtoL
	MUUhUbNPZW6motJePLdkpoLDRxNEoPtJMNRseBG8SihjALuCTs7wLz5+Y7Buq2ht+pudZTB0k3Z
	GllTWQFGyw/oL2j+4VZYBHzLFeZDA9JpGMlrsr/WubGz8g/Vr/xjR1cEgNvoEEWKv50sDdoxxA=
	=
X-Received: by 2002:a17:907:60ca:b0:c24:6985:d7a1 with SMTP id a640c23a62f3a-c24924b79ebmr457268066b.7.1787386381921;
        Sat, 22 Aug 2026 01:13:01 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a0f5-8c01-3de3-cd62-aa6f-2fb0.310.pool.telefonica.de. [2a02:3100:a0f5:8c01:3de3:cd62:aa6f:2fb0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496296b8bsm195050666b.16.2026.08.22.01.13.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Aug 2026 01:13:01 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Rashmica Gupta <rashmica.g@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: ABI: Fix powerpc memtrace Kconfig symbol
Date: Sat, 22 Aug 2026 10:12:53 +0200
Message-Id: <20260822081253.86256-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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
Content-Transfer-Encoding: 8bit

The memtrace interface is controlled by CONFIG_PPC_MEMTRACE. The
documented CONFIG_PPC64_HARDWARE_TRACING symbol does not exist.

Fixes: 1f84c2624a2d ("Add documentation for the powerpc memtrace debugfs files")
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/ABI/testing/ppc-memtrace | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/ppc-memtrace b/Documentation/ABI/testing/ppc-memtrace
index 9606aed33137f..2de9fd18715e0 100644
--- a/Documentation/ABI/testing/ppc-memtrace
+++ b/Documentation/ABI/testing/ppc-memtrace
@@ -3,7 +3,7 @@ Date:		Aug 2017
 KernelVersion:	4.14
 Contact:	linuxppc-dev@lists.ozlabs.org
 Description:	This folder contains the relevant debugfs files for the
-		hardware trace macro to use. CONFIG_PPC64_HARDWARE_TRACING
+		hardware trace macro to use. CONFIG_PPC_MEMTRACE
 		must be set.
 
 What:		/sys/kernel/debug/powerpc/memtrace/enable
-- 
2.53.0


