Return-Path: <linuxppc-dev+bounces-2952-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F1ED5AE60
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Nov 2024 05:47:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XkWLC3S4Vz2yM6;
	Thu,  7 Nov 2024 16:47:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730958435;
	cv=none; b=BowWapijrjDfrCSFaU/0LAgg3Gzj/w796AFJVSo9zSApMC3k+tdI7wXBVDuDWhFotoFt8/Oa109fRAm7n0yn5KzKpfLluDAbqtKMAz++YIbg1Gans9iFqE/RzHwpUFp7k4AaG3rnL1qoQCLSgVybYFILmi0Mb6iFKFgSMR9SdN4DSyusHoRZH9VWM+7ohWOG+/L7GbHrAnFzQCyNMm0bwQH+2fkOVGMbAHSi4WTs3muCk7jyNnlI5o1LdCJ8HRzjZcsJdqGu3S3lR7t3kDOh/K9LLGOtyTHB0UOcmhyfzE1whU/EbUUJ7julmugilMW/85U87J/9Jic8CbGRTixQXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730958435; c=relaxed/relaxed;
	bh=VrE/ceSNOUhfyZbRP3CHbCQqdr/fi1pQ/kvkvoq4iug=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PoWcOhoG65gS4aDiBPDlmnqT09wQh1rzE6S3IMovkIaK0wj5n/BouTcZlcKYldoz1OKnZ/ffy3W0ZcdPXTrD3pGachLPSf4NY5IHeR5C1zeaqM+EOp0yPkpfGSaqHNOr5rAv1tsO5iWP+cVU8ckaGQLYzmRNZaj9agntc7TpGyCVm0QseWDZ438ZupL1JggJlAnICj5VJuGNquqhdr4n928XCnlGiKqV4p219WWEOttnEcYdE/BG5/WKMV/ok6/0UNA6h3CeCBNafXW/gNQ9B//5RctTeZiIwykbOinfmheO/bYFe11yh7AvHLTq+OvDGLBHq6cN1i2MUHi1KRZGLw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass (client-ip=111.22.67.139; helo=cmccmta2.chinamobile.com; envelope-from=liujing@cmss.chinamobile.com; receiver=lists.ozlabs.org) smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cmss.chinamobile.com (client-ip=111.22.67.139; helo=cmccmta2.chinamobile.com; envelope-from=liujing@cmss.chinamobile.com; receiver=lists.ozlabs.org)
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XkWL86fTWz2yGY
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2024 16:47:11 +1100 (AEDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee5672c545ba8a-e4a9c;
	Thu, 07 Nov 2024 13:47:07 +0800 (CST)
X-RM-TRANSID:2ee5672c545ba8a-e4a9c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee8672c5459fe5-52a9d;
	Thu, 07 Nov 2024 13:47:07 +0800 (CST)
X-RM-TRANSID:2ee8672c5459fe5-52a9d
From: liujing <liujing@cmss.chinamobile.com>
To: mpe@ellerman.id.au
Cc: npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	naveen@kernel.org,
	maddy@linux.ibm.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] tty:hvc:Fix incorrect formatted output
Date: Thu,  7 Nov 2024 13:47:04 +0800
Message-Id: <20241107054704.3247-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The termno parameter is defined as an unsigned int 
in hvc_opal_probe function,So when it output should 
be modified to %u format.

Signed-off-by: liujing <liujing@cmss.chinamobile.com>

diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index 095c33ad10f8..1d2e7f2ce088 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -199,7 +199,7 @@ static int hvc_opal_probe(struct platform_device *dev)
 		/* Instanciate now to establish a mapping index==vtermno */
 		hvc_instantiate(termno, termno, ops);
 	} else {
-		pr_err("hvc_opal: Device %pOF has duplicate terminal number #%d\n",
+		pr_err("hvc_opal: Device %pOF has duplicate terminal number #%u\n",
 		       dev->dev.of_node, termno);
 		return -ENXIO;
 	}
-- 
2.27.0




