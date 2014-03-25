Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0235.hostedemail.com
 [216.40.44.235]) by ozlabs.org (Postfix) with ESMTP id 864AC140086
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Mar 2014 06:35:17 +1100 (EST)
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] powerpc: Convert last uses of __FUNCTION__ to __func__
Date: Tue, 25 Mar 2014 12:35:03 -0700
Message-Id: <1f882e154533d5f76a6d740cf27a97e6e1500718.1395775901.git.joe@perches.com>
In-Reply-To: <cover.1395775901.git.joe@perches.com>
References: <cover.1395775901.git.joe@perches.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Just about all of these have been converted to __func__,
so convert the last uses.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/powerpc/platforms/pseries/nvram.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index d7096f2..0cc240b 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -298,13 +298,13 @@ int nvram_write_os_partition(struct nvram_os_partition *part, char * buff,
 
 	rc = ppc_md.nvram_write((char *)&info, sizeof(struct err_log_info), &tmp_index);
 	if (rc <= 0) {
-		pr_err("%s: Failed nvram_write (%d)\n", __FUNCTION__, rc);
+		pr_err("%s: Failed nvram_write (%d)\n", __func__, rc);
 		return rc;
 	}
 
 	rc = ppc_md.nvram_write(buff, length, &tmp_index);
 	if (rc <= 0) {
-		pr_err("%s: Failed nvram_write (%d)\n", __FUNCTION__, rc);
+		pr_err("%s: Failed nvram_write (%d)\n", __func__, rc);
 		return rc;
 	}
 	
@@ -351,15 +351,14 @@ int nvram_read_partition(struct nvram_os_partition *part, char *buff,
 					sizeof(struct err_log_info),
 					&tmp_index);
 		if (rc <= 0) {
-			pr_err("%s: Failed nvram_read (%d)\n", __FUNCTION__,
-									rc);
+			pr_err("%s: Failed nvram_read (%d)\n", __func__, rc);
 			return rc;
 		}
 	}
 
 	rc = ppc_md.nvram_read(buff, length, &tmp_index);
 	if (rc <= 0) {
-		pr_err("%s: Failed nvram_read (%d)\n", __FUNCTION__, rc);
+		pr_err("%s: Failed nvram_read (%d)\n", __func__, rc);
 		return rc;
 	}
 
@@ -869,7 +868,7 @@ static void oops_to_nvram(struct kmsg_dumper *dumper,
 		break;
 	default:
 		pr_err("%s: ignoring unrecognized KMSG_DUMP_* reason %d\n",
-						__FUNCTION__, (int) reason);
+		       __func__, (int) reason);
 		return;
 	}
 
-- 
1.8.1.2.459.gbcd45b4.dirty
