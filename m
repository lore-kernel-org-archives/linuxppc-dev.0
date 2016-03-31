Return-Path: <prvs=3898f00e9f=ast@fb.com>
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbXK018gXzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 04:57:07 +1100 (AEDT)
Subject: Re: [PATCH 1/4] samples/bpf: Fix build breakage with
 map_perf_test_user.c
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
References: <922f95fb5d16686367a66d2d4bd176149a87e9ad.1459423412.git.naveen.n.rao@linux.vnet.ibm.com>
CC: "David S . Miller" <davem@davemloft.net>, Ananth N Mavinakayanahalli
 <ananth@in.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Daniel Borkmann
 <daniel@iogearbox.net>, <netdev@vger.kernel.org>
From: Alexei Starovoitov <ast@fb.com>
Message-ID: <56FD61B6.9000102@fb.com>
Date: Thu, 31 Mar 2016 10:43:18 -0700
MIME-Version: 1.0
In-Reply-To: <922f95fb5d16686367a66d2d4bd176149a87e9ad.1459423412.git.naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 3/31/16 4:25 AM, Naveen N. Rao wrote:
> Building BPF samples is failing with the below error:
>
> samples/bpf/map_perf_test_user.c: In function ‘main’:
> samples/bpf/map_perf_test_user.c:134:9: error: variable ‘r’ has
> initializer but incomplete type
>    struct rlimit r = {RLIM_INFINITY, RLIM_INFINITY};
>           ^
> Fix this by including the necessary header file.
>
> Cc: Alexei Starovoitov <ast@fb.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>   samples/bpf/map_perf_test_user.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/samples/bpf/map_perf_test_user.c b/samples/bpf/map_perf_test_user.c
> index 95af56e..3147377 100644
> --- a/samples/bpf/map_perf_test_user.c
> +++ b/samples/bpf/map_perf_test_user.c
> @@ -17,6 +17,7 @@
>   #include <linux/bpf.h>
>   #include <string.h>
>   #include <time.h>
> +#include <sys/resource.h>
>   #include "libbpf.h"
>   #include "bpf_load.h"

It's failing this way on powerpc? Odd.
Such hidden header dependency was always puzzling to me. Anyway:
Acked-by: Alexei Starovoitov <ast@kernel.org>

I'm assuming you want this set to go via 'net' tree, so please resubmit
with [PATCH net 1/4] subjects and cc netdev.

Reviewing your other patches...
