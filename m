Return-Path: <linuxppc-dev+bounces-21622-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD38BCD5BD1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2026 08:32:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gR08p2s4vz2xK4;
	Thu, 28 May 2026 18:32:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779957130;
	cv=none; b=F5ZO7zACYtylioorIN16nMJZSNqTOC8BvNQx1D4fkthI7zn7e3DFN3Iz/uWhUURjbGdkIWncg8yy65WVEsa8otKmTJ/Pn08z/BokVZAXBVTvXE2dCKF+GKw4KDMlqUSBf14pioOyuoroqSgjv0LzGxHE/kT55XQn+dmzBZOBYFwnZRAc6bG0h84A1hQEtbYUhPhs4VPVCUe+/pFbywTiuD2Aq0FCpirGHFuUW6wdUaRgufyjbgw3E7iRq2Yi2y2ODRb2Wna8rymcKApM5HlHsz5bCpDPBX9452Oa4R7L7MQwnuguwcid8/lZdJkCXFotYWcfo6cYsrRFVUynecDu4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779957130; c=relaxed/relaxed;
	bh=hYo3db+1PGPkP3EPtz1VuyjF5E+VRFm1vqf1aw6kaRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zm9tKfhZGOz0Re2dFNW0BMMyREjGiC6JJAtDrv9xh3dtNFUrLbu5jYcho7GAgR0+jFx6v6bggBwgdSzsmsl9pReUZaktWxEND4hzKgK88Qi5epv6lyaTlcZBVrjt3zEBYMmb0DEqKzbUA2kRcxHoxt7A7PmPlsB7N68LxAKiVk9WaOheqBx405FtCjhhRdZmGzV/uBawUs5Fj50LBQk4zKSuisZGfnyBVCSq+M2ELMQ7Qz9Yc89gAlaJlere2mnRIurzNZA+j6zOWAbNAN0N+hSqE1nPNtuAun1qqn3egDfCo+v/Ot6qD8qvqYFhK4bSw8OHy2okeLWbXmj9XqS4Bw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=IePT5ML0; dkim-atps=neutral; spf=pass (client-ip=95.215.58.172; helo=out-172.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=IePT5ML0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.172; helo=out-172.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 431 seconds by postgrey-1.37 at boromir; Thu, 28 May 2026 18:32:05 AEST
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gR08j1FqXz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 18:32:04 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779956672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hYo3db+1PGPkP3EPtz1VuyjF5E+VRFm1vqf1aw6kaRc=;
	b=IePT5ML0EWqoJRpsjGFPK9RaEmWpuqkhL2RS+FKiDXEUiSN/m/+DXYcKrf/Ef+cobnELXF
	SCk93ngGK2cjPUPJ2CNS+bA839Jg++vy33YJuwLFIJM/zIsywyh04NWi4zJ7DEBuq92ppj
	PftizC92O/O7NWkigybNb42HcWUJRJo=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/boot: drop redundant assignment in serial_edit_cmdline
Date: Thu, 28 May 2026 10:23:58 +0200
Message-ID: <20260528082357.1397611-3-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=663; i=thorsten.blum@linux.dev; h=from:subject; bh=lkdiMKt+chuHKKhjQA49PAbKrSR82zgeKbHjBcbvxrE=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFniv+f9eb68/Cur7ISvGqd27Q1bt/8ac2fxtk/Pw/Jeu V1uu1z7uKOUhUGMi0FWTJHlwawfM3xLayo3mUTshJnDygQyhIGLUwAmwr+Q4X/lWQ+uHYs/xZgu OCjEdPhV+i2NPt7guscmq1a6TDgzr0qNkeFgoulJV4baXtWLfHbxcZUblWduVXCd/SVcTHlh+/f 4newA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Drop the redundant buffer assignment in serial_edit_cmdline() since the
cp pointer is immediately overwritten.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/boot/serial.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
index c6d32a8c3612..1d221ff420fd 100644
--- a/arch/powerpc/boot/serial.c
+++ b/arch/powerpc/boot/serial.c
@@ -37,7 +37,6 @@ static void serial_edit_cmdline(char *buf, int len, unsigned int timeout)
 	char ch, *cp;
 	struct serial_console_data *scdp = console_ops.data;
 
-	cp = buf;
 	count = strlen(buf);
 	cp = &buf[count];
 	count++;

