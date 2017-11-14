Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ybhzl725pzDqwP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 20:29:39 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAE9TRLj115333
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 04:29:37 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2e7vjm476p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 04:29:37 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Tue, 14 Nov 2017 09:29:35 -0000
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 live-patching@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
 Balbir Singh <bsingharora@gmail.com>,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Jessica Yu <jeyu@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Aravinda Prasad <aravinda@linux.vnet.ibm.com>, Torsten Duwe <duwe@lst.de>
Subject: [PATCH v4 1/3] kernel/modules: Add REL24 relocation support of
 livepatch symbols
Date: Tue, 14 Nov 2017 04:29:08 -0500
In-Reply-To: <20171114092910.20399-1-kamalesh@linux.vnet.ibm.com>
References: <20171114092910.20399-1-kamalesh@linux.vnet.ibm.com>
Message-Id: <20171114092910.20399-2-kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Livepatch re-uses module loader function apply_relocate_add() to write
relocations, instead of managing them by arch-dependent
klp_write_module_reloc() function.

apply_relocate_add() doesn't understand livepatch symbols (marked with
SHN_LIVEPATCH symbol section index) and assumes them to be local symbols
by default for R_PPC64_REL24 relocation type. It fails with an error,
when trying to calculate offset with local_entry_offset():

 module_64: kpatch_meminfo: REL24 -1152921504897399800 out of range!

Whereas livepatch symbols are essentially SHN_UNDEF, should be
called via stub used for global calls. This issue can be fixed by
teaching apply_relocate_add() to handle both SHN_UNDEF/SHN_LIVEPATCH
symbols via the same stub. This patch extends SHN_UNDEF code to handle
livepatch symbols too.

Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
CC: Balbir Singh <bsingharora@gmail.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Cc: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: Torsten Duwe <duwe@lst.de>
---
 arch/powerpc/kernel/module_64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 0b0f896..39b01fd 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -613,7 +613,8 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 
 		case R_PPC_REL24:
 			/* FIXME: Handle weak symbols here --RR */
-			if (sym->st_shndx == SHN_UNDEF) {
+			if (sym->st_shndx == SHN_UNDEF ||
+			    sym->st_shndx == SHN_LIVEPATCH) {
 				/* External: go via stub */
 				value = stub_for_addr(sechdrs, value, me);
 				if (!value)
-- 
2.9.3
