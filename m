Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Fix BPF_JIT code to link with multiple TOCs
Date: Fri, 22 Jun 2012 13:50:27 +1000
Message-Id: <1340337027-22110-1-git-send-email-michael@ellerman.id.au>
Cc: matt@ozlabs.org, amodra@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the kernel is big enough (eg. allyesconfig), the linker may need to
switch TOCs when calling from the BPF JIT code out to the external
helpers (skb_copy_bits() & bpf_internal_load_pointer_neg_helper()).

In order to do that we need to leave space after the bl for the linker
to insert a reload of our TOC pointer.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/net/bpf_jit_64.S |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/net/bpf_jit_64.S b/arch/powerpc/net/bpf_jit_64.S
index 55ba385..7d3a3b5 100644
--- a/arch/powerpc/net/bpf_jit_64.S
+++ b/arch/powerpc/net/bpf_jit_64.S
@@ -105,6 +105,7 @@ sk_load_byte_msh_positive_offset:
 	mr	r4, r_addr;					\
 	li	r6, SIZE;					\
 	bl	skb_copy_bits;					\
+	nop;							\
 	/* R3 = 0 on success */					\
 	addi	r1, r1, BPF_PPC_SLOWPATH_FRAME;			\
 	ld	r0, 16(r1);					\
@@ -156,6 +157,7 @@ bpf_slow_path_byte_msh:
 	mr	r4, r_addr;					\
 	li	r5, SIZE;					\
 	bl	bpf_internal_load_pointer_neg_helper;		\
+	nop;							\
 	/* R3 != 0 on success */				\
 	addi	r1, r1, BPF_PPC_SLOWPATH_FRAME;			\
 	ld	r0, 16(r1);					\
-- 
1.7.9.5
