Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbYR41R02zDq6y
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 05:47:28 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 1 Apr 2016 04:47:26 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 369603578053
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 05:47:20 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2VIlC3t46989460
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Apr 2016 05:47:20 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2VIkkcV013688
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Apr 2016 05:46:47 +1100
Date: Fri, 1 Apr 2016 00:16:02 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Alexei Starovoitov <ast@fb.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S . Miller" <davem@davemloft.net>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Subject: Re: [PATCH 1/4] samples/bpf: Fix build breakage with
 map_perf_test_user.c
Message-ID: <20160331184602.GC17907@naverao1-tp.ibm.com>
References: <922f95fb5d16686367a66d2d4bd176149a87e9ad.1459423412.git.naveen.n.rao@linux.vnet.ibm.com>
 <56FD61B6.9000102@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <56FD61B6.9000102@fb.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/03/31 10:43AM, Alexei Starovoitov wrote:
> On 3/31/16 4:25 AM, Naveen N. Rao wrote:
> >Building BPF samples is failing with the below error:
> >
> >samples/bpf/map_perf_test_user.c: In function ‘main’:
> >samples/bpf/map_perf_test_user.c:134:9: error: variable ‘r’ has
> >initializer but incomplete type
> >   struct rlimit r = {RLIM_INFINITY, RLIM_INFINITY};
> >          ^
> >Fix this by including the necessary header file.
> >
> >Cc: Alexei Starovoitov <ast@fb.com>
> >Cc: David S. Miller <davem@davemloft.net>
> >Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> >Cc: Michael Ellerman <mpe@ellerman.id.au>
> >Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> >---
> >  samples/bpf/map_perf_test_user.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> >diff --git a/samples/bpf/map_perf_test_user.c b/samples/bpf/map_perf_test_user.c
> >index 95af56e..3147377 100644
> >--- a/samples/bpf/map_perf_test_user.c
> >+++ b/samples/bpf/map_perf_test_user.c
> >@@ -17,6 +17,7 @@
> >  #include <linux/bpf.h>
> >  #include <string.h>
> >  #include <time.h>
> >+#include <sys/resource.h>
> >  #include "libbpf.h"
> >  #include "bpf_load.h"
> 
> It's failing this way on powerpc? Odd.

This fails for me on x86_64 too -- RHEL 7.1.

> Such hidden header dependency was always puzzling to me. Anyway:
> Acked-by: Alexei Starovoitov <ast@kernel.org>
> 
> I'm assuming you want this set to go via 'net' tree, so please resubmit
> with [PATCH net 1/4] subjects and cc netdev.

Sure.

> 
> Reviewing your other patches...

Thanks for your review!

- Naveen
