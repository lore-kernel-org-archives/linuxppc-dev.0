Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 557FC679FF
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2006 05:39:42 +1100 (EST)
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id E59D1E250
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2006 19:39:36 +0100 (CET)
Date: Mon, 20 Feb 2006 19:39:36 +0100
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] change compat shmget size arg to signed
Message-ID: <20060220183936.GA31091@suse.de>
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


change second arg (the 'size') to signed to handle a size of -1.
ltp test shmget02 fails. This patch fixes it.
Oddly, we see the failure only on a POWER4 LPAR with 4.6G ram.

Signed-off-by: Olaf Hering <olh@suse.de>

 arch/powerpc/kernel/sys_ppc32.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.16-rc4-olh/arch/powerpc/kernel/sys_ppc32.c
===================================================================
--- linux-2.6.16-rc4-olh.orig/arch/powerpc/kernel/sys_ppc32.c
+++ linux-2.6.16-rc4-olh/arch/powerpc/kernel/sys_ppc32.c
@@ -429,7 +429,7 @@ long compat_sys_ipc(u32 call, u32 first,
 		return sys_shmdt(compat_ptr(ptr));
 	case SHMGET:
 		/* sign extend key_t */
-		return sys_shmget((int)first, second, third);
+		return sys_shmget((int)first, (int)second, third);
 	case SHMCTL:
 		/* sign extend shmid */
 		return compat_sys_shmctl((int)first, second, compat_ptr(ptr));
