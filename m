Return-Path: <ossthema@de.ibm.com>
Received: from mtagate2.uk.ibm.com (mtagate2.uk.ibm.com [195.212.29.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7FEA2DDEE3
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 02:57:13 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate2.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m1BFv9fv045240
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2008 15:57:09 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m1BFv993520296
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2008 15:57:09 GMT
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m1BFv8We014853
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2008 15:57:08 GMT
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: [PATCH] drivers/base: export gpl (un)register_memory_notifier
Date: Mon, 11 Feb 2008 16:57:06 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200802111657.07534.ossthema@de.ibm.com>
Cc: "Themann, Jan-Bernd" <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Thomas Klein <osstklei@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <RAISCH@de.ibm.com>, Greg KH <greg@kroah.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Drivers like eHEA need memory notifiers in order to 
update their internal DMA memory map when memory is added
to or removed from the system.

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>


---
 Hi,

 this is the modified version with EXPORT_SYMBOL_GPL

 Regards,
 Jan-Bernd


 drivers/base/memory.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 7ae413f..f5a0bf1 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -52,11 +52,13 @@ int register_memory_notifier(struct notifier_block *nb)
 {
         return blocking_notifier_chain_register(&memory_chain, nb);
 }
+EXPORT_SYMBOL_GPL(register_memory_notifier);
 
 void unregister_memory_notifier(struct notifier_block *nb)
 {
         blocking_notifier_chain_unregister(&memory_chain, nb);
 }
+EXPORT_SYMBOL_GPL(unregister_memory_notifier);
 
 /*
  * register_memory - Setup a sysfs device for a memory block
-- 
1.5.2
