Return-Path: <SRS0=WT2w=V6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BDFC433FF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Aug 2019 04:21:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AF342073D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Aug 2019 04:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF342073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=informatik.wtf
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 460DVx1vyjzDqf9
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Aug 2019 14:21:13 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 460DT110NWzDqkV
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Aug 2019 14:19:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=informatik.wtf
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 460DT024pBz8t7p
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Aug 2019 14:19:32 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 460DT01Yh0z9sBF; Fri,  2 Aug 2019 14:19:32 +1000 (AEST)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=informatik.wtf
 (client-ip=131.153.2.44; helo=h3.fbrelay.privateemail.com;
 envelope-from=cmr@informatik.wtf; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=informatik.wtf
Received: from h3.fbrelay.privateemail.com (h3.fbrelay.privateemail.com
 [131.153.2.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 460DSz2r7Xz9s3Z
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Aug 2019 14:19:30 +1000 (AEST)
Received: from MTA-06-3.privateemail.com (mta-06.privateemail.com
 [68.65.122.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id 985678162B
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Aug 2019 00:19:26 -0400 (EDT)
Received: from MTA-06.privateemail.com (localhost [127.0.0.1])
 by MTA-06.privateemail.com (Postfix) with ESMTP id 3921960039;
 Fri,  2 Aug 2019 00:19:19 -0400 (EDT)
Received: from wrwlf0000.attlocal.net (unknown [10.20.151.234])
 by MTA-06.privateemail.com (Postfix) with ESMTPA id C464A60055;
 Fri,  2 Aug 2019 04:19:18 +0000 (UTC)
From: "Christopher M. Riedl" <cmr@informatik.wtf>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 0/3] Fix oops in shared-processor spinlocks
Date: Thu,  1 Aug 2019 23:22:30 -0500
Message-Id: <20190802042233.20835-1-cmr@informatik.wtf>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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
Cc: "Christopher M. Riedl" <cmr@informatik.wtf>, ajd@linux.ibm.com,
 bauerman@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Fixes an oops when calling the shared-processor spinlock implementation
from a non-SP LPAR. Also take this opportunity to refactor
SHARED_PROCESSOR a bit.

Reference:  https://github.com/linuxppc/issues/issues/229

Changes since v1:
 - Improve comment wording to make it clear why the BOOK3S #ifdef is
   required in is_shared_processor() in spinlock.h
 - Replace empty #define of splpar_*_yield() with actual functions with
   empty bodies.

Christopher M. Riedl (3):
  powerpc/spinlocks: Refactor SHARED_PROCESSOR
  powerpc/spinlocks: Rename SPLPAR-only spinlocks
  powerpc/spinlocks: Fix oops in shared-processor spinlocks

 arch/powerpc/include/asm/spinlock.h | 62 +++++++++++++++++++++--------
 arch/powerpc/lib/locks.c            |  6 +--
 2 files changed, 48 insertions(+), 20 deletions(-)

-- 
2.22.0

