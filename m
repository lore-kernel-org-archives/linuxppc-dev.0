Return-Path: <olh@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8794768A60
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Feb 2006 23:33:51 +1100 (EST)
Date: Sat, 4 Feb 2006 13:33:46 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] fix compile warning in udbg_init_maple_realmode
Message-ID: <20060204123346.GA20490@suse.de>
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


arch/powerpc/kernel/udbg_16550.c: In function `udbg_init_maple_realmode':
arch/powerpc/kernel/udbg_16550.c:162: warning: assignment from incompatible pointer type

Signed-off-by: Olaf Hering <olh@suse.de>

 arch/powerpc/kernel/udbg_16550.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.16-rc2-olh/arch/powerpc/kernel/udbg_16550.c
===================================================================
--- linux-2.6.16-rc2-olh.orig/arch/powerpc/kernel/udbg_16550.c
+++ linux-2.6.16-rc2-olh/arch/powerpc/kernel/udbg_16550.c
@@ -144,7 +144,7 @@ unsigned int udbg_probe_uart_speed(void 
 }
 
 #ifdef CONFIG_PPC_MAPLE
-void udbg_maple_real_putc(unsigned char c)
+void udbg_maple_real_putc(char c)
 {
 	if (udbg_comport) {
 		while ((real_readb(&udbg_comport->lsr) & LSR_THRE) == 0)
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
