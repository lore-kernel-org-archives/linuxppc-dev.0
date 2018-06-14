Return-Path: <pedromfc@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4164nb4wB6zDrnp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 23:52:51 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5EDnrjQ052306
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 09:52:48 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jkpn6rq1n-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 09:52:47 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pedromfc@linux.vnet.ibm.com>;
 Thu, 14 Jun 2018 09:52:47 -0400
From: Pedro Franco de Carvalho <pedromfc@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 1/5] powerpc: Fix inverted active predicate for
 setting the EBB regset
In-Reply-To: <87fu1rtot3.fsf@concordia.ellerman.id.au>
References: <20180607152534.29427-1-pedromfc@linux.vnet.ibm.com>
 <20180607152534.29427-2-pedromfc@linux.vnet.ibm.com>
 <87fu1rtot3.fsf@concordia.ellerman.id.au>
Date: Thu, 14 Jun 2018 10:52:41 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <877en1mq52.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> Hi Pedro,
>
> Thanks for looking into this, how did you detect this? Do you have a
> test case?

Hello,

I'm working on allowing these registers to be accessed through GDB,
which is where I saw this happen. Then I used a small program that
traces another, then reads and tries to write to the regset, but not in
linux selftest format.

> I don't think Anshuman wrote it this way on purpose, but added him to Cc
> in case he remembers.
>
> But I don't think this fix is necessarily right. If we are setting the
> EBB regs via ptrace then it doesn't matter if they were previously in
> use or not, we should just set them. What *does* matter is that at the
> end of the function we set used_ebb to true, because otherwise the
> values we have set will not actually be used when the process is
> rescheduled.

Now I'm not sure why the ptrace calls for the ebb regset are guarded
with used_ebb in the first place. The save/restore_sprs functions in
kernel/process.c seem to handle the ebb registers regardless of this
flag, and it seems to be possible for user programs to read and write to
these registers even without having first created a perf event.

The flag only appears to be used in perf/core_book3s.c in the
ebb_event_add function, and the pmu registers (mmcr0, etc) only seem to
be saved to and restored from the thread_struct through
ebb_switch_in/out. So maybe the original intent was to guard the
pmu_get/set functions with used_ebb instead?

I'm not sure about this, because I don't know if it possible for a
ptrace call to happen between ebb_event_add and the first ebb_switch_in
for a thread.

Thanks!

--
Pedro
