Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wx9pL323rzDr2C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 00:06:34 +1000 (AEST)
From: Michal Suchanek <msuchanek@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michal Suchanek <msuchanek@suse.de>,
 Colin Ian King <colin.king@canonical.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] powerpc/fadump: use kstrtoint to handle sysfs store
Date: Mon, 26 Jun 2017 16:06:01 +0200
Message-Id: <20170626140601.7106-2-msuchanek@suse.de>
In-Reply-To: <20170626140601.7106-1-msuchanek@suse.de>
References: <20170626140601.7106-1-msuchanek@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently sysfs store handlers in fadump use if buf[0] == 'char'.

This means input "100foo" is interpreted as '1' and "01" as '0'.

Change to kstrtoint so leading zeroes and the like is handled in
expected way.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/kernel/fadump.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 5a7355381dac..241eff0b5f76 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1161,10 +1161,15 @@ static ssize_t fadump_release_memory_store(struct kobject *kobj,
 					struct kobj_attribute *attr,
 					const char *buf, size_t count)
 {
+	int input = -1;
+
 	if (!fw_dump.dump_active)
 		return -EPERM;
 
-	if (buf[0] == '1') {
+	if (kstrtoint(buf, 0, &input))
+		return -EINVAL;
+
+	if (input == 1) {
 		/*
 		 * Take away the '/proc/vmcore'. We are releasing the dump
 		 * memory, hence it will not be valid anymore.
@@ -1198,21 +1203,25 @@ static ssize_t fadump_register_store(struct kobject *kobj,
 					const char *buf, size_t count)
 {
 	int ret = 0;
+	int input = -1;
 
 	if (!fw_dump.fadump_enabled || fdm_active)
 		return -EPERM;
 
+	if (kstrtoint(buf, 0, &input))
+		return -EINVAL;
+
 	mutex_lock(&fadump_mutex);
 
-	switch (buf[0]) {
-	case '0':
+	switch (input) {
+	case 0:
 		if (fw_dump.dump_registered == 0) {
 			goto unlock_out;
 		}
 		/* Un-register Firmware-assisted dump */
 		fadump_unregister_dump(&fdm);
 		break;
-	case '1':
+	case 1:
 		if (fw_dump.dump_registered == 1) {
 			goto unlock_out;
 		}
-- 
2.10.2
