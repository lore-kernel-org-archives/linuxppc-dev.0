Return-Path: <SRS0=oWcN=6N=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4BDC83004
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2020 08:21:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93B28206D9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2020 08:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B28206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49Bs0c3kmjzDqys
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2020 18:21:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kaod.org (client-ip=46.105.34.1; helo=3.mo173.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 3.mo173.mail-out.ovh.net (3.mo173.mail-out.ovh.net
 [46.105.34.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49Brkw6QBpzDqrq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2020 18:09:11 +1000 (AEST)
Received: from player714.ha.ovh.net (unknown [10.108.54.36])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 059DA139A49
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2020 09:51:42 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player714.ha.ovh.net (Postfix) with ESMTPSA id A7C4A11CA9184;
 Wed, 29 Apr 2020 07:51:39 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 3/3] powerpc/xive: Do not expose a debugfs file when XIVE is
 disabled
Date: Wed, 29 Apr 2020 09:51:22 +0200
Message-Id: <20200429075122.1216388-4-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200429075122.1216388-1-clg@kaod.org>
References: <20200429075122.1216388-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 3606820353710525361
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedriedvgdduvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjedugedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehlihhnuhigphhptgdquggvvheslhhishhtshdrohiilhgrsghsrdhorhhg
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
Cc: linuxppc-dev@lists.ozlabs.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The XIVE interrupt mode can be disabled with the "xive=off" kernel
parameter, in which case there is nothing to present to the user in the
associated /sys/kernel/debug/powerpc/xive file.

Fixes: 930914b7d528 ("powerpc/xive: Add a debugfs file to dump internal XIVE state")
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/sysdev/xive/common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index 3dbc94cb4380..f591be9f01f4 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -1664,7 +1664,8 @@ DEFINE_SHOW_ATTRIBUTE(xive_core_debug);
 
 int xive_core_debug_init(void)
 {
-	debugfs_create_file("xive", 0400, powerpc_debugfs_root,
-			    NULL, &xive_core_debug_fops);
+	if (xive_enabled())
+		debugfs_create_file("xive", 0400, powerpc_debugfs_root,
+				    NULL, &xive_core_debug_fops);
 	return 0;
 }
-- 
2.25.4

