Return-Path: <hughd@google.com>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
 [209.85.210.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D7FC0B6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2012 17:12:41 +1100 (EST)
Received: by dady9 with SMTP id y9so616500dad.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2012 22:12:38 -0800 (PST)
Date: Tue, 31 Jan 2012 22:12:20 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: next BUG: using smp_processor_id() in preemptible
In-Reply-To: <1326603920.26116.18.camel@pasglop>
Message-ID: <alpine.LSU.2.00.1201312208270.1859@eggly.anvils>
References: <alpine.LSU.2.00.1112051539100.3938@sister.anvils>
 <alpine.LSU.2.00.1112220405410.23876@eggly.anvils>
 <1324588672.6632.8.camel@pasglop>
 <alpine.LSU.2.00.1201141419530.1266@eggly.anvils>
 <1326603920.26116.18.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 15 Jan 2012, Benjamin Herrenschmidt wrote:
> On Sat, 2012-01-14 at 14:21 -0800, Hugh Dickins wrote:
> > On Fri, 23 Dec 2011, Benjamin Herrenschmidt wrote:
> > > On Thu, 2011-12-22 at 04:07 -0800, Hugh Dickins wrote:
> > > > On Mon, 5 Dec 2011, Hugh Dickins wrote:
> > > > 
> > > > > 3.2.0-rc3-next-20111202 with CONFIG_DEBUG_PREEMPT=y gives me lots of
> > > > > 
> > > > > Dec  4 20:03:19 thorn kernel: BUG: using smp_processor_id() in preemptible [00000000] code: startpar/1365
> > > > > Dec  4 20:03:19 thorn kernel: caller is .arch_local_irq_restore+0x44/0x90
> > > > > Dec  4 20:03:19 thorn kernel: Call Trace:
> > > > > Dec  4 20:03:19 thorn kernel: [c0000001b45a7c60] [c000000000011fe8] .show_stack+0x6c/0x16c (unreliable)
> > > > > Dec  4 20:03:19 thorn kernel: [c0000001b45a7d10] [c00000000024318c] .debug_smp_processor_id+0xe4/0x11c
> > > > > Dec  4 20:03:19 thorn kernel: [c0000001b45a7da0] [c00000000000e2e8] .arch_local_irq_restore+0x44/0x90
> > > > > Dec  4 20:03:19 thorn kernel: [c0000001b45a7e30] [c000000000005870] .do_hash_page+0x70/0x74
> > > > > Dec  4 20:03:21 thorn kernel: debug_smp_processor_id: 21950 callbacks suppressed
> > > > > 
> > > > > from the u64 *next_tb = &__get_cpu_var(decrementers_next_tb)
> > > > > in decrementer_check_overflow(): I've no idea whether it's safe
> > > > > just to use get_cpu_var then put_cpu_var there instead,
> > > > > but no hurry, I can survive with DEBUG_PREEMPT off.
> > > > 
> > > > Still a problem in 3.2.0-rc6-next-20111222
> > > 
> > > Ah forgot about that, I'll have a look. Thanks for the reminder.
> > 
> > I'm afraid it's now blighting Linus's tree for 3.3.
> 
> Grrr, my memory is a colander... And now am in Ballarat for the week
> with a semi working 3g connection. I'll see what I can do.

Sorry to be such a bore - you can guess what I have to say about 3.3-rc2 :()

Hugh
