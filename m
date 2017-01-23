Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v6mkb2cZQzDqQK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 09:51:03 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0NMnNOC086732
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jan 2017 17:51:01 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 285gput9w9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jan 2017 17:51:00 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 24 Jan 2017 08:50:58 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 27A7C2BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 09:50:55 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0NMokxq18219102
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 09:50:54 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0NMoMgZ005421
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 09:50:22 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v2 0/3] powerpc/kernel: Simplify rtas_initialize()
Date: Tue, 24 Jan 2017 09:49:51 +1100
Message-Id: <1485211794-11093-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This simplifies rtas_initialize(), no functional changes introduced:

   * PATCH[1/3] removes the unnecessary nested if statements.
   * PATCH[2/3] uses of_property_read_u32() instead of converting the
     property's data to target in CPU endian.
   * PATCH[3/3] decreases RTAS device-tree node's refcount in error path.

v2:
   * Set RTAS device-tree node to NULL if its base, or size, or both of
     them can't be found.

Gavin Shan (3):
  powerpc/kernel: Remove nested if statements in rtas_initialize()
  powerpc/kernel: Use of_property_read_u32() in rtas_initialize()
  powerpc/kernel: Fix unbalanced refcount on RTAS device node

 arch/powerpc/kernel/rtas.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

-- 
2.7.4
