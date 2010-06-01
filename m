Return-Path: <dkirjanov@hera.kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7C710B7D1E
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jun 2010 05:43:50 +1000 (EST)
Date: Tue, 1 Jun 2010 19:43:34 +0000
From: Denis Kirjanov <dkirjanov@hera.kernel.org>
To: arnd@arndb.de, benh@kernel.crashing.org, paulus@samba.org, jkosina@suse.cz
Subject: [PATCH] powerpc/oprofile: fix potential buffer overrun in
	op_model_cell.c
Message-ID: <20100601194334.GA4549@hera.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: robert.richter@amd.com, linuxppc-dev@ozlabs.org, oprofile-list@lists.sf.net,
	cel@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix potential initial_lfsr buffer overrun.
Writing past the end of the buffer could happen when index == ENTRIES

Signed-off-by: Denis Kirjanov <dkirjanov@kernel.org>
---
 arch/powerpc/oprofile/op_model_cell.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/oprofile/op_model_cell.c b/arch/powerpc/oprofile/op_model_cell.c
index 2c9e522..7fd90d0 100644
--- a/arch/powerpc/oprofile/op_model_cell.c
+++ b/arch/powerpc/oprofile/op_model_cell.c
@@ -1077,7 +1077,7 @@ static int calculate_lfsr(int n)
 		index = ENTRIES-1;
 
 	/* make sure index is valid */
-	if ((index > ENTRIES) || (index < 0))
+	if ((index >= ENTRIES) || (index < 0))
 		index = ENTRIES-1;
 
 	return initial_lfsr[index];
