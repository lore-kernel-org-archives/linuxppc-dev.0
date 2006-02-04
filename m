Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5658E68A31
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Feb 2006 20:35:02 +1100 (EST)
Date: Sat, 4 Feb 2006 10:34:56 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] remove pointer/integer confusion in generic_calibrate_decr
Message-ID: <20060204093456.GA15051@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


remove pointer/integer confusion

Signed-off-by: Olaf Hering <olh@suse.de>

 arch/powerpc/kernel/time.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6.16-rc2-olh/arch/powerpc/kernel/time.c
===================================================================
--- linux-2.6.16-rc2-olh.orig/arch/powerpc/kernel/time.c
+++ linux-2.6.16-rc2-olh/arch/powerpc/kernel/time.c
@@ -612,10 +612,10 @@ void __init generic_calibrate_decr(void)
 
 	ppc_tb_freq = DEFAULT_TB_FREQ;		/* hardcoded default */
 	node_found = 0;
-	if (cpu != 0) {
+	if (cpu) {
 		fp = (unsigned int *)get_property(cpu, "timebase-frequency",
 						  NULL);
-		if (fp != 0) {
+		if (fp) {
 			node_found = 1;
 			ppc_tb_freq = *fp;
 		}
@@ -626,10 +626,10 @@ void __init generic_calibrate_decr(void)
 
 	ppc_proc_freq = DEFAULT_PROC_FREQ;
 	node_found = 0;
-	if (cpu != 0) {
+	if (cpu) {
 		fp = (unsigned int *)get_property(cpu, "clock-frequency",
 						  NULL);
-		if (fp != 0) {
+		if (fp) {
 			node_found = 1;
 			ppc_proc_freq = *fp;
 		}
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
