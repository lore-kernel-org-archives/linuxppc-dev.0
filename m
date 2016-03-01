Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0903D1A074D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 14:12:06 +1100 (AEDT)
Received: from mail-pf0-x231.google.com (mail-pf0-x231.google.com
 [IPv6:2607:f8b0:400e:c00::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7A019140BA3
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Mar 2016 14:12:05 +1100 (AEDT)
Received: by mail-pf0-x231.google.com with SMTP id 124so42135950pfg.0
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Feb 2016 19:12:05 -0800 (PST)
Date: Tue, 1 Mar 2016 14:11:54 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, linuxppc-dev@ozlabs.org
Subject: Re: selftests/powerpc: Remove -flto from common CFLAGS
Message-ID: <20160301141154.1938845e@camb691>
In-Reply-To: <20160229111013.71B58140779@ozlabs.org>
References: <1456727395-27386-1-git-send-email-sjitindarsingh@gmail.com>
 <20160229111013.71B58140779@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 29 Feb 2016 22:10:13 +1100 (AEDT)
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Hi Suraj,
> 
> On Mon, 2016-29-02 at 06:29:55 UTC, Suraj Jitindar Singh wrote:
> > LTO can cause GCC to inline some functions which have attributes set. The  
> 
> You should define what LTO is the first time you use it.
> 
> > act of inlining the functions can lead to GCC forgetting about the
> > attributes which leads to incorrect tests.
> > Notable example being: __attribute__((__target__("no-vsx")))  
> 
> That is probably a GCC bug, but we still need to work around it for now.
> 
> > LTO can also interact strangely with custom assembly functions and cause
> > tests to intermittently fail.  
> 
> That's probably Cyril writing bad asm :)
> 
> > Both these cases are hard to detect and require manual inspection of
> > binaries which is unlikely to happen for all tests. Furthermore, LTO
> > optimisations are not necessary for selftests and correctness is paramount
> > and as such it is best to disable LTO.
> > 
> > LTO can be enabled on a per test basis.
> > 
> > A pseries_le_defconfig kernel on a POWER8 was used to determine that the
> > same subset of selftests pass and fail with and without -flto in the
> > common Makefile.
> > 
> > These tests always fail:
> > selftests: per_event_excludes [FAIL]
> > selftests: event_attributes_test [FAIL]
> > selftests: ebb_vs_cpu_event_test [FAIL]
> > selftests: cpu_event_vs_ebb_test [FAIL]
> > selftests: cpu_event_pinned_vs_ebb_test [FAIL]  
> 
> They shouldn't :)
> 
> Are you running as root? Bare metal or guest?

The answer here is that /proc/sys/kernel/perf_event_paranoid defaults to 1 but
0 is needed for these tests to not SKIP. The standard harness does not decern
between skips and fails, running each test in powerpc/ shows SKIP/FAIL.

I have run four kernels under QEMU/KVM on a fairly busy VM box and I have the
same result for all 4. All had /proc/sys/kernel/perf_event_paranoid set to 0
before running the tests. Each test was run by it's self not with the
run_kselftest.sh script which hides SKIPs.

pseries_defconfig (BE) qemu/KVM PATCHED
# grep FAIL *.out
cpu_event_pinned_vs_ebb_test.out:[FAIL] Test FAILED on line 87
ipc_unmuxed.out:[FAIL] Test FAILED on line 38
per_event_excludes.out:[FAIL] Test FAILED on line 95

pseries_defconfig (BE) qemu/KVM unpatched
# grep FAIL *.out
cpu_event_pinned_vs_ebb_test.out:[FAIL] Test FAILED on line 87
ipc_unmuxed.out:[FAIL] Test FAILED on line 38
per_event_excludes.out:[FAIL] Test FAILED on line 95

pseries_le_defconfig (LE) qemu/KVM PATCHED
# grep FAIL *.out
cpu_event_pinned_vs_ebb_test.out:[FAIL] Test FAILED on line 87
ipc_unmuxed.out:[FAIL] Test FAILED on line 38
per_event_excludes.out:[FAIL] Test FAILED on line 95

pseries_le_defconfig (LE) qemu/KVM unpatched
# grep FAIL *.out
cpu_event_pinned_vs_ebb_test.out:[FAIL] Test FAILED on line 87
ipc_unmuxed.out:[FAIL] Test FAILED on line 38
per_event_excludes.out:[FAIL] Test FAILED on line 95

There were no matches for grep SKIP *.out for any of the four.

This patch appears to not have affected any of the tests.

Reviewed-by: Cyril Bur <cyrilbur@gmail.com>

> 
> > selftests: ipc_unmuxed [FAIL]  
> 
> That one is expected.
> 
> cheers
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
