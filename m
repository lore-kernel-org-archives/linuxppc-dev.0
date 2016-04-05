Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qfPbr1mjtzDq6T
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Apr 2016 20:04:56 +1000 (AEST)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 5 Apr 2016 20:04:44 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2EB6E3578052
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Apr 2016 20:04:33 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u35A4Oh458654804
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Apr 2016 20:04:33 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u35A3xGa001767
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Apr 2016 20:04:00 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH net 1/4] lib/test_bpf: Fix JMP_JSET tests
Date: Tue,  5 Apr 2016 15:32:53 +0530
Message-Id: <5e3cf7c4a971e6d2ff7a2d50bbec2e6e26883b84.1459850410.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

JMP_JSET tests incorrectly used BPF_JNE. Fix the same.

Cc: Alexei Starovoitov <ast@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 lib/test_bpf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 27a7a26..e76fa4d 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -4303,7 +4303,7 @@ static struct bpf_test tests[] = {
 		.u.insns_int = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 3),
-			BPF_JMP_IMM(BPF_JNE, R1, 2, 1),
+			BPF_JMP_IMM(BPF_JSET, R1, 2, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -4317,7 +4317,7 @@ static struct bpf_test tests[] = {
 		.u.insns_int = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 3),
-			BPF_JMP_IMM(BPF_JNE, R1, 0xffffffff, 1),
+			BPF_JMP_IMM(BPF_JSET, R1, 0xffffffff, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -4474,7 +4474,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 3),
 			BPF_LD_IMM64(R2, 2),
-			BPF_JMP_REG(BPF_JNE, R1, R2, 1),
+			BPF_JMP_REG(BPF_JSET, R1, R2, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
@@ -4489,7 +4489,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0),
 			BPF_LD_IMM64(R1, 3),
 			BPF_LD_IMM64(R2, 0xffffffff),
-			BPF_JMP_REG(BPF_JNE, R1, R2, 1),
+			BPF_JMP_REG(BPF_JSET, R1, R2, 1),
 			BPF_EXIT_INSN(),
 			BPF_ALU32_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
-- 
2.7.4
