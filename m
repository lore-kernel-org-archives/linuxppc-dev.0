Return-Path: <vaibhav@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gSg15V3vzF1Hp
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 19:29:01 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w719Sk6M038168
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Aug 2018 05:28:59 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kk95h2um8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Aug 2018 05:28:58 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.ibm.com>;
 Wed, 1 Aug 2018 10:28:57 +0100
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Frederic Barrat <fbarrat@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 npiggin@gmail.com
Cc: felix@linux.ibm.com, clombard@linux.ibm.com
Subject: Re: [PATCH] powerpc/64s/radix: Fix missing global invalidations when
 removing copro
In-Reply-To: <20180731132452.15994-1-fbarrat@linux.ibm.com>
References: <20180731132452.15994-1-fbarrat@linux.ibm.com>
Date: Wed, 01 Aug 2018 14:58:45 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87va8ul9ki.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Frederic Barrat <fbarrat@linux.ibm.com> writes:

> With the optimizations for TLB invalidation from commit 0cef77c7798a
> ("powerpc/64s/radix: flush remote CPUs out of single-threaded
> mm_cpumask"), the scope of a TLBI (global vs. local) can now be
> influenced by the value of the 'copros' counter of the memory context.
>
> When calling mm_context_remove_copro(), the 'copros' counter is
> decremented first before flushing. It may have the unintended side
> effect of sending local TLBIs when we explicitly need global
> invalidations in this case. Thus breaking any nMMU user in a bad and
> unpredictable way.
>
> Fix it by flushing first, before updating the 'copros' counter, so
> that invalidations will be global.
>
> Fixes: 0cef77c7798a ("powerpc/64s/radix: flush remote CPUs out of single-threaded mm_cpumask")
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> ---
Tested-by: Vaibhav Jain <vaibhav@linux.ibm.com>

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
