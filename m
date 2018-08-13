Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ptdC580YzF0Vv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 21:23:11 +1000 (AEST)
In-Reply-To: <1533651339-12816-1-git-send-email-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Breno Leitao <leitao@debian.org>,
 Gustavo Romero <gromero@linux.vnet.ibm.com>
Subject: Re: [v3] selftests/powerpc: Kill child processes on SIGINT
Message-Id: <41ptdC2xJvz9sCS@ozlabs.org>
Date: Mon, 13 Aug 2018 21:23:11 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-08-07 at 14:15:39 UTC, Breno Leitao wrote:
> There are some powerpc selftests, as tm/tm-unavailable, that run for a long
> period (>120 seconds), and if it is interrupted, as pressing CRTL-C
> (SIGINT), the foreground process (harness) dies but the child process and
> threads continue to execute (with PPID = 1 now) in background.
> 
> In this case, you'd think the whole test exited, but there are remaining
> threads and processes being executed in background. Sometimes these
> zombies processes are doing annoying things, as consuming the whole CPU or
> dumping things to STDOUT.
> 
> This patch fixes this problem by attaching an empty signal handler to
> SIGINT in the harness process. This handler will interrupt (EINTR) the
> parent process waitpid() call, letting the code to follow through the
> normal flow, which will kill all the processes in the child process group.
> 
> This patch also fixes a typo.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7c27a26e1ed5a7dd709aa19685d2c9

cheers
