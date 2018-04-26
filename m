Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Wtcv1PSDzF24d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2018 20:30:39 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] powerpc: Fix smp_send_stop NMI IPI handling
In-Reply-To: <20180425113512.20595-1-npiggin@gmail.com>
References: <20180425113512.20595-1-npiggin@gmail.com>
Date: Thu, 26 Apr 2018 20:30:37 +1000
Message-ID: <877eou5kfm.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:
> The NMI IPI handler for a receiving CPU increments nmi_ipi_busy_count
> over the handler function call, which causes later smp_send_nmi_ipi()
> callers to spin until the call is finished.
>
> The smp_send_stop function never returns, so the busy count is never
> decremeted, which can cause the system to hang in some cases. For
> example panic() will call smp_send_stop early on, then later in the
> reboot path, pnv_restart will call smp_send_stop again, which hangs.
>
> Fix this by adding a special case to the smp_send_stop handler to
> decrement the busy count, because it will never return.
>
> Fixes: 6bed3237624e3 ("powerpc: use NMI IPI for smp_send_stop")
> Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> Changes since v1:
> - Reduce #ifdef spaghetti suggested by mpe

Sorry I missed this.

But then saw it in the patchwork listing, which is why I sent my version
as v3. Which I also merged. Sorry for the confusion.

I'm pretty sure my version is equivalent to this, except for the way the
#ifdefs are arranged.

The end result of this is nicer than my version, so I'd take a cleanup
patch to get us to this final state.

cheers
