Return-Path: <dougmill@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vDjQN6GJRzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 01:42:36 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v12EcpZt138462
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Feb 2017 09:42:34 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28c6981ewh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Feb 2017 09:42:33 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dougmill@linux.vnet.ibm.com>;
 Thu, 2 Feb 2017 09:42:33 -0500
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id E4CD9C90043
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 09:42:12 -0500 (EST)
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v12EgTKu9961766
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Feb 2017 14:42:31 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EEA25112054
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 09:42:30 -0500 (EST)
Received: from oc5780617838.ibm.com (unknown [9.80.99.213])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP id C7E1E11205F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 09:42:30 -0500 (EST)
To: linuxppc-dev@lists.ozlabs.org
From: Douglas Miller <dougmill@linux.vnet.ibm.com>
Subject: xmon memory dump does not handle LE
Date: Thu, 2 Feb 2017 08:42:30 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <2a0e256f-4947-e94d-7f79-5451b3c90f9f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I was hoping this would be any easy fix, but now it looks like it will 
be more difficult.


The basic problem is that xmon memory commands like 'dd' do not properly 
display the data on LE instances. This means that not only is it 
difficult to read but one cannot copy-paste addresses from the output. 
This severely encumbers debugging using xmon on LE systems.


It looks like prdump() is highly optimized but only works on BE. Have I 
missed something, or will it take a significant re-write of this code to 
fix the LE problem?


Thanks,

Doug
