Return-Path: <brking@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2C583DE4AF
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Aug 2008 05:22:33 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7CJMRWj009395
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 15:22:27 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7CJMQZ0079720
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 15:22:26 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7CJMQle019989
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 15:22:26 -0400
Message-Id: <200808121922.m7CJMQPV019952@d01av04.pok.ibm.com>
Subject: [PATCH 1/1] powerpc: Fix vio_bus_probe oops on probe error
To: paulus@samba.org
From: Brian King <brking@linux.vnet.ibm.com>
Date: Tue, 12 Aug 2008 14:21:45 -0500
Cc: brking@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


When CMO is enabled and booted on a non CMO system and
the VIO device's probe function fails, an oops can result
since vio_cmo_bus_remove is called when it should not.

cpu 0x0: Vector: 300 (Data Access) at [c00000000e13b3d0]
    pc: c000000000020d34: .vio_cmo_bus_remove+0xc0/0x1f4
    lr: c000000000020ca4: .vio_cmo_bus_remove+0x30/0x1f4
    sp: c00000000e13b650
   msr: 8000000000009032
   dar: 0
 dsisr: 40000000
  current = 0xc00000000e0566c0
  paca    = 0xc0000000006f9b80
    pid   = 2428, comm = modprobe
enter ? for help
[c00000000e13b6e0] c000000000021d94 .vio_bus_probe+0x2f8/0x33c
[c00000000e13b7a0] c00000000029fc88 .driver_probe_device+0x13c/0x200
[c00000000e13b830] c00000000029fdac .__driver_attach+0x60/0xa4
[c00000000e13b8c0] c00000000029f050 .bus_for_each_dev+0x80/0xd8
[c00000000e13b980] c00000000029f9ec .driver_attach+0x28/0x40
[c00000000e13ba00] c00000000029f630 .bus_add_driver+0xd4/0x284
[c00000000e13baa0] c0000000002a01bc .driver_register+0xc4/0x198
[c00000000e13bb50] c00000000002168c .vio_register_driver+0x40/0x5c
[c00000000e13bbe0] d0000000003b3f1c .ibmvfc_module_init+0x70/0x109c [ibmvfc]
[c00000000e13bc70] c0000000000acf08 .sys_init_module+0x184c/0x1a10
[c00000000e13be30] c000000000008748 syscall_exit+0x0/0x40

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 arch/powerpc/kernel/vio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/powerpc/kernel/vio.c~powerpc_vio_bus_probe_error arch/powerpc/kernel/vio.c
--- linux-2.6/arch/powerpc/kernel/vio.c~powerpc_vio_bus_probe_error	2008-08-12 13:43:02.000000000 -0500
+++ linux-2.6-bjking1/arch/powerpc/kernel/vio.c	2008-08-12 13:43:56.000000000 -0500
@@ -1113,7 +1113,7 @@ static int vio_bus_probe(struct device *
 				return error;
 		}
 		error = viodrv->probe(viodev, id);
-		if (error)
+		if (error && firmware_has_feature(FW_FEATURE_CMO))
 			vio_cmo_bus_remove(viodev);
 	}
 
_
