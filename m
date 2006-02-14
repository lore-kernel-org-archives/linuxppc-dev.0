Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3C604679F3
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Feb 2006 00:10:55 +1100 (EST)
Date: Tue, 14 Feb 2006 14:10:50 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] kprobes depends on xmon
Message-ID: <20060214131050.GA25820@suse.de>
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


KPROBES depends on XMON.
arch/powerpc/lib/step.c is only compiled if CONFIG_XMON is enabled.

arch/powerpc/kernel/built-in.o:
In function `resume_execution':arch/powerpc/kernel/kprobes.c:331: undefined reference to
`.emulate_step'

Signed-off-by: Olaf Hering <olh@suse.de>

 arch/powerpc/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.16-rc3-olh/arch/powerpc/Kconfig
===================================================================
--- linux-2.6.16-rc3-olh.orig/arch/powerpc/Kconfig
+++ linux-2.6.16-rc3-olh/arch/powerpc/Kconfig
@@ -963,7 +963,7 @@ source "arch/powerpc/oprofile/Kconfig"
 
 config KPROBES
 	bool "Kprobes (EXPERIMENTAL)"
-	depends on PPC64
+	depends on PPC64 && XMON
 	help
 	  Kprobes allows you to trap at almost any kernel address and
 	  execute a callback function.  register_kprobe() establishes
