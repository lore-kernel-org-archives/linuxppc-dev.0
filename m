Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C907ADDF2A
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 00:40:17 +1100 (EST)
Date: Wed, 13 Feb 2008 07:37:27 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Fix initial lmb add region with a non-zero base
Message-ID: <Pine.LNX.4.64.0802130719330.14428@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: sparclinux@vger.kernel.org, davem@davemloft.net,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If we add to an empty lmb region with a non-zero base we will not coalesce
the number of regions done to one.  This causes problems on ppc32 for the
memory region as its assumed to only have one region.

We can fix this be easily specially casing the initial add to just replace
the dummy region.

---

Posting this since Dave's looking a pulling the lmb code out into lib/ and
sharing it between powerpc and sparc.

(this is my git tree git.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git)

- k

 arch/powerpc/mm/lmb.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/mm/lmb.c b/arch/powerpc/mm/lmb.c
index 4ce23bc..1ea8df0 100644
--- a/arch/powerpc/mm/lmb.c
+++ b/arch/powerpc/mm/lmb.c
@@ -141,6 +141,12 @@ static long __init lmb_add_region(struct lmb_region *rgn, unsigned long base,
 	unsigned long coalesced = 0;
 	long adjacent, i;

+	if ((rgn->cnt == 1) && (rgn->region[0].size == 0)) {
+		rgn->region[0].base = base;
+		rgn->region[0].size = size;
+		return 0;
+	}
+
 	/* First try and coalesce this LMB with another. */
 	for (i=0; i < rgn->cnt; i++) {
 		unsigned long rgnbase = rgn->region[i].base;
-- 
1.5.3.8
