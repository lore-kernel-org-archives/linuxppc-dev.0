Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 588DDB6F71
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  4 Jul 2011 23:32:29 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp01.au.ibm.com (8.14.4/8.13.1) with ESMTP id p64DS6CV001225
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2011 23:28:06 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p64DVC65864352
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2011 23:31:12 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p64DWRME016048
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2011 23:32:28 +1000
Date: Mon, 4 Jul 2011 19:02:23 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 4/6] hw_breakpoints: Breakpoints arch ability don't need
	perf events
Message-ID: <20110704133223.GB2963@in.ibm.com>
References: <1306273947-8410-1-git-send-email-fweisbec@gmail.com>
	<1306273947-8410-5-git-send-email-fweisbec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306273947-8410-5-git-send-email-fweisbec@gmail.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Will Deacon <will.deacon@arm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Paul Mundt <lethal@linux-sh.org>, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev@lists.ozlabs.org
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 24, 2011 at 11:52:25PM +0200, Frederic Weisbecker wrote:
> The breakpoint support ability in an arch is not related
> to the fact perf events is built or not. HAVE_HW_BREAKPOINT
> only shows an ability so this dependency makes no sense
> anymore. Archs that select HAVE_HW_BREAKPOINT already
> ensure that perf event is built.
> 
> Remove that dependency.
> 
> Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Prasad <prasad@linux.vnet.ibm.com>
> Cc: Paul Mundt <lethal@linux-sh.org>
> ---
>  arch/Kconfig |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index f78c2be..ce4be89 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -149,7 +149,6 @@ config HAVE_DEFAULT_NO_SPIN_MUTEXES
> 
>  config HAVE_HW_BREAKPOINT
>  	bool
> -	depends on PERF_EVENTS
> 
>  config HAVE_MIXED_BREAKPOINTS_REGS
>  	bool
> -- 

Just a thought you might want to consider...

The need to keep the ability (HAVE_HW_BREAKPOINT) and the user-choice to
enable hardware breakpoints (through HW_BREAKPOINT) in separate config
options isn't very clear to me (and is a bit confusing with very similar
names).

Why not make HAVE_HW_BREAKPOINT selectable by the user (which in turn
would turn on PERF_EVENTS) for a given architecture?

Thanks,
K.Prasad
