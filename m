Return-Path: <SRS0=fO6x=VZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FF9C433FF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Jul 2019 13:03:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD3CE20693
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Jul 2019 13:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD3CE20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=informatik.wtf
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45xNKj5SL3zDqRh
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Jul 2019 23:03:21 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45xNDm5ZwqzDqPP
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Jul 2019 22:59:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=informatik.wtf
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 45xNDl75Frz8syV
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Jul 2019 22:59:03 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 45xNDl6cDMz9sBZ; Sun, 28 Jul 2019 22:59:03 +1000 (AEST)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=informatik.wtf
 (client-ip=131.153.2.43; helo=h2.fbrelay.privateemail.com;
 envelope-from=cmr@informatik.wtf; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=informatik.wtf
X-Greylist: delayed 444 seconds by postgrey-1.36 at bilbo;
 Sun, 28 Jul 2019 22:59:03 AEST
Received: from h2.fbrelay.privateemail.com (h2.fbrelay.privateemail.com
 [131.153.2.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 45xNDl31Kyz9s7T
 for <linuxppc-dev@ozlabs.org>; Sun, 28 Jul 2019 22:59:03 +1000 (AEST)
Received: from MTA-08-4.privateemail.com (mta-08.privateemail.com
 [68.65.122.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by h1.fbrelay.privateemail.com (Postfix) with ESMTPS id 0472980BD4
 for <linuxppc-dev@ozlabs.org>; Sun, 28 Jul 2019 08:51:35 -0400 (EDT)
Received: from MTA-08.privateemail.com (localhost [127.0.0.1])
 by MTA-08.privateemail.com (Postfix) with ESMTP id 0FBDF60048;
 Sun, 28 Jul 2019 08:51:27 -0400 (EDT)
Received: from wrwlf0000.localdomain (unknown [10.20.151.218])
 by MTA-08.privateemail.com (Postfix) with ESMTPA id 602526003E;
 Sun, 28 Jul 2019 12:51:26 +0000 (UTC)
From: "Christopher M. Riedl" <cmr@informatik.wtf>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/3] Fix oops in shared-processor spinlocks
Date: Sun, 28 Jul 2019 07:54:35 -0500
Message-Id: <20190728125438.1550-1-cmr@informatik.wtf>
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
Cc: "Christopher M. Riedl" <cmr@informatik.wtf>, ajd@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Fixes an oops when calling the shared-processor spinlock implementation
from a non-SP LPAR. Also take this opportunity to refactor
SHARED_PROCESSOR a bit.

Reference:  https://github.com/linuxppc/issues/issues/229

Christopher M. Riedl (3):
  powerpc/spinlocks: Refactor SHARED_PROCESSOR
  powerpc/spinlocks: Rename SPLPAR-only spinlocks
  powerpc/spinlocks: Fix oops in shared-processor spinlocks

 arch/powerpc/include/asm/spinlock.h | 59 ++++++++++++++++++++---------
 arch/powerpc/lib/locks.c            |  6 +--
 2 files changed, 45 insertions(+), 20 deletions(-)

-- 
2.22.0

