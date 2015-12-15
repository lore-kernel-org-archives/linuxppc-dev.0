Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B96D91A1A3C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 22:31:22 +1100 (AEDT)
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 15 Dec 2015 17:01:19 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id A167E1258062
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 17:01:45 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBFBUUEP41746646
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 17:00:30 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBFBUU4c021630
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 17:00:30 +0530
Date: Tue, 15 Dec 2015 16:59:47 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Wang Nan <wangnan0@huawei.com>
Cc: acme@kernel.org, jolsa@redhat.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 0/3] perf build: PowerPC: Fix build breakage due to
 libbpf
Message-ID: <20151215112947.GF23726@naverao1-tp.in.ibm.com>
References: <1450090232-11437-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <1450150557-127942-1-git-send-email-wangnan0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1450150557-127942-1-git-send-email-wangnan0@huawei.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2015/12/15 03:35AM, Wang Nan wrote:
> Hi Naveen,
> 
>    Now I know your problem is in native building and the reason is
> missing proper $(ARCH). I think other than that there's another problem
> in libbpf's building: if your problem is unable to compile libbpf,
> feature checker should find it and set NO_LIBBPF=1 for perf, so perf
> building won't be blocked, only BPF related features should be turned
> off. Also, I think including Makefile.arch from tools/scripts would be
> better, because libbpf is at the same level with perf. So I separate
> them into 3 patches. Please help me test it on PowerPC.

Hi Wang,
Thanks for putting this together. Entire series:

Tested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>


> 
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> 
> Naveen N. Rao (1):
>   perf: bpf: Fix build breakage due to libbpf
> 
> Wang Nan (2):
>   perf tools: Fix PowerPC native building
>   tools: Move Makefile.arch from perf/config to tools/scripts
> 
>  tools/build/feature/test-bpf.c               | 20 +++++++++++++++++++-
>  tools/lib/bpf/Makefile                       |  3 ++-
>  tools/lib/bpf/bpf.c                          |  4 ++--
>  tools/perf/config/Makefile                   |  2 +-
>  tools/perf/tests/make                        |  2 +-
>  tools/{perf/config => scripts}/Makefile.arch |  0
>  6 files changed, 25 insertions(+), 6 deletions(-)
>  rename tools/{perf/config => scripts}/Makefile.arch (100%)
> 
> -- 
> 1.8.3.4
> 
