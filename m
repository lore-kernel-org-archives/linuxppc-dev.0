Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-wm0-x235.google.com (mail-wm0-x235.google.com
 [IPv6:2a00:1450:400c:c09::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v30TJ08M2zDqKV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 06:26:28 +1100 (AEDT)
Received: by mail-wm0-x235.google.com with SMTP id d140so23297999wmd.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 11:26:27 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kernel@vger.kernel.org,
	mpe@ellerman.id.au,
	jeyu@redhat.com
Cc: rusty@rustcorp.com.au, suzuki.poulose@arm.com, will.deacon@arm.com,
 akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org,
 arnd@arndb.de, torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
 linuxppc-dev@lists.ozlabs.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v4 1/3] powerpc/reloc32: fix corrupted modversion CRCs
Date: Tue, 17 Jan 2017 19:26:11 +0000
Message-Id: <1484681173-11644-2-git-send-email-ard.biesheuvel@linaro.org>
In-Reply-To: <1484681173-11644-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1484681173-11644-1-git-send-email-ard.biesheuvel@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 0e0ed6406e61 ("powerpc/modules: Module CRC relocation fix causes
perf issues") fixed an issue with relocatable PIE kernels in a way that
essentially reintroduced the issue again for 32-bit builds.

Since the chosen approach does is not applicable to 32-bit, fix the
issue by updating the runtime relocation routine to ignore the load
offset for the interval [__start___kcrctab, __stop___kcrctab_gpl_future),
which is where the CRCs reside. This ensures that the values of the CRC
pseudo-symbols are no longer made dependent on the runtime load offset.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/powerpc/kernel/reloc_32.S | 36 +++++++++++++++++---
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/reloc_32.S b/arch/powerpc/kernel/reloc_32.S
index f366fedb0872..150686b9febb 100644
--- a/arch/powerpc/kernel/reloc_32.S
+++ b/arch/powerpc/kernel/reloc_32.S
@@ -87,12 +87,12 @@ eodyn:				/* End of Dyn Table scan */
 	 * Work out the current offset from the link time address of .rela
 	 * section.
 	 *  cur_offset[r7] = rela.run[r9] - rela.link [r7]
-	 *  _stext.link[r12] = _stext.run[r10] - cur_offset[r7]
-	 *  final_offset[r3] = _stext.final[r3] - _stext.link[r12]
+	 *  _stext.link[r11] = _stext.run[r10] - cur_offset[r7]
+	 *  final_offset[r3] = _stext.final[r3] - _stext.link[r11]
 	 */
 	subf	r7, r7, r9	/* cur_offset */
-	subf	r12, r7, r10
-	subf	r3, r12, r3	/* final_offset */
+	subf	r11, r7, r10
+	subf	r3, r11, r3	/* final_offset */
 
 	subf	r8, r6, r8	/* relaz -= relaent */
 	/*
@@ -101,6 +101,21 @@ eodyn:				/* End of Dyn Table scan */
 	 * r13	- points to the symbol table
 	 */
 
+#ifdef CONFIG_MODVERSIONS
+	/*
+	 * Treat R_PPC_RELATIVE relocations differently when they target the
+	 * interval [__start___kcrctab, __stop___kcrctab_gpl_future): in this
+	 * case, the relocated quantities are CRC pseudo-symbols, which should
+	 * be preserved as-is, rather than be modified to take the runtime
+	 * offset into account.
+	 */
+	lwz	r10, (p_kcrc_start - 0b)(r12)
+	lwz	r11, (p_kcrc_stop - 0b)(r12)
+	subf	r12, r7, r12			/* link time addr of 0b */
+	add	r10, r10, r12
+	add	r11, r11, r12
+#endif
+
 	/*
 	 * Check if we have a relocation based on symbol
 	 * r5 will hold the value of the symbol.
@@ -135,7 +150,15 @@ get_type:
 	bne	hi16
 	lwz	r4, 0(r9)	/* r_offset */
 	lwz	r0, 8(r9)	/* r_addend */
+#ifdef CONFIG_MODVERSIONS
+	cmplw	r4, r10
+	blt	do_add
+	cmplw	r4, r11
+	blt	skip_add
+do_add:
+#endif
 	add	r0, r0, r3	/* final addend */
+skip_add:
 	stwx	r0, r4, r7	/* memory[r4+r7]) = (u32)r0 */
 	b	nxtrela		/* continue */
 
@@ -207,3 +230,8 @@ p_dyn:		.long	__dynamic_start - 0b
 p_rela:		.long	__rela_dyn_start - 0b
 p_sym:		.long	__dynamic_symtab - 0b
 p_st:		.long	_stext - 0b
+
+#ifdef CONFIG_MODVERSIONS
+p_kcrc_start:	.long	__start___kcrctab - 0b
+p_kcrc_stop:	.long	__stop___kcrctab_gpl_future - 0b
+#endif
-- 
2.7.4
