Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B3E631A02CF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 20:24:47 +1100 (AEDT)
Message-ID: <1455009881.13384.1.camel@ellerman.id.au>
Subject: Re: [PATCH v3 2/2] powerpc: tracing: don't trace hcalls on offline
 CPUs
From: Michael Ellerman <mpe@ellerman.id.au>
To: Steven Rostedt <rostedt@goodmis.org>, Denis Kirjanov
 <kda@linux-powerpc.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Date: Tue, 09 Feb 2016 20:24:41 +1100
In-Reply-To: <20160205093647.79ca2f70@gandalf.local.home>
References: <1450124286-4822-1-git-send-email-kda@linux-powerpc.org>
 <1450124286-4822-2-git-send-email-kda@linux-powerpc.org>
 <1452599615.20985.2.camel@ellerman.id.au>
 <CAOJe8K2iVOy9=Ds09_ePct3xR6qCH0U4XoKW-qP_TNEMe8GAmQ@mail.gmail.com>
 <CAOJe8K2Ahh-y95BmpsP+d2P9ysUsyo5CnhPOXymEJzjFwkR=7Q@mail.gmail.com>
 <20160205093647.79ca2f70@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-02-05 at 09:36 -0500, Steven Rostedt wrote:
> On Fri, 5 Feb 2016 14:20:17 +0300
> Denis Kirjanov <kda@linux-powerpc.org> wrote:
> > > > > Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
> > >
> > > Hi Steven,
> > >
> > > please apply with Michael's acked-by tag.
> >
> > ping
>
> Actually, can you take this through the ppc tree? The
> TRACE_EVENT_FN_COND is already in mainline.
>
> You can add my:
>
> Acked-by: Steven Rostedt <rostedt@goodmis.org>

Thanks, will do.

I tidied up the change log a bit:

    powerpc/pseries: Don't trace hcalls on offline CPUs

    If a cpu is hotplugged while the hcall trace points are active, it's
    possible to hit a warning from RCU due to the trace points calling into
    RCU from an offline cpu, eg:

      RCU used illegally from offline CPU!
      rcu_scheduler_active = 1, debug_locks = 1

    Make the hypervisor tracepoints conditional by using
    TRACE_EVENT_FN_COND.

    Acked-by: Steven Rostedt <rostedt@goodmis.org>
    Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
    Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>


cheers
