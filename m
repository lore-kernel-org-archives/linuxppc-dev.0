Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D9C122C0165
 for <linuxppc-dev@ozlabs.org>; Sat, 14 Sep 2013 10:49:27 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 13 Sep 2013 20:49:25 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 92BC26E803C
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Sep 2013 20:49:23 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8E0nNQK48955442
 for <linuxppc-dev@ozlabs.org>; Sat, 14 Sep 2013 00:49:23 GMT
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r8E0nMDi001619
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Sep 2013 21:49:22 -0300
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/8][v4] powerpc: Rename branch_opcode() to instr_opcode()
Date: Fri, 13 Sep 2013 17:49:13 -0700
Message-Id: <1379119755-21025-7-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1379119755-21025-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1379119755-21025-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <michaele@au1.ibm.com>, Stephane Eranian <eranian@google.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The logic used in branch_opcode() to extract the opcode for an instruction
applies to non branch instructions also. So rename to instr_opcode().

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/lib/code-patching.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 17e5b23..2bc9db3 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -72,19 +72,19 @@ unsigned int create_cond_branch(const unsigned int *addr,
 	return instruction;
 }
 
-static unsigned int branch_opcode(unsigned int instr)
+static unsigned int instr_opcode(unsigned int instr)
 {
 	return (instr >> 26) & 0x3F;
 }
 
 static int instr_is_branch_iform(unsigned int instr)
 {
-	return branch_opcode(instr) == 18;
+	return instr_opcode(instr) == 18;
 }
 
 static int instr_is_branch_bform(unsigned int instr)
 {
-	return branch_opcode(instr) == 16;
+	return instr_opcode(instr) == 16;
 }
 
 int instr_is_relative_branch(unsigned int instr)
-- 
1.7.9.5
