Return-Path: <SRS0=Hff1=NE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E087C004D3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 07:38:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93689204FD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 07:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pfkrmEOR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93689204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42g2F51TYszDrNS
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 18:38:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pfkrmEOR";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=baylibre.com
 (client-ip=2a00:1450:4864:20::341; helo=mail-wm1-x341.google.com;
 envelope-from=clabbe@baylibre.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="pfkrmEOR"; 
 dkim-atps=neutral
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42g29y5PqPzDqfP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 18:36:06 +1100 (AEDT)
Received: by mail-wm1-x341.google.com with SMTP id 143-v6so4210256wmf.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 00:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ODwBHD32jhW5oV5hnzfkQNF20S9JHF60nxTCzvRSMYs=;
 b=pfkrmEORvWmmg6GoJ03HKgHQ8eTPVFFjYvexK1/zzvQJg7xheXYDhOUzbe4ACG5Gxd
 Bw9QisgsUh/U4Pt90JYcgjXSceSyQuCTGLLFwwlJxvhl+xNEdBeRlu/kZrt4K9nWlvvY
 q0p206waxa2KR5mKjmrHL3JKegjqLlkYkG5UsPIMauavt9eSJ/NvbZ5+JsdhvOw+Cj1b
 M7liZto0DEioToL16biSi4evCbACexl2fMZQpDf8wbVWFaS+xhra/oYO0UI+JgT+FPyV
 dwymaBxmoUsPVQWoNj1RvQJA3PnHi225DYgNJm54qrEtVF6GBvdkoB24jbL6jHatWYL4
 DzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ODwBHD32jhW5oV5hnzfkQNF20S9JHF60nxTCzvRSMYs=;
 b=eYNgw5inxgx5ZojkYnYbeLBFmjM/0d+36VsjCAFRBUXla4RL1z3UTzGojFXHiX+Hm9
 zGo+SGr46dmG51BSIKJFnybiWfjX2Jw0+0h7HMn9spYhh0OblvQdwuES6lm1MYMceGKc
 0X7/dtKZMJw5J0qyH1maTghi1blwrOmn3vVEQCveThHGBztpi4VocZ/fC+kPJjtuRk/Y
 nUKVDiASe3JSYVMg+yDtf1vSlZPTTySzsKKkNlGO61MHHdYVQF0pW/4RRE/j3TmBvuAn
 dqFeR1qewits2GqWPdlkFAOk0rkxIxAUjT1LEplf+MJxXF21fo6XmV6pgRHeeSJN9ma6
 O23A==
X-Gm-Message-State: AGRZ1gKW0++m7m+ZxjoNulDZKFcg7S2g1m5vGYmcfdla1gtUlQ6EGM+g
 ndSXJi16zS1si2ShVLgY+DH00w==
X-Google-Smtp-Source: AJdET5d78+A2+vMixTRSJJBFDDMLMmQrKX+AsmD1m7hBABZmN4pDksUn2KpW3a6Wd6LQVPP2Wj7WjA==
X-Received: by 2002:a1c:9d90:: with SMTP id
 g138-v6mr1469825wme.41.1540366563869; 
 Wed, 24 Oct 2018 00:36:03 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
 by smtp.googlemail.com with ESMTPSA id
 b139-v6sm6254351wmd.36.2018.10.24.00.36.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 24 Oct 2018 00:36:03 -0700 (PDT)
From: Corentin Labbe <clabbe@baylibre.com>
To: Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de,
 airlied@linux.ie, alexandre.torgue@st.com, alistair@popple.id.au,
 benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net,
 galak@kernel.crashing.org, joabreu@synopsys.com, khilman@baylibre.com,
 matthias.bgg@gmail.com, maxime.ripard@bootlin.com, michal.lkml@markovi.net,
 mpe@ellerman.id.au, mporter@kernel.crashing.org, narmstrong@baylibre.com,
 nicolas.palix@imag.fr, oss@buserror.net, paulus@samba.org,
 peppe.cavallaro@st.com, tj@kernel.org, vitb@kernel.crashing.org,
 wens@csie.org
Subject: [PATCH v3 2/7] include: add setbits_leXX/clrbits_leXX/clrsetbits_leXX
 in linux/setbits.h
Date: Wed, 24 Oct 2018 07:35:48 +0000
Message-Id: <1540366553-18541-3-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540366553-18541-1-git-send-email-clabbe@baylibre.com>
References: <1540366553-18541-1-git-send-email-clabbe@baylibre.com>
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org,
 linux-sunxi@googlegroups.com, linux-mediatek@lists.infradead.org,
 Corentin Labbe <clabbe@baylibre.com>, linux-amlogic@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, cocci@systeme.lip6.fr,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch adds setbits_le32/clrbits_le32/clrsetbits_le32 and
setbits_le64/clrbits_le64/clrsetbits_le64 in linux/setbits.h header.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 include/linux/setbits.h | 84 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 include/linux/setbits.h

diff --git a/include/linux/setbits.h b/include/linux/setbits.h
new file mode 100644
index 000000000000..c82faf8d7fe4
--- /dev/null
+++ b/include/linux/setbits.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_SETBITS_H
+#define __LINUX_SETBITS_H
+
+#include <linux/io.h>
+
+#define __setbits(rfn, wfn, addr, set) wfn((rfn(addr) | (set)), addr)
+#define __clrbits(rfn, wfn, addr, mask) wfn((rfn(addr) & ~(mask)), addr)
+#define __clrsetbits(rfn, wfn, addr, mask, set) wfn(((rfn(addr) & ~(mask)) | (set)), addr)
+#define __setclrbits(rfn, wfn, addr, mask, set) wfn(((rfn(addr) | (set)) & ~(mask)), addr)
+
+#ifndef setbits_le32
+#define setbits_le32(addr, set) __setbits(readl, writel, addr, set)
+#endif
+#ifndef setbits_le32_relaxed
+#define setbits_le32_relaxed(addr, set) __setbits(readl_relaxed, writel_relaxed, \
+					       addr, set)
+#endif
+
+#ifndef clrbits_le32
+#define clrbits_le32(addr, mask) __clrbits(readl, writel, addr, mask)
+#endif
+#ifndef clrbits_le32_relaxed
+#define clrbits_le32_relaxed(addr, mask) __clrbits(readl_relaxed, writel_relaxed, \
+						addr, mask)
+#endif
+
+#ifndef clrsetbits_le32
+#define clrsetbits_le32(addr, mask, set) __clrsetbits(readl, writel, addr, mask, set)
+#endif
+#ifndef clrsetbits_le32_relaxed
+#define clrsetbits_le32_relaxed(addr, mask, set) __clrsetbits(readl_relaxed, \
+							   writel_relaxed, \
+							   addr, mask, set)
+#endif
+
+#ifndef setclrbits_le32
+#define setclrbits_le32(addr, mask, set) __setclrbits(readl, writel, addr, mask, set)
+#endif
+#ifndef setclrbits_le32_relaxed
+#define setclrbits_le32_relaxed(addr, mask, set) __setclrbits(readl_relaxed, \
+							   writel_relaxed, \
+							   addr, mask, set)
+#endif
+
+/* We cannot use CONFIG_64BIT as some x86 drivers use non-atomicwriteq() */
+#if defined(writeq) && defined(readq)
+#ifndef setbits_le64
+#define setbits_le64(addr, set) __setbits(readq, writeq, addr, set)
+#endif
+#ifndef setbits_le64_relaxed
+#define setbits_le64_relaxed(addr, set) __setbits(readq_relaxed, writeq_relaxed, \
+					       addr, set)
+#endif
+
+#ifndef clrbits_le64
+#define clrbits_le64(addr, mask) __clrbits(readq, writeq, addr, mask)
+#endif
+#ifndef clrbits_le64_relaxed
+#define clrbits_le64_relaxed(addr, mask) __clrbits(readq_relaxed, writeq_relaxed, \
+						addr, mask)
+#endif
+
+#ifndef clrsetbits_le64
+#define clrsetbits_le64(addr, mask, set) __clrsetbits(readq, writeq, addr, mask, set)
+#endif
+#ifndef clrsetbits_le64_relaxed
+#define clrsetbits_le64_relaxed(addr, mask, set) __clrsetbits(readq_relaxed, \
+							   writeq_relaxed, \
+							   addr, mask, set)
+#endif
+
+#ifndef setclrbits_le64
+#define setclrbits_le64(addr, mask, set) __setclrbits(readq, writeq, addr, mask, set)
+#endif
+#ifndef setclrbits_le64_relaxed
+#define setclrbits_le64_relaxed(addr, mask, set) __setclrbits(readq_relaxed, \
+							   writeq_relaxed, \
+							   addr, mask, set)
+#endif
+
+#endif /* writeq/readq */
+
+#endif /* __LINUX_SETBITS_H */
-- 
2.18.1

