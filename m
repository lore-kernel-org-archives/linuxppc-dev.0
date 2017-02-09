Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJkK96BkSzDqGX
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Feb 2017 14:37:01 +1100 (AEDT)
Date: Thu, 9 Feb 2017 14:37:01 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Alistair
 Popple <alistair@popple.id.au>
Subject: linux-next: manual merge of the kvm-ppc tree with the powerpc tree
Message-ID: <20170209143701.4e37c1be@canb.auug.org.au>
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

Today's linux-next merge of the kvm-ppc tree got conflicts in:

  arch/powerpc/include/asm/opal.h
  arch/powerpc/platforms/powernv/opal-wrappers.S

between commit:

  1d0761d2557d ("powerpc/powernv: Initialise nest mmu")

from the powerpc tree and commit:

  ab9bad0ead9a ("powerpc/powernv: Remove separate entry for OPAL real mode calls")

from the kvm-ppc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc arch/powerpc/include/asm/opal.h
index 08ddea966601,16efe7406776..000000000000
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@@ -228,11 -225,6 +225,7 @@@ int64_t opal_int_set_mfrr(uint32_t cpu
  int64_t opal_pci_tce_kill(uint64_t phb_id, uint32_t kill_type,
  			  uint32_t pe_num, uint32_t tce_size,
  			  uint64_t dma_addr, uint32_t npages);
- int64_t opal_rm_pci_tce_kill(uint64_t phb_id, uint32_t kill_type,
- 			     uint32_t pe_num, uint32_t tce_size,
- 			     uint64_t dma_addr, uint32_t npages);
 +int64_t opal_nmmu_set_ptcr(uint64_t chip_id, uint64_t ptcr);
  
  /* Internal functions */
  extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
diff --cc arch/powerpc/platforms/powernv/opal-wrappers.S
index f7c19c9c57ed,28799e557348..000000000000
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@@ -304,12 -296,7 +296,8 @@@ OPAL_CALL(opal_pci_get_presence_state
  OPAL_CALL(opal_pci_get_power_state,		OPAL_PCI_GET_POWER_STATE);
  OPAL_CALL(opal_pci_set_power_state,		OPAL_PCI_SET_POWER_STATE);
  OPAL_CALL(opal_int_get_xirr,			OPAL_INT_GET_XIRR);
- OPAL_CALL_REAL(opal_rm_int_get_xirr,		OPAL_INT_GET_XIRR);
  OPAL_CALL(opal_int_set_cppr,			OPAL_INT_SET_CPPR);
  OPAL_CALL(opal_int_eoi,				OPAL_INT_EOI);
- OPAL_CALL_REAL(opal_rm_int_eoi,			OPAL_INT_EOI);
  OPAL_CALL(opal_int_set_mfrr,			OPAL_INT_SET_MFRR);
- OPAL_CALL_REAL(opal_rm_int_set_mfrr,		OPAL_INT_SET_MFRR);
  OPAL_CALL(opal_pci_tce_kill,			OPAL_PCI_TCE_KILL);
 +OPAL_CALL(opal_nmmu_set_ptcr,			OPAL_NMMU_SET_PTCR);
- OPAL_CALL_REAL(opal_rm_pci_tce_kill,		OPAL_PCI_TCE_KILL);
