Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4kNG34sZzDqQ1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 18:57:34 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s4kNF6brTz9sBr
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Aug 2016 18:57:33 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u748sYcE139161
 for <linuxppc-dev@ozlabs.org>; Thu, 4 Aug 2016 04:57:31 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24kkah0sp0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 04 Aug 2016 04:57:31 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 4 Aug 2016 18:57:29 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 5D80C2BB0055
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Aug 2016 18:57:27 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u748vR8d26345538
 for <linuxppc-dev@ozlabs.org>; Thu, 4 Aug 2016 18:57:27 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u748vQMD008924
 for <linuxppc-dev@ozlabs.org>; Thu, 4 Aug 2016 18:57:27 +1000
Subject: Re: [PATCH v2 3/3] powernv: Fix MCE handler to avoid trashing CR0/CR1
 registers.
To: Stewart Smith <stewart@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <20160301054655.15714.48085.stgit@mars.in.ibm.com>
 <20160301054817.15714.20605.stgit@mars.in.ibm.com>
 <87mvkt891s.fsf@linux.vnet.ibm.com>
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Thu, 4 Aug 2016 14:27:24 +0530
MIME-Version: 1.0
In-Reply-To: <87mvkt891s.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <5208d498-ffa8-cf5f-dcae-2f8d0d1b0889@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/04/2016 09:44 AM, Stewart Smith wrote:
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>
>> The current implementation of MCE early handling modifies CR0/1 registers
>> without saving its old values. Fix this by moving early check for
>> powersaving mode to machine_check_handle_early().
> 
> From (internal bug report) it seems as though in a test where one
> injects continuous SLB Multi Hit errors, this bug could lead to rebooting
> "due to to Platform error" rather than continuing to recover
> successfully. It might be a good idea to mention that in commit message
> here.

This patch does not address the specific internal bug that you talking
about. I am still chasing that bug.

> 
> Also, should this go to stable?
> 

However yes. This should go to stable tree.
