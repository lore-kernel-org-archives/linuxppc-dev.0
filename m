Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 269AF1A0094
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2015 07:55:29 +1100 (AEDT)
Message-ID: <1425070490.4645.86.camel@kernel.crashing.org>
Subject: Re: [PATCH v4 0/3] powerpc: Enable seccomp filter support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Purcareata Bogdan <b43198@freescale.com>
Date: Sat, 28 Feb 2015 07:54:50 +1100
In-Reply-To: <54F01C85.2020602@freescale.com>
References: <1424247413-20753-1-git-send-email-bogdan.purcareata@freescale.com>
 <54F01C85.2020602@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, pmoore@redhat.com, paulus@samba.org,
 Bogdan Purcareata <bogdan.purcareata@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, strosake@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-02-27 at 09:28 +0200, Purcareata Bogdan wrote:
> Ping?

What is the ping for ?

Ben.

> On 18.02.2015 10:16, Bogdan Purcareata wrote:
> > Add the missing pieces in order to enable SECCOMP_FILTER on PowerPC
> > architectures, and enable this support.
> >
> > Testing has been pursued using libseccomp with the latest ppc support patches
> > [1][2], on Freescale platforms for both ppc and ppc64. Support on ppc64le has
> > also been tested, courtesy of Mike Strosaker.
> >
> > [1] https://groups.google.com/forum/#!topic/libseccomp/oz42LfMDsxg
> > [2] https://groups.google.com/forum/#!topic/libseccomp/TQWfCt_nD7c
> >
> > v4:
> > - rebased on top of 3.19
> >
> > v3:
> > - keep setting ENOSYS in syscall entry assembly when syscall tracing is disabled
> >
> > v2:
> > - move setting ENOSYS from syscall entry assembly to do_syscall_trace_enter
> >
> > Bogdan Purcareata (3):
> >    powerpc: Don't force ENOSYS as error on syscall fail
> >    powerpc: Relax secure computing on syscall entry trace
> >    powerpc: Enable HAVE_ARCH_SECCOMP_FILTER
> >
> >   arch/powerpc/Kconfig           | 1 +
> >   arch/powerpc/kernel/entry_32.S | 7 ++++++-
> >   arch/powerpc/kernel/entry_64.S | 5 +++--
> >   arch/powerpc/kernel/ptrace.c   | 8 ++++++--
> >   4 files changed, 16 insertions(+), 5 deletions(-)
> >
