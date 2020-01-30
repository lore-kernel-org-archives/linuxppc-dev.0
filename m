Return-Path: <SRS0=bRiG=3T=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E54CC2D0DB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jan 2020 16:19:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3D0620707
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jan 2020 16:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="X9LhxdZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3D0620707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 487lsd6gP0zDqc6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jan 2020 03:19:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.a=rsa-sha256
 header.s=mail header.b=X9LhxdZE; dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 487ldk2kzxzDqSY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2020 03:08:42 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 487ldd2zQzz9v6KQ;
 Thu, 30 Jan 2020 17:08:37 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=X9LhxdZE; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id XQHp63Tpvetz; Thu, 30 Jan 2020 17:08:37 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 487ldd1fxlz9v6KL;
 Thu, 30 Jan 2020 17:08:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1580400517; bh=opdc97PQgpxv6WQptdNj4QCI44pmYV4DmS9A7ZMKMhQ=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=X9LhxdZERdpj1RBH8cqlpbU6LLGFypCEgKkf8NcHPPpy3gWter1LkiyWIlC6uktg6
 kzf/3qWUxytjj5VRX1tRXLg5+Z5BtjWDg3U6VgiPHUlvsfk0pt0sYCjp1Uri9fEIoW
 V+Q6tiVn2QT+7A17JjIukPkJRO0tRsoFs8M72X+I=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id BD1698B87B;
 Thu, 30 Jan 2020 17:08:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id a3HgqEy-UMm0; Thu, 30 Jan 2020 17:08:38 +0100 (CET)
Received: from po14934vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 815438B877;
 Thu, 30 Jan 2020 17:08:38 +0100 (CET)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 4DDC065283; Thu, 30 Jan 2020 16:08:38 +0000 (UTC)
Message-Id: <47500ae9aa628aead4c5b5a71d5279268cdddb48.1580399657.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1580399657.git.christophe.leroy@c-s.fr>
References: <cover.1580399657.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 4/6] lib/vdso: Allow fixed clock mode
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 nathanl@linux.ibm.com, arnd@arndb.de, tglx@linutronix.de,
 vincenzo.frascino@arm.com, luto@kernel.org
Date: Thu, 30 Jan 2020 16:08:38 +0000 (UTC)
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

Some architectures have a fixed clocksource which is known at compile
time and cannot be replaced or disabled at runtime, e.g. timebase on
PowerPC. For such cases the clock mode check in the VDSO code is
pointless.

Therefore, give architectures the opportunity to redefine the way
clock_mode is checked by moving the check into an
__arch_vdso_capable() macro.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 lib/vdso/gettimeofday.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 72d65dd50cb4..0b4b71880f22 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -120,12 +120,18 @@ static __always_inline int do_hres(const struct vdso_data *vd, clockid_t clk,
 			cpu_relax();
 		}
 		smp_rmb();
+#ifdef __arch_vdso_capable
+		if (unlikely(!__arch_vdso_capable(vd->clock_mode)))
+			return -1;
+#endif
 
 		cycles = __arch_get_hw_counter(vd->clock_mode);
 		ns = vdso_ts->nsec;
 		last = vd->cycle_last;
+#ifndef __arch_vdso_capable
 		if (unlikely((s64)cycles < 0))
 			return -1;
+#endif
 
 		ns += vdso_calc_delta(cycles, last, vd->mask, vd->mult);
 		ns >>= vd->shift;
-- 
2.25.0

