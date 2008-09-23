Return-Path: <bigeasy@www.tglx.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F2017DE1FC
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 05:54:12 +1000 (EST)
Received: from www.tglx.de (www.tglx.de [127.0.0.1])
	by www.tglx.de (8.13.8/8.13.8/TGLX-2007100201) with ESMTP id
	m8NJs4eW011997
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 21:54:04 +0200
Received: (from bigeasy@localhost)
	by www.tglx.de (8.13.8/8.13.8/Submit) id m8NJs4WB011996
	for linuxppc-dev@ozlabs.org; Tue, 23 Sep 2008 21:54:04 +0200
Date: Tue, 23 Sep 2008 21:54:04 +0200
From: Sebastian Siewior <bigeasy@linutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [RFC] powerpc/boot: add kernel,end node to the cuboot target
Message-ID: <20080923195404.GA10935@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

this could be used by the kexec userland code.

Signed-off-by: Sebastian Siewior <bigeasy@linutronix.de>
---
This is done by the 64bit kexec code allready. The 32bit doesn't use the
device tree at all. I'm not sure whether the node has to be a 32bit or
64bit value.

 arch/powerpc/boot/main.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
index 27f6af1..a8714cf 100644
--- a/arch/powerpc/boot/main.c
+++ b/arch/powerpc/boot/main.c
@@ -27,7 +27,7 @@ struct addr_range {
 
 #undef DEBUG
 
-static struct addr_range prep_kernel(void)
+static struct addr_range prep_kernel(void *chosen)
 {
 	char elfheader[256];
 	void *vmlinuz_addr = _vmlinux_start;
@@ -72,7 +72,7 @@ static struct addr_range prep_kernel(void)
 		fatal("ran out of data!  only got 0x%x of 0x%lx bytes.\n\r",
 				len, ei.loadsize);
 	printf("done 0x%x bytes\n\r", len);
-
+	setprop_val(chosen, "linux,kernel-end", (u32)(ei.memsize));
 	flush_cache(addr, ei.loadsize);
 
 	return (struct addr_range){addr, ei.memsize};
@@ -180,7 +180,7 @@ void start(void)
 	if (!chosen)
 		chosen = create_node(NULL, "chosen");
 
-	vmlinux = prep_kernel();
+	vmlinux = prep_kernel(chosen);
 	initrd = prep_initrd(vmlinux, chosen,
 			     loader_info.initrd_addr, loader_info.initrd_size);
 	prep_cmdline(chosen);
-- 
1.5.6.5
