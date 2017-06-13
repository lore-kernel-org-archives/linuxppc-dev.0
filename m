Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wnDqy6Rn2zDqL3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 01:55:26 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5DFrwiC119644
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 11:55:24 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b2jef2fq3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 11:55:23 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Tue, 13 Jun 2017 11:55:23 -0400
Subject: Re: [PATCH v2] perf: libdw support for powerpc [ping]
To: Mark Wielaard <mark@klomp.org>
References: <1496312681-20133-1-git-send-email-pbonzini@redhat.com>
 <a44cf3bd-e868-a8d5-4518-2bea76be7f8f@redhat.com>
 <593E81ED.8060606@linux.vnet.ibm.com> <1497354282.3755.201.camel@klomp.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 acme@kernel.org, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Tue, 13 Jun 2017 21:25:09 +0530
MIME-Version: 1.0
In-Reply-To: <1497354282.3755.201.camel@klomp.org>
Content-Type: text/plain; charset=utf-8
Message-Id: <59400ADD.4090709@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Mark,

On Tuesday 13 June 2017 05:14 PM, Mark Wielaard wrote:
> I see the same on very short runs. But when doing a slightly longer run,
> even just using ls -lahR, which does some more work, then I do see user
> backtraces. They are still missing for some of the early samples though.
> It is as if there is a stack/memory address mismatch when the probe is
> "too early" in ld.so.
>
> Could you do a test run on some program that does some more work to see
> if you never get any user stack traces, or if you only not get them for
> some specific probes?

Thanks for checking. I tried a proper workload this time, but I still
don't see any userspace callchain getting unwound.

  $ ./perf record --call-graph=dwarf -- zip -q -r temp.zip .
  [ perf record: Woken up 2891 times to write data ]
  [ perf record: Captured and wrote 723.290 MB perf.data (87934 samples) ]


With libdw:

 $ LD_LIBRARY_PATH=/home/ravi/elfutils-git/usr/local/lib:\
    /home/ravi/elfutils-git/usr/local/lib/elfutils/:$LD_LIBRARY_PATH\
    ./perf script

  zip 16699  6857.354633:      37371 cycles:u:
                   ecedc xmon_core (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                   8c4fc __hash_page_64K (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                   83450 hash_preload (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                   7cc34 update_mmu_cache (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                  330064 alloc_set_pte (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                  330efc do_fault (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                  334580 __handle_mm_fault (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                  335040 handle_mm_fault (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                   7bf94 do_page_fault (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                   7bec4 do_page_fault (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                   7be78 do_page_fault (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                   1a4f8 handle_page_fault (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)

  zip 16699  6857.354663:     300677 cycles:u:

  zip 16699  6857.354895:     584131 cycles:u:

  zip 16699  6857.355312:     589687 cycles:u:

  zip 16699  6857.355606:     560142 cycles:u:


With libunwind:

$ ./perf script

  zip 16699  6857.354633:      37371 cycles:u:
                     ecedc xmon_core (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                     8c4fc __hash_page_64K (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                     83450 hash_preload (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                     7cc34 update_mmu_cache (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                    330064 alloc_set_pte (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                    330efc do_fault (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                    334580 __handle_mm_fault (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                    335040 handle_mm_fault (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                     7bf94 do_page_fault (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                     7bec4 do_page_fault (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                     7be78 do_page_fault (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                     1a4f8 handle_page_fault (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                      1920 _start (/usr/lib64/ld-2.17.so)

  zip 16699  6857.354663:     300677 cycles:u:
                      fa38 _dl_new_object (/usr/lib64/ld-2.17.so)
                      3073 dl_main (/usr/lib64/ld-2.17.so)
                     2045b _dl_sysdep_start (/usr/lib64/ld-2.17.so)
                      1c7f _dl_start_final (/usr/lib64/ld-2.17.so)
                      5ce7 _dl_start (/usr/lib64/ld-2.17.so)
                      1937 _start (/usr/lib64/ld-2.17.so)

  zip 16699  6857.354895:     584131 cycles:u:
                     103d0 _dl_relocate_object (/usr/lib64/ld-2.17.so)

  zip 16699  6857.355312:     589687 cycles:u:
                      df68 do_lookup_x (/usr/lib64/ld-2.17.so)
                      e8d7 _dl_lookup_symbol_x (/usr/lib64/ld-2.17.so)
                     14bb3 _dl_fixup (/usr/lib64/ld-2.17.so)
                     1ef37 _dl_runtime_resolve (/usr/lib64/ld-2.17.so)
                     20bf7 copy_args (/usr/bin/zip)
                      286f main (/usr/bin/zip)
                     2497f generic_start_main.isra.0 (/usr/lib64/libc-2.17.so)
                     24b73 __libc_start_main (/usr/lib64/libc-2.17.so)

  zip 16699  6857.355606:     560142 cycles:u:
                     84764 _IO_getc (/usr/lib64/libc-2.17.so)
                      c4d7 find_next_signature (/usr/bin/zip)
                     15c8b readzipfile (/usr/bin/zip)
                      3477 main (/usr/bin/zip)
                     2497f generic_start_main.isra.0 (/usr/lib64/libc-2.17.so)
                     24b73 __libc_start_main (/usr/lib64/libc-2.17.so)


Right now, I'm busy with few other things so I'm not able to dig further.
But I can look into this next week or so.

Thanks,
Ravi
