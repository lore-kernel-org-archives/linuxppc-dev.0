Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 33C6FDDF80
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 01:22:09 +1000 (EST)
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id B25DE21D815
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 17:22:30 +0200 (CEST)
Received: from localhost (unknown [192.168.1.157])
	by mail.m-online.net (Postfix) with ESMTP id 0130390019
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 17:22:07 +0200 (CEST)
Received: from localhost ([192.168.3.149])
	by localhost (scanner1.m-online.net [192.168.1.157]) (amavisd-new,
	port 10024) with ESMTP id bPMxTsvLIKWH for <linuxppc-dev@ozlabs.org>;
	Wed, 23 Apr 2008 17:22:07 +0200 (CEST)
Received: from ibook.aepfle.de (DSL01.83.171.163.124.ip-pool.NEFkom.net
	[83.171.163.124]) by mail.mnet-online.de (Postfix) with ESMTP
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 17:22:06 +0200 (CEST)
Date: Wed, 23 Apr 2008 17:22:06 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linuxppc-dev@ozlabs.org
Subject: missing current-speed property prevents autoconsole on pegasos
Message-ID: <20080423152206.GA10935@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Pegasos2 has no current-speed property in
/pci@80000000/isa@C/serial@i2F8. As a result, console=ttyS0,115200 is
still required unless the patch below is used.

What is the correct way to restore console detection on pegasos2?

Index: linux-2.6.25-pegasos/arch/powerpc/platforms/chrp/setup.c
===================================================================
--- linux-2.6.25-pegasos.orig/arch/powerpc/platforms/chrp/setup.c
+++ linux-2.6.25-pegasos/arch/powerpc/platforms/chrp/setup.c
@@ -302,7 +305,7 @@ static void chrp_init_early(void)
        if (!property)
                goto out_put;
        if (!strcmp(property, "failsafe") || !strcmp(property, "serial"))
-               add_preferred_console("ttyS", 0, NULL);
+               add_preferred_console("ttyS", 0, "115200");
 out_put:
        of_node_put(node);
 }
