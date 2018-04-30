Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Z92z2Q4dzF26c
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2018 13:27:39 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Make it clearer that systbl check errors are errors
Date: Mon, 30 Apr 2018 13:27:36 +1000
Message-Id: <20180430032736.2862-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the systbl_chk.sh checks fail we print a message, but with no
indication that it's an error. That makes it hard to find in build
logs with eg. grep.

So prefix any output with "Error:".

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/systbl_chk.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/systbl_chk.sh b/arch/powerpc/kernel/systbl_chk.sh
index 31b6e7c358ca..f2e356c2a345 100644
--- a/arch/powerpc/kernel/systbl_chk.sh
+++ b/arch/powerpc/kernel/systbl_chk.sh
@@ -16,7 +16,7 @@ awk	'BEGIN { num = -1; }	# Ignore the beginning of the file
 	/^START_TABLE/ { num = 0; next; }
 	/^END_TABLE/ {
 		if (num != $2) {
-			printf "NR_syscalls (%s) is not one more than the last syscall (%s)\n",
+			printf "Error: NR_syscalls (%s) is not one more than the last syscall (%s)\n",
 				$2, num - 1;
 			exit(1);
 		}
@@ -25,7 +25,7 @@ awk	'BEGIN { num = -1; }	# Ignore the beginning of the file
 	{
 		if (num == -1) next;
 		if (($1 != -1) && ($1 != num)) {
-			printf "Syscall %s out of order (expected %s)\n",
+			printf "Error: Syscall %s out of order (expected %s)\n",
 				$1, num;
 			exit(1);
 		};
-- 
2.14.1
