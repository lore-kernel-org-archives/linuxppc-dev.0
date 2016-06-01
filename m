Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rKNkk1DkpzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Jun 2016 18:27:10 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rKNkj4TD8z9t5X
 for <linuxppc-dev@ozlabs.org>; Wed,  1 Jun 2016 18:27:09 +1000 (AEST)
Received: from pps.filterd (m0048817.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u518O0bl023243
 for <linuxppc-dev@ozlabs.org>; Wed, 1 Jun 2016 04:27:07 -0400
Message-Id: <201606010827.u518O0bl023243@mx0a-001b2d01.pphosted.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 239r986r0f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 01 Jun 2016 04:27:07 -0400
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 1 Jun 2016 13:57:03 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 8105EE0060
 for <linuxppc-dev@ozlabs.org>; Wed,  1 Jun 2016 14:00:25 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u518QexS16712172
 for <linuxppc-dev@ozlabs.org>; Wed, 1 Jun 2016 13:56:41 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u518QjAp016586
 for <linuxppc-dev@ozlabs.org>; Wed, 1 Jun 2016 13:56:59 +0530
Date: Wed, 01 Jun 2016 13:56:42 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
CC: mikey@neuling.org, james.hogan@imgtec.com, avagin@openvz.org,
 Paul.Clothier@imgtec.com, cyrilbur@gmail.com, peterz@infradead.org,
 palves@redhat.com, emachado@linux.vnet.ibm.com,
 shuahkh@osg.samsung.com, akpm@linux-foundation.org, oleg@redhat.com,
 dhowells@redhat.com, Ulrich.Weigand@de.ibm.com, kirjanov@gmail.com,
 davej@redhat.com, tglx@linutronix.de, sukadev@linux.vnet.ibm.com,
 davem@davemloft.net, sam.bobroff@au1.ibm.com
Subject: Re: [PATCH V10 00/28] Add new powerpc specific ELF core notes
References: <1455613198-5113-1-git-send-email-khandual@linux.vnet.ibm.com>
 <57062722.5090706@linux.vnet.ibm.com>
 <5EA48413-85A1-4CB7-8843-CE22B2BB1F08@ellerman.id.au>
 <570B54EB.90507@linux.vnet.ibm.com> <1460524468.30704.5.camel@ellerman.id.au>
 <5718F901.6010104@linux.vnet.ibm.com> <5748004F.7040408@linux.vnet.ibm.com>
 <1464649951.16938.5.camel@ellerman.id.au>
In-Reply-To: <1464649951.16938.5.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/31/2016 04:42 AM, Michael Ellerman wrote:
> Hi Laurent,
> 
> Sorry no. My next branch closed for 4.7 about 3 weeks ago.
> 
> This series has been blocked for a long time on the gdb support, but that is
> now working. However it still doesn't pass its own selftests, and I had some

This series was clearing all of the selftests at the time it was posted.
But yes, it has some assumptions from timing and sync perspective which
gets broken some times as the kernel changes. Its been bit difficult to
perfect the sync requirements as we can do only some much inside the
transaction once it gets started. There are scopes here to improve these
selftests but not clearing them today does not really mean the patches are
now functionally broken.

> disagreements with the implementation - it duplicates a lot of code rather
> than refactoring things.

hmm, sorry, I dont remember the context here. Can you please point to the
discussion in this regard ?

> 
> I'm waiting on a patch from Cyril which will rework how the TM FP state is
> handled, and that should make this series easier to implement.

Can you please elaborate on this ? Has this patch been posted in the mailing
list ? How does this make it easier for us to implement these ELF notes ?

> 
> The plan is that both should go into 4.8.
