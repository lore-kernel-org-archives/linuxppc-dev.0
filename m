Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B16E1140087
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 May 2014 18:38:15 +1000 (EST)
Message-ID: <1399797477.17624.40.camel@pasglop>
Subject: Re: [PATCH] powerpc: irq work racing with timer interrupt can
 result in timer interrupt hang
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Sun, 11 May 2014 18:37:57 +1000
In-Reply-To: <536F3192.2050004@linux.vnet.ibm.com>
References: <20140509174712.55fe72d0@kryten>
 <536CA561.8010803@linux.vnet.ibm.com> <1399695993.4481.47.camel@pasglop>
 <536E477F.2070009@linux.vnet.ibm.com> <1399760754.17624.21.camel@pasglop>
 <536F3192.2050004@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulmck@linux.vnet.ibm.com, paulus@samba.org,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2014-05-11 at 13:45 +0530, Preeti U Murthy wrote:
>  +       /* Don't adjust the decrementer if some irq work is pending
> */
>  +       if (!test_irq_work_pending())
>  +               set_dec(evt);
>  +       else
>  +               set_dec(1);
> 
>                   ^^^^^ your patch currently does not have this
> explicit
> set_dec(1) here. Will that create a problem? 
>
> If there is any irq work pending at this point, will someone set the
> decrementer to fire immediately after this point? The current code in
> decrementer_set_next_event() sets set_dec(1) explicitly in case of
> pending irq work.

Hrm, actually this is an interesting point. The problem isn't that
*someone* will do a set_dec, nobody else should that matters.

The problem is that irq_work can be triggered typically by NMIs or
similar, which means that it might be queued between the
test_irq_work_pending() and the set_dec(), thus causing a race.

So basically Anton's original patch is fine :-) I had missed that
we did a post-set_dec() test already in decrementer_next_event()
so as far as I can tell, removing the pre-test, which is what Anton
does, is really all we need.

Cheers,
Ben.
