Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 04655DDFD8
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 21:49:09 +1000 (EST)
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l4TBn1o6008325
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 13:49:01 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id l4TBn1xg008323
	for linuxppc-dev@ozlabs.org; Tue, 29 May 2007 13:49:01 +0200
Date: Tue, 29 May 2007 13:49:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: remove unused do_signal export
Message-ID: <20070529114901.GA7886@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

do_signal is never used in modular code (obviously), and not other
architecture exports it either.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/powerpc/kernel/ppc_ksyms.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/ppc_ksyms.c	2007-05-29 12:34:22.000000000 +0200
+++ linux-2.6/arch/powerpc/kernel/ppc_ksyms.c	2007-05-29 12:34:30.000000000 +0200
@@ -67,7 +67,6 @@ EXPORT_SYMBOL(ISA_DMA_THRESHOLD);
 EXPORT_SYMBOL(DMA_MODE_READ);
 EXPORT_SYMBOL(DMA_MODE_WRITE);
 
-EXPORT_SYMBOL(do_signal);
 EXPORT_SYMBOL(transfer_to_handler);
 EXPORT_SYMBOL(do_IRQ);
 EXPORT_SYMBOL(machine_check_exception);
Index: linux-2.6/arch/powerpc/kernel/signal_64.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/signal_64.c	2007-05-29 12:34:46.000000000 +0200
+++ linux-2.6/arch/powerpc/kernel/signal_64.c	2007-05-29 12:34:54.000000000 +0200
@@ -568,4 +568,3 @@ int do_signal(sigset_t *oldset, struct p
 
 	return 0;
 }
-EXPORT_SYMBOL(do_signal);
Index: linux-2.6/arch/ppc/kernel/ppc_ksyms.c
===================================================================
--- linux-2.6.orig/arch/ppc/kernel/ppc_ksyms.c	2007-05-29 12:34:38.000000000 +0200
+++ linux-2.6/arch/ppc/kernel/ppc_ksyms.c	2007-05-29 12:34:41.000000000 +0200
@@ -65,7 +65,6 @@ extern unsigned long mm_ptov (unsigned l
 
 EXPORT_SYMBOL(clear_pages);
 EXPORT_SYMBOL(clear_user_page);
-EXPORT_SYMBOL(do_signal);
 EXPORT_SYMBOL(transfer_to_handler);
 EXPORT_SYMBOL(do_IRQ);
 EXPORT_SYMBOL(machine_check_exception);
