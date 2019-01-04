Return-Path: <SRS0=Lr1k=PM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09597C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 23:06:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83D00218D3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 23:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D00218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43WgQB13bmzDqQQ
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Jan 2019 10:06:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.85.221.67; helo=mail-wr1-f67.google.com;
 envelope-from=mcroce@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43WdKD1Q1zzDqMG
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Jan 2019 08:31:56 +1100 (AEDT)
Received: by mail-wr1-f67.google.com with SMTP id p4so37742756wrt.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Jan 2019 13:31:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=A+2/3qYF9bkEDS/AfEXpeoXxGiPbDco3v0PCIVHdPxg=;
 b=meZU6oRwLjo2a9ZdXWp+xtGPupPpsyHpzWUPJMjPTWD/plWVNhbLb0zxL3K84h/Z3/
 AXFX/WGNsVoBKpR7cnMmWkUqWLHo8Z7sX82W6M0fcJ43faBQ0ro5lKRsbHTcBFVWTsLq
 t6zWVo/oW8F18HNyxg7vfA+OvJ4Rhu8I0/JjxbQEPrGWZrMDlkbxrKZXySyQjH514BcJ
 zgWJiTVqv+fJt0bs/tD3xDob51ebmL0ywUzGgg4dJ210TsczxxZgg+df3KNkmm1Qq6dQ
 HEZ5ahAscznYpTdxFtVpFwmcxbfFc8VQWPWJEDnI8jXONaJ00Cke97ZsS6HykZ8Ut5nQ
 BmFw==
X-Gm-Message-State: AJcUukfjl5ZBC2e8WzhW5Zt/ZzcbS1u2OnZVd1TguL6vcuK//l0bXjWj
 zKm07zUPlpPxKIKeUJGNRvPv6g==
X-Google-Smtp-Source: ALg8bN5PDPFwkApAQC4mDIN3+uryrHu2wsEqEcFELDbNztoIfqadTO71H3mv1ay8Mkm/LLIau1Wkww==
X-Received: by 2002:adf:b649:: with SMTP id i9mr47322467wre.70.1546637514014; 
 Fri, 04 Jan 2019 13:31:54 -0800 (PST)
Received: from mcroce-redhat.redhat.com
 (host177-2-dynamic.16-87-r.retail.telecomitalia.it. [87.16.2.177])
 by smtp.gmail.com with ESMTPSA id d2sm38704415wrs.97.2019.01.04.13.31.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 13:31:53 -0800 (PST)
From: Matteo Croce <mcroce@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 02/12] powerpc/hvsi: fix typo
Date: Fri,  4 Jan 2019 22:31:52 +0100
Message-Id: <20190104213152.28602-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 05 Jan 2019 10:00:31 +1100
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Fix spelling mistake: "lenght" -> "length"

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 arch/powerpc/include/asm/hvsi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/hvsi.h b/arch/powerpc/include/asm/hvsi.h
index 3fdc54df63c9..464a7519ed64 100644
--- a/arch/powerpc/include/asm/hvsi.h
+++ b/arch/powerpc/include/asm/hvsi.h
@@ -64,7 +64,7 @@ struct hvsi_priv {
 	unsigned int	inbuf_len;	/* data in input buffer */
 	unsigned char	inbuf[HVSI_INBUF_SIZE];
 	unsigned int	inbuf_cur;	/* Cursor in input buffer */
-	unsigned int	inbuf_pktlen;	/* packet lenght from cursor */
+	unsigned int	inbuf_pktlen;	/* packet length from cursor */
 	atomic_t	seqno;		/* packet sequence number */
 	unsigned int	opened:1;	/* driver opened */
 	unsigned int	established:1;	/* protocol established */
-- 
2.20.1

