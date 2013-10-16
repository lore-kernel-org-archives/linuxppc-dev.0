Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e35.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 18CED2C00C8
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 13:07:10 +1100 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 15 Oct 2013 20:07:09 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 91C2F3E40042
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Oct 2013 20:07:07 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9G277MD300012
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Oct 2013 20:07:07 -0600
Received: from d03av04.boulder.ibm.com (localhost [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9G276LO022480
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Oct 2013 20:07:06 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: [PATCH 01/10][v6] powerpc: Rename branch_opcode() to instr_opcode()
Date: Tue, 15 Oct 2013 19:06:33 -0700
Message-Id: <1381889202-16826-2-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1381889202-16826-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1381889202-16826-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: Michael Ellerman <michaele@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>,
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
