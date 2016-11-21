Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tMc1L4HrwzDvhQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 16:03:02 +1100 (AEDT)
Date: Mon, 21 Nov 2016 16:01:36 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 3/4] powerpc/powernv: Define real-mode versions of OPAL XICS
 accessors
Message-ID: <20161121050136.GF26748@fergus.ozlabs.ibm.com>
References: <1479704214-29147-1-git-send-email-paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479704214-29147-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This defines real-mode versions of opal_int_get_xirr(), opal_int_eoi()
and opal_int_set_mfrr(), for use by KVM real-mode code.

It also exports opal_int_set_mfrr() so that the modular part of KVM
can use it to send IPIs.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/opal.h                | 3 +++
 arch/powerpc/platforms/powernv/opal-wrappers.S | 3 +++
 arch/powerpc/platforms/powernv/opal.c          | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index e958b70..5c7db0f 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -220,9 +220,12 @@ int64_t opal_pci_set_power_state(uint64_t async_token, uint64_t id,
 int64_t opal_pci_poll2(uint64_t id, uint64_t data);
 
 int64_t opal_int_get_xirr(uint32_t *out_xirr, bool just_poll);
+int64_t opal_rm_int_get_xirr(__be32 *out_xirr, bool just_poll);
 int64_t opal_int_set_cppr(uint8_t cppr);
 int64_t opal_int_eoi(uint32_t xirr);
+int64_t opal_rm_int_eoi(uint32_t xirr);
 int64_t opal_int_set_mfrr(uint32_t cpu, uint8_t mfrr);
+int64_t opal_rm_int_set_mfrr(uint32_t cpu, uint8_t mfrr);
 int64_t opal_pci_tce_kill(uint64_t phb_id, uint32_t kill_type,
 			  uint32_t pe_num, uint32_t tce_size,
 			  uint64_t dma_addr, uint32_t npages);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 44d2d84..3aa40f1 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -304,8 +304,11 @@ OPAL_CALL(opal_pci_get_presence_state,		OPAL_PCI_GET_PRESENCE_STATE);
 OPAL_CALL(opal_pci_get_power_state,		OPAL_PCI_GET_POWER_STATE);
 OPAL_CALL(opal_pci_set_power_state,		OPAL_PCI_SET_POWER_STATE);
 OPAL_CALL(opal_int_get_xirr,			OPAL_INT_GET_XIRR);
+OPAL_CALL_REAL(opal_rm_int_get_xirr,		OPAL_INT_GET_XIRR);
 OPAL_CALL(opal_int_set_cppr,			OPAL_INT_SET_CPPR);
 OPAL_CALL(opal_int_eoi,				OPAL_INT_EOI);
+OPAL_CALL_REAL(opal_rm_int_eoi,			OPAL_INT_EOI);
 OPAL_CALL(opal_int_set_mfrr,			OPAL_INT_SET_MFRR);
+OPAL_CALL_REAL(opal_rm_int_set_mfrr,		OPAL_INT_SET_MFRR);
 OPAL_CALL(opal_pci_tce_kill,			OPAL_PCI_TCE_KILL);
 OPAL_CALL_REAL(opal_rm_pci_tce_kill,		OPAL_PCI_TCE_KILL);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 893d8ea..2822935 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -886,3 +886,5 @@ EXPORT_SYMBOL_GPL(opal_leds_get_ind);
 EXPORT_SYMBOL_GPL(opal_leds_set_ind);
 /* Export this symbol for PowerNV Operator Panel class driver */
 EXPORT_SYMBOL_GPL(opal_write_oppanel_async);
+/* Export this for KVM */
+EXPORT_SYMBOL_GPL(opal_int_set_mfrr);
-- 
2.7.4
