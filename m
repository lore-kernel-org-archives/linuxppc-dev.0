Return-Path: <nfont@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7D154DDF7E
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jun 2008 07:29:32 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5KLOpe6024897
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 17:24:51 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5KLTQej141426
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 15:29:26 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5KLTP4P024236
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 15:29:25 -0600
Received: from austin.ibm.com (netmail2.austin.ibm.com [9.41.248.176])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m5KLTOeD024208
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 15:29:24 -0600
Received: from [9.53.40.161] (mudbug-009053040161.austin.ibm.com [9.53.40.161])
	by austin.ibm.com (8.13.8/8.12.10) with ESMTP id m5KLTOtN068110
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 16:29:24 -0500
Message-ID: <485C2134.4030109@austin.ibm.com>
Date: Fri, 20 Jun 2008 16:29:24 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/5] Allow drc indexes to be specified in formats other than
	decimal
References: <485C2033.20101@austin.ibm.com>
In-Reply-To: <485C2033.20101@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Allow the drc index passed to the /proc/ppc64/ofdt file to be specified
in formats other than decimal.  This allows us to easily specify drc indexes
in hex that would otherwise appears as negative integers.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---

Index: linux-2.6.git/arch/powerpc/platforms/pseries/reconfig.c
===================================================================
--- linux-2.6.git.orig/arch/powerpc/platforms/pseries/reconfig.c	2008-06-03 
16:29:04.000000000 -0500
+++ linux-2.6.git/arch/powerpc/platforms/pseries/reconfig.c	2008-06-19 
22:03:12.000000000 -0500
@@ -365,7 +365,7 @@
  	*buf = '\0';
  	buf++;

-	handle = simple_strtoul(handle_str, NULL, 10);
+	handle = simple_strtoul(handle_str, NULL, 0);

  	*npp = of_find_node_by_phandle(handle);
  	return buf;
