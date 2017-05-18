Return-Path: <pbonzini@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wTKwG1DwZzDqcL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 04:49:01 +1000 (AEST)
Subject: Re: [PATCH] perf: libdw support for powerpc
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: acme@kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <20170518170018.10507-1-pbonzini@redhat.com>
 <1495131092.c1jiws8vlt.astroid@naverao1-tp.none>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <be48f6fe-0f0e-8667-0ad0-65e00904f008@redhat.com>
Date: Thu, 18 May 2017 20:48:55 +0200
MIME-Version: 1.0
In-Reply-To: <1495131092.c1jiws8vlt.astroid@naverao1-tp.none>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 18/05/2017 20:19, Naveen N. Rao wrote:
> Paolo Bonzini wrote:
>> The ARM and x86 architectures already use libdw, and it is useful to
>> have as much common code for the unwinder as possible.  Porting PPC
>> to libdw only needs an architecture-specific hook to move the register
>> state from perf to libdw.
> 
> Thanks. Ravi has had a similar patch locally, but from what I
> understand, there are issues with libdw based unwinding on powerpc64. I
> gave this a quick test and I don't see the user-space call trace being
> unwinded properly with libdw.

I don't see that problem:

-   99,98%     0,00%  dd       libc-2.17.so                    [.] generic_start_main.isra.0
     generic_start_main.isra.0
   - main
      - 99,97% iread
         - 97,82% sys_read
            - 96,97% extract_entropy_user
                 89,44% powernv_get_random_long
                 4,63% sha_transform
                 2,07% extract_buf
           1,15% _raw_spin_lock_irqsave
           0,51% extract_buf

(This is "perf record dd if=/dev/urandom of=/dev/null bs=512").

Can you copy the contents of tools/perf/.config-detected here?

>> diff --git a/tools/perf/arch/powerpc/util/unwind-libdw.c
>> b/tools/perf/arch/powerpc/util/unwind-libdw.c
>> new file mode 100644
>> index 0000000..c61e1d8
>> --- /dev/null
>> +++ b/tools/perf/arch/powerpc/util/unwind-libdw.c
>> @@ -0,0 +1,73 @@
>> +#include <elfutils/libdwfl.h>
>> +#include "../../util/util.h"
>> +#include "../../util/unwind-libdw.h"
>> +#include "../../util/perf_regs.h"
> 
> As an aside, we also need to include "event.h", without which there are
> a few compile errors.

Oops, I was compiling this on 4.11.  Sorry.

Paolo
