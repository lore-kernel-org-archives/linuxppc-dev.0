Return-Path: <stevewin@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 857B5DDD0E
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 07:18:18 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l2CKGlut012599
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Mar 2007 16:16:47 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l2CKICwE065288
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Mar 2007 14:18:12 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l2CKICQT012095
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Mar 2007 14:18:12 -0600
To: david@gibson.dropbear.id.au
MIME-Version: 1.0
Subject: Fw: [PATCH 2/15] Automatically lmb_reserve() initrd
Message-ID: <OF0BE55B3C.650D62FC-ON8725729C.006DDB97-8525729C.006F8642@us.ibm.com>
From: Stephen Winiecki <stevewin@us.ibm.com>
Date: Mon, 12 Mar 2007 16:21:43 -0400
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

+#ifdef CONFIG_BLK_DEV_INITRD
+                DBG("Looking for initrd properties... ");
+                prop = of_get_flat_dt_prop(node, "linux,initrd-start", 
&l);
+                if (prop) {
+                                initrd_start = (unsigned 
long)__va(of_read_ulong(prop, l/4));
+                                prop = of_get_flat_dt_prop(node, 
"linux,initrd-end", &l);
+                                if (prop) {
+                                                initrd_end = (unsigned 
long)__va(of_read_ulong(prop, l/4));
+                                                initrd_below_start_ok = 
1;
+                                } else {
+                                                initrd_start = 0;
+                                }
+                }
+                DBG("initrd_start=0x%lx  initrd_end=0x%lx\n", 
initrd_start, initrd_end);
+#endif /* CONFIG_BLK_DEV_INITRD */
+

Also from Patch 7:
Index: working-2.6/arch/powerpc/boot/main.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/main.c            2007-02-19 
14:01:15.000000000 +1100
+++ working-2.6/arch/powerpc/boot/main.c                 2007-02-19 
14:01:38.000000000 +1100

+                /* Tell the kernel initrd address via device tree */
+                devp = finddevice("/chosen");
+                if (! devp) {
+                                printf("Device tree has no chosen 
node!\n\r");
+                                exit();
+                }
+
+                initrd_start = (u32)initrd_addr;
+                initrd_end = (u32)initrd_addr + initrd_size;
+
+                setprop(devp, "linux,initrd-start", &initrd_start,
+                                sizeof(initrd_start));
+                setprop(devp, "linux,initrd-end", &initrd_end, 
sizeof(initrd_end));
 
-                flush_cache((void *)vmlinux.addr, vmlinux.size);
+                return (struct addr_range){(void *)initrd_addr, 
initrd_size};

It might be helpful if some kind of message was surfaced if the 
initrd-start/end properties didn't exist in the dt, esp. since it may not 
be well known initially as a dts definition requirement/option (voice of 
experience :)).  In general I think surfacing messages for any properties 
which are detected as not existing and which might be normally expected 
would be a good thing as people get familiar with defining dts files and 
specifying properties for their platforms. 
