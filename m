Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.29.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C9B62DDDF0
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 13:52:34 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.8/8.13.8) with ESMTP id l1H2qTHJ290806
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 02:52:29 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l1H2qTBH1433708
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 03:52:29 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l1H2qT0F025364
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 03:52:29 +0100
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: paulus@samba.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	johnrose@us.ibm.com, Sylvain Munaut <tnt@246tnt.com>
Subject: [PATCH 2.6.21-rc1] ibmebus: Use of_device_uevent()
Date: Sat, 17 Feb 2007 03:56:12 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200702170356.12600.hnguyen@linux.vnet.ibm.com>
Cc: fenkes@de.ibm.com, pmac@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch replaces ibmebus_uevent() by Sylvain's generic function.


Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---


 ibmebus.c |   37 +++----------------------------------
 1 file changed, 3 insertions(+), 34 deletions(-)


diff -urp a/arch/powerpc/kernel/ibmebus.c b/arch/powerpc/kernel/ibmebus.c
--- a/arch/powerpc/kernel/ibmebus.c	2007-02-17 03:25:53.403375784 +0100
+++ b/arch/powerpc/kernel/ibmebus.c	2007-02-17 03:27:28.230336112 +0100
@@ -372,41 +372,10 @@ static int ibmebus_bus_match(struct devi
 	return 0;
 }
 
-static int ibmebus_uevent(struct device *dev, char **envp, int num_envp,
-			char *buffer, int buffer_size)
-{
-	const struct ibmebus_dev *ebus_dev = to_ibmebus_dev(dev);
-	char *name, *cp, *loc_code;
-	int length;
-
-	if (!num_envp)
-		return -ENOMEM;
-
-	if (!ebus_dev->ofdev.node)
-		return -ENODEV;
-
-	name = (char *)get_property(ebus_dev->ofdev.node, "name", NULL);
-	cp = (char *)get_property(ebus_dev->ofdev.node, "compatible", NULL);
-	loc_code = (char *)get_property(ebus_dev->ofdev.node,
-					"ibm,loc-code", NULL);
-	if (!(name && cp && loc_code))
-		return -ENODEV;
-
-	envp[0] = buffer;
-	length = scnprintf(buffer, buffer_size,
-			   "MODALIAS=ibmebus:T%s:S%s:L%s",
-			   name, cp, loc_code);
-	if (buffer_size - length <= 0)
-		return -ENOMEM;
-	envp[1] = NULL;
-
-	return 0;
-}
-
 struct bus_type ibmebus_bus_type = {
-	.name = "ibmebus",
-	.uevent = ibmebus_uevent,
-	.match = ibmebus_bus_match,
+	.name   = "ibmebus",
+	.uevent = of_device_uevent,
+	.match  = ibmebus_bus_match,
 };
 EXPORT_SYMBOL(ibmebus_bus_type);
 
