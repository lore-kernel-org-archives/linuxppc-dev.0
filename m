Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B72B7B70AA
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Oct 2010 17:05:48 +1100 (EST)
Subject: Re: [PATCH] powerpc: Fix invalid page flags in create TLB CAM path
	for PTE_64BIT
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100924164451.GA14042@windriver.com>
Date: Thu, 7 Oct 2010 01:05:37 -0500
Message-Id: <A8991A1D-1769-4C84-B4F2-AC244547C57A@kernel.crashing.org>
References: <1285272615-22758-1-git-send-email-paul.gortmaker@windriver.com>
	<20100923153347.4b517105@udp111988uds.am.freescale.net>
	<1285279157.5158.17.camel@pasglop>
	<20100924164451.GA14042@windriver.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 24, 2010, at 11:44 AM, Paul Gortmaker wrote:

>>=20
>> =46rom d48ebb58b8214f9faec775a5e06902f638f165cf Mon Sep 17 00:00:00 =
2001
> From: Tiejun Chen <tiejun.chen@windriver.com>
> Date: Tue, 21 Sep 2010 19:31:31 +0800
> Subject: [PATCH] powerpc: Fix invalid page flags in create TLB CAM =
path for PTE_64BIT
>=20
> There exists a four line chunk of code, which when configured for
> 64 bit address space, can incorrectly set certain page flags during
> the TLB creation.  It turns out that this is code which isn't used,
> but might still serve a purpose.  Since it isn't obvious why it exists
> or why it causes problems, the below description covers both in =
detail.
>=20
> For powerpc bootstrap, the physical memory (at most 768M), is mapped
> into the kernel space via the following path:
>=20
> MMU_init()
>    |
>    + adjust_total_lowmem()
>            |
>            + map_mem_in_cams()
>                    |
>                    + settlbcam(i, virt, phys, cam_sz, PAGE_KERNEL_X, =
0);
>=20
> On settlbcam(), the kernel will create TLB entries according to the =
flag,
> PAGE_KERNEL_X.
>=20
> settlbcam()
> {
>        ...
>        TLBCAM[index].MAS1 =3D MAS1_VALID
>                        | MAS1_IPROT | MAS1_TSIZE(tsize) | =
MAS1_TID(pid);
>                                ^
> 			These entries cannot be invalidated by the
> 			kernel since MAS1_IPROT is set on TLB property.
>        ...
>        if (flags & _PAGE_USER) {
>           TLBCAM[index].MAS3 |=3D MAS3_UX | MAS3_UR;
>           TLBCAM[index].MAS3 |=3D ((flags & _PAGE_RW) ? MAS3_UW : 0);
>        }
>=20
> For classic BookE (flags & _PAGE_USER) is 'zero' so it's fine.
> But on boards like the the Freescale P4080, we want to support 36-bit
> physical address on it. So the following options may be set:
>=20
> CONFIG_FSL_BOOKE=3Dy
> CONFIG_PTE_64BIT=3Dy
> CONFIG_PHYS_64BIT=3Dy
>=20
> As a result, boards like the P4080 will introduce PTE format as =
Book3E.
> As per the file: arch/powerpc/include/asm/pgtable-ppc32.h
>=20
>  * #elif defined(CONFIG_FSL_BOOKE) && defined(CONFIG_PTE_64BIT)
>  * #include <asm/pte-book3e.h>
>=20
> So PAGE_KERNEL_X is __pgprot(_PAGE_BASE | _PAGE_KERNEL_RWX) and the
> book3E version of _PAGE_KERNEL_RWX is defined with:
>=20
>  (_PAGE_BAP_SW | _PAGE_BAP_SR | _PAGE_DIRTY | _PAGE_BAP_SX)
>=20
> Note the _PAGE_BAP_SR, which is also defined in the book3E _PAGE_USER:
>=20
>  #define _PAGE_USER        (_PAGE_BAP_UR | _PAGE_BAP_SR) /* Can be =
read */
>=20
> So the possibility exists to wrongly assign the user MAS3_U<RWX> bits
> to kernel (PAGE_KERNEL_X) address space via the following code =
fragment:
>=20
>        if (flags & _PAGE_USER) {
>           TLBCAM[index].MAS3 |=3D MAS3_UX | MAS3_UR;
>           TLBCAM[index].MAS3 |=3D ((flags & _PAGE_RW) ? MAS3_UW : 0);
>        }
>=20
> Here is a dump of the TLB info from Simics with the above code =
present:
> ------
> L2 TLB1
>                                            GT                   SSS =
UUU V I
> Row  Logical           Physical            SS TLPID  TID  WIMGE XWR =
XWR F P   V
> ----- ----------------- ------------------- -- ----- ----- ----- --- =
--- - -   -
>  0   c0000000-cfffffff 000000000-00fffffff 00     0     0   M   XWR =
XWR 0 1   1
>  1   d0000000-dfffffff 010000000-01fffffff 00     0     0   M   XWR =
XWR 0 1   1
>  2   e0000000-efffffff 020000000-02fffffff 00     0     0   M   XWR =
XWR 0 1   1
>=20
> Actually this conditional code was used for two legacy functions:
>=20
>  1: support KGDB to set break point.
>     KGDB already dropped this; now uses its core write to set break =
point.
>=20
>  2: io_block_mapping() to create TLB in segmentation size (not =
PAGE_SIZE)
>     for device IO space.
>     This use case is also removed from the latest PowerPC kernel.
>=20
> However, there may still be a use case for it in the future, like
> large user pages, so we can't remove it entirely.  As an alternative,
> we match on all bits of _PAGE_USER instead of just any bits, so the
> case where just _PAGE_BAP_SR is set can't sneak through.
>=20
> With this done, the TLB appears without U having XWR as below:
>=20
> -------
> L2 TLB1
>                                            GT                   SSS =
UUU V I
> Row  Logical           Physical            SS TLPID  TID  WIMGE XWR =
XWR F P   V
> ----- ----------------- ------------------- -- ----- ----- ----- --- =
--- - -   -
>  0   c0000000-cfffffff 000000000-00fffffff 00     0     0   M   XWR    =
 0 1   1
>  1   d0000000-dfffffff 010000000-01fffffff 00     0     0   M   XWR    =
 0 1   1
>  2   e0000000-efffffff 020000000-02fffffff 00     0     0   M   XWR    =
 0 1   1
>=20
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> arch/powerpc/include/asm/pte-common.h |    7 +++++++
> arch/powerpc/mm/fsl_booke_mmu.c       |    3 ++-
> 2 files changed, 9 insertions(+), 1 deletions(-)

applied to next

- k
