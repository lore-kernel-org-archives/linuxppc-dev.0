Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sTnhx0YMHzDsG1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Sep 2016 01:40:00 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u87Fbf8h092339
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Sep 2016 11:39:58 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25a2y052vy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Sep 2016 11:39:58 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Wed, 7 Sep 2016 09:39:56 -0600
Subject: Re: [PATCH v6 0/7] perf: Cross arch annotate + few miscellaneous fixes
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 acme@kernel.org
References: <1471611578-11255-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com,
 treeze.taeung@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
 markus@trippelsdorf.de, chris.ryder@arm.com, pawel.moll@arm.com,
 mhiramat@kernel.org, rmk+kernel@arm.linux.org.uk, jolsa@kernel.org,
 mpe@ellerman.id.au, hemant@linux.vnet.ibm.com, namhyung@kernel.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Wed, 7 Sep 2016 21:09:40 +0530
MIME-Version: 1.0
In-Reply-To: <1471611578-11255-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <57D034BC.2090101@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

Any update on this?

-Ravi

On Friday 19 August 2016 06:29 PM, Ravi Bangoria wrote:
> Currently Perf annotate support code navigation (branches and calls)
> only when run on the same architecture where perf.data was recorded.
> But, for example, record on powerpc server and annotate on client's
> x86 desktop is not supported.
>
> This patchset enables cross arch annotate. Currently I've used x86
> and arm instructions which are already available and added support
> for powerpc.
>
> Additionally this patch series also contains few other related fixes.
>
> Patches are prepared on top of acme/perf/core and tested it with x86
> and powerpc only.
>
> Note for arm:
> I don't have arm test machine. As suggested by Russell in one of the
> review comment, I've copied all instructions from default table to
> arm table. This way it want break tool on arm but cleanup is needed
> for x86 specific instructions added in arm table.
>
> Example:
>
>   Record on powerpc:
>   $ ./perf record -a
>
>   Report -> Annotate on x86:
>   $ ./perf report -i perf.data.powerpc --vmlinux vmlinux.powerpc
>
> Changes in v6:
>   - Instead of adding only those instructions defined in #ifdef __arm__,
>     add all instructions from default table to arm table.
>
> v5 link:
>   https://lkml.org/lkml/2016/8/19/35
>
> Naveen N. Rao (1):
>   perf annotate: Add support for powerpc
>
> Ravi Bangoria (6):
>   perf: Define macro for normalized arch names
>   perf annotate: Add cross arch annotate support
>   perf annotate: Do not ignore call instruction with indirect target
>   perf annotate: Show raw form for jump instruction with indirect target
>   perf annotate: Support jump instruction with target as second operand
>   perf annotate: Fix jump target outside of function address range
>
>  tools/perf/arch/common.c           |  36 ++--
>  tools/perf/arch/common.h           |  11 ++
>  tools/perf/builtin-top.c           |   2 +-
>  tools/perf/ui/browsers/annotate.c  |   8 +-
>  tools/perf/ui/gtk/annotate.c       |   2 +-
>  tools/perf/util/annotate.c         | 330 +++++++++++++++++++++++++++++++------
>  tools/perf/util/annotate.h         |  10 +-
>  tools/perf/util/unwind-libunwind.c |   4 +-
>  8 files changed, 327 insertions(+), 76 deletions(-)
>
