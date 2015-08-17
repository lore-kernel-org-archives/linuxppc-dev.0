Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com
 [IPv6:2607:f8b0:400e:c03::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 06D871A0501
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 21:19:28 +1000 (AEST)
Received: by paccq16 with SMTP id cq16so63128106pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 04:19:24 -0700 (PDT)
Date: Mon, 17 Aug 2015 19:19:14 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/3] powerpc/e6500: hw tablewalk: order the memory access
 when acquire/release tcd lock
Message-ID: <20150817111914.GB26870@pek-khao-d1.corp.ad.wrs.com>
References: <1439466697-18989-1-git-send-email-haokexin@gmail.com>
 <1439466697-18989-3-git-send-email-haokexin@gmail.com>
 <1439523559.4099.116.camel@freescale.com>
 <20150814071357.GI30310@pek-khao-d1.corp.ad.wrs.com>
 <1439599463.4099.124.camel@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
In-Reply-To: <1439599463.4099.124.camel@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2015 at 07:44:23PM -0500, Scott Wood wrote:
> On Fri, 2015-08-14 at 15:13 +0800, Kevin Hao wrote:
> > On Thu, Aug 13, 2015 at 10:39:19PM -0500, Scott Wood wrote:
> > > On Thu, 2015-08-13 at 19:51 +0800, Kevin Hao wrote:
> > > > I didn't find anything unusual. But I think we do need to order the
> > > > load/store of esel_next when acquire/release tcd lock. For acquire,
> > > > add a data dependency to order the loads of lock and esel_next.
> > > > For release, even there already have a "isync" here, but it doesn't
> > > > guarantee any memory access order. So we still need "lwsync" for
> > > > the two stores for lock and esel_next.
> > >=20
> > > I was going to say that esel_next is just a hint and it doesn't reall=
y=20
> > > matter=20
> > > if we occasionally get the wrong value, unless it happens often enoug=
h to=20
> > > cause more performance degradation than the lwsync causes.  However, =
with=20
> > > the=20
> > > A-008139 workaround we do need to read the same value from esel_next =
both=20
> > > times.  It might be less costly to save/restore an additional registe=
r=20
> > > instead of lwsync, though.
> >=20
> > I will try to get some benchmark number to compare which method is a bi=
t=20
> > better.
> > Do you have any recommended benchmark for a case this is?
>=20
> lmbench lat_mem_rd with a stride chosen to maximize TLB misses.  For the=
=20
> uncontended case, one instance; for the contended case, two instances, on=
e=20
> pinned to each thread of a core.

I have tried the method to save/restore an additional register for the esel
with the following codes:

diff --git a/arch/powerpc/include/asm/exception-64e.h b/arch/powerpc/includ=
e/asm/exception-64e.h
index a8b52b61043f..8267c1404050 100644
--- a/arch/powerpc/include/asm/exception-64e.h
+++ b/arch/powerpc/include/asm/exception-64e.h
@@ -69,9 +69,9 @@
 #define EX_TLB_ESR	( 9 * 8) /* Level 0 and 2 only */
 #define EX_TLB_SRR0	(10 * 8)
 #define EX_TLB_SRR1	(11 * 8)
+#define EX_TLB_R9	(12 * 8)
 #ifdef CONFIG_BOOK3E_MMU_TLB_STATS
-#define EX_TLB_R8	(12 * 8)
-#define EX_TLB_R9	(13 * 8)
+#define EX_TLB_R8	(13 * 8)
 #define EX_TLB_LR	(14 * 8)
 #define EX_TLB_SIZE	(15 * 8)
 #else
diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
index e4185581c5a7..8d184dd530c4 100644
--- a/arch/powerpc/mm/tlb_low_64e.S
+++ b/arch/powerpc/mm/tlb_low_64e.S
@@ -68,11 +68,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
 	ld	r14,PACAPGD(r13)
 	std	r15,EX_TLB_R15(r12)
 	std	r10,EX_TLB_CR(r12)
+	std	r9,EX_TLB_R9(r12)
 	TLB_MISS_PROLOG_STATS
 .endm
=20
 .macro tlb_epilog_bolted
 	ld	r14,EX_TLB_CR(r12)
+	ld	r9,EX_TLB_R9(r12)
 	ld	r10,EX_TLB_R10(r12)
 	ld	r11,EX_TLB_R11(r12)
 	ld	r13,EX_TLB_R13(r12)
@@ -297,6 +299,7 @@ itlb_miss_fault_bolted:
  * r13 =3D PACA
  * r11 =3D tlb_per_core ptr
  * r10 =3D crap (free to use)
+ * r9  =3D esel entry
  */
 tlb_miss_common_e6500:
 	crmove	cr2*4+2,cr0*4+2		/* cr2.eq !=3D 0 if kernel address */
@@ -334,8 +337,8 @@ BEGIN_FTR_SECTION		/* CPU_FTR_SMT */
 	 * with tlbilx before overwriting.
 	 */
=20
-	lbz	r15,TCD_ESEL_NEXT(r11)
-	rlwinm	r10,r15,16,0xff0000
+	lbz	r9,TCD_ESEL_NEXT(r11)
+	rlwinm	r10,r9,16,0xff0000
 	oris	r10,r10,MAS0_TLBSEL(1)@h
 	mtspr	SPRN_MAS0,r10
 	isync
@@ -429,15 +432,14 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_SMT)
 	mtspr	SPRN_MAS2,r15
=20
 tlb_miss_huge_done_e6500:
-	lbz	r15,TCD_ESEL_NEXT(r11)
 	lbz	r16,TCD_ESEL_MAX(r11)
 	lbz	r14,TCD_ESEL_FIRST(r11)
-	rlwimi	r10,r15,16,0x00ff0000	/* insert esel_next into MAS0 */
-	addi	r15,r15,1		/* increment esel_next */
+	rlwimi	r10,r9,16,0x00ff0000	/* insert esel_next into MAS0 */
+	addi	r9,r9,1		/* increment esel_next */
 	mtspr	SPRN_MAS0,r10
-	cmpw	r15,r16
-	iseleq	r15,r14,r15		/* if next =3D=3D last use first */
-	stb	r15,TCD_ESEL_NEXT(r11)
+	cmpw	r9,r16
+	iseleq	r9,r14,r9		/* if next =3D=3D last use first */
+	stb	r9,TCD_ESEL_NEXT(r11)
=20
 	tlbwe
=20

The following is the benchmark number on a t2080rdb board:
For uncontended case (taskset -c 0 lat_mem_rd 2048 2097152):
		origin		lwsync		r9
2.00000		1.958		1.958		1.958
3.00000		1.958		1.958		1.958
4.00000		1.958		1.958		1.958
6.00000		1.958		1.958		1.958
8.00000		1.958		1.958		1.958
12.00000	6.528		6.528		6.528
16.00000	6.528		6.528		6.528
24.00000	37.862		37.862		37.861
32.00000	37.862		37.862		37.862
48.00000	37.862		37.862		37.862
64.00000	37.862		37.862		37.862
96.00000	37.862		37.863		37.862
128.00000	221.621		232.067		222.927
192.00000	221.874		232.333		222.925
256.00000	221.623		232.066		222.927
384.00000	221.758		232.331		222.927
512.00000	221.621		232.165		222.926
768.00000	221.776		236.870		226.598
1024.00000	264.199		271.351		259.281
1536.00000	370.748		380.910		372.544
2048.00000	392.185		404.696		395.881

For contended case (taskset -c 0 lat_mem_rd 2048 2097152 &
                    taskset -c 1 lat_mem_rd 2048 2097152 >/dev/null 2>&1):
		origin		lwsync		r9
2.00000		3.366		2.944		3.086
3.00000		2.915		3.256		3.095
4.00000		3.043		2.443		2.617
6.00000		2.742		3.367		2.629
8.00000		3.145		3.365		2.443
12.00000	18.267		11.885		13.736
16.00000	15.607		13.312		18.048
24.00000	37.856		37.208		37.855
32.00000	37.856		37.861		37.855
48.00000	37.856		37.861		37.855
64.00000	57.487		37.861		52.505
96.00000	270.445		229.641		143.241
128.00000	284.535		279.907		305.540
192.00000	275.491		298.282		295.592
256.00000	265.155		331.212		259.096
384.00000	276.084		291.023		251.282
512.00000	275.852		335.602		267.074
768.00000	289.682		354.521		312.180
1024.00000	344.968		355.977		343.725
1536.00000	410.961		454.381		412.790
2048.00000	392.984		461.818		397.185

It seems that the using of an additional register do have better performanc=
e in
both cases.

Thanks,
Kevin

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV0cMyAAoJEJNY7TDerrFxbf0H/RU6E0QuM8WMaDuWwfhs34kG
icKdMGXtVbQ/I6hDRGefaoUOt4YWb9hK5BHSQIZRgnjiPW4Zco31TVm1isuNzyGz
AG8O/pxkvH//DaBefup4FxXJ8xeLwAptFKW8n/csEWCGJ7409U26ZKzSrubO3d89
GzwGks4PoJLg6GDdtsIg9M5oWcWYL122Ma0714Qkh00/mrmamKfhn2nTEkanQRQz
ToV3A72rv2AxlKd+dFXfjP5gcNBWc65mSy9Nq6OOzzuuzi7eBYV24f3Dx8zav5rW
rbDWNWQusLR/fyLjHF6kYz7Xjkq+eLKLKpSkzQCSvsj8fGGdFxkVTNPh3Hu96iU=
=6Z2m
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
