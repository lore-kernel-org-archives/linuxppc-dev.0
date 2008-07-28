Return-Path: <mingo@elte.hu>
Date: Mon, 28 Jul 2008 16:41:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: CONFIG_FRAME_POINTER [was [PATCH] x86: BUILD_IRQ say .text]
Message-ID: <20080728144133.GH18144@elte.hu>
References: <Pine.LNX.4.64.0807211828470.26173@blonde.site>
	<20080724104459.GI28817@elte.hu>
	<Pine.LNX.4.64.0807251839190.20617@blonde.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0807251839190.20617@blonde.site>
Cc: the arch/x86 maintainers <x86@kernel.org>, linux-kernel@vger.kernel.org,
	Mike Travis <travis@sgi.com>, Linuxppc-dev@ozlabs.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Hugh Dickins <hugh@veritas.com> wrote:

> [PATCH] sched: move sched_clock before first use
> 
> Move sched_clock() up to stop warning: weak declaration of 
> `sched_clock' after first use results in unspecified behavior (if 
> -fno-unit-at-a-time).
> 
> Signed-off-by: Hugh Dickins <hugh@veritas.com>

applied to tip/sched/urgent - thanks Hugh.

> I rather think CONFIG_FRAME_POINTER shouldn't exist at all (or be a 
> private, config-user-invisible, specific-to-a-few-arches thing): what 
> one wants to configure is how far to sacrifice cpu performance and 
> kernel smallness to getting a good stacktrace.  Frame pointer is just 
> an implementation detail on that, appropriate to some arches. Perhaps 
> three settings: no stacktrace, fair stacktrace, best stacktrace.

actually, we consciously use and rely on frame pointers on x86. The 
runtime cost on 64-bit is miniscule and the improved backtrace output in 
recent kernels makes backtraces _much_ easier to interpret:

 Call Trace:
  <NMI>  [<ffffffff80480779>] _raw_spin_trylock+0x19/0x50
  [<ffffffff808fb2e9>] _spin_lock_irqsave+0x59/0x90
  [<ffffffff80261ab4>] atomic_notifier_chain_register+0x24/0x60
  [<ffffffff80262f38>] ? __profile_tick+0x58/0x90
  [<ffffffff808fd1a9>] nmi_watchdog_tick+0x59/0x1e0
  [<ffffffff808fc79a>] default_do_nmi+0x6a/0x220
  [<ffffffff808fc9b4>] do_nmi+0x64/0xb0
  [<ffffffff808fc032>] nmi+0xa2/0xc2
  [<ffffffff80285bd1>] ? stopmachine+0x61/0xd0
  <<EOE>>  [<ffffffff8020dca9>] child_rip+0xa/0x11
  [<ffffffff8020cf3e>] ? restore_args+0x0/0x30
  [<ffffffff80285b70>] ? stopmachine+0x0/0xd0
  [<ffffffff8020dc9f>] ? child_rip+0x0/0x11

we experimented with using dwarf2 data in the past but it proved to be 
very fragile in practice - we depended too much on the whims of 
gcc/binutils being absolutely correct, etc.

Something as fundamental to the kernel's general health as backtraces 
must not be fragile. So the EBP based backtracing code was ported to 
64-bit as well and it was improved further upon.

kudos to Arjan for that.

	Ingo
