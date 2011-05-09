Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 98387B6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 10 May 2011 10:17:46 +1000 (EST)
Date: Mon, 9 May 2011 16:33:02 -0700
From: Greg KH <greg@kroah.com>
To: Ingo Molnar <mingo@elte.hu>, Frederic Weisbecker <fweisbec@gmail.com>,
	LPPC <linuxppc-dev@lists.ozlabs.org>, Prasad <prasad@linux.vnet.ibm.com>
Subject: Re: [stable] Patch Upstream: hw_breakpoints, powerpc: Fix
	CONFIG_HAVE_HW_BREAKPOINT off-case in ptrace_set_debugreg()
Message-ID: <20110509233302.GA3721@kroah.com>
References: <201105072120.p47LK2IJ016755@hera.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201105072120.p47LK2IJ016755@hera.kernel.org>
Cc: stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, May 07, 2011 at 09:20:02PM +0000, James Bottomley wrote:
> commit: 925f83c085e1bb08435556c5b4844a60de002e31
> From: Frederic Weisbecker <fweisbec@gmail.com>
> Date: Fri, 6 May 2011 01:53:18 +0200
> Subject: [PATCH] hw_breakpoints, powerpc: Fix CONFIG_HAVE_HW_BREAKPOINT
>  off-case in ptrace_set_debugreg()
> 
> We make use of ptrace_get_breakpoints() / ptrace_put_breakpoints() to
> protect ptrace_set_debugreg() even if CONFIG_HAVE_HW_BREAKPOINT if off.
> However in this case, these APIs are not implemented.
> 
> To fix this, push the protection down inside the relevant ifdef.
> Best would be to export the code inside
> CONFIG_HAVE_HW_BREAKPOINT into a standalone function to cleanup
> the ifdefury there and call the breakpoint ref API inside. But
> as it is more invasive, this should be rather made in an -rc1.
> 
> Fixes this build error:
> 
>   arch/powerpc/kernel/ptrace.c:1594: error: implicit declaration of function 'ptrace_get_breakpoints' make[2]: ***
> 
> Reported-by: Ingo Molnar <mingo@elte.hu>
> Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: LPPC <linuxppc-dev@lists.ozlabs.org>
> Cc: Prasad <prasad@linux.vnet.ibm.com>
> Cc: v2.6.33.. <stable@kernel.org>

This patch applied after I tweaked it to the .38-stable tree, but it
doesn't apply at all to 2.6.33-stable.  If someone wants to see it
there, please send a backported patch to stable@kernel.org.
