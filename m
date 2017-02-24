Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vV1Z0553tzDqGn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 17:35:20 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1O6SjSB008573
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 01:35:18 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28teq1a5x7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 01:35:17 -0500
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Fri, 24 Feb 2017 16:35:15 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 295412BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 17:35:12 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1O6Z4SM48890068
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 17:35:12 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1O6Yd99006252
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 17:34:39 +1100
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: powerpc: Enable cpuhotplug with ESL=1 on POWER9
Date: Fri, 24 Feb 2017 12:04:14 +0530
Message-Id: <20170224063416.7201-1-svaidy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The attached patch enables ESL=1 STOP2 for cpuhotplug.  This is a debug
patch that we could carry now until STOP states are discovered from
device tree.

Test run:

[  151.670021] CPU8 going offline with request psscr 00000000003f0332
[  151.719856] CPU 8 offline: Remove Rx thread
[  189.200410] CPU8 coming online with psscr 20000000003f0332, srr1 9000000000261001

We request ESL=EC=1 and STOP2 and successfully wakeup from that state
using IPI from XIVE.

--Vaidy
