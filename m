Return-Path: <paolo.bonzini@gmail.com>
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com
 [IPv6:2a00:1450:400c:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wTgx2104zzDqcl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 18:20:54 +1000 (AEST)
Received: by mail-wm0-x244.google.com with SMTP id k15so15339175wmh.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 01:20:53 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: [PATCH] perf: libdw support for powerpc
From: Paolo Bonzini <pbonzini@redhat.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: acme@kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <20170518170018.10507-1-pbonzini@redhat.com>
 <1495131092.c1jiws8vlt.astroid@naverao1-tp.none>
 <be48f6fe-0f0e-8667-0ad0-65e00904f008@redhat.com>
Message-ID: <24a6080b-c0bb-9965-013c-60b4368c649c@redhat.com>
Date: Fri, 19 May 2017 10:20:48 +0200
MIME-Version: 1.0
In-Reply-To: <be48f6fe-0f0e-8667-0ad0-65e00904f008@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 18/05/2017 20:48, Paolo Bonzini wrote:
> 
> 
> On 18/05/2017 20:19, Naveen N. Rao wrote:
>> Paolo Bonzini wrote:
>>> The ARM and x86 architectures already use libdw, and it is useful to
>>> have as much common code for the unwinder as possible.  Porting PPC
>>> to libdw only needs an architecture-specific hook to move the register
>>> state from perf to libdw.
>>
>> Thanks. Ravi has had a similar patch locally, but from what I
>> understand, there are issues with libdw based unwinding on powerpc64. I
>> gave this a quick test and I don't see the user-space call trace being
>> unwinded properly with libdw.
> 
> I don't see that problem:
> 
> -   99,98%     0,00%  dd       libc-2.17.so                    [.] generic_start_main.isra.0
>      generic_start_main.isra.0
>    - main
>       - 99,97% iread
>          - 97,82% sys_read
>             - 96,97% extract_entropy_user
>                  89,44% powernv_get_random_long
>                  4,63% sha_transform
>                  2,07% extract_buf
>            1,15% _raw_spin_lock_irqsave
>            0,51% extract_buf
> 
> (This is "perf record dd if=/dev/urandom of=/dev/null bs=512").
> 
> Can you copy the contents of tools/perf/.config-detected here?

FWIW it works fine for me here with latest Linus tree and your suggested
change to fix compilation:

--- a/tools/perf/arch/powerpc/util/unwind-libdw.c
+++ b/tools/perf/arch/powerpc/util/unwind-libdw.c
@@ -1,7 +1,7 @@
 #include <elfutils/libdwfl.h>
-#include "../../util/util.h"
 #include "../../util/unwind-libdw.h"
 #include "../../util/perf_regs.h"
+#include "../../util/event.h"

 /* See backends/ppc_initreg.c and backends/ppc_regs.c in elfutils.  */
 static const int special_regs[3][2] = {

Thanks,

Paolo
