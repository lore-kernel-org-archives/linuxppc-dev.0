Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A36201A0FE1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 22:10:13 +1100 (AEDT)
In-Reply-To: <1456727395-27386-1-git-send-email-sjitindarsingh@gmail.com>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: Re: selftests/powerpc: Remove -flto from common CFLAGS
Message-Id: <20160229111013.71B58140779@ozlabs.org>
Date: Mon, 29 Feb 2016 22:10:13 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Suraj,

On Mon, 2016-29-02 at 06:29:55 UTC, Suraj Jitindar Singh wrote:
> LTO can cause GCC to inline some functions which have attributes set. The

You should define what LTO is the first time you use it.

> act of inlining the functions can lead to GCC forgetting about the
> attributes which leads to incorrect tests.
> Notable example being: __attribute__((__target__("no-vsx")))

That is probably a GCC bug, but we still need to work around it for now.

> LTO can also interact strangely with custom assembly functions and cause
> tests to intermittently fail.

That's probably Cyril writing bad asm :)

> Both these cases are hard to detect and require manual inspection of
> binaries which is unlikely to happen for all tests. Furthermore, LTO
> optimisations are not necessary for selftests and correctness is paramount
> and as such it is best to disable LTO.
> 
> LTO can be enabled on a per test basis.
> 
> A pseries_le_defconfig kernel on a POWER8 was used to determine that the
> same subset of selftests pass and fail with and without -flto in the
> common Makefile.
> 
> These tests always fail:
> selftests: per_event_excludes [FAIL]
> selftests: event_attributes_test [FAIL]
> selftests: ebb_vs_cpu_event_test [FAIL]
> selftests: cpu_event_vs_ebb_test [FAIL]
> selftests: cpu_event_pinned_vs_ebb_test [FAIL]

They shouldn't :)

Are you running as root? Bare metal or guest?

> selftests: ipc_unmuxed [FAIL]

That one is expected.

cheers
