Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-oi0-x243.google.com (mail-oi0-x243.google.com
 [IPv6:2607:f8b0:4003:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40jsz82Rh1zF3Kq
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 May 2018 02:36:04 +1000 (AEST)
Received: by mail-oi0-x243.google.com with SMTP id k17-v6so7312220oih.5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 May 2018 09:36:03 -0700 (PDT)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <CA+7wUszjeXyYYExUmAVMh774HGD-5-CP5GKo5dSS6g32Dg1JcQ@mail.gmail.com>
References: <20180512033525.18762-1-npiggin@gmail.com>
 <CA+7wUszjeXyYYExUmAVMh774HGD-5-CP5GKo5dSS6g32Dg1JcQ@mail.gmail.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Sat, 12 May 2018 18:35:41 +0200
Message-ID: <CA+7wUsyRzLxid5Agd5L70ZAPpv7QjWx9qiJpxi5J_M+=pJy9ng@mail.gmail.com>
Subject: Re: [PATCH] selftests/powerpc: fix exec benchmark
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, May 12, 2018 at 10:54 AM, Mathieu Malaterre <malat@debian.org> wrote:
> Nick,
>
> On Sat, May 12, 2018 at 5:35 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
>> The exec_target binary could segfault calling _exit(2) because r13
>> is not set up properly (and libc looks at that when performing a
>> syscall). Call SYS_exit using syscall(2) which doesn't seem to
>> have this problem.
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  tools/testing/selftests/powerpc/benchmarks/exec_target.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/powerpc/benchmarks/exec_target.c b/tools/testing/selftests/powerpc/benchmarks/exec_target.c
>> index 3c9c144192be..c14b0fc1edde 100644
>> --- a/tools/testing/selftests/powerpc/benchmarks/exec_target.c
>> +++ b/tools/testing/selftests/powerpc/benchmarks/exec_target.c
>> @@ -6,8 +6,11 @@
>>   * Copyright 2018, Anton Blanchard, IBM Corp.
>>   */
>>
>> -void _exit(int);
>> +#define _GNU_SOURCE
>> +#include <unistd.h>
>> +#include <sys/syscall.h>
>> +
>>  void _start(void)
>>  {
>> -       _exit(0);
>> +       syscall(SYS_exit, 0);
>>  }
>> --
>> 2.17.0
>>
>
> Could you please apply the same patch to :
>
> ./tools/testing/selftests/size/get_size.c
>
> It segfault on ppc32 with default cross compiler from Debian.

Nevermind, I did not tested and this seems not to be sufficient to
make the executable run properly.
