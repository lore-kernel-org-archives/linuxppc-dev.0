Return-Path: <mingo@elte.hu>
Received: from fallback.mail.elte.hu (fallback.mail.elte.hu [157.181.151.13])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CC9B61007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  6 May 2011 16:14:23 +1000 (EST)
Received: from mx3.mail.elte.hu ([157.181.1.138])
	by fallback.mail.elte.hu with esmtp (Exim) id 1QIEIr-0007ui-Pz
	from <mingo@elte.hu>
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 May 2011 08:14:17 +0200
Date: Fri, 6 May 2011 08:13:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Frederic Weisbecker <fweisbec@gmail.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc, hw_breakpoints: Fix CONFIG_HAVE_HW_BREAKPOINT
	off-case in ptrace_set_debugreg
Message-ID: <20110506061353.GA21742@elte.hu>
References: <1304639598-4707-1-git-send-email-fweisbec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1304639598-4707-1-git-send-email-fweisbec@gmail.com>
Cc: Prasad <prasad@linux.vnet.ibm.com>, LPPC <linuxppc-dev@lists.ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>, "v2.6.33.." <stable@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Frederic Weisbecker <fweisbec@gmail.com> wrote:

> We make use of ptrace_get_breakpoints() / ptrace_put_breakpoints()
> to protect ptrace_set_debugreg() even if CONFIG_HAVE_HW_BREAKPOINT
> if off. However in this case, these APIs are not implemented.
> 
> To fix this, push the protection down inside the relevant ifdef.
> Best would be to export the code inside CONFIG_HAVE_HW_BREAKPOINT
> into a standalone function to cleanup the ifdefury there and call
> the breakpoint ref API inside. But as it is more invasive, this
> should be rather made in an -rc1.
> 
> Fixes:
> 
> arch/powerpc/kernel/ptrace.c:1594: error: implicit declaration of function 'ptrace_get_breakpoints'
> make[2]: *** [arch/powerpc/kernel/ptrace.o] Error 1
> make[1]: *** [arch/powerpc/kernel] Error 2
> make: *** [sub-make] Error 2

Thanks.

I'll need a PowerPC ack for this. Note: it's dependent on hw-breakpoint fixes 
in tip:perf/urgent so the commit will want to go there too.

Thanks,

	Ingo
