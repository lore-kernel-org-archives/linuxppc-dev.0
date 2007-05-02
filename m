Return-Path: <kevcorry@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9B85ADDF06
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 03:11:51 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l42HBm1H022161
	for <linuxppc-dev@ozlabs.org>; Wed, 2 May 2007 13:11:48 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l42HBmJm176956
	for <linuxppc-dev@ozlabs.org>; Wed, 2 May 2007 11:11:48 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l42HBmUg009840
	for <linuxppc-dev@ozlabs.org>; Wed, 2 May 2007 11:11:48 -0600
From: Kevin Corry <kevcorry@us.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] powerpc: change topology_init() to a subsys_initcall
Date: Wed, 2 May 2007 12:11:49 -0500
References: <200705021208.59068.kevcorry@us.ibm.com>
In-Reply-To: <200705021208.59068.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705021211.49331.kevcorry@us.ibm.com>
Cc: Stephane Eranian <eranian@hpl.hp.com>, Carl Love <carll@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Change the powerpc version of topology_init() from an __initcall to
a subsys_initcall to match all other architectures.

Signed-off-by: Kevin Corry <kevcorry@us.ibm.com>

Index: linux-2.6.21/arch/powerpc/kernel/sysfs.c
===================================================================
--- linux-2.6.21.orig/arch/powerpc/kernel/sysfs.c
+++ linux-2.6.21/arch/powerpc/kernel/sysfs.c
@@ -498,4 +498,4 @@ static int __init topology_init(void)
 
 	return 0;
 }
-__initcall(topology_init);
+subsys_initcall(topology_init);
