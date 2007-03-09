Return-Path: <fenkes@de.ibm.com>
Received: from mtagate6.uk.ibm.com (mtagate6.uk.ibm.com [195.212.29.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4DFCADDD01
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 05:04:30 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate6.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l29I4QQk141704
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Mar 2007 18:04:26 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l29I4PuS1478886
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Mar 2007 18:04:25 GMT
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l29I4PWT004424
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Mar 2007 18:04:25 GMT
From: Joachim Fenkes <fenkes@de.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ibmebus: uevent support
Date: Fri, 9 Mar 2007 19:01:29 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703091901.29133.fenkes@de.ibm.com>
Cc: pmac@au1.ibm.com, paulus@samba.org, johnrose@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds uevent support to ibmebus using the generic of_device_uevent()
function.


Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---


I split this change into a separate patch because it depends on another
patch against 2.6.20, submitted by Sylvain Munaut:
http://patchwork.ozlabs.org/linuxppc/patch?id=9558


 ibmebus.c |    1 +
 1 file changed, 1 insertion(+)


diff -Nurp 03.almost-all/arch/powerpc/kernel/ibmebus.c 04.uevent/arch/powerpc/kernel/ibmebus.c
--- 03.almost-all/arch/powerpc/kernel/ibmebus.c	2007-03-09 17:37:08.309979440 +0100
+++ 04.uevent/arch/powerpc/kernel/ibmebus.c	2007-03-07 19:07:53.000000000 +0100
@@ -460,6 +460,7 @@ static struct bus_attribute ibmebus_bus_
 
 struct bus_type ibmebus_bus_type = {
 	.name      = "ibmebus",
+	.uevent    = of_device_uevent,
 	.match     = ibmebus_bus_match,
 	.dev_attrs = ibmebus_dev_attrs,
 	.bus_attrs = ibmebus_bus_attrs
