Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wvDzr13NQzDqkM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 20:23:03 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5NAIoCn012098
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 06:23:01 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b8vqc3cdd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 06:23:01 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 23 Jun 2017 20:22:59 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5NAMt4W7405982
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 20:22:55 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5NAMsXW028339
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 20:22:55 +1000
Subject: Re: [PATCH] powerpc: Invalidate ERAT on powersave wakeup for POWER9
To: Michael Neuling <mikey@neuling.org>, mpe@ellerman.id.au
References: <20170622172616.7598-1-mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Fri, 23 Jun 2017 15:52:47 +0530
MIME-Version: 1.0
In-Reply-To: <20170622172616.7598-1-mikey@neuling.org>
Content-Type: text/plain; charset=windows-1252
Message-Id: <14f2ed7e-5cb5-6d86-c66f-661ec653e2b2@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/22/2017 10:56 PM, Michael Neuling wrote:
> On POWER9 the ERAT may be incorrect on wakeup from some stop states
> that lose state. This causes random segvs and illegal instructions
> when these stop states are enabled.
> 
> This patch invalidates the ERAT on wakeup on POWER9 to prevent this
> from causing a problem.

Cant there be any real genuine ERAT error on the wake up path
from these states ? Just being curious.
