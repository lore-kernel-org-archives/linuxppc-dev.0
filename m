Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9EDA51A026E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 01:02:54 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Mon, 20 Apr 2015 20:32:51 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 4F73F394005C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 20:32:49 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3KF2hS333161426
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 20:32:43 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3KEdYdl012007
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 20:09:35 +0530
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/5] KVM events analysis on powerpc with perf
Date: Mon, 20 Apr 2015 20:32:10 +0530
Message-Id: <1429542135-10632-1-git-send-email-hemant@linux.vnet.ibm.com>
Cc: maddy@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com, peterz@infradead.org,
 linux-kernel@vger.kernel.org, acme@kernel.org, paulus@samba.org,
 warrier@linux.vnet.ibm.com, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello!
This patchset enables "perf kvm stat record/report" on powerpc,
which can be used to analyze certain KVM events : KVM exits and
hypervisor calls. The statistics can be shown individually for
each running VM in the host and hence, can be useful in giving
an idea of the performance of a VM on a certain workload.

Example usages are shown in each of the patches individually.
Here is a sample output :
Analyze events for pid(s) 60515, all VCPUs:

          VM-EXIT    Samples  Samples%     Time%    Min Time    Max Time         Avg time

   H_DATA_STORAGE       5006    35.30%     0.13%      1.94us     49.46us     12.37us ( +-   0.52% )
   HV_DECREMENTER       4457    31.43%     0.02%      0.72us     16.14us      1.91us ( +-   0.96% )
          SYSCALL       2690    18.97%     0.10%      2.84us    528.24us     18.29us ( +-   3.75% )
   RETURN_TO_HOST       1789    12.61%    99.76%      1.58us 672791.91us  27470.23us ( +-   3.00% )
         EXTERNAL        240     1.69%     0.00%      0.69us     10.67us      1.33us ( +-   5.34% )

Total Samples:14182, Total events handled time:49264158.30us.

The above example shows how many number of kvm exits have happened
during a certain period of time. Along with the total number of exits,
it also groups all the exits based on their reasons. Frequency for
individual exit reasons is also shown.

This patchset makes use of kvm_hv tracepoints and enables "perf kvm
stat record" to trace on them. After recording, "perf kvm stat report"
does all the post processing of parsing the events captured and
classifying them according to their exit reasons (which are already
availabe in "trace_book3s.h"). Similar method is used with hcall
analysis.

Thanks,
Hemant Kumar
