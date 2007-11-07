Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E3874DDE3E
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 01:35:25 +1100 (EST)
Subject: [PATCH] powerpc: fix powersave-nap sysctl registration
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Wed, 07 Nov 2007 20:11:43 +0100
Message-Id: <1194462703.5996.0.camel@johannes.berg>
Mime-Version: 1.0
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The sysctl check code complains about a writable directory,
fix it.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/powerpc/kernel/idle.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- everything.orig/arch/powerpc/kernel/idle.c	2007-11-07 19:54:56.787884927 +0100
+++ everything/arch/powerpc/kernel/idle.c	2007-11-07 20:00:27.965924749 +0100
@@ -122,7 +122,7 @@ static ctl_table powersave_nap_sysctl_ro
 	{
 		.ctl_name	= CTL_KERN,
 		.procname	= "kernel",
-		.mode		= 0755,
+		.mode		= 0555,
 		.child		= powersave_nap_ctl_table,
 	},
 	{}
