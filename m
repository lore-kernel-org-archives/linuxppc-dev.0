Return-Path: <SRS0=KcrN=2N=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E34C2D0C0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Dec 2019 14:48:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ACE420709
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Dec 2019 14:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="KCu8JdhV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ACE420709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47hMfH3z8szDqM7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Dec 2019 01:48:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="KCu8JdhV"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47hMGm5kjYzDqKj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Dec 2019 01:31:12 +1100 (AEDT)
Received: from localhost (mailhub1-ext [192.168.12.233])
 by localhost (Postfix) with ESMTP id 47hMGZ4Tyvz9txjv;
 Mon, 23 Dec 2019 15:31:02 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=KCu8JdhV; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id mFPGrRR_Px4H; Mon, 23 Dec 2019 15:31:02 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 47hMGZ3S6Mz9txhg;
 Mon, 23 Dec 2019 15:31:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1577111462; bh=gGQQWU2/OzDgivXq6POKzHHoU8nAP0pffpFK4Hw4f5o=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=KCu8JdhV8ril/SLZ2cIjpvSR6KUhaaxUBf12AAawmc6m9awzyxj0erkSut9SwKMy4
 lIa9o/tvu2IQe7H4F3ik2pCVBURsKq/6FA5TZsotz4+/RJuPrSovLLYC7Qh7aSnqoZ
 0urZbdFBzVdeOA77s9XkFrxcctol1LftVrxIWgMg=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 908908B7AB;
 Mon, 23 Dec 2019 15:31:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 0Ts-AinkXcCE; Mon, 23 Dec 2019 15:31:07 +0100 (CET)
Received: from po16098vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.230.100])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 6226C8B7A1;
 Mon, 23 Dec 2019 15:31:07 +0100 (CET)
Received: by po16098vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 6C7BC637D4; Mon, 23 Dec 2019 14:31:07 +0000 (UTC)
Message-Id: <21e8afa38c02ca8672c2690307383507fe63b454.1577111367.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1577111363.git.christophe.leroy@c-s.fr>
References: <cover.1577111363.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 06/10] lib: vdso: make do_coarse() return 0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 arnd@arndb.de, tglx@linutronix.de, vincenzo.frascino@arm.com,
 luto@kernel.org
Date: Mon, 23 Dec 2019 14:31:07 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

do_coarse() is similare to do_hres() except that it never
fails.

Change its type to int instead of void and get it return 0
at all time. This cleans the code a bit.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 lib/vdso/gettimeofday.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 86d5b1c8796b..17b4cff6e5f0 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -64,7 +64,7 @@ static inline int do_hres(const struct vdso_data *vd, clockid_t clk,
 	return 0;
 }
 
-static void do_coarse(const struct vdso_data *vd, clockid_t clk,
+static int do_coarse(const struct vdso_data *vd, clockid_t clk,
 		      struct __kernel_timespec *ts)
 {
 	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
@@ -75,6 +75,8 @@ static void do_coarse(const struct vdso_data *vd, clockid_t clk,
 		ts->tv_sec = vdso_ts->sec;
 		ts->tv_nsec = vdso_ts->nsec;
 	} while (unlikely(vdso_read_retry(vd, seq)));
+
+	return 0;
 }
 
 static __maybe_unused int
@@ -92,14 +94,13 @@ __cvdso_clock_gettime(const struct vdso_data *vd, clockid_t clock,
 	 * clocks are handled in the VDSO directly.
 	 */
 	msk = 1U << clock;
-	if (likely(msk & VDSO_HRES)) {
+	if (likely(msk & VDSO_HRES))
 		return do_hres(&vd[CS_HRES_COARSE], clock, ts);
-	} else if (msk & VDSO_COARSE) {
-		do_coarse(&vd[CS_HRES_COARSE], clock, ts);
-		return 0;
-	} else if (msk & VDSO_RAW) {
+	else if (msk & VDSO_COARSE)
+		return do_coarse(&vd[CS_HRES_COARSE], clock, ts);
+	else if (msk & VDSO_RAW)
 		return do_hres(&vd[CS_RAW], clock, ts);
-	}
+
 	return -1;
 }
 
-- 
2.13.3

