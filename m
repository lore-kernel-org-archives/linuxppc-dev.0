Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x22e.google.com (mail-pg0-x22e.google.com
 [IPv6:2607:f8b0:400e:c05::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40WxqB3d1wzF24d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2018 22:54:45 +1000 (AEST)
Received: by mail-pg0-x22e.google.com with SMTP id a13so11415543pgu.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2018 05:54:45 -0700 (PDT)
Date: Thu, 26 Apr 2018 22:54:28 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] powerpc: Fix smp_send_stop NMI IPI handling
Message-ID: <20180426225428.4d46fad9@roar.ozlabs.ibm.com>
In-Reply-To: <877eou5kfm.fsf@concordia.ellerman.id.au>
References: <20180425113512.20595-1-npiggin@gmail.com>
 <877eou5kfm.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 26 Apr 2018 20:30:37 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> > The NMI IPI handler for a receiving CPU increments nmi_ipi_busy_count
> > over the handler function call, which causes later smp_send_nmi_ipi()
> > callers to spin until the call is finished.
> >
> > The smp_send_stop function never returns, so the busy count is never
> > decremeted, which can cause the system to hang in some cases. For
> > example panic() will call smp_send_stop early on, then later in the
> > reboot path, pnv_restart will call smp_send_stop again, which hangs.
> >
> > Fix this by adding a special case to the smp_send_stop handler to
> > decrement the busy count, because it will never return.
> >
> > Fixes: 6bed3237624e3 ("powerpc: use NMI IPI for smp_send_stop")
> > Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> > Changes since v1:
> > - Reduce #ifdef spaghetti suggested by mpe  
> 
> Sorry I missed this.
> 
> But then saw it in the patchwork listing, which is why I sent my version
> as v3. Which I also merged. Sorry for the confusion.
> 
> I'm pretty sure my version is equivalent to this, except for the way the
> #ifdefs are arranged.
> 
> The end result of this is nicer than my version, so I'd take a cleanup
> patch to get us to this final state.

That's okay. We end up needing to fix the !NMI case as well, with
"powerpc: Fix deadlock with multiple calls to smp_send_stop", so I
can rediff that and send it up.

Thanks,
Nick
