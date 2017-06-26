Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wx9pH3gwYzDr1h
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 00:06:30 +1000 (AEST)
From: Michal Suchanek <msuchanek@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michal Suchanek <msuchanek@suse.de>,
 Colin Ian King <colin.king@canonical.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] powerpc/fadump: return 0 on re-registration
Date: Mon, 26 Jun 2017 16:06:00 +0200
Message-Id: <20170626140601.7106-1-msuchanek@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When fadump is already registered return success.

Currently EEXIST is returned which is difficult to handle race-free in
userspace when shell scripts are used. If multiple writers are trying to
write '1' there is no difference in whichever succeeds so just return 0
to all.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/kernel/fadump.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 436aedf195ab..5a7355381dac 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1214,7 +1214,6 @@ static ssize_t fadump_register_store(struct kobject *kobj,
 		break;
 	case '1':
 		if (fw_dump.dump_registered == 1) {
-			ret = -EEXIST;
 			goto unlock_out;
 		}
 		/* Register Firmware-assisted dump */
-- 
2.10.2
