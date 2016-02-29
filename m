Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 59A061A0324
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 10:35:14 +1100 (AEDT)
Message-ID: <1456788914.21548.2.camel@ellerman.id.au>
Subject: Re: selftests/powerpc: Remove -flto from common CFLAGS
From: Michael Ellerman <mpe@ellerman.id.au>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, linuxppc-dev@ozlabs.org
Date: Tue, 01 Mar 2016 10:35:14 +1100
In-Reply-To: <20160301100825.67747147@camb691>
References: <1456727395-27386-1-git-send-email-sjitindarsingh@gmail.com>
 <20160229111013.71B58140779@ozlabs.org> <20160301100825.67747147@camb691>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-03-01 at 10:08 +1100, Cyril Bur wrote:
> On Mon, 29 Feb 2016 22:10:13 +1100 (AEDT)
> Michael Ellerman <mpe@ellerman.id.au> wrote:
> > On Mon, 2016-29-02 at 06:29:55 UTC, Suraj Jitindar Singh wrote:
> > > Both these cases are hard to detect and require manual inspection of
> > > binaries which is unlikely to happen for all tests. Furthermore, LTO
> > > optimisations are not necessary for selftests and correctness is paramount
> > > and as such it is best to disable LTO.
> > >
> > > LTO can be enabled on a per test basis.
> > >
> > > A pseries_le_defconfig kernel on a POWER8 was used to determine that the
> > > same subset of selftests pass and fail with and without -flto in the
> > > common Makefile.
> > >
> > > These tests always fail:
> > > selftests: per_event_excludes [FAIL]
> > > selftests: event_attributes_test [FAIL]
> > > selftests: ebb_vs_cpu_event_test [FAIL]
> > > selftests: cpu_event_vs_ebb_test [FAIL]
> > > selftests: cpu_event_pinned_vs_ebb_test [FAIL]
> >
> > They shouldn't :)
> >
> > Are you running as root? Bare metal or guest?
>
> Interesting. I believe this was run baremetal as root. I'm going to test the
> patch in qemu at root. Is there a list of expected failures in certain
> situations?

Nope.

Most of those require the perf paranoid level to be set, see eg:

  tools/testing/selftests/powerpc/pmu/ebb/cpu_event_vs_ebb_test.c:        SKIP_IF(require_paranoia_below(1));

cheers
