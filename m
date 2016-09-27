Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sk4Vr68R6zDrVT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 01:28:51 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8RFIE8N077404
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 11:28:49 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25qsq2nwcs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 11:28:49 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Tue, 27 Sep 2016 09:28:48 -0600
Subject: Re: [PATCH v7 0/6] perf annotate: Cross arch support + few fixes
To: linux-kernel@vger.kernel.org, acme@kernel.org
References: <1474472876-2706-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Cc: kim.phillips@arm.com, linuxppc-dev@lists.ozlabs.org, peterz@infradead.org,
 mingo@redhat.com, alexander.shishkin@linux.intel.com,
 treeze.taeung@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
 markus@trippelsdorf.de, namhyung@kernel.org, pawel.moll@arm.com,
 chris.ryder@arm.com, jolsa@kernel.org, mhiramat@kernel.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Tue, 27 Sep 2016 20:58:33 +0530
MIME-Version: 1.0
In-Reply-To: <1474472876-2706-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <57EA9021.7070101@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

Any updates?

Arnaldo, if patches looks good to you, can you please pickup them.

-Ravi

On Wednesday 21 September 2016 09:17 PM, Ravi Bangoria wrote:
> Currently Perf annotate support code navigation (branches and calls)
> only when run on the same architecture where perf.data was recorded.
> But, for example, record on powerpc server and annotate on client's
> x86 desktop is not supported.
>
> This patchset adds supports for that.
>
> Example:
>
>   Record on powerpc:
>   $ ./perf record -a
>
>   Report -> Annotate on x86:
>   $ ./perf report -i perf.data.powerpc --vmlinux vmlinux.powerpc
>
> Changes in v7:
>   - Using string for normalized arch names instread of macros.(i.e.
>     removed patch 1/7 of v6)
>   - In patch 1/6, make norm_arch as global var instead of passing them
>     to each parser.
>   - In patch 1/6 and 6/6, little bit change in initializing instruction
>     list.
>   - patch 4/7 of v6 is already accepted. Removed that in v7.
>   - Address other review comments.
>   - Added more examples in patch descriptions.
>
> v6 link:
>   https://lkml.org/lkml/2016/8/19/411
>
> Kim, I don't have arm test machine. Can you please help me to test
> this on arm.
>
>
> Kim Phillips (1):
>   perf annotate: cross arch annotate support fixes for ARM
>
> Naveen N. Rao (1):
>   perf annotate: Add support for powerpc
>
> Ravi Bangoria (4):
>   perf annotate: Add cross arch annotate support
>   perf annotate: Show raw form for jump instruction with indirect target
>   perf annotate: Support jump instruction with target as second operand
>   perf annotate: Fix jump target outside of function address range
>
>  tools/perf/builtin-top.c          |   2 +-
>  tools/perf/ui/browsers/annotate.c |   8 +-
>  tools/perf/ui/gtk/annotate.c      |   2 +-
>  tools/perf/util/annotate.c        | 259 ++++++++++++++++++++++++++++++++------
>  tools/perf/util/annotate.h        |   8 +-
>  5 files changed, 232 insertions(+), 47 deletions(-)
>
