Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wfVnN4TZ0zDqK9
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Jun 2017 02:59:52 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v52GxQeM008014
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Jun 2017 12:59:45 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2aua8pcf9k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Jun 2017 12:59:45 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Sat, 3 Jun 2017 02:59:43 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v52GxXGE60293144
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 3 Jun 2017 02:59:41 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v52Gx82U024465
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 3 Jun 2017 02:59:09 +1000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Greg Kurz <gkurz@linux.vnet.ibm.com>,
 "Alastair D'Silva" <alastair@au1.ibm.com>, stable@vger.kernel.org
Subject: Re: [RESEND-PATCH] cxl: Avoid double free_irq() for psl,
 slice interrupts
In-Reply-To: <693c34cc-9b88-c616-325b-de01e4cb760b@linux.vnet.ibm.com>
References: <20170602093555.9205-1-vaibhav@linux.vnet.ibm.com>
 <693c34cc-9b88-c616-325b-de01e4cb760b@linux.vnet.ibm.com>
Date: Fri, 02 Jun 2017 22:28:39 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87tw3yl41s.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:


>> +	    irq_find_mapping(NULL, afu->native->psl_virq))
>
>                                                      ^^^
> Shouldn't it be psl_hwirq?
>
Thanks for catching this Fred. I have sent a v2 patch fixing this.

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
