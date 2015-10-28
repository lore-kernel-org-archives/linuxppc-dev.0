Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CAB511A0312
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 11:51:36 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mikey@neuling.org, cyrilbur@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 13/19] powerpc: Create disable_kernel_{fp,altivec,vsx,spe}()
Date: Wed, 28 Oct 2015 11:51:01 +1100
Message-Id: <1445993467-667-13-git-send-email-anton@samba.org>
In-Reply-To: <1445993467-667-1-git-send-email-anton@samba.org>
References: <1445993467-667-1-git-send-email-anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The enable_kernel_*() functions leave the relevant MSR bits enabled
until we exit the kernel sometime later. Create disable versions
that wrap the kernel use of FP, Altivec VSX or SPE.

While we don't want to disable it normally for performance reasons
(MSR writes are slow), it will be used for a debug boot option that
does this and catches bad uses in other areas of the kernel.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/crypto/aes-spe-glue.c       | 1 +
 arch/powerpc/crypto/sha1-spe-glue.c      | 1 +
 arch/powerpc/crypto/sha256-spe-glue.c    | 1 +
 arch/powerpc/include/asm/switch_to.h     | 5 +++++
 arch/powerpc/kernel/align.c              | 2 ++
 arch/powerpc/kvm/book3s_paired_singles.c | 1 +
 arch/powerpc/kvm/book3s_pr.c             | 4 ++++
 arch/powerpc/kvm/booke.c                 | 4 ++++
 arch/powerpc/lib/vmx-helper.c            | 2 ++
 arch/powerpc/lib/xor_vmx.c               | 4 ++++
 drivers/crypto/vmx/aes.c                 | 3 +++
 drivers/crypto/vmx/aes_cbc.c             | 3 +++
 drivers/crypto/vmx/aes_ctr.c             | 3 +++
 drivers/crypto/vmx/ghash.c               | 4 ++++
 lib/raid6/altivec.uc                     | 1 +
 15 files changed, 39 insertions(+)

diff --git a/arch/powerpc/crypto/aes-spe-glue.c b/arch/powerpc/crypto/aes-spe-glue.c
index bd5e63f..93ee046 100644
--- a/arch/powerpc/crypto/aes-spe-glue.c
+++ b/arch/powerpc/crypto/aes-spe-glue.c
@@ -85,6 +85,7 @@ static void spe_begin(void)
 
 static void spe_end(void)
 {
+	disable_kernel_spe();
 	/* reenable preemption */
 	preempt_enable();
 }
diff --git a/arch/powerpc/crypto/sha1-spe-glue.c b/arch/powerpc/crypto/sha1-spe-glue.c
index 3e1d222..f9ebc38 100644
--- a/arch/powerpc/crypto/sha1-spe-glue.c
+++ b/arch/powerpc/crypto/sha1-spe-glue.c
@@ -46,6 +46,7 @@ static void spe_begin(void)
 
 static void spe_end(void)
 {
+	disable_kernel_spe();
 	/* reenable preemption */
 	preempt_enable();
 }
diff --git a/arch/powerpc/crypto/sha256-spe-glue.c b/arch/powerpc/crypto/sha256-spe-glue.c
index f4a616f..718a079 100644
--- a/arch/powerpc/crypto/sha256-spe-glue.c
+++ b/arch/powerpc/crypto/sha256-spe-glue.c
@@ -47,6 +47,7 @@ static void spe_begin(void)
 
 static void spe_end(void)
 {
+	disable_kernel_spe();
 	/* reenable preemption */
 	preempt_enable();
 }
diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index 6bcfb89..dbc4caa 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -27,6 +27,11 @@ extern void giveup_spe(struct task_struct *);
 extern void load_up_spe(struct task_struct *);
 extern void switch_booke_debug_regs(struct debug_reg *new_debug);
 
+static inline void disable_kernel_fp(void) { }
+static inline void disable_kernel_altivec(void) { }
+static inline void disable_kernel_spe(void) { }
+static inline void disable_kernel_vsx(void) { }
+
 #ifdef CONFIG_PPC_FPU
 extern void flush_fp_to_thread(struct task_struct *);
 extern void giveup_fpu(struct task_struct *);
diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index 86150fb..8e7cb8e 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -960,6 +960,7 @@ int fix_alignment(struct pt_regs *regs)
 			preempt_disable();
 			enable_kernel_fp();
 			cvt_df(&data.dd, (float *)&data.x32.low32);
+			disable_kernel_fp();
 			preempt_enable();
 #else
 			return 0;
@@ -1000,6 +1001,7 @@ int fix_alignment(struct pt_regs *regs)
 		preempt_disable();
 		enable_kernel_fp();
 		cvt_fd((float *)&data.x32.low32, &data.dd);
+		disable_kernel_fp();
 		preempt_enable();
 #else
 		return 0;
diff --git a/arch/powerpc/kvm/book3s_paired_singles.c b/arch/powerpc/kvm/book3s_paired_singles.c
index a759d9a..eab96cf 100644
--- a/arch/powerpc/kvm/book3s_paired_singles.c
+++ b/arch/powerpc/kvm/book3s_paired_singles.c
@@ -1265,6 +1265,7 @@ int kvmppc_emulate_paired_single(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	if (rcomp)
 		kvmppc_set_cr(vcpu, cr);
 
+	disable_kernel_fp();
 	preempt_enable();
 
 	return emulated;
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 64891b0..49f5dad 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -751,6 +751,7 @@ static int kvmppc_handle_ext(struct kvm_vcpu *vcpu, unsigned int exit_nr,
 		preempt_disable();
 		enable_kernel_fp();
 		load_fp_state(&vcpu->arch.fp);
+		disable_kernel_fp();
 		t->fp_save_area = &vcpu->arch.fp;
 		preempt_enable();
 	}
@@ -760,6 +761,7 @@ static int kvmppc_handle_ext(struct kvm_vcpu *vcpu, unsigned int exit_nr,
 		preempt_disable();
 		enable_kernel_altivec();
 		load_vr_state(&vcpu->arch.vr);
+		disable_kernel_altivec();
 		t->vr_save_area = &vcpu->arch.vr;
 		preempt_enable();
 #endif
@@ -788,6 +790,7 @@ static void kvmppc_handle_lost_ext(struct kvm_vcpu *vcpu)
 		preempt_disable();
 		enable_kernel_fp();
 		load_fp_state(&vcpu->arch.fp);
+		disable_kernel_fp();
 		preempt_enable();
 	}
 #ifdef CONFIG_ALTIVEC
@@ -795,6 +798,7 @@ static void kvmppc_handle_lost_ext(struct kvm_vcpu *vcpu)
 		preempt_disable();
 		enable_kernel_altivec();
 		load_vr_state(&vcpu->arch.vr);
+		disable_kernel_altivec();
 		preempt_enable();
 	}
 #endif
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index fd58751..778ef86 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -98,6 +98,7 @@ void kvmppc_vcpu_disable_spe(struct kvm_vcpu *vcpu)
 	preempt_disable();
 	enable_kernel_spe();
 	kvmppc_save_guest_spe(vcpu);
+	disable_kernel_spe();
 	vcpu->arch.shadow_msr &= ~MSR_SPE;
 	preempt_enable();
 }
@@ -107,6 +108,7 @@ static void kvmppc_vcpu_enable_spe(struct kvm_vcpu *vcpu)
 	preempt_disable();
 	enable_kernel_spe();
 	kvmppc_load_guest_spe(vcpu);
+	disable_kernel_spe();
 	vcpu->arch.shadow_msr |= MSR_SPE;
 	preempt_enable();
 }
@@ -141,6 +143,7 @@ static inline void kvmppc_load_guest_fp(struct kvm_vcpu *vcpu)
 	if (!(current->thread.regs->msr & MSR_FP)) {
 		enable_kernel_fp();
 		load_fp_state(&vcpu->arch.fp);
+		disable_kernel_fp();
 		current->thread.fp_save_area = &vcpu->arch.fp;
 		current->thread.regs->msr |= MSR_FP;
 	}
@@ -182,6 +185,7 @@ static inline void kvmppc_load_guest_altivec(struct kvm_vcpu *vcpu)
 		if (!(current->thread.regs->msr & MSR_VEC)) {
 			enable_kernel_altivec();
 			load_vr_state(&vcpu->arch.vr);
+			disable_kernel_altivec();
 			current->thread.vr_save_area = &vcpu->arch.vr;
 			current->thread.regs->msr |= MSR_VEC;
 		}
diff --git a/arch/powerpc/lib/vmx-helper.c b/arch/powerpc/lib/vmx-helper.c
index ac93a3b..b27e030 100644
--- a/arch/powerpc/lib/vmx-helper.c
+++ b/arch/powerpc/lib/vmx-helper.c
@@ -46,6 +46,7 @@ int enter_vmx_usercopy(void)
  */
 int exit_vmx_usercopy(void)
 {
+	disable_kernel_altivec();
 	pagefault_enable();
 	preempt_enable();
 	return 0;
@@ -70,6 +71,7 @@ int enter_vmx_copy(void)
  */
 void *exit_vmx_copy(void *dest)
 {
+	disable_kernel_altivec();
 	preempt_enable();
 	return dest;
 }
diff --git a/arch/powerpc/lib/xor_vmx.c b/arch/powerpc/lib/xor_vmx.c
index e905f7c..07f49f1 100644
--- a/arch/powerpc/lib/xor_vmx.c
+++ b/arch/powerpc/lib/xor_vmx.c
@@ -74,6 +74,7 @@ void xor_altivec_2(unsigned long bytes, unsigned long *v1_in,
 		v2 += 4;
 	} while (--lines > 0);
 
+	disable_kernel_altivec();
 	preempt_enable();
 }
 EXPORT_SYMBOL(xor_altivec_2);
@@ -102,6 +103,7 @@ void xor_altivec_3(unsigned long bytes, unsigned long *v1_in,
 		v3 += 4;
 	} while (--lines > 0);
 
+	disable_kernel_altivec();
 	preempt_enable();
 }
 EXPORT_SYMBOL(xor_altivec_3);
@@ -135,6 +137,7 @@ void xor_altivec_4(unsigned long bytes, unsigned long *v1_in,
 		v4 += 4;
 	} while (--lines > 0);
 
+	disable_kernel_altivec();
 	preempt_enable();
 }
 EXPORT_SYMBOL(xor_altivec_4);
@@ -172,6 +175,7 @@ void xor_altivec_5(unsigned long bytes, unsigned long *v1_in,
 		v5 += 4;
 	} while (--lines > 0);
 
+	disable_kernel_altivec();
 	preempt_enable();
 }
 EXPORT_SYMBOL(xor_altivec_5);
diff --git a/drivers/crypto/vmx/aes.c b/drivers/crypto/vmx/aes.c
index 20539fb..022c7ab 100644
--- a/drivers/crypto/vmx/aes.c
+++ b/drivers/crypto/vmx/aes.c
@@ -86,6 +86,7 @@ static int p8_aes_setkey(struct crypto_tfm *tfm, const u8 *key,
 	enable_kernel_vsx();
 	ret = aes_p8_set_encrypt_key(key, keylen * 8, &ctx->enc_key);
 	ret += aes_p8_set_decrypt_key(key, keylen * 8, &ctx->dec_key);
+	disable_kernel_vsx();
 	pagefault_enable();
 	preempt_enable();
 
@@ -104,6 +105,7 @@ static void p8_aes_encrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
 		pagefault_disable();
 		enable_kernel_vsx();
 		aes_p8_encrypt(src, dst, &ctx->enc_key);
+		disable_kernel_vsx();
 		pagefault_enable();
 		preempt_enable();
 	}
@@ -120,6 +122,7 @@ static void p8_aes_decrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
 		pagefault_disable();
 		enable_kernel_vsx();
 		aes_p8_decrypt(src, dst, &ctx->dec_key);
+		disable_kernel_vsx();
 		pagefault_enable();
 		preempt_enable();
 	}
diff --git a/drivers/crypto/vmx/aes_cbc.c b/drivers/crypto/vmx/aes_cbc.c
index 8847b92..1881b3f 100644
--- a/drivers/crypto/vmx/aes_cbc.c
+++ b/drivers/crypto/vmx/aes_cbc.c
@@ -87,6 +87,7 @@ static int p8_aes_cbc_setkey(struct crypto_tfm *tfm, const u8 *key,
 	enable_kernel_vsx();
 	ret = aes_p8_set_encrypt_key(key, keylen * 8, &ctx->enc_key);
 	ret += aes_p8_set_decrypt_key(key, keylen * 8, &ctx->dec_key);
+	disable_kernel_vsx();
 	pagefault_enable();
 	preempt_enable();
 
@@ -127,6 +128,7 @@ static int p8_aes_cbc_encrypt(struct blkcipher_desc *desc,
 			ret = blkcipher_walk_done(desc, &walk, nbytes);
 		}
 
+		disable_kernel_vsx();
 		pagefault_enable();
 		preempt_enable();
 	}
@@ -167,6 +169,7 @@ static int p8_aes_cbc_decrypt(struct blkcipher_desc *desc,
 			ret = blkcipher_walk_done(desc, &walk, nbytes);
 		}
 
+		disable_kernel_vsx();
 		pagefault_enable();
 		preempt_enable();
 	}
diff --git a/drivers/crypto/vmx/aes_ctr.c b/drivers/crypto/vmx/aes_ctr.c
index 8095866..2d58b18 100644
--- a/drivers/crypto/vmx/aes_ctr.c
+++ b/drivers/crypto/vmx/aes_ctr.c
@@ -83,6 +83,7 @@ static int p8_aes_ctr_setkey(struct crypto_tfm *tfm, const u8 *key,
 	pagefault_disable();
 	enable_kernel_vsx();
 	ret = aes_p8_set_encrypt_key(key, keylen * 8, &ctx->enc_key);
+	disable_kernel_vsx();
 	pagefault_enable();
 
 	ret += crypto_blkcipher_setkey(ctx->fallback, key, keylen);
@@ -101,6 +102,7 @@ static void p8_aes_ctr_final(struct p8_aes_ctr_ctx *ctx,
 	pagefault_disable();
 	enable_kernel_vsx();
 	aes_p8_encrypt(ctrblk, keystream, &ctx->enc_key);
+	disable_kernel_vsx();
 	pagefault_enable();
 
 	crypto_xor(keystream, src, nbytes);
@@ -139,6 +141,7 @@ static int p8_aes_ctr_crypt(struct blkcipher_desc *desc,
 						    AES_BLOCK_SIZE,
 						    &ctx->enc_key,
 						    walk.iv);
+			disable_kernel_vsx();
 			pagefault_enable();
 
 			/* We need to update IV mostly for last bytes/round */
diff --git a/drivers/crypto/vmx/ghash.c b/drivers/crypto/vmx/ghash.c
index 1f4586c..6c999cb0 100644
--- a/drivers/crypto/vmx/ghash.c
+++ b/drivers/crypto/vmx/ghash.c
@@ -120,6 +120,7 @@ static int p8_ghash_setkey(struct crypto_shash *tfm, const u8 *key,
 	pagefault_disable();
 	enable_kernel_vsx();
 	gcm_init_p8(ctx->htable, (const u64 *) key);
+	disable_kernel_vsx();
 	pagefault_enable();
 	preempt_enable();
 	return crypto_shash_setkey(ctx->fallback, key, keylen);
@@ -150,6 +151,7 @@ static int p8_ghash_update(struct shash_desc *desc,
 			enable_kernel_vsx();
 			gcm_ghash_p8(dctx->shash, ctx->htable,
 				     dctx->buffer, GHASH_DIGEST_SIZE);
+			disable_kernel_vsx();
 			pagefault_enable();
 			preempt_enable();
 			src += GHASH_DIGEST_SIZE - dctx->bytes;
@@ -162,6 +164,7 @@ static int p8_ghash_update(struct shash_desc *desc,
 			pagefault_disable();
 			enable_kernel_vsx();
 			gcm_ghash_p8(dctx->shash, ctx->htable, src, len);
+			disable_kernel_vsx();
 			pagefault_enable();
 			preempt_enable();
 			src += len;
@@ -192,6 +195,7 @@ static int p8_ghash_final(struct shash_desc *desc, u8 *out)
 			enable_kernel_vsx();
 			gcm_ghash_p8(dctx->shash, ctx->htable,
 				     dctx->buffer, GHASH_DIGEST_SIZE);
+			disable_kernel_vsx();
 			pagefault_enable();
 			preempt_enable();
 			dctx->bytes = 0;
diff --git a/lib/raid6/altivec.uc b/lib/raid6/altivec.uc
index bec27fc..682aae8 100644
--- a/lib/raid6/altivec.uc
+++ b/lib/raid6/altivec.uc
@@ -101,6 +101,7 @@ static void raid6_altivec$#_gen_syndrome(int disks, size_t bytes, void **ptrs)
 
 	raid6_altivec$#_gen_syndrome_real(disks, bytes, ptrs);
 
+	disable_kernel_altivec();
 	preempt_enable();
 }
 
-- 
2.5.0
