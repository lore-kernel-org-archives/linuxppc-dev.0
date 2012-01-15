Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CB449B6F65
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Jan 2012 16:05:28 +1100 (EST)
Message-ID: <1326603920.26116.18.camel@pasglop>
Subject: Re: next BUG: using smp_processor_id() in preemptible
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugh Dickins <hughd@google.com>
Date: Sun, 15 Jan 2012 16:05:20 +1100
In-Reply-To: <alpine.LSU.2.00.1201141419530.1266@eggly.anvils>
References: <alpine.LSU.2.00.1112051539100.3938@sister.anvils>
 <alpine.LSU.2.00.1112220405410.23876@eggly.anvils>
 <1324588672.6632.8.camel@pasglop>
 <alpine.LSU.2.00.1201141419530.1266@eggly.anvils>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2012-01-14 at 14:21 -0800, Hugh Dickins wrote:
> On Fri, 23 Dec 2011, Benjamin Herrenschmidt wrote:
> > On Thu, 2011-12-22 at 04:07 -0800, Hugh Dickins wrote:
> > > On Mon, 5 Dec 2011, Hugh Dickins wrote:
> > > 
> > > > 3.2.0-rc3-next-20111202 with CONFIG_DEBUG_PREEMPT=y gives me lots of
> > > > 
> > > > Dec  4 20:03:19 thorn kernel: BUG: using smp_processor_id() in preemptible [00000000] code: startpar/1365
> > > > Dec  4 20:03:19 thorn kernel: caller is .arch_local_irq_restore+0x44/0x90
> > > > Dec  4 20:03:19 thorn kernel: Call Trace:
> > > > Dec  4 20:03:19 thorn kernel: [c0000001b45a7c60] [c000000000011fe8] .show_stack+0x6c/0x16c (unreliable)
> > > > Dec  4 20:03:19 thorn kernel: [c0000001b45a7d10] [c00000000024318c] .debug_smp_processor_id+0xe4/0x11c
> > > > Dec  4 20:03:19 thorn kernel: [c0000001b45a7da0] [c00000000000e2e8] .arch_local_irq_restore+0x44/0x90
> > > > Dec  4 20:03:19 thorn kernel: [c0000001b45a7e30] [c000000000005870] .do_hash_page+0x70/0x74
> > > > Dec  4 20:03:21 thorn kernel: debug_smp_processor_id: 21950 callbacks suppressed
> > > > 
> > > > from the u64 *next_tb = &__get_cpu_var(decrementers_next_tb)
> > > > in decrementer_check_overflow(): I've no idea whether it's safe
> > > > just to use get_cpu_var then put_cpu_var there instead,
> > > > but no hurry, I can survive with DEBUG_PREEMPT off.
> > > 
> > > Still a problem in 3.2.0-rc6-next-20111222
> > 
> > Ah forgot about that, I'll have a look. Thanks for the reminder.
> 
> I'm afraid it's now blighting Linus's tree for 3.3.

Grrr, my memory is a colander... And now am in Ballarat for the week
with a semi working 3g connection. I'll see what I can do.

Cheers,
Ben.
