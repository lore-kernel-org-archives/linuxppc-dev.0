Return-Path: <sfr@canb.auug.org.au>
Date: Thu, 22 Mar 2012 15:23:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: random little legacy iSeries removal tidy ups
Message-Id: <20120322152327.a22edc0a388131fc445c99d1@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Thu__22_Mar_2012_15_23_27_+1100_0G87HCD0qHk7fL2A"
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__22_Mar_2012_15_23_27_+1100_0G87HCD0qHk7fL2A
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/boot/.gitignore            |    1 -
 arch/powerpc/include/asm/iommu.h        |    1 -
 arch/powerpc/include/asm/irq.h          |    2 +-
 arch/powerpc/include/asm/mmu-hash64.h   |   12 ------------
 arch/powerpc/include/asm/smp.h          |    1 -
 arch/powerpc/include/asm/udbg.h         |    1 -
 arch/powerpc/kernel/irq.c               |    4 ++--
 arch/powerpc/kernel/prom_init.c         |    2 +-
 arch/powerpc/kernel/udbg.c              |    3 ---
 arch/powerpc/kernel/vdso.c              |    4 ++--
 arch/powerpc/platforms/cell/beat_htab.c |    2 --
 11 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/boot/.gitignore b/arch/powerpc/boot/.gitignore
index 12da77e..1c1aadc 100644
--- a/arch/powerpc/boot/.gitignore
+++ b/arch/powerpc/boot/.gitignore
@@ -27,7 +27,6 @@ zImage.bin.*
 zImage.chrp
 zImage.coff
 zImage.holly
-zImage.iseries
 zImage.*lds
 zImage.miboot
 zImage.pmac
diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/io=
mmu.h
index edfc980..957a83f 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -112,7 +112,6 @@ extern void iommu_unmap_page(struct iommu_table *tbl, d=
ma_addr_t dma_handle,
 			     struct dma_attrs *attrs);
=20
 extern void iommu_init_early_pSeries(void);
-extern void iommu_init_early_iSeries(void);
 extern void iommu_init_early_dart(void);
 extern void iommu_init_early_pasemi(void);
=20
diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index 22064be..f8af370 100644
--- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -170,7 +170,7 @@ extern void irq_set_default_host(struct irq_host *host);
  * irq_set_virq_count - Set the maximum number of virt irqs
  * @count: number of linux virtual irqs, capped with NR_IRQS
  *
- * This is mainly for use by platforms like iSeries who want to program
+ * This is mainly for use by platforms like PS3 who want to program
  * the virtual irq number in the controller to avoid the reverse mapping
  */
 extern void irq_set_virq_count(unsigned int count);
diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/a=
sm/mmu-hash64.h
index 412ba49..e06794a 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -267,7 +267,6 @@ extern void demote_segment_4k(struct mm_struct *mm, uns=
igned long addr);
=20
 extern void hpte_init_native(void);
 extern void hpte_init_lpar(void);
-extern void hpte_init_iSeries(void);
 extern void hpte_init_beat(void);
 extern void hpte_init_beat_v3(void);
=20
@@ -325,9 +324,6 @@ extern void slb_set_size(u16 size);
  * WARNING - If you change these you must make sure the asm
  * implementations in slb_allocate (slb_low.S), do_stab_bolted
  * (head.S) and ASM_VSID_SCRAMBLE (below) are changed accordingly.
- *
- * You'll also need to change the precomputed VSID values in head.S
- * which are used by the iSeries firmware.
  */
=20
 #define VSID_MULTIPLIER_256M	ASM_CONST(200730139)	/* 28-bit prime */
@@ -484,14 +480,6 @@ static inline unsigned long get_vsid(unsigned long con=
text, unsigned long ea,
 			     | (ea >> SID_SHIFT_1T), 1T);
 }
=20
-/*
- * This is only used on legacy iSeries in lparmap.c,
- * hence the 256MB segment assumption.
- */
-#define VSID_SCRAMBLE(pvsid)	(((pvsid) * VSID_MULTIPLIER_256M) %	\
-				 VSID_MODULUS_256M)
-#define KERNEL_VSID(ea)		VSID_SCRAMBLE(GET_ESID(ea))
-
 #endif /* __ASSEMBLY__ */
=20
 #endif /* _ASM_POWERPC_MMU_HASH64_H_ */
diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index adba970..ebc24dc 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -122,7 +122,6 @@ extern void smp_muxed_ipi_set_data(int cpu, unsigned lo=
ng data);
 extern void smp_muxed_ipi_message_pass(int cpu, int msg);
 extern irqreturn_t smp_ipi_demux(void);
=20
-void smp_init_iSeries(void);
 void smp_init_pSeries(void);
 void smp_init_cell(void);
 void smp_init_celleb(void);
diff --git a/arch/powerpc/include/asm/udbg.h b/arch/powerpc/include/asm/udb=
g.h
index 8338aef..b303881 100644
--- a/arch/powerpc/include/asm/udbg.h
+++ b/arch/powerpc/include/asm/udbg.h
@@ -44,7 +44,6 @@ extern void __init udbg_init_debug_lpar_hvsi(void);
 extern void __init udbg_init_pmac_realmode(void);
 extern void __init udbg_init_maple_realmode(void);
 extern void __init udbg_init_pas_realmode(void);
-extern void __init udbg_init_iseries(void);
 extern void __init udbg_init_rtas_panel(void);
 extern void __init udbg_init_rtas_console(void);
 extern void __init udbg_init_debug_beat(void);
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 4ec471a..cb73d66 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -208,8 +208,8 @@ notrace void arch_local_irq_restore(unsigned long en)
 	 * we are checking the "new" CPU instead of the old one. This
 	 * is only a problem if an event happened on the "old" CPU.
 	 *
-	 * External interrupt events on non-iseries will have caused
-	 * interrupts to be hard-disabled, so there is no problem, we
+	 * External interrupt events will have caused interrupts to
+	 * be hard-disabled, so there is no problem, we
 	 * cannot have preempted.
 	 */
 	irq_happened =3D get_irq_happened();
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_ini=
t.c
index e2d5990..ea4e311 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -447,7 +447,7 @@ static void __init __attribute__((noreturn)) prom_panic=
(const char *reason)
 	if (RELOC(of_platform) =3D=3D PLATFORM_POWERMAC)
 		asm("trap\n");
=20
-	/* ToDo: should put up an SRC here on p/iSeries */
+	/* ToDo: should put up an SRC here on pSeries */
 	call_prom("exit", 0, 0);
=20
 	for (;;)			/* should never get here */
diff --git a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
index 57fa2c0..c39c1ca 100644
--- a/arch/powerpc/kernel/udbg.c
+++ b/arch/powerpc/kernel/udbg.c
@@ -46,9 +46,6 @@ void __init udbg_early_init(void)
 #elif defined(CONFIG_PPC_EARLY_DEBUG_MAPLE)
 	/* Maple real mode debug */
 	udbg_init_maple_realmode();
-#elif defined(CONFIG_PPC_EARLY_DEBUG_ISERIES)
-	/* For iSeries - hit Ctrl-x Ctrl-x to see the output */
-	udbg_init_iseries();
 #elif defined(CONFIG_PPC_EARLY_DEBUG_BEAT)
 	udbg_init_debug_beat();
 #elif defined(CONFIG_PPC_EARLY_DEBUG_PAS_REALMODE)
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 7d14bb6..12d7216 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -727,10 +727,10 @@ static int __init vdso_init(void)
 	vdso_data->version.minor =3D SYSTEMCFG_MINOR;
 	vdso_data->processor =3D mfspr(SPRN_PVR);
 	/*
-	 * Fake the old platform number for pSeries and iSeries and add
+	 * Fake the old platform number for pSeries and add
 	 * in LPAR bit if necessary
 	 */
-	vdso_data->platform =3D machine_is(iseries) ? 0x200 : 0x100;
+	vdso_data->platform =3D 0x100;
 	if (firmware_has_feature(FW_FEATURE_LPAR))
 		vdso_data->platform |=3D 1;
 	vdso_data->physicalMemorySize =3D memblock_phys_mem_size();
diff --git a/arch/powerpc/platforms/cell/beat_htab.c b/arch/powerpc/platfor=
ms/cell/beat_htab.c
index 2516c1c..943c9d3 100644
--- a/arch/powerpc/platforms/cell/beat_htab.c
+++ b/arch/powerpc/platforms/cell/beat_htab.c
@@ -95,7 +95,6 @@ static long beat_lpar_hpte_insert(unsigned long hpte_grou=
p,
 	unsigned long lpar_rc;
 	u64 hpte_v, hpte_r, slot;
=20
-	/* same as iseries */
 	if (vflags & HPTE_V_SECONDARY)
 		return -1;
=20
@@ -319,7 +318,6 @@ static long beat_lpar_hpte_insert_v3(unsigned long hpte=
_group,
 	unsigned long lpar_rc;
 	u64 hpte_v, hpte_r, slot;
=20
-	/* same as iseries */
 	if (vflags & HPTE_V_SECONDARY)
 		return -1;
=20
--=20
1.7.9.1

--=20
Stephen Rothwell <sfr@canb.auug.org.au>

--Signature=_Thu__22_Mar_2012_15_23_27_+1100_0G87HCD0qHk7fL2A
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPaqk/AAoJEECxmPOUX5FEk6gQAJyxV85p9WiFfpMi6xxqOr2f
lruXCwVIM+295fuYueaWf8zRUd1Pc/MurVsA9oKevv4X4O5clDwGPTrQ0fR4AkaE
rfem/kC2+wHJ/BsAqRHLNMH/KeoqpnILZey+R4BUimAbblc9NtYIg//uZ9mhjd/V
JTxy9+kvUOEDYK55gw0Mo7VlLqR/vMQDhSNULlBu53SVIQac4hL8USOZOdxcfQ60
2vDhvK0JCWUa5rfeFAp16lml1ld1RqNxBmvyCJffW4Rb/3mQnn++Cg1Dgt3C92Df
pPCIPwOuIJpgAcOiiuXI2HqDmhDbKU1nPGuD0Tkc42Y4jLOrbCg1dyLP1Up2JmLa
1eQl2I+W5MEg1KYTxifa5laEuPacWpC9f4LooK1XoDiBjG8giMK7RIkZ7qiWuewu
fiE/Op8f8NZW+vmg+5cuMq6c8VxppfKppEfbyUnCa2q84bTEPcHm8l6aBl+3kWEL
LiO834ujb675scMnBV4gTPWLehGkBzJHIWj09kT950L5NSrOjARYZrpWMybXtw69
jmm+qtV48lMPBJFEZe5hCJoPhmpIx3xR72/LJUbdsRk8jMt9QDkI7DgaIy+tPexh
b8Q9PADCv1uRZKQaUBjueLcAZ7KqQpTNKKPpcLdAXW6rAzs87Uh8gOdppYV9shBq
saDUm8dKVS7ALsDPAm2Z
=e0zO
-----END PGP SIGNATURE-----

--Signature=_Thu__22_Mar_2012_15_23_27_+1100_0G87HCD0qHk7fL2A--
