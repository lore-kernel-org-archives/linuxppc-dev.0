Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CEAEA1A0744
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 20:03:20 +1100 (AEDT)
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A189C1400B7
 for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2015 20:03:19 +1100 (AEDT)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 1 Apr 2015 14:33:16 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 6B8DAE0054
 for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2015 14:35:34 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3192tXf51314728
 for <linuxppc-dev@ozlabs.org>; Wed, 1 Apr 2015 14:32:56 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3192tF5031765
 for <linuxppc-dev@ozlabs.org>; Wed, 1 Apr 2015 14:32:55 +0530
Message-ID: <551BB43E.5070600@linux.vnet.ibm.com>
Date: Wed, 01 Apr 2015 14:32:54 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: perf report broken for branch stack samples
Content-Type: text/plain; charset=ISO-8859-1
Cc: "ak@linux.intel.com" <ak@linux.intel.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Michael Ellerman <michaele@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

perf report is not showing up the branch stack sample results in the
from_symbol ---> to_symbol format even if the perf.data file has got
the samples (through 'perf record -b <workload>' session). Perf report
still displays the generic event based relative symbol classification
as usual. This problem can also be seen on X86. I wonder whether there
is any semantics change in the way perf report auto detects branch stack
samples in the perf.data file and reports in the intended format. After
doing a git bisect session, this following commit seems to have changed
the  perf report behavior.

commit fa94c36c29ed8bb4749b5fd7ea51a593f673dcef
Author: Andi Kleen <ak@linux.intel.com>
Date:   Wed Nov 12 18:05:22 2014 -0800

    perf report: Add --branch-history option
    
    Add a --branch-history option to perf report that changes all the
    settings necessary for using the branches in callstacks.
    
    This is just a short cut to make this nicer to use, it does not enable
    any functionality by itself.
    
    v2: Change sort order. Rename option to --branch-history to
        be less confusing.
    v3: Updates
    v4: Fix conflict with newer perf base
    v5: Port to latest tip
    v6: Add more comments. Remove CCKEY_ADDRESS setting. Remove
        unnecessary branch_mode setting. Use a boolean.
    
    Signed-off-by: Andi Kleen <ak@linux.intel.com>
    Cc: Jiri Olsa <jolsa@redhat.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Link: http://lkml.kernel.org/r/1415844328-4884-5-git-send-email-andi@firstfloor.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

I dont have much context of this change but it seems to be using branch
records along with call chain data (provided you have used both -b/-j
and -g option during perf record) to display better control flow graph ?
But then if we have just used -b and not -g then it should still give us
the previous output what we used to get.

Regards
Anshuman
