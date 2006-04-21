Return-Path: <linas@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1EC6F67A70
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 10:40:46 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3L0ehcM008371
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Apr 2006 20:40:43 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3L0b2Ji269212
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Apr 2006 18:37:02 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k3L0ehBX032500
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Apr 2006 18:40:43 -0600
Date: Thu, 20 Apr 2006 19:40:42 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc/pseries: avoid crash in PCI code if mem system not up.
Message-ID: <20060421004042.GC7242@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Paul,
Please apply and forward upstream.  And a question: once 
upon a time, the arch PCI subsystem was inited after mem init 
was done; currently, it seems to be happening before mem init. 
Is this intentional? 

--linas


[PATCH] powerpc/pseries: avoid crash in PCI code if mem system not up.

The powerpc code is currently performing PCI setup before
memory initialization. PCI setup touches PCI config space
registers. If the PCI card is bad, this will evoke an error,
which currrently can't be handled, as the PCI error recovery 
code expects kmalloc() to be functional.  This patch will
cause the system to punt instead of crashing with

cpu 0x0: Vector: 300 (Data Access) at [c0000000004434d0]
    pc: c0000000000c06b4: .kmem_cache_alloc+0x8c/0xf4
    lr: c00000000004ad6c: .eeh_send_failure_event+0x48/0xfc

This patch Will also print name of the offending pci device.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----

 arch/powerpc/platforms/pseries/eeh_event.c |    9 +++++++++
 1 files changed, 9 insertions(+)

Index: linux-2.6.17-rc1/arch/powerpc/platforms/pseries/eeh_event.c
===================================================================
--- linux-2.6.17-rc1.orig/arch/powerpc/platforms/pseries/eeh_event.c	2006-04-05 09:56:38.000000000 -0500
+++ linux-2.6.17-rc1/arch/powerpc/platforms/pseries/eeh_event.c	2006-04-20 19:29:48.000000000 -0500
@@ -124,7 +124,16 @@ int eeh_send_failure_event (struct devic
 {
 	unsigned long flags;
 	struct eeh_event *event;
+	char *location;
 
+	if (!mem_init_done)
+	{
+		printk(KERN_ERR "EEH: event during early boot not handled\n");
+		location = (char *) get_property(dn, "ibm,loc-code", NULL);
+		printk(KERN_ERR "EEH: device node = %s\n", dn->full_name);
+		printk(KERN_ERR "EEH: PCI location = %s\n", location);
+		return 1;
+	}
 	event = kmalloc(sizeof(*event), GFP_ATOMIC);
 	if (event == NULL) {
 		printk (KERN_ERR "EEH: out of memory, event not handled\n");
