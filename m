Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0114.outbound.protection.outlook.com [207.46.100.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BBF7D1A03D6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 09:48:14 +1000 (AEST)
Message-ID: <1428623281.22867.558.camel@freescale.com>
Subject: Re: [PATCH 2/2] powerpc: Add ppc64 hard lockup detector support
From: Scott Wood <scottwood@freescale.com>
To: Anton Blanchard <anton@samba.org>
Date: Thu, 9 Apr 2015 18:48:01 -0500
In-Reply-To: <1428547976-24890-2-git-send-email-anton@samba.org>
References: <1428547976-24890-1-git-send-email-anton@samba.org>
 <1428547976-24890-2-git-send-email-anton@samba.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: rric@kernel.org, oprofile-list@lists.sf.net, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-04-09 at 12:52 +1000, Anton Blanchard wrote:
> The hard lockup detector uses a PMU event as a periodic NMI to
> detect if we are stuck (where stuck means no timer interrupts have
> occurred).
> 
> Ben's rework of the ppc64 soft disable code has made ppc64 PMU
> exceptions a partial NMI. They can get disabled if an external
> interrupt comes in, but otherwise PMU interrupts will fire in
> interrupt disabled regions.
> 
> We disable the hard lockup detector by default for a few reasons:
> 
> - It breaks userspace event based branches on POWER8.
> - It is likely to produce false positives on KVM guests.

What causes the false positives with KVM?  I'm wondering if it makes
sense to enable this by default for book3e.

> - Since PMCs can only count to 2^31, counting cycles means we might
>   take multiple PMU exceptions per second per hardware thread even
>   if our hard lockup timeout is 10 seconds.

It'd be nice if this could be used with some event other than
PERF_COUNT_HW_CPU_CYCLES, such as something based on the timebase -- or
using the actual watchdog on book3e which would not consume a perf
counter and would be a full NMI as long as MSR[CE] is left on.

-Scott
