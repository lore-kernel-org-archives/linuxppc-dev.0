Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYCBN3RQjzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 23:58:36 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5KDn0o3039935
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 09:58:34 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23n2u637ea-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 09:58:34 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 20 Jun 2016 07:58:32 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 3833D3E4004F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 07:58:29 -0600 (MDT)
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5KDwTh141287870
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 06:58:29 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 13F5F6E041
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 07:58:29 -0600 (MDT)
Received: from [9.41.92.173] (unknown [9.41.92.173])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP id ED9957A007
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 07:58:28 -0600 (MDT)
To: linuxppc-dev@lists.ozlabs.org
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: [PATCH 0/2] powerpc/pseries: Dynamic associativity-lookup-arrays
 updating
Date: Mon, 20 Jun 2016 08:58:28 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <5767F684.9090802@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The ibm,dynamic-reconfiguration-memory/ibm,associativity-lookup-arrays
property used to track the associativity for LMBs assigned to a system
may not contain all of the possible associativity arrays for the system
at boot time. When a LMB is added to the system and its associativity
array is not present in the lookup array we need to update the lookup
array to contain the new associativity array.

The first patch splits the code that creates a clone of a property into
its own routine so this can be used for cloning any of the properties
used during memory hotplug.

The second patch updates the associativity lookup code to dynamically
add new associativity arrays to the lookup array if they are not
present.

-Nathan

 hotplug-memory.c |  131 ++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 92 insertions(+), 39 deletions(-)
 
