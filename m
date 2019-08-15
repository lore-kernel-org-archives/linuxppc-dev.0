Return-Path: <SRS0=to3W=WL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAD7C31E40
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Aug 2019 05:06:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D3D208C2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Aug 2019 05:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D3D208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=informatik.wtf
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 468DvT5c9rzDr4D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Aug 2019 15:06:45 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 468DqC5YmTzDqk8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2019 15:03:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=informatik.wtf
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 468DqC4FCYz8syQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2019 15:03:03 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 468DqC41v5z9sNx; Thu, 15 Aug 2019 15:03:03 +1000 (AEST)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=informatik.wtf
 (client-ip=131.153.2.43; helo=h2.fbrelay.privateemail.com;
 envelope-from=cmr@informatik.wtf; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=informatik.wtf
Received: from h2.fbrelay.privateemail.com (h2.fbrelay.privateemail.com
 [131.153.2.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 468DqB5bx6z9sNF
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Aug 2019 15:03:02 +1000 (AEST)
Received: from MTA-06-3.privateemail.com (mta-06.privateemail.com
 [68.65.122.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by h1.fbrelay.privateemail.com (Postfix) with ESMTPS id C90658139E
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Aug 2019 01:02:58 -0400 (EDT)
Received: from MTA-06.privateemail.com (localhost [127.0.0.1])
 by MTA-06.privateemail.com (Postfix) with ESMTP id 6AA1F60065;
 Thu, 15 Aug 2019 01:02:53 -0400 (EDT)
Received: from wrwlf0000.attlocal.net (unknown [10.20.151.220])
 by MTA-06.privateemail.com (Postfix) with ESMTPA id 1D2E360063;
 Thu, 15 Aug 2019 05:02:53 +0000 (UTC)
From: "Christopher M. Riedl" <cmr@informatik.wtf>
To: linuxppc-dev@ozlabs.org,
	kernel-hardening@lists.openwall.com
Subject: [RFC PATCH v4 0/2] Restrict xmon when kernel is locked down
Date: Thu, 15 Aug 2019 00:06:14 -0500
Message-Id: <20190815050616.2547-1-cmr@informatik.wtf>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Xmon should be either fully or partially disabled depending on the
kernel lockdown state.

Put xmon into read-only mode for lockdown=integrity and completely
disable xmon when lockdown=confidentiality. Since this can occur
dynamically, there may be pre-existing, active breakpoints in xmon when
transitioning into read-only mode. These breakpoints will still trigger,
so allow them to be listed, but not cleared or altered, using xmon.

Changes since v3:
 - Allow active breakpoints to be shown/listed in read-only mode

Changes since v2:
 - Rebased onto v36 of https://patchwork.kernel.org/cover/11049461/
   (based on: f632a8170a6b667ee4e3f552087588f0fe13c4bb)
 - Do not clear existing breakpoints when transitioning from
   lockdown=none to lockdown=integrity
 - Remove line continuation and dangling quote (confuses checkpatch.pl)
   from the xmon command help/usage string

Christopher M. Riedl (2):
  powerpc/xmon: Allow listing active breakpoints in read-only mode
  powerpc/xmon: Restrict when kernel is locked down

 arch/powerpc/xmon/xmon.c     | 78 ++++++++++++++++++++++++++++++++----
 include/linux/security.h     |  2 +
 security/lockdown/lockdown.c |  2 +
 3 files changed, 74 insertions(+), 8 deletions(-)

-- 
2.22.0

