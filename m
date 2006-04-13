Return-Path: <jimix@watson.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D0CB367D66
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2006 12:05:12 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e35.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3D25956003203
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2006 22:05:09 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3D21dYY239750
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2006 20:01:39 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k3D259sZ001415
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2006 20:05:09 -0600
Received: from [10.0.1.6] (sig-9-65-60-15.mts.ibm.com [9.65.60.15])
	by d03av04.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id
	k3D258mM001132
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2006 20:05:08 -0600
Mime-Version: 1.0 (Apple Message framework v749.3)
Message-Id: <5148225C-AE27-4365-A1C2-40C46491AF0D@watson.ibm.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: linuxppc-dev@ozlabs.org
From: Jimi Xenidis <jimix@watson.ibm.com>
Subject: [patch][rfc]flattened device tree: Passing a dtb (blob) to Linux.
Date: Wed, 12 Apr 2006 22:05:09 -0400
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A devtree compiler (dtc) generated devtree blob is "relocatable" and  
so does not contain a reserved_map entry for the blob itself.
This means that if passed to Linux, Linux will not get lmb_reserve()  
the blob and it could be over.
The following patch will explicitly reserve the "blob" as it was  
given to us and stops prom_init.c from creating a reserved mapping  
for the blob.

NOTE: that the dtc must also not generate the blob reservation  
entry.  Should we try to detect this redundant entry? Should we bump  
the DT version number?


Signed-off-by:  <jimix@watson.ibm.com>
--
diff -r eb0990a251a9 arch/powerpc/kernel/prom.c
--- a/arch/powerpc/kernel/prom.c	Thu Mar 30 22:05:40 2006 -0500
+++ b/arch/powerpc/kernel/prom.c	Wed Apr 12 22:00:27 2006 -0400
@@ -1132,6 +1132,11 @@ static void __init early_reserve_mem(voi
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
diff -r eb0990a251a9 arch/powerpc/kernel/prom_init.c
--- a/arch/powerpc/kernel/prom_init.c	Thu Mar 30 22:05:40 2006 -0500
+++ b/arch/powerpc/kernel/prom_init.c	Wed Apr 12 22:00:27 2006 -0400
@@ -1909,11 +1909,7 @@ static void __init flatten_device_tree(v
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
@@ -1926,6 +1922,9 @@ static void __init flatten_device_tree(v
				    RELOC(mem_reserve_map)[i].size);
	}
#endif
+	/* Bump mem_reserve_cnt to cause further reservations to fail
+	 * since it's too late.
+	 */
	RELOC(mem_reserve_cnt) = MEM_RESERVE_MAP_SIZE;
	prom_printf("Device tree strings 0x%x -> 0x%x\n",
