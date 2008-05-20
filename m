Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6B127DDF17
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 15:43:44 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: paulus@samba.org
Subject: [PATCH 1/4] lmb: Fix compile warning
Date: Tue, 20 May 2008 00:43:35 -0500
Message-Id: <1211262218-13949-2-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1211262218-13949-1-git-send-email-galak@kernel.crashing.org>
References: <1211262218-13949-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, davem@davemloft.net, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

lib/lmb.c: In function 'lmb_dump_all':
lib/lmb.c:51: warning: format '%lx' expects type 'long unsigned int', but argument 2 has type 'u64'

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Acked-by: David S. Miller <davem@davemloft.net>
---
 lib/lmb.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 867f7b5..5d7b928 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -48,7 +48,8 @@ void lmb_dump_all(void)
 	}
 
 	pr_info("    reserved.cnt	  = 0x%lx\n", lmb.reserved.cnt);
-	pr_info("    reserved.size	  = 0x%lx\n", lmb.reserved.size);
+	pr_info("    reserved.size	  = 0x%llx\n",
+	    (unsigned long long)lmb.memory.size);
 	for (i=0; i < lmb.reserved.cnt ;i++) {
 		pr_info("    reserved.region[0x%lx].base       = 0x%llx\n",
 		    i, (unsigned long long)lmb.reserved.region[i].base);
-- 
1.5.4.5
