Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C683D1A08D1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Sep 2014 09:45:56 +1000 (EST)
Message-ID: <1411083956.12154.29.camel@ale.ozlabs.ibm.com>
Subject: Re: [PATCH 02/15] powerpc/cell: Move data segment faulting code out
 of cell platform
From: Michael Neuling <mikey@neuling.org>
To: Jeremy Kerr <jk@ozlabs.org>
Date: Fri, 19 Sep 2014 09:45:56 +1000
In-Reply-To: <541AB38B.5080706@ozlabs.org>
References: <1411028820-29933-1-git-send-email-mikey@neuling.org>
 <1411028820-29933-3-git-send-email-mikey@neuling.org>
 <541AB38B.5080706@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, arnd@arndb.de, greg@kroah.com,
 linux-kernel@vger.kernel.org, imunsie@au.ibm.com, linuxppc-dev@ozlabs.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > +
> > +int copro_data_segment(struct mm_struct *mm, u64 ea, u64 *esid, u64 *v=
sid)
> > +{
> > +	int psize, ssize;
> > +
> > +	*esid =3D (ea & ESID_MASK) | SLB_ESID_V;
> > +
> > +	switch (REGION_ID(ea)) {
> > +	case USER_REGION_ID:
> > +		pr_devel("copro_data_segment: 0x%llx -- USER_REGION_ID\n", ea);
> > +#ifdef CONFIG_PPC_MM_SLICES
> > +		psize =3D get_slice_psize(mm, ea);
> > +#else
> > +		psize =3D mm->context.user_psize;
> > +#endif
> > +		ssize =3D user_segment_size(ea);
> > +		*vsid =3D (get_vsid(mm->context.id, ea, ssize)
> > +			<< slb_vsid_shift(ssize)) | SLB_VSID_USER
> > +			| (ssize =3D=3D MMU_SEGSIZE_1T ? SLB_VSID_B_1T : 0);
> > +		break;
> > +	case VMALLOC_REGION_ID:
> > +		pr_devel("copro_data_segment: 0x%llx -- VMALLOC_REGION_ID\n", ea);
> > +		if (ea < VMALLOC_END)
> > +			psize =3D mmu_vmalloc_psize;
> > +		else
> > +			psize =3D mmu_io_psize;
> > +		*vsid =3D (get_kernel_vsid(ea, mmu_kernel_ssize)
> > +			<< SLB_VSID_SHIFT) | SLB_VSID_KERNEL
> > +			| (mmu_kernel_ssize =3D=3D MMU_SEGSIZE_1T ? SLB_VSID_B_1T : 0);
> > +		break;
> > +	case KERNEL_REGION_ID:
> > +		pr_devel("copro_data_segment: 0x%llx -- KERNEL_REGION_ID\n", ea);
> > +		psize =3D mmu_linear_psize;
> > +		*vsid =3D (get_kernel_vsid(ea, mmu_kernel_ssize)
> > +			<< SLB_VSID_SHIFT) | SLB_VSID_KERNEL
> > +			| (mmu_kernel_ssize =3D=3D MMU_SEGSIZE_1T ? SLB_VSID_B_1T : 0);
> > +		break;
> > +	default:
> > +		/* Future: support kernel segments so that drivers can use the
> > +		 * CoProcessors */
> > +		pr_debug("invalid region access at %016llx\n", ea);
> > +		return 1;
> > +	}
> > +	*vsid |=3D mmu_psize_defs[psize].sllp;
>=20
> A bit of a nitpick, but how about you remove the repeated:
>=20
> 		| (<size> =3D=3D MMU_SEGSIZE_1T ? SLB_VSID_B_1T : 0)
>=20
> then set ssize in each of the switch cases (like we do with psize), and
> or-in the VSID_B_1T bit at the end:
> =09
> 	*vsid |=3D mmu_psize_defs[psize].sllp
> 		| (ssize =3D=3D MMU_SEGSIZE_1T ? SLB_VSID_B_1T : 0);

Nice.  I think below is what you mean.

I'll fold this into the existing patch and repost in a few days.

Thanks,
Mikey

diff --git a/arch/powerpc/mm/copro_fault.c b/arch/powerpc/mm/copro_fault.c
index 4105a63..939caf6 100644
--- a/arch/powerpc/mm/copro_fault.c
+++ b/arch/powerpc/mm/copro_fault.c
@@ -107,8 +107,7 @@ int copro_data_segment(struct mm_struct *mm, u64 ea, u6=
4 *esid, u64 *vsid)
 #endif
 		ssize =3D user_segment_size(ea);
 		*vsid =3D (get_vsid(mm->context.id, ea, ssize)
-			<< slb_vsid_shift(ssize)) | SLB_VSID_USER
-			| (ssize =3D=3D MMU_SEGSIZE_1T ? SLB_VSID_B_1T : 0);
+			 << slb_vsid_shift(ssize)) | SLB_VSID_USER;
 		break;
 	case VMALLOC_REGION_ID:
 		pr_devel("copro_data_segment: 0x%llx -- VMALLOC_REGION_ID\n", ea);
@@ -116,16 +115,16 @@ int copro_data_segment(struct mm_struct *mm, u64 ea, =
u64 *esid, u64 *vsid)
 			psize =3D mmu_vmalloc_psize;
 		else
 			psize =3D mmu_io_psize;
+		ssize =3D mmu_kernel_ssize;
 		*vsid =3D (get_kernel_vsid(ea, mmu_kernel_ssize)
-			<< SLB_VSID_SHIFT) | SLB_VSID_KERNEL
-			| (mmu_kernel_ssize =3D=3D MMU_SEGSIZE_1T ? SLB_VSID_B_1T : 0);
+			 << SLB_VSID_SHIFT) | SLB_VSID_KERNEL;
 		break;
 	case KERNEL_REGION_ID:
 		pr_devel("copro_data_segment: 0x%llx -- KERNEL_REGION_ID\n", ea);
 		psize =3D mmu_linear_psize;
+		ssize =3D mmu_kernel_ssize;
 		*vsid =3D (get_kernel_vsid(ea, mmu_kernel_ssize)
-			<< SLB_VSID_SHIFT) | SLB_VSID_KERNEL
-			| (mmu_kernel_ssize =3D=3D MMU_SEGSIZE_1T ? SLB_VSID_B_1T : 0);
+			 << SLB_VSID_SHIFT) | SLB_VSID_KERNEL;
 		break;
 	default:
 		/* Future: support kernel segments so that drivers can use the
@@ -133,7 +132,8 @@ int copro_data_segment(struct mm_struct *mm, u64 ea, u6=
4 *esid, u64 *vsid)
 		pr_debug("invalid region access at %016llx\n", ea);
 		return 1;
 	}
-	*vsid |=3D mmu_psize_defs[psize].sllp;
+	*vsid |=3D mmu_psize_defs[psize].sllp |
+		(ssize =3D=3D MMU_SEGSIZE_1T) ? SLB_VSID_B_1T : 0;
=20
 	return 0;
 }
