Return-Path: <rashmica.g@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gGBk20K7zF18f
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 11:37:13 +1000 (AEST)
Received: by mail-pl0-x243.google.com with SMTP id j8-v6so7967538pll.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 18:37:13 -0700 (PDT)
Sender: Rashmica Gupta <rashmicy@gmail.com>
Subject: Re: Infinite looping observed in __offline_pages
To: John Allen <jallen@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: mhocko@suse.cz, n-horiguchi@ah.jp.nec.com,
 kamezawa.hiroyu@jp.fujitsu.com, mgorman@suse.de
References: <20180725181115.hmlyd3tmnu3mn3sf@p50.austin.ibm.com>
From: Rashmica <rashmica.g@gmail.com>
Message-ID: <b79a4cc4-34d4-a9ca-4d17-367be7d7cc1d@gmail.com>
Date: Wed, 1 Aug 2018 11:37:05 +1000
MIME-Version: 1.0
In-Reply-To: <20180725181115.hmlyd3tmnu3mn3sf@p50.austin.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 26/07/18 04:11, John Allen wrote:
> Hi All,
>
> Under heavy stress and constant memory hot add/remove, I have observed
> the following loop to occasionally loop infinitely:
>
> mm/memory_hotplug.c:__offline_pages
>
> repeat:
>        /* start memory hot removal */
>        ret = -EINTR;
>        if (signal_pending(current))
>                goto failed_removal;
>
>        cond_resched();
>        lru_add_drain_all();
>        drain_all_pages(zone);
>
>        pfn = scan_movable_pages(start_pfn, end_pfn);
>        if (pfn) { /* We have movable pages */
>                ret = do_migrate_range(pfn, end_pfn);
>                goto repeat;
>        }
>

What is CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE set to for you?

I have also observed this when hot removing and adding memory. However I
only have only seen this when my kernel has
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=n (when it is set to online
automatically I do not have this issue) so I assumed that I wasn't
onlining the memory properly...

> What appears to be happening in this case is that do_migrate_range
> returns a failure code which is being ignored. The failure is stemming
> from migrate_pages returning "1" which I'm guessing is the result of
> us hitting the following case:
>
> mm/migrate.c: migrate_pages
>
>     default:
>         /*
>          * Permanent failure (-EBUSY, -ENOSYS, etc.):
>          * unlike -EAGAIN case, the failed page is
>          * removed from migration page list and not
>          * retried in the next outer loop.
>          */
>         nr_failed++;
>         break;
>     }
>
> Does a failure in do_migrate_range indicate that the range is
> unmigratable and the loop in __offline_pages should terminate and goto
> failed_removal? Or should we allow a certain number of retrys before we
> give up on migrating the range?
>
> This issue was observed on a ppc64le lpar on a 4.18-rc6 kernel.
>
> -John
>
