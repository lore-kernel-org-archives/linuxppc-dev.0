Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4FEA167B33
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Feb 2006 01:00:16 +1100 (EST)
Date: Fri, 10 Feb 2006 15:00:08 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] poison invalid cpus
Message-ID: <20060210140008.GA11864@suse.de>
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


from Anton Blanchard <anton@samba.org>
Novell bug145459

Ensure that per cpu access to !possible cpus causes a fault instead of silent
corruption.

Signed-off-by: Olaf Hering <olh@suse.de>

 arch/powerpc/kernel/setup_64.c |    8 ++++++++
 1 files changed, 8 insertions(+)

Index: linux-2.6.16-rc1-git3/arch/powerpc/kernel/setup_64.c
===================================================================
--- linux-2.6.16-rc1-git3.orig/arch/powerpc/kernel/setup_64.c
+++ linux-2.6.16-rc1-git3/arch/powerpc/kernel/setup_64.c
@@ -670,6 +670,14 @@ void __init setup_per_cpu_areas(void)
 		size = PERCPU_ENOUGH_ROOM;
 #endif
 
+	/*
+	 * Poison invalid cpus, with lots of high bits set this should
+	 * always fault
+	 */
+	for (i = 0; i < NR_CPUS; i++) {
+		paca[i].data_offset = 0xeeeeeeeeeeeeeeeeULL;
+	}
+
 	for_each_cpu(i) {
 		ptr = alloc_bootmem_node(NODE_DATA(cpu_to_node(i)), size);
 		if (!ptr)
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
