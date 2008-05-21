Return-Path: <Shengping.Liu@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 3C419DDF08
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 12:43:29 +1000 (EST)
Message-ID: <48337D1C.2070108@windriver.com>
Date: Wed, 21 May 2008 10:38:36 +0900
From: Andrew Liu <shengping.liu@windriver.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Uniformly use memstart_addr variable as the start
	address of physical memory in powerpc branch
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[POWERPC]: Uniformly use memstart_addr as the start address of RAM

The variable: memstart_addr whose initial value is got from dts file
is used as the start address of physical memory in PowerPC ARCH,
although it is used in functions: mapin_ram(pgtable_32.c) and
cam_mapin_ram(fsl_booke_mmu.c), however, in function: mmu_mapin_ram
(ppc_mmu_32.c), use 0 as the start address of physical memory, so
it is necessary to unify them: in mmu_mapin_ram, use memstart_addr
as the start address of physical memory, instead of 0.

Signed-off-by: Andrew Liu <shengping.liu@windriver.com>
---

b/arch/powerpc/mm/ppc_mmu_32.c |    4 ++--
1 file changed, 2 insertions(+), 2 deletions(-)


diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index cef9f15..f133c6e 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -98,7 +98,7 @@ unsigned long __init mmu_mapin_ram(void)
			break;
	}

-	setbat(2, KERNELBASE, 0, bl, _PAGE_RAM);
+	setbat(2, KERNELBASE, memstart_addr, bl, _PAGE_RAM);
	done = (unsigned long)bat_addrs[2].limit - KERNELBASE + 1;
	if ((done < tot) && !bat_addrs[3].limit) {
		/* use BAT3 to cover a bit more */
@@ -106,7 +106,7 @@ unsigned long __init mmu_mapin_ram(void)
		for (bl = 128<<10; bl < max_size; bl <<= 1)
			if (bl * 2 > tot)
				break;
-		setbat(3, KERNELBASE+done, done, bl, _PAGE_RAM);
+		setbat(3, KERNELBASE+done, memstart_addr+done, bl, _PAGE_RAM);
		done = (unsigned long)bat_addrs[3].limit - KERNELBASE + 1;
	}
