Return-Path: <linuxppc-dev+bounces-24611-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F845C44532
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 15:54:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4MQd28sQz2xyl;
	Wed, 22 Jul 2026 01:54:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.178
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784649289;
	cv=none; b=IPeFUmdgWtjlGnKE4J3l+6e6G27ggPR7+EjlYOnt62/HFlCNmUtw+HaJ8CNcFLqZ+EfJJL+YsZgAOxY/10gfstPqRSNo8Shh8Ktj4yrS8aXCnh3tQL00rVc6SD/OAAnKmqAY3aNISFpOEoEUYpRkF+yaQwhNN7tVKZJMLhWb64iTj9bXvevoJzD6+X7XxulnQLXB/mnaMLlDuxE3ZT/UdlTlevSDPF7Dr/uK9HgBaRn9i7Yx12fXFd8Y5XJnfAaomg5ki3vHeTjjjMAhOLqnapfQaofM19n0ONyrSCZYNpGla4n98H913JHlTPthgKSp2unyGDJQ5RWmwjW7mLfkfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784649289; c=relaxed/relaxed;
	bh=PHsLbISyxDzDV5B3VfZ3nuHc5ydt3zfq0bmim3PoWyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J7pmmCMnNPsMh2WHUIy97hHrbqiWZRKlo3MtGJItOvO/VXChyQjb8bG7ZWhXNHfYS23m4Evb/261pLQVL1xUYNDuCeN0y+fD5wVVYS2DcsAGFNRiL3dYEv/WgVq4noKd2IcLY5Nx7kXomXIuscdMFCLK2gOS79AxDW+IsxN5+i62V60QfQ4EqzFNV1Gtc91OPUYLG5dkHkdFjIBXO5jhhw3zAAymgw473ReXeIdTKA7tz9FczCqGGfk4XLJgRXB/vwKCWTe2VfZG3QPaWjyVlegcWFAeGuUMb49gV1gEfTg7OLwRs8icTw9nM0EgkBPan0HwXiJ3zd1wWc95W9OYSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uONLQzEw; dkim-atps=neutral; spf=pass (client-ip=91.218.175.178; helo=out-178.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uONLQzEw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.178; helo=out-178.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4MQZ4pt7z2xqJ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 01:54:45 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784649264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PHsLbISyxDzDV5B3VfZ3nuHc5ydt3zfq0bmim3PoWyk=;
	b=uONLQzEwQuuB7jHolqPSohqpzTanqIuIDPr0SFP038eeTSfeRBZ6O2x+NOIHzW3udWayKP
	WKFFBO9P9ELSgGi+u4wESXq2Rvp184TECPp1UPIPXTrvyL4dDE+9/LMpBRoRLqc2nKphtw
	KesiMtuWJEtxzrjdw+UebLvlEM9vNsI=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] powerpc/powernv: Avoid strlen() in pnv_restart()
Date: Tue, 21 Jul 2026 17:53:45 +0200
Message-ID: <20260721155346.121975-3-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=761; i=thorsten.blum@linux.dev; h=from:subject; bh=JHaC0T74RoJZv3853lnA3pAICDFedlLnY3QaJtTc/5s=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnx07iWR/CKmx0I99l6MGR1aUvooWXntu56ulljy+Vox gtGHYeyO0pZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAiP+8z/E/YpaMim/npy+Sd 6VeirxVsnM/Icuq0pSTTyTn+J2PT6toYGZbr38hvbrjS86zraf66QzenZfpKWzGGxwYHiwfJmHR 58gMA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Check only the first byte instead of scanning the entire string with
strlen().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/platforms/powernv/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 06ed5e2aa265..2af92e7ba4ee 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -312,7 +312,7 @@ static void  __noreturn pnv_restart(char *cmd)
 	pnv_prepare_going_down();
 
 	do {
-		if (!cmd || !strlen(cmd))
+		if (!cmd || *cmd == '\0')
 			rc = opal_cec_reboot();
 		else if (strcmp(cmd, "full") == 0)
 			rc = opal_cec_reboot2(OPAL_REBOOT_FULL_IPL, NULL);

