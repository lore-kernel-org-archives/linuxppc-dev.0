Return-Path: <fweimer@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVJXC2h1NzDr5J
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 01:50:33 +1100 (AEDT)
Subject: Re: POWER: Unexpected fault when writing to brk-allocated memory
To: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm <linux-mm@kvack.org>
References: <f251fc3e-c657-ebe8-acc8-f55ab4caa667@redhat.com>
 <20171105231850.5e313e46@roar.ozlabs.ibm.com>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <6d293bb3-78bd-6d20-3684-be6358bd3d7b@redhat.com>
Date: Sun, 5 Nov 2017 15:50:28 +0100
MIME-Version: 1.0
In-Reply-To: <20171105231850.5e313e46@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/05/2017 01:18 PM, Nicholas Piggin wrote:
> Something like the following patch may help if you could test.

The patch appears to fix it:

# /lib64/ld64.so.1 ./a.out
initial brk value: 0x7fffe4590000
probing at 0x80000001fffc

I used the follow simplified reproducer:

#include <err.h>
#include <unistd.h>
#include <inttypes.h>
#include <errno.h>
#include <stdio.h>

int
main (void)
{
   errno = 0;
   void *p = sbrk (0);
   if (errno != 0)
     err (1, "sbrk (0)");
   printf ("initial brk value: %p\n", p);
   unsigned long long target = 0x800000020000ULL;
   if ((uintptr_t) p >= target)
     errx (1, "initial brk value is already above target");
   unsigned long long increment = target - (uintptr_t) p;
   errno = 0;
   sbrk (increment);
   if (errno != 0)
     err (1, "sbrk (0x%llx)", increment);
   volatile int *pi = (volatile int *) (target - 4);
   printf ("probing at %p\n", pi);
   *pi = 1;
}


It is still probabilistic because if the increment is too large, the 
second sbrk call will fail with an out of memory error (which is 
expected), so you'll have to run it a couple of times.

If the test fails, the write at the will segfault.

Thanks,
Florian
