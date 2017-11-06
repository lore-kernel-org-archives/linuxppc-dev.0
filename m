Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVmgf4TN5zDr5T
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 19:58:38 +1100 (AEDT)
Received: by mail-qt0-x241.google.com with SMTP id f8so10006652qta.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Nov 2017 00:58:38 -0800 (PST)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org,
 corbet@lwn.net, arnd@arndb.de
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, linuxram@us.ibm.com
Subject: [PATCH v9 06/51] powerpc: helper functions to initialize AMR,
 IAMR and UAMOR registers
Date: Mon,  6 Nov 2017 00:56:58 -0800
Message-Id: <1509958663-18737-7-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
References: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce  helper functions that can initialize the bits in the AMR,
IAMR and UAMOR register; the bits that correspond to the given pkey.

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/mm/pkeys.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index b6bdfdf..f3bf661 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -16,6 +16,10 @@
 int  pkeys_total;		/* Total pkeys as per device tree */
 u32  initial_allocation_mask;	/* Bits set for reserved keys */
 
+#define AMR_BITS_PER_PKEY 2
+#define PKEY_REG_BITS (sizeof(u64)*8)
+#define pkeyshift(pkey) (PKEY_REG_BITS - ((pkey+1) * AMR_BITS_PER_PKEY))
+
 void __init pkey_initialize(void)
 {
 	int os_reserved, i;
@@ -97,3 +101,46 @@ static inline void write_uamor(u64 value)
 {
 	mtspr(SPRN_UAMOR, value);
 }
+
+static inline void init_amr(int pkey, u8 init_bits)
+{
+	u64 new_amr_bits = (((u64)init_bits & 0x3UL) << pkeyshift(pkey));
+	u64 old_amr = read_amr() & ~((u64)(0x3ul) << pkeyshift(pkey));
+
+	write_amr(old_amr | new_amr_bits);
+}
+
+static inline void init_iamr(int pkey, u8 init_bits)
+{
+	u64 new_iamr_bits = (((u64)init_bits & 0x1UL) << pkeyshift(pkey));
+	u64 old_iamr = read_iamr() & ~((u64)(0x1ul) << pkeyshift(pkey));
+
+	write_iamr(old_iamr | new_iamr_bits);
+}
+
+static void pkey_status_change(int pkey, bool enable)
+{
+	u64 old_uamor;
+
+	/* Reset the AMR and IAMR bits for this key */
+	init_amr(pkey, 0x0);
+	init_iamr(pkey, 0x0);
+
+	/* Enable/disable key */
+	old_uamor = read_uamor();
+	if (enable)
+		old_uamor |= (0x3ul << pkeyshift(pkey));
+	else
+		old_uamor &= ~(0x3ul << pkeyshift(pkey));
+	write_uamor(old_uamor);
+}
+
+void __arch_activate_pkey(int pkey)
+{
+	pkey_status_change(pkey, true);
+}
+
+void __arch_deactivate_pkey(int pkey)
+{
+	pkey_status_change(pkey, false);
+}
-- 
1.7.1
