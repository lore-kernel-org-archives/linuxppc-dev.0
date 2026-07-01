Return-Path: <linuxppc-dev+bounces-23300-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A937C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 11:45:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqyrG2p9Bz2xKh;
	Wed, 01 Jul 2026 21:45:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::bb"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782906334;
	cv=none; b=k2rw7dBk2UolnyM8U2oeIZLDrhHeQvUJ5NVf+M5ovMyoXFz6ggEnuyiu0EwClirwMDBLfKghf1nXkCiHqgbD8MnFrBkesI/eM8UqS/2bmQmQFODlTRyyas4MLQpwJfU2yxdZBaADfKQGh4jJ4VMtjytXVhIVymsjiYQnOS/hRg+vinpd8hFoPZ+cbk5gc7GH2Wx1+HfdKOil6WhzzIu3uymOhWTsle5ZGKxCl8Q6sXE2k4uvnjVoi0d09A8fAoA8bt4ezuS7NMkrV6x4VSmI/IbEdcTwE5E3qntt33K7wBFWeD2GaxQzDkxJHTnHkwonGGZ9DqvmxUxeZO2/6q2MYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782906334; c=relaxed/relaxed;
	bh=F2zEipyLBPNWr2N0lqN7UPAi4JkA/IxNSz3/dnrfle8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k9zpj0bmZcZItHy0z59Z9ZkIESrsYg5ilRH8BQyvm0VP3sc8/V4dc2bw16gLWwgnejgZ9XOz3z9ss4XyHRO7oI3dTND0hIXWv4LwMe5fczqA15hb7+fL/en283r18oEpseOF27YOaOSbitif7z6xlelYcghUP/1sD76n3+XKlhv21OCyBpp+Rbal++kBC8nUe3UOkuc0wBnhHf/SsE0uLxscdEiU4UejRe1z4I+Onoko1oCm46kESWBQ5BXRd01wuwyRnNwoSim1d+hNnHT+ZxGGxJ5+UJjhADzYQ0J2OQwFioClm8urFq+REu776P7dmNqezOyriiLBHZUfviK+LQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass (client-ip=2001:41d0:203:375::bb; helo=out-187.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::bb; helo=out-187.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [IPv6:2001:41d0:203:375::bb])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqyrF2DfSz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 21:45:31 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] powerpc/dt_cpu_ftrs: Avoid separate strlen() in scan_callback()
Date: Wed,  1 Jul 2026 13:44:28 +0200
Message-ID: <20260701114428.818748-3-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1679; i=thorsten.blum@linux.dev; h=from:subject; bh=E75/SRsgQeXD7pVj5U+TFWau1RMu0zbCmb7kpJzaYpo=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkuf+cEG21I+POpbXrPvbO7uF2X6ZZmsV60OPBOkp2Bc 7J55VmJjlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAbjJxxkZ7gS0vV5i2Gd57+G6 +ceCFyUuN1X4f/pojIu0ep9hR5OaLsP/PEGNRdVyevbCletSTJdunmY4J7Au7kZF/q2rIS+WLBF iBQA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Check only the first byte instead of scanning the entire string with
strlen().  While at it, keep dt_cpu_name static, but move it into
dt_cpu_ftrs_scan_callback(), where it is assigned.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Check only the first byte since strscpy() copies empty strings (David)
- v1: https://lore.kernel.org/lkml/20260630154657.693088-2-thorsten.blum@linux.dev/
---
 arch/powerpc/kernel/dt_cpu_ftrs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index 3af6c06af02f..4f0799c8daa9 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -90,8 +90,6 @@ static void __restore_cpu_cpufeatures(void)
 		init_pmu_registers();
 }
 
-static char dt_cpu_name[64];
-
 static struct cpu_spec __initdata base_cpu_spec = {
 	.cpu_name		= NULL,
 	.cpu_features		= CPU_FTRS_DT_CPU_BASE,
@@ -1069,6 +1067,7 @@ static int __init count_cpufeatures_subnodes(unsigned long node,
 static int __init dt_cpu_ftrs_scan_callback(unsigned long node, const char
 					    *uname, int depth, void *data)
 {
+	static char dt_cpu_name[64];
 	const __be32 *prop;
 	int count, i;
 	u32 isa;
@@ -1106,8 +1105,8 @@ static int __init dt_cpu_ftrs_scan_callback(unsigned long node, const char
 	}
 
 	prop = of_get_flat_dt_prop(node, "display-name", NULL);
-	if (prop && strlen((char *)prop) != 0) {
-		strscpy(dt_cpu_name, (char *)prop, sizeof(dt_cpu_name));
+	if (prop && *(char *)prop != 0) {
+		strscpy(dt_cpu_name, (char *)prop);
 		cur_cpu_spec->cpu_name = dt_cpu_name;
 	}
 

