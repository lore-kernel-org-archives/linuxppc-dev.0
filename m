Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 622A06882A
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Nov 2005 00:04:11 +1100 (EST)
Date: Tue, 29 Nov 2005 14:04:05 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Message-ID: <20051129130405.GA19793@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: [PATCH] prevent stack corruption in call_prom_ret
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Use the correct pointer to clear the memory of the return values,
to prevent stack corruption in the callers stackframe.

Signed-off-by: Olaf Hering <olh@suse.de>

 arch/powerpc/kernel/prom_init.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.15-rc3-olh/arch/powerpc/kernel/prom_init.c
===================================================================
--- linux-2.6.15-rc3-olh.orig/arch/powerpc/kernel/prom_init.c
+++ linux-2.6.15-rc3-olh/arch/powerpc/kernel/prom_init.c
@@ -265,7 +265,7 @@ static int __init call_prom_ret(const ch
 	va_end(list);
 
 	for (i = 0; i < nret; i++)
-		rets[nargs+i] = 0;
+		args.args[nargs+i] = 0;
 
 	if (enter_prom(&args, RELOC(prom_entry)) < 0)
 		return PROM_ERROR;
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
