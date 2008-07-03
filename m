Return-Path: <nfont@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7674BDDE26
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 13:19:22 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m633JJdB024177
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jul 2008 23:19:19 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m633JJ7c134006
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jul 2008 21:19:19 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m633JJrE015657
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jul 2008 21:19:19 -0600
Received: from austin.ibm.com (netmail2.austin.ibm.com [9.41.248.176])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m633JImj015651
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jul 2008 21:19:19 -0600
Received: from [9.65.174.195] (sig-9-65-174-195.mts.ibm.com [9.65.174.195])
	by austin.ibm.com (8.13.8/8.12.10) with ESMTP id m633JHgh043698
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jul 2008 22:19:18 -0500
Message-ID: <486C453C.1010903@austin.ibm.com>
Date: Wed, 02 Jul 2008 22:19:24 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/5 v2] Allow phandle to be specified in formats other than
	decimal
References: <486C4462.4010004@austin.ibm.com>
In-Reply-To: <486C4462.4010004@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Allow the phandle passed to the /proc/ppc64/ofdt file to be specified
in formats other than decimal.  This allows us to easily specify phandle
values in hex that would otherwise appear as negative integers.

This is an issue on systems where the value of 
/proc/device-tree/ibm,dynamic-reconfiguration-memory.ibm,phandle is
fffffff9.  Having to pass this to the ofdt file as a string results in
a large negative number, and simple_strtoul() does not handle negative
numbers.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---
 arch/powerpc/platforms/pseries/reconfig.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.git/arch/powerpc/platforms/pseries/reconfig.c
===================================================================
--- linux-2.6.git.orig/arch/powerpc/platforms/pseries/reconfig.c	2008-07-01 09:38:22.000000000 -0500
+++ linux-2.6.git/arch/powerpc/platforms/pseries/reconfig.c	2008-07-01 09:38:26.000000000 -0500
@@ -365,7 +365,7 @@
 	*buf = '\0';
 	buf++;
 
-	handle = simple_strtoul(handle_str, NULL, 10);
+	handle = simple_strtoul(handle_str, NULL, 0);
 
 	*npp = of_find_node_by_phandle(handle);
 	return buf;
