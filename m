Return-Path: <keescook@google.com>
Received: from mail-io0-x22e.google.com (mail-io0-x22e.google.com
 [IPv6:2607:f8b0:4001:c06::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yRxCb0q4NzDr5J
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Nov 2017 05:12:58 +1100 (AEDT)
Received: by mail-io0-x22e.google.com with SMTP id i38so8024031iod.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Nov 2017 11:12:58 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20171101165309.515688bc@canb.auug.org.au>
References: <20171101165309.515688bc@canb.auug.org.au>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 1 Nov 2017 11:12:55 -0700
Message-ID: <CAGXu5jKOOTsg4mAXRR3hHoeJ-RgvUhid9MQy=H0NL_KruHDbUg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the tip tree with the powerpc tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 31, 2017 at 10:53 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> Today's linux-next merge of the tip tree got a conflict in:
>
>   arch/powerpc/mm/numa.c
>
> between commit:
>
>   cee5405da402 ("powerpc/hotplug: Improve responsiveness of hotplug change")
>
> from the powerpc tree and commit:
>
>   df7e828c1b69 ("timer: Remove init_timer_deferrable() in favor of timer_setup()")
>
> from the tip tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc arch/powerpc/mm/numa.c
> index eb604b3574fa,73016451f330..000000000000
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@@ -1506,9 -1466,7 +1505,7 @@@ static struct timer_list topology_timer
>
>   static void reset_topology_timer(void)
>   {
> -       topology_timer.data = 0;
> -       topology_timer.expires = jiffies + topology_timer_secs * HZ;
> -       mod_timer(&topology_timer, topology_timer.expires);
>  -      mod_timer(&topology_timer, jiffies + 60 * HZ);
> ++      mod_timer(&topology_timer, jiffies + topology_timer_secs * HZ);
>   }
>
>   #ifdef CONFIG_SMP
> @@@ -1561,13 -1520,14 +1558,14 @@@ int start_topology_update(void
>                         rc = of_reconfig_notifier_register(&dt_update_nb);
>   #endif
>                 }
>  -      } else if (firmware_has_feature(FW_FEATURE_VPHN) &&
>  +      }
>  +      if (firmware_has_feature(FW_FEATURE_VPHN) &&
>                    lppaca_shared_proc(get_lppaca())) {
>                 if (!vphn_enabled) {
>  -                      prrn_enabled = 0;
>                         vphn_enabled = 1;
>                         setup_cpu_associativity_change_counters();
> -                       init_timer_deferrable(&topology_timer);
> +                       timer_setup(&topology_timer, topology_timer_fn,
> +                                   TIMER_DEFERRABLE);
>                         reset_topology_timer();
>                 }
>         }

Thanks, this looks correct to me!

-Kees

-- 
Kees Cook
Pixel Security
