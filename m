Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wmWdS3lzczDqL2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 21:58:51 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5CBwkgm047081
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 07:58:49 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b19bdnbep-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 07:58:49 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Mon, 12 Jun 2017 07:58:48 -0400
Subject: Re: [PATCH v2] perf: libdw support for powerpc [ping]
To: Paolo Bonzini <pbonzini@redhat.com>
References: <1496312681-20133-1-git-send-email-pbonzini@redhat.com>
 <a44cf3bd-e868-a8d5-4518-2bea76be7f8f@redhat.com>
Cc: linux-kernel@vger.kernel.org, acme@kernel.org,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, mark@klomp.org
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Mon, 12 Jun 2017 17:28:37 +0530
MIME-Version: 1.0
In-Reply-To: <a44cf3bd-e868-a8d5-4518-2bea76be7f8f@redhat.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <593E81ED.8060606@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Paolo,

Thanks for the patch and really sorry for being late. I was quite busy
with few other things.

On Friday 09 June 2017 06:00 PM, Paolo Bonzini wrote:
>
> On 01/06/2017 12:24, Paolo Bonzini wrote:
>> Porting PPC to libdw only needs an architecture-specific hook to move
>> the register state from perf to libdw.
>>
>> The ARM and x86 architectures already use libdw, and it is useful to
>> have as much common code for the unwinder as possible.  Mark Wielaard
>> has contributed a frame-based unwinder to libdw, so that unwinding works
>> even for binaries that do not have CFI information.  In addition,
>> libunwind is always preferred to libdw by the build machinery so this
>> cannot introduce regressions on machines that have both libunwind and
>> libdw installed.
>>
>> Cc: acme@kernel.org
>> Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>> 	v1->v2: fix for 4.11->4.12 changes
> Ravi, Naveen, any reviews?

So, I tested this patch along with Mark's patch[1] on elfutils an looks
like it's not working. Steps on what I did:

After applying Mark's patch on upstream elfutils:

  $ aclocal
  $ autoheader
  $ autoconf
  $ automake --add-missing
  $ ./configure
  $ make
  $ make install DESTDIR=/home/ravi/elfutils-git

After applying your patch on upstream perf:

  $ make
  $ ./perf record --call-graph=dwarf ls
  $ LD_LIBRARY_PATH=/home/ravi/elfutils-git/usr/local/lib:\
    /home/ravi/elfutils-git/usr/local/lib/elfutils/:$LD_LIBRARY_PATH \
    ./perf script

    ls 44159  1800.878468:     191408 cycles:u:

    ls 44159  1800.878673:     419356 cycles:u:
                       8a97c hpte_need_flush (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                       835f4 flush_hash_page (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                       8acec hpte_need_flush (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                      3468f4 ptep_clear_flush (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                      328b10 wp_page_copy (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                      32ebe4 do_wp_page (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                      33434c __handle_mm_fault (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                      335040 handle_mm_fault (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                       7bf94 do_page_fault (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                       1a4f8 handle_page_fault (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)

    ls 44159  1800.878961:     430876 cycles:u:

    ls 44159  1800.879195:     423785 cycles:u:

    ls 44159  1800.879360:     427359 cycles:u:

Here I don't see userspace callchain getting unwound. Please let me know
if I'm doing anything wrong. Same perf.data with libunwind:

    ls 44159  1800.878468:     191408 cycles:u:
                       20380 _dl_sysdep_start (/usr/lib64/ld-2.17.so)
                        1c7f _dl_start_final (/usr/lib64/ld-2.17.so)
                        5ce7 _dl_start (/usr/lib64/ld-2.17.so)
                        1937 _start (/usr/lib64/ld-2.17.so)

    ls 44159  1800.878673:     419356 cycles:u:
                       8a97c hpte_need_flush (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                       835f4 flush_hash_page (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                       8acec hpte_need_flush (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                      3468f4 ptep_clear_flush (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                      328b10 wp_page_copy (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                      32ebe4 do_wp_page (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                      33434c __handle_mm_fault (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                      335040 handle_mm_fault (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                       7bf94 do_page_fault (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                       1a4f8 handle_page_fault (/usr/lib/debug/lib/modules/4.11.0-3.el7.ppc64le/vmlinux)
                        7cd4 _dl_map_object_from_fd (/usr/lib64/ld-2.17.so)
                        b24b _dl_map_object (/usr/lib64/ld-2.17.so)
                       12b3b openaux (/usr/lib64/ld-2.17.so)
                       159bf _dl_catch_error (/usr/lib64/ld-2.17.so)
                       13323 _dl_map_object_deps (/usr/lib64/ld-2.17.so)
                        3feb dl_main (/usr/lib64/ld-2.17.so)
                       2045b _dl_sysdep_start (/usr/lib64/ld-2.17.so)
                        1c7f _dl_start_final (/usr/lib64/ld-2.17.so)
                        5ce7 _dl_start (/usr/lib64/ld-2.17.so)
                        1937 _start (/usr/lib64/ld-2.17.so)

    ls 44159  1800.878961:     430876 cycles:u:
                        dcb8 check_match.10245 (/usr/lib64/ld-2.17.so)
                        e55b do_lookup_x (/usr/lib64/ld-2.17.so)
                        e8d7 _dl_lookup_symbol_x (/usr/lib64/ld-2.17.so)
                       10493 _dl_relocate_object (/usr/lib64/ld-2.17.so)
                        4cf7 dl_main (/usr/lib64/ld-2.17.so)
                       2045b _dl_sysdep_start (/usr/lib64/ld-2.17.so)
                        1c7f _dl_start_final (/usr/lib64/ld-2.17.so)
                        5ce7 _dl_start (/usr/lib64/ld-2.17.so)
                        1937 _start (/usr/lib64/ld-2.17.so)

    ls 44159  1800.879195:     423785 cycles:u:
                       960a0 malloc (/usr/lib64/libc-2.17.so)
                       32a53 _nl_intern_locale_data (/usr/lib64/libc-2.17.so)
                       3337f _nl_load_locale_from_archive (/usr/lib64/libc-2.17.so)
                       323b3 _nl_find_locale (/usr/lib64/libc-2.17.so)
                       31b93 setlocale (/usr/lib64/libc-2.17.so)
                        2a8b _init (/usr/bin/ls)
                       2497f generic_start_main.isra.0 (/usr/lib64/libc-2.17.so)
                       24b73 __libc_start_main (/usr/lib64/libc-2.17.so)

    ls 44159  1800.879360:     427359 cycles:u:
                       a42b8 get_next_seq (/usr/lib64/libc-2.17.so)
                       a54ff __strcoll_l (/usr/lib64/libc-2.17.so)


[1] https://sourceware.org/ml/elfutils-devel/2017-q2/msg00223.html
