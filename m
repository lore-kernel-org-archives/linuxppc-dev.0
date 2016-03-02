Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 019201A0B4C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 20:00:38 +1100 (AEDT)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C8FD414090A
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Mar 2016 20:00:37 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 2 Mar 2016 19:00:36 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id CEC4D2CE8054
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Mar 2016 20:00:32 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2290OqS12124474
 for <linuxppc-dev@ozlabs.org>; Wed, 2 Mar 2016 20:00:32 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u22900Ot003596
 for <linuxppc-dev@ozlabs.org>; Wed, 2 Mar 2016 20:00:00 +1100
Message-ID: <56D6AB70.3040503@linux.vnet.ibm.com>
Date: Wed, 02 Mar 2016 14:29:28 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Cyril Bur <cyrilbur@gmail.com>
CC: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V10 17/28] selftests, powerpc: Add ptrace tests for EBB
References: <1455613198-5113-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1455613198-5113-18-git-send-email-khandual@linux.vnet.ibm.com>
 <20160302113247.48a0e8d0@camb691>
In-Reply-To: <20160302113247.48a0e8d0@camb691>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/02/2016 06:02 AM, Cyril Bur wrote:
> On Tue, 16 Feb 2016 14:29:47 +0530
> Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:
> 
>> This patch adds ptrace interface test for EBB specific
>> registers. This also adds some generic ptrace interface
>> based helper functions to be used by other patches later
>> on in the series.
>>
>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> ---
>>  tools/testing/selftests/powerpc/Makefile           |   3 +-
>>  tools/testing/selftests/powerpc/ptrace/Makefile    |   7 +
>>  .../testing/selftests/powerpc/ptrace/ptrace-ebb.c  | 150 ++++++++++++++
>>  .../testing/selftests/powerpc/ptrace/ptrace-ebb.h  | 103 ++++++++++
>>  tools/testing/selftests/powerpc/ptrace/ptrace.h    | 225 +++++++++++++++++++++
>>  5 files changed, 487 insertions(+), 1 deletion(-)
>>  create mode 100644 tools/testing/selftests/powerpc/ptrace/Makefile
>>  create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-ebb.c
>>  create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-ebb.h
>>  create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace.h
>>
>> diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
>> index 0c2706b..5b3c62c 100644
>> --- a/tools/testing/selftests/powerpc/Makefile
>> +++ b/tools/testing/selftests/powerpc/Makefile
>> @@ -22,7 +22,8 @@ SUB_DIRS = benchmarks 		\
>>  	   switch_endian	\
>>  	   syscalls		\
>>  	   tm			\
>> -	   vphn
>> +	   vphn			\
>> +	   ptrace
>>  
>>  endif
>>  
>> diff --git a/tools/testing/selftests/powerpc/ptrace/Makefile b/tools/testing/selftests/powerpc/ptrace/Makefile
>> new file mode 100644
>> index 0000000..8666ac0
>> --- /dev/null
>> +++ b/tools/testing/selftests/powerpc/ptrace/Makefile
>> @@ -0,0 +1,7 @@
>> +TEST_PROGS := ptrace-ebb
>> +all: $(TEST_PROGS)
>> +
>> +$(TEST_PROGS): ../harness.c ptrace.S ../utils.c
>> +ptrace-ebb: ../pmu/event.c ../pmu/lib.c ../pmu/ebb/ebb_handler.S ../pmu/ebb/busy_loop.S
>> +clean:
>> +	rm -f $(TEST_PROGS) *.o
> 
> If you:
> include ../../lib.mk
> 
> Then this Makefile just works with run_tests and install targets from the
> base Makefile

Sure, will do that.

> 
>> diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-ebb.c b/tools/testing/selftests/powerpc/ptrace/ptrace-ebb.c
>> new file mode 100644
>> index 0000000..e1ca608
>> --- /dev/null
>> +++ b/tools/testing/selftests/powerpc/ptrace/ptrace-ebb.c
>> @@ -0,0 +1,150 @@
>> +/*
>> + * Ptrace interface test for EBB
>> + *
>> + * Copyright (C) 2015 Anshuman Khandual, IBM Corporation.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version
>> + * 2 of the License, or (at your option) any later version.
>> + */
>> +#include "../pmu/ebb/ebb.h"
>> +#include "ptrace.h"
>> +#include "ptrace-ebb.h"
>> +
> 
> Check out tools/testing/selftests/powerpc/utils.h which provides a nice (and
> super hacky) FAIL_IF() macro.

Sure, will check it out and see where all it can be used.
