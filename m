Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42KRsK6JLzzF13T
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 02:50:45 +1000 (AEST)
Message-Id: <281b090b4788a3bdd442033590289f23d4c061a3.1537892498.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1537892498.git.christophe.leroy@c-s.fr>
References: <cover.1537892498.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 02/22] powerpc/code-patching: add a helper to get the
 address of a patch_site
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 25 Sep 2018 16:50:42 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds a helper to get the address of a patch_site

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/code-patching.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index 31733a95bbd0..bca48cc1b6ad 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -36,6 +36,11 @@ int raw_patch_instruction(unsigned int *addr, unsigned int instr);
 int patch_instruction_site(s32 *addr, unsigned int instr);
 int patch_branch_site(s32 *site, unsigned long target, int flags);
 
+static inline unsigned long site_addr(s32 *site)
+{
+	return (unsigned long)site + *site;
+}
+
 int instr_is_relative_branch(unsigned int instr);
 int instr_is_relative_link_branch(unsigned int instr);
 int instr_is_branch_to_addr(const unsigned int *instr, unsigned long addr);
-- 
2.13.3
