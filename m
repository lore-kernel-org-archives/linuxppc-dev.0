Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7CD9C2C00B7
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Mar 2013 09:40:28 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 28 Mar 2013 16:40:26 -0600
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id CCA3CC90025
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Mar 2013 18:40:23 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2SMeL8R46661830
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Mar 2013 18:40:22 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2SMeL9a017125
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Mar 2013 19:40:21 -0300
Date: Thu, 28 Mar 2013 15:39:53 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Jiri Olsa <jolsa@redhat.com>
Subject: perf test failures on Power
Message-ID: <20130328223952.GA21777@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



The 'perf' tool has some built-in test cases and one of them checks to
see if the symbols in vmlinux match those in /proc/kallsyms.

This test is failing on Power for several reasons. I fixed a couple of
them (described briefly at the end of the mail) and these fixes take
the test further.

One pending failure is because maps in vmlinux differ from kallsyms.

Here is some output:

$ ./perf test -v 1

---
Using /lib/modules/3.8.0-rc4-perf-core+/build/vmlinux for symbols

0xc000000000001800: diff name v: machine_check_fwnmi k: machine_check_pSeries
0xc000000000005780: diff name v: __end_interrupts k: system_call_entry_direct
0xc000000000006800: diff name v: __end_handlers k: .do_hash_page
0xc000000000009300: diff name v: __secondary_start k: copy_to_here
0xc00000000063d7a0: diff name v: __kprobes_text_end k: .vdso_getcpu_init
Maps only in vmlinux:
 c00000000063d804-c000000000642077 0 [kernel].cpuinit.text
 c000000000642078-c00000000064225f 0 [kernel].text.unlikely
 c000000000642260-c0000000007cffff 0 [kernel].meminit.text
 c0000000007d0000-c000000000812043 0 [kernel].init.text
 c000000000812044-d000000000f8ffff 0 [kernel].exit.text
Maps in vmlinux with a different name in kallsyms:
---

Looking a the first pair of differing symbols in kallsyms and vmlinux:

	$ grep c000000000001800 /proc/kallsyms
	c000000000001800 T machine_check_fwnmi
	c000000000001800 t machine_check_pSeries

	$ nm /boot/vmlinux-3.8.0-rc4-perf-core |grep c000000000001800 
	c000000000001800 T machine_check_fwnmi
	c000000000001800 t machine_check_pSeries

Now perf attempts to "fixup" the duplicates (see choose_best_symbol() in
tools/perf/util/symbol.c) and use heuristics to choose one from the pair
and discard the other.

When processing the pair of 'machine_check_fwnmi' and 'machine_check_pSeries'
from kallsyms, it finds that they both have global binding and it chooses
'machine_check_pSeries' based on the string length of the symbol name.

When processing the same pair from vmlinux, it finds that 'machine_check_fwnmi'
has the global binding and chooses that.

Finally, when comparing the vmlinux symbols with kallsyms, this mismatch
is shows up as a failure.

Some questions:
	- Is perf trying to choose one from the pair, so we have only one
	  symbol to use when building a profile or call-graph ?

	- Why do some symbols like 'machine_check_fwnmi' above, appear with
	  global binding in /proc/kallsyms and local binding in vmlinux ?




----
Here are couple of other failures in 'perf test' on Power. I applied some
quick fixes for these to expose the above failures.

1. Look for .__start or _stext.

    On powerpc, multiple symbols match the address of '_stext':

        $ grep c000000000000000 /proc/kallsyms
        c000000000000000 T .__start
        c000000000000000 T _stext
        c000000000000000 T _text

   choose_best_symbol() discards all but .__start() because, ironically, it
   has the least preceding underscores. The vmlinux test case later looks for
   _stext and fails.

   Quick fix, have the test case look for either _stext or .__start.

2. In vmlinux, system call names have '.sys' or '_sys_'. 
   In kallsyms, the names have '.SyS' or '_SyS_'

    0xc000000000067660: diff name v: .sys_sched_get_priority_max k: .SyS_sched_get_priority_max
    0xc000000000067690: diff name v: .sys_sched_get_priority_min k: .SyS_sched_get_priority_min
    0xc0000000000f2650: diff name v: .compat_sys_waitid k: .compat_SyS_waitid
    0xc0000000000f2780: diff name v: .compat_sys_wait4 k: .compat_SyS_wait4

  	Quick fix: treat names as identical if they only differ in upper/lower
	case of the substring 'sys'.

	Curious though why kallsyms and vmlinux differ this way.
