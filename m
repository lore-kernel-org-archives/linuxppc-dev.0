Return-Path: <B43198@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0128.outbound.protection.outlook.com [65.55.169.128])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D03CD1A006F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 18:28:32 +1100 (AEDT)
Message-ID: <54F01C85.2020602@freescale.com>
Date: Fri, 27 Feb 2015 09:28:05 +0200
From: Purcareata Bogdan <b43198@freescale.com>
MIME-Version: 1.0
To: Bogdan Purcareata <bogdan.purcareata@freescale.com>,
 <benh@kernel.crashing.org>, <paulus@samba.org>,
 <linuxppc-dev@lists.ozlabs.org>, <mpe@ellerman.id.au>
Subject: Re: [PATCH v4 0/3] powerpc: Enable seccomp filter support
References: <1424247413-20753-1-git-send-email-bogdan.purcareata@freescale.com>
In-Reply-To: <1424247413-20753-1-git-send-email-bogdan.purcareata@freescale.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Cc: pmoore@redhat.com, linux-kernel@vger.kernel.org,
 strosake@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ping?

On 18.02.2015 10:16, Bogdan Purcareata wrote:
> Add the missing pieces in order to enable SECCOMP_FILTER on PowerPC
> architectures, and enable this support.
>
> Testing has been pursued using libseccomp with the latest ppc support patches
> [1][2], on Freescale platforms for both ppc and ppc64. Support on ppc64le has
> also been tested, courtesy of Mike Strosaker.
>
> [1] https://groups.google.com/forum/#!topic/libseccomp/oz42LfMDsxg
> [2] https://groups.google.com/forum/#!topic/libseccomp/TQWfCt_nD7c
>
> v4:
> - rebased on top of 3.19
>
> v3:
> - keep setting ENOSYS in syscall entry assembly when syscall tracing is disabled
>
> v2:
> - move setting ENOSYS from syscall entry assembly to do_syscall_trace_enter
>
> Bogdan Purcareata (3):
>    powerpc: Don't force ENOSYS as error on syscall fail
>    powerpc: Relax secure computing on syscall entry trace
>    powerpc: Enable HAVE_ARCH_SECCOMP_FILTER
>
>   arch/powerpc/Kconfig           | 1 +
>   arch/powerpc/kernel/entry_32.S | 7 ++++++-
>   arch/powerpc/kernel/entry_64.S | 5 +++--
>   arch/powerpc/kernel/ptrace.c   | 8 ++++++--
>   4 files changed, 16 insertions(+), 5 deletions(-)
>
