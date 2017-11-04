Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yTsWb0JhlzDr5S
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Nov 2017 08:33:30 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Russell Currey <ruscur@russell.cc>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: eeh: stop using do_gettimeofday()
Date: Sat,  4 Nov 2017 22:26:52 +0100
Message-Id: <20171104212727.3228606-1-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This interface is inefficient and deprecated because of the y2038
overflow.

ktime_get_seconds() is an appropriate replacement here, since it
has sufficient granularity but is more efficient and uses monotonic
time.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/include/asm/eeh.h   | 2 +-
 arch/powerpc/kernel/eeh_driver.c | 2 +-
 arch/powerpc/kernel/eeh_pe.c     | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index cd1df96335e5..5161c37dd039 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -93,7 +93,7 @@ struct eeh_pe {
 	struct pci_bus *bus;		/* Top PCI bus for bus PE	*/
 	int check_count;		/* Times of ignored error	*/
 	int freeze_count;		/* Times of froze up		*/
-	struct timeval tstamp;		/* Time on first-time freeze	*/
+	time64_t tstamp;		/* Time on first-time freeze	*/
 	int false_positives;		/* Times of reported #ff's	*/
 	atomic_t pass_dev_cnt;		/* Count of passed through devs	*/
 	struct eeh_pe *parent;		/* Parent PE			*/
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 4e1b433f6cb5..4f71e4c9beb7 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -623,7 +623,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
 				struct eeh_rmv_data *rmv_data)
 {
 	struct pci_bus *frozen_bus = eeh_pe_bus_get(pe);
-	struct timeval tstamp;
+	time64_t tstamp;
 	int cnt, rc;
 	struct eeh_dev *edev;
 
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 2e8d1b2b5af4..2d4956e97aa9 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -526,16 +526,16 @@ int eeh_rmv_from_parent_pe(struct eeh_dev *edev)
  */
 void eeh_pe_update_time_stamp(struct eeh_pe *pe)
 {
-	struct timeval tstamp;
+	time64_t tstamp;
 
 	if (!pe) return;
 
 	if (pe->freeze_count <= 0) {
 		pe->freeze_count = 0;
-		do_gettimeofday(&pe->tstamp);
+		pe->tstamp = ktime_get_seconds();
 	} else {
-		do_gettimeofday(&tstamp);
-		if (tstamp.tv_sec - pe->tstamp.tv_sec > 3600) {
+		tstamp = ktime_get_seconds();
+		if (tstamp - pe->tstamp > 3600) {
 			pe->tstamp = tstamp;
 			pe->freeze_count = 0;
 		}
-- 
2.9.0
