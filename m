Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zvKft5cq9zF0V0
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Mar 2018 21:54:30 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mathieu Malaterre <malat@debian.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH 17/21] powerpc: Add missing prototype for
 sys_debug_setcontext
In-Reply-To: <20180225172236.29650-18-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org>
 <20180225172236.29650-18-malat@debian.org>
Date: Sun, 04 Mar 2018 21:54:29 +1100
Message-ID: <87muzoglga.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mathieu Malaterre <malat@debian.org> writes:

> In commit 81e7009ea46c ("powerpc: merge ppc signal.c and ppc64 signal32.c=
")
> the function sys_debug_setcontext was added without a prototype.
>
> Fix compilation warning (treated as error in W=3D1):
>
>   CC      arch/powerpc/kernel/signal_32.o
> arch/powerpc/kernel/signal_32.c:1227:5: error: no previous prototype for =
=E2=80=98sys_debug_setcontext=E2=80=99 [-Werror=3Dmissing-prototypes]
>  int sys_debug_setcontext(struct ucontext __user *ctx,
>      ^~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors

This one should actually be using the SYSCALL_DEFINE syntax, so that it
can be used with CONFIG_FTRACE_SYSCALLS.

See eg. our mmap:

  SYSCALL_DEFINE6(mmap, unsigned long, addr, size_t, len,
  		unsigned long, prot, unsigned long, flags,
  		unsigned long, fd, off_t, offset)
  {
  	return do_mmap2(addr, len, prot, flags, fd, offset, PAGE_SHIFT);
  }


We probably still need this patch, but I'm not entirely sure because the
SYSCALL_DEFINE macro does all sorts of shenanigans.

cheers
