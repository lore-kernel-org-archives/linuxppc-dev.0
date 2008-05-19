Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0F6ABDDDFC
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 14:34:45 +1000 (EST)
Date: Sun, 18 May 2008 23:34:36 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Subject: [PATCH v2] lmb: Fix compile warning
In-Reply-To: <20080518.203116.199516667.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0805182333550.10619@blarg.am.freescale.net>
References: <1211136296-4572-1-git-send-email-galak@kernel.crashing.org>
	<1211136296-4572-2-git-send-email-galak@kernel.crashing.org>
	<20080518.203116.199516667.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
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
---

Cast so it works everywhere.

- k

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
