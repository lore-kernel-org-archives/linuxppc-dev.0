Return-Path: <linuxppc-dev+bounces-23389-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19760C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 12:06:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grbGB1zS3z2yjv;
	Thu, 02 Jul 2026 22:06:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.183
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782994002;
	cv=none; b=BeCPb9/Ypw2nVAz6cbDgyvFUnAhs0D2BjpHEZ3D20L8r/hYnDt8e6ZbSfl79w0+7Zw0SSo7diHumdokPXTPRidTAlgijkZq8neuXOITRVADOcVLMMsnlkplL0snuIZ/v4RoXkjT/AN5jDOZ3EYBmXwMsWiA45rz+ds7nKjWGs890SQWZZrmGKpigCPNj5kjuh3J9IrtzMdZi9vyGHICPxCyPDUqC3YnW8HKSEnVdwiP7LFa7w4qCMbzHgfdkkhqTgR6ZtZPGCHEgA5LSfoVBVlWyXlz2Mh5Qxs8Mr88HzOquJvMmvURsJ9kSSWJhoIqw8uVAKSRQnJluPSc1gjqdEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782994002; c=relaxed/relaxed;
	bh=EpJZ25WsLuIlkqseCrbEHPfxQ4Tt5MBUyDicJs/5yFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cw5Zdcuy04t7BJtwudH4rSImnHfDpip/93xDnZTNpDj9C2nOZfXzgDnkXkFrdkpXGdCUl5hS1EXA07kbzktO9341OyeLTh/FnQIu2+mUc4+J3kuFkN7oeYd03RgGhCNIOvfbC6jx7tP6HqIr9FtKtefwW9RldVAKt39Wsrh/2cW/swtrsqIOH392TC46CFsCpT2OYqq7RNEwk64bnPqWh9rEfDaOmFPnpmY8BnoBfgl3hsAQ34PFuGB2jd8LBg0ZUJWAEGgMEFnFZDy8TRMk3JGQbqV5idEUbQHuKody9NLrETc1YdnioT4wGXXJdmfcOxbfsXsN7y7SyOPMBHXtqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pQMCWR48; dkim-atps=neutral; spf=pass (client-ip=91.218.175.183; helo=out-183.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pQMCWR48;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.183; helo=out-183.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grbG94JmBz2yQG
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 22:06:41 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782993980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EpJZ25WsLuIlkqseCrbEHPfxQ4Tt5MBUyDicJs/5yFk=;
	b=pQMCWR48HrTKFfEiVKfi3/l06Bn2GCOjXTwUOGzFrAnKZcmvhvluO3+UaatJOkSq7qmNkD
	BpG54LO/blIyC7cRma+a7KEYb4Jo4iyWMKGYobz2/uwVbDVVmH7VZ2tkCN56ditIaondft
	9cFplZVafSFdbAsFXOZjOA4zmnZT0d0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Jiri Bohac <jbohac@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Scott Wood <oss@buserror.net>,
	Jason Yan <yanaijie@huawei.com>,
	Diana Craciun <diana.craciun@nxp.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] powerpc/kaslr_booke: Fix reserved-memory reg property length check
Date: Thu,  2 Jul 2026 14:05:51 +0200
Message-ID: <20260702120551.3046-4-thorsten.blum@linux.dev>
In-Reply-To: <20260702120551.3046-3-thorsten.blum@linux.dev>
References: <20260702120551.3046-3-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1272; i=thorsten.blum@linux.dev; h=from:subject; bh=ZZW7lUB7b9ygP6ck5Uz5hyt0C+D3AW01lrX5XsNNbiQ=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFluIQrtvdNeHSuNDfwSuzHeO7lImX/H3yfFzLp32cRfv +/TzF7cUcrCIMbFICumyPJg1o8ZvqU1lZtMInbCzGFlAhnCwMUpABMxYmdkWPU35oAA092GnbNU ZxX/NbK0UFWbdFUlQVrj/VxFjYxHqowMbRF/0x2+uN0U9H/nZOpw01O2ZDrDg3lHL/+evVczrVS SEQA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In overlaps_reserved_region(), fdt_getprop() returns the reg property
length in bytes, which the loop condition compares against a cell count.
Since each cell is 4 bytes, scale the count to bytes before comparing it
with len to avoid reading past the end of a truncated reg property.

Fixes: 6a38ea1d7b94 ("powerpc/fsl_booke/32: randomize the kernel image offset")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/mm/nohash/kaslr_booke.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/nohash/kaslr_booke.c b/arch/powerpc/mm/nohash/kaslr_booke.c
index 3e5e67c76bda..82106a9d9d4c 100644
--- a/arch/powerpc/mm/nohash/kaslr_booke.c
+++ b/arch/powerpc/mm/nohash/kaslr_booke.c
@@ -123,8 +123,8 @@ static __init bool overlaps_reserved_region(const void *fdt, u32 start,
 
 		len = 0;
 		reg = fdt_getprop(fdt, subnode, "reg", &len);
-		while (len >= (regions.reserved_mem_addr_cells +
-			       regions.reserved_mem_size_cells)) {
+		while (len >= 4 * (regions.reserved_mem_addr_cells +
+				   regions.reserved_mem_size_cells)) {
 			base = fdt32_to_cpu(reg[0]);
 			if (regions.reserved_mem_addr_cells == 2)
 				base = (base << 32) | fdt32_to_cpu(reg[1]);

