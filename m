Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qkh6F1pM0zDq5m
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 19:12:37 +1000 (AEST)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 12 Apr 2016 19:12:35 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 1CD163578052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 19:12:33 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3C9COhd1114506
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 19:12:32 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3C9BxCn012430
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 19:12:00 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Mark Wielaard <mjw@redhat.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Balbir Singh <bsingharora@gmail.com>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: [PATCH v2 0/2] perf probe fixes for ppc64le
Date: Tue, 12 Apr 2016 14:40:48 +0530
Message-Id: <cover.1460451721.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset fixes three issues found with perf probe on ppc64le:
1. 'perf test kallsyms' failure on ppc64le (reported by Michael
Ellerman). This was due to the symbols being fixed up during symbol
table load. This is fixed in patch 2 by delaying symbol fixup until
later.
2. perf probe function offset was being calculated from the local entry
point (LEP), which does not match user expectation when trying to look
at function disassembly output (reported by Ananth N). This is fixed for
kallsyms in patch 1 and for symbol table in patch 2.
3. perf probe failure with kretprobe when using kallsyms. This was
failing as we were specifying an offset. This is fixed in patch 1.

A few examples demonstrating the issues and the fix:

Example for issue (2):
--------------------
    # objdump -d vmlinux | grep -A8 \<_do_fork\>:
    c0000000000b6a00 <_do_fork>:
    c0000000000b6a00:	f7 00 4c 3c 	addis   r2,r12,247
    c0000000000b6a04:	00 86 42 38 	addi    r2,r2,-31232
    c0000000000b6a08:	a6 02 08 7c 	mflr    r0
    c0000000000b6a0c:	d0 ff 41 fb 	std     r26,-48(r1)
    c0000000000b6a10:	26 80 90 7d 	mfocrf  r12,8
    c0000000000b6a14:	d8 ff 61 fb 	std     r27,-40(r1)
    c0000000000b6a18:	e0 ff 81 fb 	std     r28,-32(r1)
    c0000000000b6a1c:	e8 ff a1 fb 	std     r29,-24(r1)
    # perf probe -v _do_fork+4
    probe-definition(0): _do_fork+4 
    symbol:_do_fork file:(null) line:0 offset:4 return:0 lazy:(null)
    0 arguments
    Looking at the vmlinux_path (8 entries long)
    Using /proc/kcore for kernel object code
    Using /proc/kallsyms for symbols
    Opening /sys/kernel/debug/tracing//kprobe_events write=1
    Writing event: p:probe/_do_fork _text+748044
    Added new event:
      probe:_do_fork       (on _do_fork+4)

    You can now use it in all perf tools, such as:

	    perf record -e probe:_do_fork -aR sleep 1

    # printf "%x\n" 748044
    b6a0c
    ^^^^^
This is offset from the LEP. With this, there is also no way to ever
probe between the GEP and the LEP.

With this patchset:
    # perf probe -v _do_fork+4
    probe-definition(0): _do_fork+4 
    symbol:_do_fork file:(null) line:0 offset:4 return:0 lazy:(null)
    0 arguments
    Looking at the vmlinux_path (8 entries long)
    Using /proc/kcore for kernel object code
    Using /proc/kallsyms for symbols
    Opening /sys/kernel/debug/tracing//kprobe_events write=1
    Writing event: p:probe/_do_fork _text+748036
    Added new event:
      probe:_do_fork       (on _do_fork+4)

    You can now use it in all perf tools, such as:

	    perf record -e probe:_do_fork -aR sleep 1

    # perf probe -v _do_fork
    probe-definition(0): _do_fork 
    symbol:_do_fork file:(null) line:0 offset:0 return:0 lazy:(null)
    0 arguments
    Looking at the vmlinux_path (8 entries long)
    Using /proc/kcore for kernel object code
    Using /proc/kallsyms for symbols
    Opening /sys/kernel/debug/tracing//kprobe_events write=1
    Writing event: p:probe/_do_fork _text+748040
    Added new event:
      probe:_do_fork       (on _do_fork)

    You can now use it in all perf tools, such as:

	    perf record -e probe:_do_fork -aR sleep 1

We only offset to the LEP if function entry is specified, otherwise, we
offset from the GEP.

Example for issue (3):
---------------------
Before patch:
    # perf probe -v _do_fork:%return
    probe-definition(0): _do_fork:%return 
    symbol:_do_fork file:(null) line:0 offset:0 return:1 lazy:(null)
    0 arguments
    Looking at the vmlinux_path (8 entries long)
    Using /proc/kcore for kernel object code
    Using /proc/kallsyms for symbols
    Opening /sys/kernel/debug/tracing//kprobe_events write=1
    Writing event: r:probe/_do_fork _do_fork+8
    Failed to write event: Invalid argument
      Error: Failed to add events. Reason: Invalid argument (Code: -22)

After patch:
    # perf probe _do_fork:%return
    Added new event:
      probe:_do_fork       (on _do_fork%return)

    You can now use it in all perf tools, such as:

	    perf record -e probe:_do_fork -aR sleep 1


Concept Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Cc: Mark Wielaard <mjw@redhat.com>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

Naveen N. Rao (2):
  perf tools: Fix kprobe and kretprobe handling with kallsyms on ppc64le
  perf tools: Fix kallsyms perf test on ppc64le

 tools/perf/arch/powerpc/util/sym-handling.c | 43 +++++++++++++++++++++--------
 tools/perf/util/probe-event.c               |  5 ++--
 tools/perf/util/probe-event.h               |  3 +-
 tools/perf/util/symbol-elf.c                |  7 +++--
 tools/perf/util/symbol.h                    |  3 +-
 5 files changed, 43 insertions(+), 18 deletions(-)

-- 
2.7.4
