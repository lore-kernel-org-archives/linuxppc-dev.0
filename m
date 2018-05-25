Return-Path: <bauerman@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40sVFL3CTnzF1dQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 12:14:46 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4P2ECF3111362
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 22:14:43 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j64tussqq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 22:14:43 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.ibm.com>;
 Thu, 24 May 2018 22:14:42 -0400
References: <20180223183344.21038-1-bauerman@linux.vnet.ibm.com>
 <87tvr6mlbe.fsf@concordia.ellerman.id.au>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] selftests/powerpc: Add ptrace tests for Protection
 Key registers
In-reply-to: <87tvr6mlbe.fsf@concordia.ellerman.id.au>
Date: Thu, 24 May 2018 23:14:27 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <874liwqy64.fsf@morokweng.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Michael Ellerman <mpe@ellerman.id.au> writes:

> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
>
>> This test exercises read and write access to the AMR, IAMR and UAMOR.
>>
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
>> ---
>>  tools/testing/selftests/powerpc/include/reg.h      |   1 +
>>  tools/testing/selftests/powerpc/ptrace/Makefile    |   5 +-
>>  tools/testing/selftests/powerpc/ptrace/child.h     | 130 ++++++++
>>  .../testing/selftests/powerpc/ptrace/ptrace-pkey.c | 326 +++++++++++++++++++++
>
> This is failing on machines without pkeys:
>
>   test: ptrace_pkey
>   tags: git_version:52e7d87
>   [FAIL] Test FAILED on line 117
>   [FAIL] Test FAILED on line 191
>   failure: ptrace_pkey
>
>
> I think the first fail is in the child here:
>
> int ptrace_read_regs(pid_t child, unsigned long type, unsigned long regs[],
> 		     int n)
> {
> 	struct iovec iov;
> 	long ret;
>
> 	FAIL_IF(start_trace(child));
>
> 	iov.iov_base = regs;
> 	iov.iov_len = n * sizeof(unsigned long);
>
> 	ret = ptrace(PTRACE_GETREGSET, child, type, &iov);
> 	FAIL_IF(ret != 0);
>
>
> Which makes sense.

Yes, that is indeed what is going on.

> The test needs to skip if pkeys are not available/enabled. Using the
> availability of the REGSET might actually be a nice way to detect that,
> because it's read-only.

 I forgot to consider the case of pkeys not available or not enabled,
 sorry about that.

I just sent a v2 which implements your suggestion above.

--
Thiago Jung Bauermann
IBM Linux Technology Center
