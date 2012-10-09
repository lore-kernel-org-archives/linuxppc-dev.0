Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 18/20] powerpc/xmon: Use kallsyms_lookup_size_offset() in
 get_function_bounds()
Date: Wed, 10 Oct 2012 01:20:45 +1100
Message-Id: <1349792447-15714-18-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1349792447-15714-1-git-send-email-michael@ellerman.id.au>
References: <1349792447-15714-1-git-send-email-michael@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We throw away the name so we should use kallsyms_lookup_size_offset(),
which does what we need and nothing more.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index c6cd027..9eb1d34 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1313,15 +1313,13 @@ static void get_function_bounds(unsigned long pc, unsigned long *startp,
 				unsigned long *endp)
 {
 	unsigned long size, offset;
-	const char *name;
 
 	*startp = *endp = 0;
 	if (pc == 0)
 		return;
 
 	if (start_bus_error_jump() == 0) {
-		name = kallsyms_lookup(pc, &size, &offset, NULL, tmpstr);
-		if (name != NULL) {
+		if (kallsyms_lookup_size_offset(pc, &size, &offset)) {
 			*startp = pc - offset;
 			*endp = pc - offset + size;
 		}
-- 
1.7.9.5
