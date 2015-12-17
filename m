Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 59FFC1A11AC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 16:08:10 +1100 (AEDT)
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 17 Dec 2015 10:38:07 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 3F4A7125801E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 10:38:30 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBH580Xa1048886
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 10:38:01 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBH580FL023487
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 10:38:00 +0530
Date: Thu, 17 Dec 2015 10:37:14 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: "Wangnan (F)" <wangnan0@huawei.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, jolsa@redhat.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sukadev@linux.vnet.ibm.com
Subject: Re: [PATCH v4] perf: bpf: Fix build breakage due to libbpf
Message-ID: <20151217050714.GB21524@naverao1-tp.ibm.com>
References: <1450150557-127942-4-git-send-email-wangnan0@huawei.com>
 <1450169473-137129-1-git-send-email-wangnan0@huawei.com>
 <20151215114046.GG23726@naverao1-tp.in.ibm.com>
 <20151216194234.GA19926@kernel.org> <56720FFB.5060407@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56720FFB.5060407@huawei.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2015/12/17 09:29AM, Wang Nan wrote:
> 
> 
> On 2015/12/17 3:42, Arnaldo Carvalho de Melo wrote:
> >Em Tue, Dec 15, 2015 at 05:10:46PM +0530, Naveen N. Rao escreveu:
> >>On 2015/12/15 08:51AM, Wang Nan wrote:
> >>>From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
> >>>
> >>>perf build is currently (v4.4-rc5) broken on powerpc:
> >>>
> >>>bpf.c:28:4: error: #error __NR_bpf not defined. libbpf does not support
> >>>your arch.
> >>>  #  error __NR_bpf not defined. libbpf does not support your arch.
> >>>     ^
> >>>
> >>>Fix this by including tools/scripts/Makefile.arch for the proper
> >>>$ARCH macro. While at it, remove redundant LP64 macro definition.
> >>>
> >>>Also, since libbpf require $(srctree) now, detect the path of
> >>>srctree like perf.
> >>>
> >>>Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> >>>Signed-off-by: Wang Nan <wangnan0@huawei.com>
> >>>Acked-by: Jiri Olsa <jolsa@kernel.org>
> >>>Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> >>>Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> >>>---
> >>>
> >>>v3 -> v4: Add srctree detector code so directly run 'make' in libbpf
> >>>           directory would not cause error.
> >>Good catch!
> >>
> >>Tested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> >Trying to apply the patchkit:
> >
> >[acme@zoo linux]$ make -C tools clean > /dev/null 2>&1
> >[acme@zoo linux]$ make -C tools/perf build-test
> >make: Entering directory '/home/git/linux/tools/perf'
> >Testing Makefile
> >tests/make:15: /scripts/Makefile.arch: No such file or directory
> >make[2]: *** No rule to make target '/scripts/Makefile.arch'.  Stop.
> >tests/make:5: recipe for target 'all' failed
> >make[1]: *** [all] Error 2
> >Makefile:81: recipe for target 'build-test' failed
> >make: *** [build-test] Error 2
> >make: Leaving directory '/home/git/linux/tools/perf'
> >[acme@zoo linux]$
> >
> >What am I doing wrong?
> 
> You need all 3 patches. This v4 patch is a fix for previous v3 3/3 and I
> send
> this patch by replying that one. I thought your email client is sorted by
> thread
> so you can easily find it but it seems I was wrong...

Arrgh! I see the confusion - your v4 didn't explicitly mention patch 
number 3, so that must have made Arnaldo think that this patch alone is 
enough. Perhaps [PATCH v4 3/3] would have been clearer.

> 
> The whole thread is:
> 
> [PATCH v3 0/3] perf build: PowerPC: Fix build breakage due to libbpf:
> http://lkml.kernel.org/g/1450150557-127942-1-git-send-email-wangnan0@huawei.com
> 
> [PATCH v3 1/3] perf tools: Fix PowerPC native building
> http://lkml.kernel.org/g/1450150557-127942-2-git-send-email-wangnan0@huawei.com
> 
> [PATCH v3 2/3] tools: Move Makefile.arch from perf/config to tools/scripts
> http://lkml.kernel.org/g/1450150557-127942-3-git-send-email-wangnan0@huawei.com
> 
> [PATCH v3 3/3] perf: bpf: Fix build breakage due to libbpf
> http://lkml.kernel.org/g/1450150557-127942-4-git-send-email-wangnan0@huawei.com
> 
> and [PATCH v3 3/3] breaks local building because the usage of "srctree", and
	     ^^
You mean v4 here.

Anyway, now that you've sent v4, it should be much clearer.

Thanks,
Naveen
