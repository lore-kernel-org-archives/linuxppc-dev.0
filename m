Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41vnBL4g0JzF0pD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 20:35:22 +1000 (AEST)
In-Reply-To: <20180817065500.16899-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: muriloo@linux.ibm.com
Subject: Re: powerpc/traps: Avoid rate limit messages from show unhandled
 signals
Message-Id: <41vnBL2ZpGz9s7c@ozlabs.org>
Date: Tue, 21 Aug 2018 20:35:22 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-08-17 at 06:55:00 UTC, Michael Ellerman wrote:
> In the recent commit to add an explicit ratelimit state when showing
> unhandled signals, commit 35a52a10c3ac ("powerpc/traps: Use an
> explicit ratelimit state for show_signal_msg()"), I put the check of
> show_unhandled_signals and the ratelimit state before the call to
> unhandled_signal() so as to avoid unnecessarily calling the latter
> when show_unhandled_signals is false.
> 
> However that causes us to check the ratelimit state on every call, so
> if we take a lot of *handled* signals that has the effect of making
> the ratelimit code print warnings that callbacks have been suppressed
> when they haven't.
> 
> So rearrange the code so that we check show_unhandled_signals first,
> then call unhandled_signal() and finally check the ratelimit state.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/997dd26cb3c8b7c9b8765751cc1491

cheers
