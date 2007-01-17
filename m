Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 7C273DDE46
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 17:41:18 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l0H6fGuq014779
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 23:41:16 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0H6fE5B024838
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 00:41:15 -0600 (CST)
Message-ID: <45ADC54E.3030908@freescale.com>
Date: Wed, 17 Jan 2007 14:42:22 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: Paul <paulus@samba.org>
Subject: [PATCH] Fix bug in 836x and 832x platform code
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The wrongly use of of_find_node_by_name() causes of_node_put()
on a node which has already been put. It causes the refcount of
the node to underflow, which triggers the WARN_ON in kref_get
for 836x and 832x.

Signed-off-by: Li Yang <leoli@freescale.com>

---
 arch/powerpc/platforms/83xx/mpc832x_mds.c |    2 +-
 arch/powerpc/platforms/83xx/mpc8360e_pb.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index f58c978..4d47119 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -103,7 +103,7 @@ static void __init mpc832x_sys_setup_arch(void)
 #ifdef CONFIG_QUICC_ENGINE
 	qe_reset();
 
-	if ((np = of_find_node_by_name(np, "par_io")) != NULL) {
+	if ((np = of_find_node_by_name(NULL, "par_io")) != NULL) {
 		par_io_init(np);
 		of_node_put(np);
 
diff --git a/arch/powerpc/platforms/83xx/mpc8360e_pb.c b/arch/powerpc/platforms/83xx/mpc8360e_pb.c
index 7bfd47a..53b92a9 100644
--- a/arch/powerpc/platforms/83xx/mpc8360e_pb.c
+++ b/arch/powerpc/platforms/83xx/mpc8360e_pb.c
@@ -108,7 +108,7 @@ static void __init mpc8360_sys_setup_arch(void)
 #ifdef CONFIG_QUICC_ENGINE
 	qe_reset();
 
-	if ((np = of_find_node_by_name(np, "par_io")) != NULL) {
+	if ((np = of_find_node_by_name(NULL, "par_io")) != NULL) {
 		par_io_init(np);
 		of_node_put(np);
 
