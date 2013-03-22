Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2DE352C009E
 for <linuxppc-dev@ozlabs.org>; Sat, 23 Mar 2013 02:49:51 +1100 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Sat, 23 Mar 2013 01:39:21 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 62C8D2BB0023
 for <linuxppc-dev@ozlabs.org>; Sat, 23 Mar 2013 02:49:45 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2MFadf65505500
 for <linuxppc-dev@ozlabs.org>; Sat, 23 Mar 2013 02:36:40 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2MFnh15019607
 for <linuxppc-dev@ozlabs.org>; Sat, 23 Mar 2013 02:49:44 +1100
Date: Fri, 22 Mar 2013 21:19:35 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [BUG][PATCH] powerpc: fix numa distance for form0 device tree
Message-ID: <20130322154935.GA26283@dirshya.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Michael Neuling <mikey@neuling.org>
Reply-To: svaidy@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

    powerpc: fix numa distance for form0 device tree
    
    The following commit breaks numa distance setup for old powerpc
    systems that use form0 encoding in device tree.
    
        commit 41eab6f88f24124df89e38067b3766b7bef06ddb
        powerpc/numa: Use form 1 affinity to setup node distance
    
    Device tree node /rtas/ibm,associativity-reference-points would
    index into /cpus/PowerPCxxxx/ibm,associativity based on form0 or
    form1 encoding detected by ibm,architecture-vec-5 property.
    
    All modern systems use form1 and current kernel code is correct.
    However, on older systems with form0 encoding, the numa distance
    will get hard coded as LOCAL_DISTANCE for all nodes.  This causes
    task scheduling anomaly since scheduler will skip building numa
    level domain (topmost domain with all cpus) if all numa distances
    are same.  (value of 'level' in sched_init_numa() will remain 0)
    
    Prior to the above commit:
    #define node_distance(from,to)
    	((from) == (to) ? LOCAL_DISTANCE : REMOTE_DISTANCE)
    
    Restoring compatible behavior with this patch for old powerpc systems
    with device tree where numa distance are encoded as form0.

    Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index bba87ca..6a252c4 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -201,7 +201,7 @@ int __node_distance(int a, int b)
 	int distance = LOCAL_DISTANCE;
 
 	if (!form1_affinity)
-		return distance;
+		return ((a == b) ? LOCAL_DISTANCE : REMOTE_DISTANCE);
 
 	for (i = 0; i < distance_ref_points_depth; i++) {
 		if (distance_lookup_table[a][i] == distance_lookup_table[b][i])
