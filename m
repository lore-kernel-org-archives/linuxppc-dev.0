Return-Path: <rashmicy@gmail.com>
Received: from mail-pa0-x22e.google.com (mail-pa0-x22e.google.com
 [IPv6:2607:f8b0:400e:c03::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B536A1A1E0B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 16:08:52 +1100 (AEDT)
Received: by pabfh17 with SMTP id fh17so215240344pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2015 21:08:51 -0800 (PST)
Received: from circle.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id ux3sm55304740pac.18.2015.11.30.21.08.49
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 30 Nov 2015 21:08:50 -0800 (PST)
From: Rashmica Gupta <rashmicy@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] selftests/powerpc: Add in check for TM
Date: Tue,  1 Dec 2015 16:08:24 +1100
Message-Id: <1448946504-11653-4-git-send-email-rashmicy@gmail.com>
In-Reply-To: <1448946504-11653-1-git-send-email-rashmicy@gmail.com>
References: <1448946504-11653-1-git-send-email-rashmicy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The resched-dscr test does not currently check for TM, so add in check.

Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
---
 tools/testing/selftests/powerpc/tm/tm-resched-dscr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c b/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c
index 88c46481e59b..8243558aac6c 100644
--- a/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c
+++ b/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c
@@ -38,6 +38,8 @@ int test_body(void)
 {
 	uint64_t rv, dscr1 = 1, dscr2, texasr;
 
+	SKIP_IF(!have_htm());
+
 	printf("Check DSCR TM context switch: ");
 	fflush(stdout);
 	for (;;) {
-- 
2.5.0
