Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPNv35PWxzDw45
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 13:48:47 +1100 (AEDT)
Date: Thu, 24 Nov 2016 13:48:47 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Michael
 Neuling <mikey@neuling.org>
Subject: linux-next: manual merge of the kvm-ppc-paulus tree with the
 powerpc tree
Message-ID: <20161124134847.1006994a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Paul,

Today's linux-next merge of the kvm-ppc-paulus tree got a conflict in:

  arch/powerpc/include/asm/reg.h

between commit:

  29a969b76481 ("powerpc: Revert Load Monitor Register Support")

from the powerpc tree and commits:

  7fd317f8c330 ("powerpc/64: Add some more SPRs and SPR bits for POWER9")
  02ed21aeda0e ("powerpc/powernv: Define and set POWER9 HFSCR doorbell bit")

from the kvm-ppc-paulus tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc arch/powerpc/include/asm/reg.h
index 332e6b4b306a,04aa1ee8cdb6..000000000000
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@@ -292,6 -295,9 +295,7 @@@
  #define SPRN_HRMOR	0x139	/* Real mode offset register */
  #define SPRN_HSRR0	0x13A	/* Hypervisor Save/Restore 0 */
  #define SPRN_HSRR1	0x13B	/* Hypervisor Save/Restore 1 */
 -#define SPRN_LMRR	0x32D	/* Load Monitor Region Register */
 -#define SPRN_LMSER	0x32E	/* Load Monitor Section Enable Register */
+ #define SPRN_ASDR	0x330	/* Access segment descriptor register */
  #define SPRN_IC		0x350	/* Virtual Instruction Count */
  #define SPRN_VTB	0x351	/* Virtual Time Base */
  #define SPRN_LDBAR	0x352	/* LD Base Address Register */
@@@ -302,6 -308,8 +306,7 @@@
  #define SPRN_PMCR	0x374	/* Power Management Control Register */
  
  /* HFSCR and FSCR bit numbers are the same */
 -#define FSCR_LM_LG	11	/* Enable Load Monitor Registers */
+ #define FSCR_MSGP_LG	10	/* Enable MSGP */
  #define FSCR_TAR_LG	8	/* Enable Target Address Register */
  #define FSCR_EBB_LG	7	/* Enable Event Based Branching */
  #define FSCR_TM_LG	5	/* Enable Transactional Memory */
@@@ -315,6 -324,8 +320,7 @@@
  #define   FSCR_EBB	__MASK(FSCR_EBB_LG)
  #define   FSCR_DSCR	__MASK(FSCR_DSCR_LG)
  #define SPRN_HFSCR	0xbe	/* HV=1 Facility Status & Control Register */
 -#define   HFSCR_LM	__MASK(FSCR_LM_LG)
+ #define   HFSCR_MSGP	__MASK(FSCR_MSGP_LG)
  #define   HFSCR_TAR	__MASK(FSCR_TAR_LG)
  #define   HFSCR_EBB	__MASK(FSCR_EBB_LG)
  #define   HFSCR_TM	__MASK(FSCR_TM_LG)
