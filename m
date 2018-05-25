Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40sj8r56ndzF1nH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 20:26:36 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] selftests/powerpc: Add ptrace tests for Protection
 Key registers
In-Reply-To: <874liwqy64.fsf@morokweng.localdomain>
References: <20180223183344.21038-1-bauerman@linux.vnet.ibm.com>
 <87tvr6mlbe.fsf@concordia.ellerman.id.au>
 <874liwqy64.fsf@morokweng.localdomain>
Date: Fri, 25 May 2018 20:26:35 +1000
Message-ID: <87po1kqbdw.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
> Michael Ellerman <mpe@ellerman.id.au> writes:
>> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
>>>  tools/testing/selftests/powerpc/include/reg.h      |   1 +
>>>  tools/testing/selftests/powerpc/ptrace/Makefile    |   5 +-
>>>  tools/testing/selftests/powerpc/ptrace/child.h     | 130 ++++++++
>>>  .../testing/selftests/powerpc/ptrace/ptrace-pkey.c | 326 +++++++++++++++++++++
>>
>> This is failing on machines without pkeys:
>>
>>   test: ptrace_pkey
>>   tags: git_version:52e7d87
>>   [FAIL] Test FAILED on line 117
>>   [FAIL] Test FAILED on line 191
>>   failure: ptrace_pkey
>>
>>
>> I think the first fail is in the child here:
>>
>> int ptrace_read_regs(pid_t child, unsigned long type, unsigned long regs[],
>> 		     int n)
>> {
>> 	struct iovec iov;
>> 	long ret;
>>
>> 	FAIL_IF(start_trace(child));
>>
>> 	iov.iov_base = regs;
>> 	iov.iov_len = n * sizeof(unsigned long);
>>
>> 	ret = ptrace(PTRACE_GETREGSET, child, type, &iov);
>> 	FAIL_IF(ret != 0);
>>
>>
>> Which makes sense.
>
> Yes, that is indeed what is going on.
>
>> The test needs to skip if pkeys are not available/enabled. Using the
>> availability of the REGSET might actually be a nice way to detect that,
>> because it's read-only.
>
>  I forgot to consider the case of pkeys not available or not enabled,
>  sorry about that.

No worries.

> I just sent a v2 which implements your suggestion above.

Thanks.

cheers
