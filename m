Return-Path: <stewart@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4c7p2TYgzDqRt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 14:16:22 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s4c7n4lfRz9stY
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Aug 2016 14:16:21 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u744EuDW039301
 for <linuxppc-dev@ozlabs.org>; Thu, 4 Aug 2016 00:16:19 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24kkagfr66-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 04 Aug 2016 00:16:19 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 4 Aug 2016 00:14:48 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 3/3] powernv: Fix MCE handler to avoid trashing CR0/CR1
 registers.
In-Reply-To: <20160301054817.15714.20605.stgit@mars.in.ibm.com>
References: <20160301054655.15714.48085.stgit@mars.in.ibm.com>
 <20160301054817.15714.20605.stgit@mars.in.ibm.com>
Date: Thu, 04 Aug 2016 14:14:39 +1000
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87mvkt891s.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>
> The current implementation of MCE early handling modifies CR0/1 registers
> without saving its old values. Fix this by moving early check for
> powersaving mode to machine_check_handle_early().

>From (internal bug report) it seems as though in a test where one
injects continuous SLB Multi Hit errors, this bug could lead to rebooting
"due to to Platform error" rather than continuing to recover
successfully. It might be a good idea to mention that in commit message
here.

Also, should this go to stable?

-- 
Stewart Smith
OPAL Architect, IBM.
