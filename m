Return-Path: <muriloo@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41W2MR0C82zF3Hb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 02:16:17 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6IGEsvx049328
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 12:16:15 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ka73ydads-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 12:16:15 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <muriloo@linux.ibm.com>;
 Wed, 18 Jul 2018 12:16:14 -0400
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Kees Cook <keescook@chromium.org>, Mathieu Malaterre <malat@debian.org>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/prom_init: remove linux,stdout-package property
Date: Wed, 18 Jul 2018 13:15:44 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20180718161544.12134-1-muriloo@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This property was added in 2004 and the only use of it, which was already inside
`#if 0`, was removed a month later.

Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
---
 arch/powerpc/kernel/prom_init.c | 2 --
 1 file changed, 2 deletions(-)

v1..v2:
- Move github.com links to this section so they can still end up in the mail
  archive.
- Remove Fixes: tag from commit message.
- Add Link: tag here.
- Link to v1: https://lkml.kernel.org/r/20180712171904.18971-1-muriloo@linux.ibm.com

This property was added in 2004 by

    https://github.com/mpe/linux-fullhistory/commit/689fe5072fe9a0dec914bfa4fa60aed1e54563e6

and the only use of it, which was already inside `#if 0`, was removed a month
later by

    https://github.com/mpe/linux-fullhistory/commit/1fbe5a6d90f6cd4ea610737ef488719d1a875de7

Link: https://github.com/linuxppc/linux/issues/125

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 5425dd3d6a9f..c45fb463c9e5 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2102,8 +2102,6 @@ static void __init prom_init_stdout(void)
 	stdout_node = call_prom("instance-to-package", 1, 1, prom.stdout);
 	if (stdout_node != PROM_ERROR) {
 		val = cpu_to_be32(stdout_node);
-		prom_setprop(prom.chosen, "/chosen", "linux,stdout-package",
-			     &val, sizeof(val));
 
 		/* If it's a display, note it */
 		memset(type, 0, sizeof(type));
-- 
2.17.1
