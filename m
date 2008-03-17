Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 7EF94DDD01
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 14:47:59 +1100 (EST)
Date: Mon, 17 Mar 2008 14:47:58 +1100
To: Paul Mackerras <paulus@samba.org>, LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] Force 4K pages for IO addresses.
Message-ID: <20080317034758.GG6887@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, antonb@bakeyournoodle.com,
	Jan-Bernd Themann <themann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently HEA requires 4K pages for IO resources.  Just set the pages size to
IO to 4K.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
Paul, please consider this for 2.6.25

 arch/powerpc/mm/hash_utils_64.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

Fixes the following ooops:
Unable to handle kernel paging request for data at address 0xd00008008006c040
Faulting instruction address: 0xc000000000336b08
Oops: Kernel access of bad area, sig: 7 [#1]
SMP NR_CPUS=32 pSeries
Modules linked in:
NIP: c000000000336b08 LR: c000000000336aac CTR: 8000000000138240
REGS: c0000000fcef3190 TRAP: 0300   Not tainted  (2.6.25-rc5.20080317-143135)
MSR: 8000000000009032 <EE,ME,IR,DR>  CR: 24000442  XER: 00000020
DAR: d00008008006c040, DSISR: 0000000042000000
TASK = c0000000fc979190[2781] 'ifconfig' THREAD: c0000000fcef0000 CPU: 7
GPR00: 8000000000000000 c0000000fcef3410 c0000000009cf350 0000000000000000
GPR04: 0000000000000005 0000000000000000 c0000000fc470e50 0000000000000000
GPR08: c0000000fc11fc00 d00008008006c040 f000ffffffffffff 0000000000000000
GPR12: 0000000000000000 c0000000008aed80 0000000028004422 0000000000000000
GPR16: 0000000010120588 00000000100d0000 00000000100b0000 00000000100d0000
GPR20: 0000000010010474 c0000000fea08000 c0000000fcef3cd0 0000000000008914
GPR24: 0000000000000000 0000000000000000 c0000000fe02e000 0000000000000060
GPR28: 0000000000000060 0000000000000000 c00000000094afa8 c0000000fc470e40
NIP [c000000000336b08] .ehea_create_cq+0x1c4/0x26c
LR [c000000000336aac] .ehea_create_cq+0x168/0x26c
Call Trace:
[c0000000fcef3410] [c000000000336aac] .ehea_create_cq+0x168/0x26c (unreliable)
[c0000000fcef34b0] [c00000000032efc4] .ehea_init_port_res+0xd0/0x4c0
[c0000000fcef3570] [c000000000331ba8] .ehea_up+0x134/0x754
[c0000000fcef3670] [c0000000003323c4] .ehea_open+0x84/0x104
[c0000000fcef3710] [c0000000004d55a0] .dev_open+0xb8/0x128
[c0000000fcef37a0] [c0000000004d53e0] .dev_change_flags+0x110/0x218
[c0000000fcef3840] [c000000000528db0] .devinet_ioctl+0x2d4/0x76c
[c0000000fcef3940] [c0000000005293a8] .inet_ioctl+0xe0/0x130
[c0000000fcef39c0] [c0000000004c4590] .sock_ioctl+0x2c0/0x314
[c0000000fcef3a60] [c0000000000fb970] .vfs_ioctl+0x5c/0xf0
[c0000000fcef3b00] [c0000000000fbe34] .do_vfs_ioctl+0x430/0x460
[c0000000fcef3bb0] [c0000000000fbeb0] .sys_ioctl+0x4c/0x88
[c0000000fcef3c60] [c00000000012c364] .dev_ifsioc+0x138/0x324
[c0000000fcef3d40] [c00000000012fdbc] .compat_sys_ioctl+0x398/0x428
[c0000000fcef3e30] [c000000000008748] syscall_exit+0x0/0x40

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 32f4161..f399b1d 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -351,9 +351,7 @@ static void __init htab_init_page_sizes(void)
 		mmu_vmalloc_psize = MMU_PAGE_64K;
 		if (mmu_linear_psize == MMU_PAGE_4K)
 			mmu_linear_psize = MMU_PAGE_64K;
-		if (cpu_has_feature(CPU_FTR_CI_LARGE_PAGE))
-			mmu_io_psize = MMU_PAGE_64K;
-		else
+		if (!cpu_has_feature(CPU_FTR_CI_LARGE_PAGE))
 			mmu_ci_restrictions = 1;
 	}
 #endif /* CONFIG_PPC_64K_PAGES */
-- 
1.5.4.3

Yours Tony

  linux.conf.au    http://www.marchsouth.org/
  Jan 19 - 24 2009 The Australian Linux Technical Conference!
