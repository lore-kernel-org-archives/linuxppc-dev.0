Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsmkn5CDyzDq8c
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 11:06:41 +1000 (AEST)
Date: Tue, 20 Jun 2017 22:06:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Mark Wielaard <mark@klomp.org>
Cc: Milian Wolff <milian.wolff@kdab.com>,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] perf: libdw support for powerpc [ping]
Message-ID: <20170621010635.GK13640@kernel.org>
References: <1496312681-20133-1-git-send-email-pbonzini@redhat.com>
 <1497354282.3755.201.camel@klomp.org>
 <59400ADD.4090709@linux.vnet.ibm.com>
 <3621613.kMnvz8Tm3d@milian-kdab2>
 <1497525392.3755.307.camel@klomp.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497525392.3755.307.camel@klomp.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Thu, Jun 15, 2017 at 01:16:32PM +0200, Mark Wielaard escreveu:
> On Thu, 2017-06-15 at 10:46 +0200, Milian Wolff wrote:
> > Just a quick question: Have you guys applied my recent patch:
> > 
> > commit 5ea0416f51cc93436bbe497c62ab49fd9cb245b6
> > Author: Milian Wolff <milian.wolff@kdab.com>
> > Date:   Thu Jun 1 23:00:21 2017 +0200
> > 
> >     perf report: Include partial stacks unwound with libdw
> >     
> >     So far the whole stack was thrown away when any error occurred before
> >     the maximum stack depth was unwound. This is actually a very common
> >     scenario though. The stacks that got unwound so far are still
> >     interesting. This removes a large chunk of differences when comparing
> >     perf script output for libunwind and libdw perf unwinding.
> > 
> > If not, then this could explain the issue you are seeing.
> 
> Thanks! No, I didn't have that patch (*) yet. It makes a huge
> difference. With that, Paolo's patch and the elfutils libdw powerpc64
> fallback unwinder patch, it looks like I get user stack traces for
> everything now on ppc64le.

Can I take that as a Tested-by: you?

- Arnaldo
 
> Cheers,
> 
> Mark
> 
> (*) It just this one-liner, but what a difference that makes:
> 
> --- a/tools/perf/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw.c
> @@ -224,7 +224,7 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
>  
>         err = dwfl_getthread_frames(ui->dwfl, thread->tid, frame_callback, ui);
>  
> -       if (err && !ui->max_stack)
> +       if (err && ui->max_stack != max_stack)
>                 err = 0;
>  
>         /*
