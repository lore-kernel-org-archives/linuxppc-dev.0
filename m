Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41hk3h4KnFzF12N
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2018 20:36:16 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <leitao@debian.org>,
 Gustavo Romero <gromero@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/selftests: Avoid backgroud process/threads
In-Reply-To: <1533046208-8757-1-git-send-email-leitao@debian.org>
References: <1533046208-8757-1-git-send-email-leitao@debian.org>
Date: Fri, 03 Aug 2018 20:36:15 +1000
Message-ID: <87bmajhh40.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Breno Leitao <leitao@debian.org> writes:

> Current tm-unavailable test runs for a long period (>120 seconds), and if it is
> interrupted, as pressing CRTL-C (SIGINT), the foreground process (harness) dies
> but the child process and threads continue to execute (with PPID = 1 now).
>
> In this case, you'd think the test is gone, but there are two threads being
> executed in background, one of the thread ('pong') consumes 100% of the CPU and
> the other one ('ping') dumps output message, from time to time, in the STDOUT,
> which is annoying.
>
> This patch simply gets the child process to be SIGTERMed when the parent dies.

Hmm, I think we should fix this in the harness if possible.

In run_test() it does:

	/* Kill anything else in the process group that is still running */
	kill(-pid, SIGTERM);


But that doesn't work if the harness has been killed with Ctrl-C.

I think the harness could have a SIGINT handler that basically does the
above and then exits?

cheers
