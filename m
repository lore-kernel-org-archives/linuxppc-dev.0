Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA2F71A006F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 20:43:36 +1100 (AEDT)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Fri, 27 Feb 2015 15:13:34 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id BC855125805B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 15:14:49 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1R9hSX751249174
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 15:13:29 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1R9hRnR023900
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 15:13:27 +0530
Subject: [PATCH v1 0/2] perf/kvm: perf-kvm-stat on powerpc
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Fri, 27 Feb 2015 15:13:26 +0530
Message-ID: <20150227093649.6367.15679.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: maddy@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com, anton@au1.ibm.com,
 linux-kernel@vger.kernel.org, agraf@suse.de, paulus@samba.org,
 warrier@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

perf kvm stat record/report which can be used to analyze KVM related statistics
isn't enabled on powerpc. This patchset enables "perf kvm stat" on powerpc.
The first patch enables perf kvm stat record and report to report kvm exits.

"record" enables recording of the tracepoints: kvm_hv:kvm_guest_enter and
kvm_hv:kvm_guest_exit in the first patch and kvm_hv:kvm_hcall_enter and
kvm_hv:kvm_hcall_exit in the second patch.

This command can be used to record kvm events on the host:
# perf kvm stat record -a

To report the kvm guest related exit events, use:
# perf kvm stat report
or
# perf kvm stat report --event=vmexit

This should show the exit events along with the exit reasons.

The second patch in this series adds support to show the hcall events too with:
# perf kvm stat report --event=syscall

---

Hemant Kumar (1):
      perf/kvm: perf-kvm-stat to report syscalls

Srikar Dronamraju (1):
      perf/kvm: Enable perf-kvm-stat record/report on powerpc


 arch/powerpc/include/asm/hvcall.h            |  120 -------------------------
 arch/powerpc/include/uapi/asm/hcall_codes.h  |  123 ++++++++++++++++++++++++++
 arch/powerpc/include/uapi/asm/kvm_perf.h     |   19 ++++
 arch/powerpc/include/uapi/asm/trace_book3s.h |   33 +++++++
 arch/powerpc/include/uapi/asm/trace_hcall.h  |  122 ++++++++++++++++++++++++++
 arch/powerpc/kvm/trace_book3s.h              |   32 -------
 arch/powerpc/kvm/trace_hv.h                  |  119 -------------------------
 arch/powerpc/kvm/trace_pr.h                  |    2 
 tools/perf/arch/powerpc/Makefile             |    1 
 tools/perf/arch/powerpc/util/Build           |    1 
 tools/perf/arch/powerpc/util/kvm-stat.c      |   94 ++++++++++++++++++++
 11 files changed, 398 insertions(+), 268 deletions(-)
 create mode 100644 arch/powerpc/include/uapi/asm/hcall_codes.h
 create mode 100644 arch/powerpc/include/uapi/asm/kvm_perf.h
 create mode 100644 arch/powerpc/include/uapi/asm/trace_book3s.h
 create mode 100644 arch/powerpc/include/uapi/asm/trace_hcall.h
 delete mode 100644 arch/powerpc/kvm/trace_book3s.h
 create mode 100644 tools/perf/arch/powerpc/util/kvm-stat.c

--
