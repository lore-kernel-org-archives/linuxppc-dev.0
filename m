Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CCD0E1A0270
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 17:49:05 +1100 (AEDT)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Tue, 24 Mar 2015 12:18:59 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 4048A125805A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 12:20:34 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2O6mtOu41615582
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 12:18:56 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2O6fun7028310
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 12:11:57 +0530
Message-ID: <551108D6.7090805@linux.vnet.ibm.com>
Date: Tue, 24 Mar 2015 12:18:54 +0530
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v1 0/2] perf/kvm: perf-kvm-stat on powerpc
References: <20150227093649.6367.15679.stgit@localhost.localdomain>
In-Reply-To: <20150227093649.6367.15679.stgit@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: maddy@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com, anton@au1.ibm.com,
 agraf@suse.de, linux-kernel@vger.kernel.org, paulus@samba.org,
 warrier@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

These patches were posted a month back. We don't have any review 
comments to handle at this time. Can you pull these patches to your tree?
Please, do let me know if you want me to rebase these patches to a 
different tree (like Arnaldo's/tip etc).

On 02/27/2015 03:13 PM, Hemant Kumar wrote:
> perf kvm stat record/report which can be used to analyze KVM related statistics
> isn't enabled on powerpc. This patchset enables "perf kvm stat" on powerpc.
> The first patch enables perf kvm stat record and report to report kvm exits.
>
> "record" enables recording of the tracepoints: kvm_hv:kvm_guest_enter and
> kvm_hv:kvm_guest_exit in the first patch and kvm_hv:kvm_hcall_enter and
> kvm_hv:kvm_hcall_exit in the second patch.
>
> This command can be used to record kvm events on the host:
> # perf kvm stat record -a
>
> To report the kvm guest related exit events, use:
> # perf kvm stat report
> or
> # perf kvm stat report --event=vmexit
>
> This should show the exit events along with the exit reasons.
>
> The second patch in this series adds support to show the hcall events too with:
> # perf kvm stat report --event=syscall
>
> ---
>
> Hemant Kumar (1):
>        perf/kvm: perf-kvm-stat to report syscalls
>
> Srikar Dronamraju (1):
>        perf/kvm: Enable perf-kvm-stat record/report on powerpc
>
>
>   arch/powerpc/include/asm/hvcall.h            |  120 -------------------------
>   arch/powerpc/include/uapi/asm/hcall_codes.h  |  123 ++++++++++++++++++++++++++
>   arch/powerpc/include/uapi/asm/kvm_perf.h     |   19 ++++
>   arch/powerpc/include/uapi/asm/trace_book3s.h |   33 +++++++
>   arch/powerpc/include/uapi/asm/trace_hcall.h  |  122 ++++++++++++++++++++++++++
>   arch/powerpc/kvm/trace_book3s.h              |   32 -------
>   arch/powerpc/kvm/trace_hv.h                  |  119 -------------------------
>   arch/powerpc/kvm/trace_pr.h                  |    2
>   tools/perf/arch/powerpc/Makefile             |    1
>   tools/perf/arch/powerpc/util/Build           |    1
>   tools/perf/arch/powerpc/util/kvm-stat.c      |   94 ++++++++++++++++++++
>   11 files changed, 398 insertions(+), 268 deletions(-)
>   create mode 100644 arch/powerpc/include/uapi/asm/hcall_codes.h
>   create mode 100644 arch/powerpc/include/uapi/asm/kvm_perf.h
>   create mode 100644 arch/powerpc/include/uapi/asm/trace_book3s.h
>   create mode 100644 arch/powerpc/include/uapi/asm/trace_hcall.h
>   delete mode 100644 arch/powerpc/kvm/trace_book3s.h
>   create mode 100644 tools/perf/arch/powerpc/util/kvm-stat.c
>
> --
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

-- 
Thanks,
Hemant Kumar
