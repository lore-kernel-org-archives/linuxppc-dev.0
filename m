Return-Path: <mikey@ozlabs.org>
To: linuxppc-dev@ozlabs.org, paulus@samba.org
From: Michael Neuling <mikey@neuling.org>
Subject: [PATCH] powerpc: Auto reserve of device tree blob
References: <5148225C-AE27-4365-A1C2-40C46491AF0D@watson.ibm.com>
Date: Thu, 18 May 2006 17:03:05 -0500
Sender: mikey@ozlabs.org
Message-Id: <20060518220408.49C6567A44@ozlabs.org>
Reply-To: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jimi Xenidis <jimix@watson.ibm.com>

A devtree compiler (dtc) generated devtree blob is "relocatable" and so
does not contain a reserved_map entry for the blob itself.  This means
that if passed to Linux, Linux will not get lmb_reserve() the blob and
it could be over.  The following patch will explicitly reserve the
"blob" as it was given to us and stops prom_init.c from creating a
reserved mapping for the blob.

NOTE: that the dtc/kexec should not generate the blob reservation entry.
Although if they do, LMB reserver handles overlaps.

Signed-off-by:  <jimix@watson.ibm.com>
Acked-by: Michael Neuling <mikey@neuling.org>
---
After some discussion last time, it seemed this was the right was to do
this.  I'll post the kexec cleanups if/when this gets upstream.

Mikey

 arch/powerpc/kernel/prom.c      |    5 +++++
 arch/powerpc/kernel/prom_init.c |    9 ++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

Index: linux-2.6-powerpc/arch/powerpc/kernel/prom.c
===================================================================
--- linux-2.6-powerpc.orig/arch/powerpc/kernel/prom.c
+++ linux-2.6-powerpc/arch/powerpc/kernel/prom.c
@@ -1240,6 +1240,11 @@ static void __init early_reserve_mem(voi
 
 	reserve_map = (u64 *)(((unsigned long)initial_boot_params) +
 					initial_boot_params->off_mem_rsvmap);
+
+	/* before we do anything, lets reserve the dt blob */
+	lmb_reserve(__pa((unsigned long)initial_boot_params),
+		    initial_boot_params->totalsize);
+
 #ifdef CONFIG_PPC32
 	/* 
 	 * Handle the case where we might be booting from an old kexec
Index: linux-2.6-powerpc/arch/powerpc/kernel/prom_init.c
===================================================================
--- linux-2.6-powerpc.orig/arch/powerpc/kernel/prom_init.c
+++ linux-2.6-powerpc/arch/powerpc/kernel/prom_init.c
@@ -2031,11 +2031,7 @@ static void __init flatten_device_tree(v
 	/* Version 16 is not backward compatible */
 	hdr->last_comp_version = 0x10;
 
-	/* Reserve the whole thing and copy the reserve map in, we
-	 * also bump mem_reserve_cnt to cause further reservations to
-	 * fail since it's too late.
-	 */
-	reserve_mem(RELOC(dt_header_start), hdr->totalsize);
+	/* Copy the reserve map in */
 	memcpy(rsvmap, RELOC(mem_reserve_map), sizeof(mem_reserve_map));
 
 #ifdef DEBUG_PROM
@@ -2048,6 +2044,9 @@ static void __init flatten_device_tree(v
 				    RELOC(mem_reserve_map)[i].size);
 	}
 #endif
+	/* Bump mem_reserve_cnt to cause further reservations to fail
+	 * since it's too late.
+	 */
 	RELOC(mem_reserve_cnt) = MEM_RESERVE_MAP_SIZE;
 
 	prom_printf("Device tree strings 0x%x -> 0x%x\n",
