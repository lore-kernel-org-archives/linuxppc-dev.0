Return-Path: <yizhouzhou@ict.ac.cn>
Received: from cstnet.cn (smtp25.cstnet.cn [IPv6:2001:cc0:2fff:7::25])
 by ozlabs.org (Postfix) with ESMTP id 1C2492C0096
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Dec 2013 14:15:33 +1100 (EST)
Date: Mon, 2 Dec 2013 11:07:04 +0800 (GMT+08:00)
From: "Zhouyi Zhou" <yizhouzhou@ict.ac.cn>
To: "Zhouyi Zhou" <zhouzhouyi@gmail.com>
Message-ID: <e9c283.a967.142b14600da.Coremail.yizhouzhou@ict.ac.cn>
In-Reply-To: <1385549465-15945-1-git-send-email-yizhouzhou@ict.ac.cn>
References: <1385549465-15945-1-git-send-email-yizhouzhou@ict.ac.cn>
Subject: ping: re: [PATCH 1/1] kernel code that do not handle NULL return of
 kmem_cache_zalloc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ping
>=C2=A0I=C2=A0do=C2=A0a=C2=A0grep=C2=A0for=C2=A0kmem_cache_zalloc=C2=A0and=
=C2=A0kmem_cache_alloc
>=C2=A0in=C2=A0kernel=C2=A0tree,=C2=A0and=C2=A0find=C2=A0some=C2=A0code=C2=
=A0do=C2=A0not=C2=A0handle=C2=A0NULL
>=C2=A0return=C2=A0of=C2=A0kmem_cache_zalloc=C2=A0correctly
>=C2=A0
>=C2=A0
>=C2=A0Signed-off-by:=C2=A0Zhouyi=C2=A0Zhou=C2=A0<yizhouzhou@ict.ac.cn>
>=C2=A0---
>=C2=A0=C2=A0arch/powerpc/kvm/book3s_32_mmu_host.c=C2=A0|=C2=A0=C2=A0=C2=A0=
=C2=A05=C2=A0+++++
>=C2=A0=C2=A0drivers/iommu/omap-iommu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0++-
>=C2=A0=C2=A0fs/jffs2/malloc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A04=C2=A0++++
>=C2=A0=C2=A03=C2=A0files=C2=A0changed,=C2=A011=C2=A0insertions(+),=C2=A01=
=C2=A0deletion(-)
>=C2=A0
>=C2=A0diff=C2=A0--git=C2=A0a/arch/powerpc/kvm/book3s_32_mmu_host.c=C2=A0b/=
arch/powerpc/kvm/book3s_32_mmu_host.c
>=C2=A0index=C2=A03a0abd2..5fac89d=C2=A0100644
>=C2=A0---=C2=A0a/arch/powerpc/kvm/book3s_32_mmu_host.c
>=C2=A0+++=C2=A0b/arch/powerpc/kvm/book3s_32_mmu_host.c
>=C2=A0@@=C2=A0-243,6=C2=A0+243,11=C2=A0@@=C2=A0next_pteg:
>=C2=A0=C2=A0=09/*=C2=A0Now=C2=A0tell=C2=A0our=C2=A0Shadow=C2=A0PTE=C2=A0co=
de=C2=A0about=C2=A0the=C2=A0new=C2=A0page=C2=A0*/
>=C2=A0=C2=A0
>=C2=A0=C2=A0=09pte=C2=A0=3D=C2=A0kvmppc_mmu_hpte_cache_next(vcpu);
>=C2=A0+=09if=C2=A0(!pte)=C2=A0{
>=C2=A0+=09=09kvm_release_pfn_clean(hpaddr=C2=A0>>=C2=A0PAGE_SHIFT);
>=C2=A0+=09=09r=C2=A0=3D=C2=A0-EAGAIN;
>=C2=A0+=09=09goto=C2=A0out;
>=C2=A0+=09}
>=C2=A0=C2=A0
>=C2=A0=C2=A0=09dprintk_mmu("KVM:=C2=A0%c%c=C2=A0Map=C2=A00x%llx:=C2=A0[%lx=
]=C2=A00x%llx=C2=A0(0x%llx)=C2=A0->=C2=A0%lx\n",
>=C2=A0=C2=A0=09=09=C2=A0=C2=A0=C2=A0=C2=A0orig_pte->may_write=C2=A0?=C2=A0=
'w'=C2=A0:=C2=A0'-',
>=C2=A0diff=C2=A0--git=C2=A0a/drivers/iommu/omap-iommu.c=C2=A0b/drivers/iom=
mu/omap-iommu.c
>=C2=A0index=C2=A0bcd78a7..5155714=C2=A0100644
>=C2=A0---=C2=A0a/drivers/iommu/omap-iommu.c
>=C2=A0+++=C2=A0b/drivers/iommu/omap-iommu.c
>=C2=A0@@=C2=A0-551,7=C2=A0+551,8=C2=A0@@=C2=A0static=C2=A0u32=C2=A0*iopte_=
alloc(struct=C2=A0omap_iommu=C2=A0*obj,=C2=A0u32=C2=A0*iopgd,=C2=A0u32=C2=
=A0da)
>=C2=A0=C2=A0=09=09dev_vdbg(obj->dev,=C2=A0"%s:=C2=A0a=C2=A0new=C2=A0pte:%p=
\n",=C2=A0__func__,=C2=A0iopte);
>=C2=A0=C2=A0=09}=C2=A0else=C2=A0{
>=C2=A0=C2=A0=09=09/*=C2=A0We=C2=A0raced,=C2=A0free=C2=A0the=C2=A0reduniova=
nt=C2=A0table=C2=A0*/
>=C2=A0-=09=09iopte_free(iopte);
>=C2=A0+=09=09if=C2=A0(iopte)
>=C2=A0+=09=09=09iopte_free(iopte);
>=C2=A0=C2=A0=09}
>=C2=A0=C2=A0
>=C2=A0=C2=A0pte_ready:
>=C2=A0diff=C2=A0--git=C2=A0a/fs/jffs2/malloc.c=C2=A0b/fs/jffs2/malloc.c
>=C2=A0index=C2=A04f47aa2..58e2336=C2=A0100644
>=C2=A0---=C2=A0a/fs/jffs2/malloc.c
>=C2=A0+++=C2=A0b/fs/jffs2/malloc.c
>=C2=A0@@=C2=A0-287,6=C2=A0+287,8=C2=A0@@=C2=A0struct=C2=A0jffs2_xattr_datu=
m=C2=A0*jffs2_alloc_xattr_datum(void)
>=C2=A0=C2=A0{
>=C2=A0=C2=A0=09struct=C2=A0jffs2_xattr_datum=C2=A0*xd;
>=C2=A0=C2=A0=09xd=C2=A0=3D=C2=A0kmem_cache_zalloc(xattr_datum_cache,=C2=A0=
GFP_KERNEL);
>=C2=A0+=09if=C2=A0(!xd)
>=C2=A0+=09=09return=C2=A0NULL;
>=C2=A0=C2=A0=09dbg_memalloc("%p\n",=C2=A0xd);
>=C2=A0=C2=A0
>=C2=A0=C2=A0=09xd->class=C2=A0=3D=C2=A0RAWNODE_CLASS_XATTR_DATUM;
>=C2=A0@@=C2=A0-305,6=C2=A0+307,8=C2=A0@@=C2=A0struct=C2=A0jffs2_xattr_ref=
=C2=A0*jffs2_alloc_xattr_ref(void)
>=C2=A0=C2=A0{
>=C2=A0=C2=A0=09struct=C2=A0jffs2_xattr_ref=C2=A0*ref;
>=C2=A0=C2=A0=09ref=C2=A0=3D=C2=A0kmem_cache_zalloc(xattr_ref_cache,=C2=A0G=
FP_KERNEL);
>=C2=A0+=09if=C2=A0(!ref)
>=C2=A0+=09=09return=C2=A0NULL;
>=C2=A0=C2=A0=09dbg_memalloc("%p\n",=C2=A0ref);
>=C2=A0=C2=A0
>=C2=A0=C2=A0=09ref->class=C2=A0=3D=C2=A0RAWNODE_CLASS_XATTR_REF;
>=C2=A0--=C2=A0
>=C2=A01.7.10.4
>=C2=A0
