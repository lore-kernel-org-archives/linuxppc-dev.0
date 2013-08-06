Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 01/63] powerpc: Align p_toc
Date: Wed,  7 Aug 2013 02:01:18 +1000
Message-Id: <1375804940-22050-2-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

p_toc is an 8 byte relative offset to the TOC that we place in the
text section. This means it is only 4 byte aligned where it should
be 8 byte aligned. Add an explicit alignment.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/head_64.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index b61363d..3d11d80 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -703,6 +703,7 @@ _GLOBAL(relative_toc)
 	mtlr	r0
 	blr
 
+.balign 8
 p_toc:	.llong	__toc_start + 0x8000 - 0b
 
 /*
-- 
1.8.1.2
