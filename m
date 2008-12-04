Return-Path: <brking@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B5CEADDDFA
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2008 01:08:45 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mB4E8A15026970
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Dec 2008 09:08:10 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mB4E8gMQ113188
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Dec 2008 09:08:42 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mB4E8g6S002423
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Dec 2008 09:08:42 -0500
Message-Id: <200812041408.mB4E8fRV002401@d01av03.pok.ibm.com>
Subject: [PATCH 1/1] powerpc: Check for valid hugepage size in
	hugetlb_get_unmapped_area
To: paulus@samba.org
From: Brian King <brking@linux.vnet.ibm.com>
Date: Thu, 04 Dec 2008 08:07:54 -0600
Cc: brking@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
	kniht@linux.vnet.ibm.com, agl@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


It looks like most of the hugetlb code is doing the correct thing if
hugepages are not supported, but the mmap code is not. If we get into
the mmap code when hugepages are not supported, such as in an LPAR
which is running Active Memory Sharing, we can oops the kernel. This
patch fixes the oops being seen in this path.

ops: Kernel access of
bad area, sig: 11 [#1]
SMP NR_CPUS=1024 NUMA pSeries
Modules linked in: nfs(N) lockd(N) nfs_acl(N) sunrpc(N) ipv6(N) fuse(N) loop(N)
dm_mod(N) sg(N) ibmveth(N) sd_mod(N) crc_t10dif(N) ibmvscsic(N)
scsi_transport_srp(N) scsi_tgt(N) scsi_mod(N)
Supported: No
NIP: c000000000038d60 LR: c00000000003945c CTR: c0000000000393f0
REGS: c000000077e7b830 TRAP: 0300   Tainted: G          
(2.6.27.5-bz50170-2-ppc64)
MSR: 8000000000009032 <EE,ME,IR,DR>  CR: 44000448  XER: 20000001
DAR: c000002000af90a8, DSISR: 0000000040000000
TASK = c00000007c1b8600[4019] 'hugemmap01' THREAD: c000000077e78000 CPU: 6
GPR00: 0000001fffffffe0 c000000077e7bab0 c0000000009a4e78 0000000000000000
GPR04: 0000000000010000 0000000000000001 00000000ffffffff 0000000000000001
GPR08: 0000000000000000 c000000000af90c8 0000000000000001 0000000000000000
GPR12: 000000000000003f c000000000a73880 0000000000000000 0000000000000000
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000010000
GPR20: 0000000000000000 0000000000000003 0000000000010000 0000000000000001
GPR24: 0000000000000003 0000000000000000 0000000000000001 ffffffffffffffb5
GPR28: c000000077ca2e80 0000000000000000 c00000000092af78 0000000000010000
NIP [c000000000038d60] .slice_get_unmapped_area+0x6c/0x4e0
LR [c00000000003945c] .hugetlb_get_unmapped_area+0x6c/0x80
Call Trace:
[c000000077e7bbc0] [c00000000003945c] .hugetlb_get_unmapped_area+0x6c/0x80
[c000000077e7bc30] [c000000000107e30] .get_unmapped_area+0x64/0xd8
[c000000077e7bcb0] [c00000000010b140] .do_mmap_pgoff+0x140/0x420
[c000000077e7bd80] [c00000000000bf5c] .sys_mmap+0xc4/0x140
[c000000077e7be30] [c0000000000086b4] syscall_exit+0x0/0x40
Instruction dump:
fac1ffb0 fae1ffb8 fb01ffc0 fb21ffc8 fb41ffd0 fb61ffd8 fb81ffe0 fbc1fff0
fbe1fff8 f821fef1 f8c10158 f8e10160 <7d49002e> f9010168 e92d01b0 eb4902b0

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 arch/powerpc/mm/hugetlbpage.c |    3 +++
 1 file changed, 3 insertions(+)

diff -puN arch/powerpc/mm/hugetlbpage.c~powerpc_hugepage_mmap_check arch/powerpc/mm/hugetlbpage.c
--- linux-2.6/arch/powerpc/mm/hugetlbpage.c~powerpc_hugepage_mmap_check	2008-12-03 16:08:40.000000000 -0600
+++ linux-2.6-bjking1/arch/powerpc/mm/hugetlbpage.c	2008-12-03 16:10:57.000000000 -0600
@@ -507,6 +507,9 @@ unsigned long hugetlb_get_unmapped_area(
 {
 	struct hstate *hstate = hstate_file(file);
 	int mmu_psize = shift_to_mmu_psize(huge_page_shift(hstate));
+
+	if (!mmu_huge_psizes[mmu_psize])
+		return -EINVAL;
 	return slice_get_unmapped_area(addr, len, flags, mmu_psize, 1, 0);
 }
 
_
