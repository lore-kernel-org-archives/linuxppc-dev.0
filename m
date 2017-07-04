Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x209D19ywzDr1X
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Jul 2017 20:09:36 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id z6so29252948pfk.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Jul 2017 03:09:36 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 2/3] powerpc/pseries/le: work around a firmware quirk
Date: Tue,  4 Jul 2017 20:09:08 +1000
Message-Id: <20170704100909.8738-3-npiggin@gmail.com>
In-Reply-To: <20170704100909.8738-1-npiggin@gmail.com>
References: <20170704100909.8738-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some PowerVM firmware when delivering a system reset interrupt to a
little endian OS will mess up SRR registers. They are byteswapped, and
SRR1 is incorrect. An example from a crash:

  NIP: 14dd0900000000c0
  MSR: 1000000200000080

It's possible to detect this pattern in SRR1 (that would never happen in
normal operation), and at least fix the NIP. After this patch, the same
interrupt reports NIP properly:

  NIP [c00000000009dd14] plpar_hcall_norets+0x1c/0x28

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/pseries/ras.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index bb70b26334f0..4923ffe230cf 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -379,6 +379,21 @@ static void fwnmi_release_errinfo(void)
 
 int pSeries_system_reset_exception(struct pt_regs *regs)
 {
+#ifdef __LITTLE_ENDIAN__
+	/*
+	 * Some firmware byteswaps SRR registers and gives incorrect SRR1. Try
+	 * to detect the bad SRR1 pattern here. Flip the NIP back to correct
+	 * endian for reporting purposes. Unfortunately the MSR can't be fixed,
+	 * so clear it. It will be missing MSR_RI so we won't try to recover.
+	 */
+	if ((be64_to_cpu(regs->msr) &
+			(MSR_LE|MSR_RI|MSR_DR|MSR_IR|MSR_ME|MSR_PR|
+			 MSR_ILE|MSR_HV|MSR_SF)) == (MSR_DR|MSR_SF)) {
+		regs->nip = be64_to_cpu((__be64)regs->nip);
+		regs->msr = 0;
+	}
+#endif
+
 	if (fwnmi_active) {
 		struct rtas_error_log *errhdr = fwnmi_get_errinfo(regs);
 		if (errhdr) {
-- 
2.11.0
