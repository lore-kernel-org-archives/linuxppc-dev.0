Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqDTR24StzDrPt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 19:45:15 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6D9iMgU102084
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:45:13 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2452at7en0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:45:13 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Wed, 13 Jul 2016 03:45:12 -0600
Subject: Re: [PATCH v4 0/3] perf annotate: Enable cross arch annotate
To: acme@kernel.org, mpe@ellerman.id.au
References: <1467952813-5797-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 anton@ozlabs.org, ananth@in.ibm.com, dja@axtens.net,
 naveen.n.rao@linux.vnet.ibm.com, David.Laight@ACULAB.COM,
 rmk+kernel@arm.linux.org.uk,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Wed, 13 Jul 2016 15:15:02 +0530
MIME-Version: 1.0
In-Reply-To: <1467952813-5797-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <57860D9E.7000906@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Arnaldo, Michael,

I've tested this patchset on ppc64 BE and LE both. Please review this.

-Ravi

On Friday 08 July 2016 10:10 AM, Ravi Bangoria wrote:
> Perf can currently only support code navigation (branches and calls) in
> annotate when run on the same architecture where perf.data was recorded.
> But cross arch annotate is not supported.
>
> This patchset enables cross arch annotate. Currently I've used x86
> and arm instructions which are already available and adding support
> for powerpc as well. Adding support for other arch will be easy.
>
> I've created this patch on top of acme/perf/core. And tested it with
> x86 and powerpc only.
>
> Note for arm:
> Few instructions were defined under #if __arm__ which I've used as a
> table for arm. But I'm not sure whether instruction defined outside of
> that also contains arm instructions. Apart from that, 'call__parse()'
> and 'move__parse()' contains #ifdef __arm__ directive. I've changed it
> to  if (!strcmp(norm_arch, arm)). I don't have a arm machine to test
> these changes.
>
> Example:
>
>    Record on powerpc:
>    $ ./perf record -a
>
>    Report -> Annotate on x86:
>    $ ./perf report -i perf.data.powerpc --vmlinux vmlinux.powerpc
>
> Changes in v4:
>    - powerpc: Added support for branch instructions that includes 'ctr'
>    - __maybe_unused was misplaced at few location. Corrected it.
>    - Moved position of v3 last patch that define macro for each arch name
>
> v3 link: https://lkml.org/lkml/2016/6/30/99
>
> Naveen N. Rao (1):
>    perf annotate: add powerpc support
>
> Ravi Bangoria (2):
>    perf: Define macro for normalized arch names
>    perf annotate: Enable cross arch annotate
>
>   tools/perf/arch/common.c           |  36 ++---
>   tools/perf/arch/common.h           |  11 ++
>   tools/perf/builtin-top.c           |   2 +-
>   tools/perf/ui/browsers/annotate.c  |   3 +-
>   tools/perf/ui/gtk/annotate.c       |   2 +-
>   tools/perf/util/annotate.c         | 273 ++++++++++++++++++++++++++++++-------
>   tools/perf/util/annotate.h         |   6 +-
>   tools/perf/util/unwind-libunwind.c |   4 +-
>   8 files changed, 265 insertions(+), 72 deletions(-)
>
> --
> 2.5.5
>
