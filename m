Return-Path: <linuxppc-dev+bounces-25574-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A1A6C2A09B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 12:45:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGkQl5Q9vz3c4l;
	Fri, 07 Aug 2026 22:45:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786073575;
	cv=none; b=BrEfpGxKqhfvlmzOfC7BAlTGyd0bUb39g7BFGJ5kVMtQ2ihLjiL9sEdpeI0zTIINAFS2Nn5FZ/a0spOycghAfVkKH5bSafhG9lgfjRyxnBDcUrZKvG/TcZ4JguqwZAMiZes902kCzm3xmF1hCUetpPQsSVHP3WmCAfxVoZ98UYYZO8dmu2Vz5BKRgO1MdlbHEQrr7yPzMWQ3DUOHwHyMqn08V7JoBKnPCGXz4QiCHUccg405g/pKFFGhJQ3kyAHflPjZd/7FBLBLjhGlNKCDQcerZndRx+NTSoL9BY0CUjdRnAdrcueoKAKXQVQoqKRstA6121LjZsWQhT5PzaXKLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786073575; c=relaxed/relaxed;
	bh=PH0u6VKVcdnKq3RD4C8Jl3ruYiCzfpiU2VU9toT/gTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K0biXO65ebjCK2tRPMwR5goXdfdZZC9lnWfXRwzdi+zGhLn7UMXyRuDtVIpuxMbhl7aHcU8y3Nn7As0SIj3bMa4zeWYsWqzZSOsL+Cp8O45ngWFxca+lVnog6HCjKFMB252/kYGcXn4ZvO5CvVbTs3AJ4PFeUbaMPHHfRShmQdT/GNQNyhsfNblHtkF2zp3YbUPD9qNk/MyISzAJIdvkve0uiCtVZAll0Q6trZAuNBJfW8njqAv37+e4mXQTMFxtRLLXKA89V/41zqB8S6u9XPWmLZZHc2BsR43bAmCr0HeQHHW1chtoZlmNAYYuXxfzfYgvMLfHfJNsSd8hb3rGEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=liuxixin@kylinos.cn; receiver=lists.ozlabs.org) smtp.mailfrom=kylinos.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kylinos.cn (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=liuxixin@kylinos.cn; receiver=lists.ozlabs.org)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGV8f1NV0z3bwp
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 13:32:49 +1000 (AEST)
X-UUID: 7e894400921011f1aa26b74ffac11d73-20260807
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:33ea77ee-d0f3-4b6e-9568-4b9186e6dcaa,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:30d4aacd81b1023fa7802ba724ca08a9,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|865|898,TC:nil,Content:0|15|50
	,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7e894400921011f1aa26b74ffac11d73-20260807
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1171004808; Fri, 07 Aug 2026 11:31:36 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: [PATCH v1 3/4] powerpc/pseries: energy: bound H_BEST_ENERGY cnt and sysfs output
Date: Fri, 07 Aug 2026 11:11:14 +0800
Message-ID: <prpppc03energ.1786072274.git.liuxixin@kylinos.cn>
In-Reply-To: <cover.1786072274.git.liuxixin@kylinos.cn>
References: <cover.1786072274.git.liuxixin@kylinos.cn>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py

The H_BEST_ENERGY sysfs path takes cnt from the hypercall return buffer
and walks buf_page[2*i+1] without checking that cnt fits in the single
page allocated for the hcall, and sprintf()s into the PAGE_SIZE sysfs
buffer without remaining-space checks.

Clamp cnt to the number of u32 pairs that fit in the page, and stop
formatting before overflowing the sysfs page.

Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
---
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/pseries_energy.c b/arch/powerpc/platforms/pseries/pseries_energy.c
index fdaf85ecd39b..8344f00656e5 100644
--- a/arch/powerpc/platforms/pseries/pseries_energy.c
+++ b/arch/powerpc/platforms/pseries/pseries_energy.c
@@ -209,16 +209,28 @@
 		return -EINVAL;
 	}
 
+	/*
+	 * Each entry occupies two u32s in buf_page. Never walk past the
+	 * page, and never sprintf past the PAGE_SIZE sysfs buffer.
+	 */
 	cnt = retbuf[0];
+	if (cnt > (PAGE_SIZE / sizeof(u32)) / 2)
+		cnt = (PAGE_SIZE / sizeof(u32)) / 2;
+
 	for (i = 0; i < cnt; i++) {
 		cpu = drc_index_to_cpu(buf_page[2*i+1]);
 		if ((cpu_online(cpu) && !activate) ||
-		    (!cpu_online(cpu) && activate))
+		    (!cpu_online(cpu) && activate)) {
+			if (s - page >= PAGE_SIZE - 16)
+				break;
 			s += sprintf(s, "%d,", cpu);
+		}
 	}
 	if (s > page) { /* Something to show */
 		s--; /* Suppress last comma */
-		s += sprintf(s, "\n");
+		/* sprintf needs room for '\n' and trailing NUL. */
+		if (s - page < PAGE_SIZE - 1)
+			s += sprintf(s, "\n");
 	}
 
 	free_page((unsigned long) buf_page);
-- 
2.43.0


