Return-Path: <ben@decadent.org.uk>
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
 [88.96.1.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vflwR3GK0zDqY3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Mar 2017 22:51:35 +1100 (AEDT)
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Michael Ellerman" <mpe@ellerman.id.au>,
 "Paul Mackerras" <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 "Larry Finger" <Larry.Finger@lwfinger.net>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
 "Nicholas Piggin" <npiggin@gmail.com>
Date: Fri, 10 Mar 2017 11:46:22 +0000
Message-ID: <lsq.1489146382.724297421@decadent.org.uk>
Subject: [PATCH 3.16 122/370] powerpc: Fix build warning on 32-bit PPC
In-Reply-To: <lsq.1489146380.780052105@decadent.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

3.16.42-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Larry Finger <Larry.Finger@lwfinger.net>

commit 8ae679c4bc2ea2d16d92620da8e3e9332fa4039f upstream.

I am getting the following warning when I build kernel 4.9-git on my
PowerBook G4 with a 32-bit PPC processor:

    AS      arch/powerpc/kernel/misc_32.o
  arch/powerpc/kernel/misc_32.S:299:7: warning: "CONFIG_FSL_BOOKE" is not defined [-Wundef]

This problem is evident after commit 989cea5c14be ("kbuild: prevent
lib-ksyms.o rebuilds"); however, this change in kbuild only exposes an
error that has been in the code since 2005 when this source file was
created.  That was with commit 9994a33865f4 ("powerpc: Introduce
entry_{32,64}.S, misc_{32,64}.S, systbl.S").

The offending line does not make a lot of sense.  This error does not
seem to cause any errors in the executable, thus I am not recommending
that it be applied to any stable versions.

Thanks to Nicholas Piggin for suggesting this solution.

Fixes: 9994a33865f4 ("powerpc: Introduce entry_{32,64}.S, misc_{32,64}.S, systbl.S")
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/powerpc/kernel/misc_32.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -313,7 +313,7 @@ _GLOBAL(flush_instruction_cache)
 	lis	r3, KERNELBASE@h
 	iccci	0,r3
 #endif
-#elif CONFIG_FSL_BOOKE
+#elif defined(CONFIG_FSL_BOOKE)
 BEGIN_FTR_SECTION
 	mfspr   r3,SPRN_L1CSR0
 	ori     r3,r3,L1CSR0_CFI|L1CSR0_CLFC
