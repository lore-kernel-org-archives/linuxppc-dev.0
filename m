Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <e1b874df92f61cbd3c25bd90f6e48784dc1f632b.1214271072.git.michael@ellerman.id.au>
In-Reply-To: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
References: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 03/14] powerpc: Make create_branch() return errors if the
	branch target is too large
Date: Tue, 24 Jun 2008 11:32:24 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If you pass a target value to create_branch() which is more than 32MB - 4,
or - 32MB away from the branch site, then it's impossible to create an
immediate branch. The current code doesn't check, which will lead to us
creating a branch to somewhere else - which is bad.

For code that cares to check we return 0, which is easy to check for, and
for code that doesn't at least we'll be creating an illegal instruction,
rather than a branch to some random address.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/lib/code-patching.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 638dde3..430f4c1 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -26,12 +26,18 @@ unsigned int create_branch(const unsigned int *addr,
 			   unsigned long target, int flags)
 {
 	unsigned int instruction;
+	long offset;
 
+	offset = target;
 	if (! (flags & BRANCH_ABSOLUTE))
-		target = target - (unsigned long)addr;
+		offset = offset - (unsigned long)addr;
+
+	/* Check we can represent the target in the instruction format */
+	if (offset < -0x2000000 || offset > 0x1fffffc || offset & 0x3)
+		return 0;
 
 	/* Mask out the flags and target, so they don't step on each other. */
-	instruction = 0x48000000 | (flags & 0x3) | (target & 0x03FFFFFC);
+	instruction = 0x48000000 | (flags & 0x3) | (offset & 0x03FFFFFC);
 
 	return instruction;
 }
-- 
1.5.5
