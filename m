Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 73F22681B8
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Feb 2006 22:45:01 +1100 (EST)
Date: Sat, 4 Feb 2006 12:44:56 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] remove pointer/integer confusion in of_find_node_by_name
Message-ID: <20060204114456.GA19392@suse.de>
References: <20060204093456.GA15051@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20060204093456.GA15051@suse.de>
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

 arch/powerpc/kernel/prom.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.16-rc2-olh/arch/powerpc/kernel/prom.c
===================================================================
--- linux-2.6.16-rc2-olh.orig/arch/powerpc/kernel/prom.c
+++ linux-2.6.16-rc2-olh/arch/powerpc/kernel/prom.c
@@ -1398,8 +1398,8 @@ struct device_node *of_find_node_by_name
 
 	read_lock(&devtree_lock);
 	np = from ? from->allnext : allnodes;
-	for (; np != 0; np = np->allnext)
-		if (np->name != 0 && strcasecmp(np->name, name) == 0
+	for (; np != NULL; np = np->allnext)
+		if (np->name != NULL && strcasecmp(np->name, name) == 0
 		    && of_node_get(np))
 			break;
 	if (from)
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
