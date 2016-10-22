Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t12sf4gyCzDvXl
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Oct 2016 11:07:02 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id 128so9863984pfz.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 17:07:02 -0700 (PDT)
Date: Sat, 22 Oct 2016 11:06:36 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
 linux-kernel@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>,
 linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Heiko Carstens
 <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Noam Camus <noamc@ezchip.com>, virtualization@lists.linux-foundation.org,
 xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org
Subject: Re: [PATCH 2/5] stop_machine: yield CPU during stop machine
Message-ID: <20161022110636.410f20bd@roar.ozlabs.ibm.com>
In-Reply-To: <20161021120536.GC3142@twins.programming.kicks-ass.net>
References: <1477051138-1610-1-git-send-email-borntraeger@de.ibm.com>
 <1477051138-1610-3-git-send-email-borntraeger@de.ibm.com>
 <20161021120536.GC3142@twins.programming.kicks-ass.net>
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

On Fri, 21 Oct 2016 14:05:36 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Oct 21, 2016 at 01:58:55PM +0200, Christian Borntraeger wrote:
> > stop_machine can take a very long time if the hypervisor does
> > overcommitment for guest CPUs. When waiting for "the one", lets
> > give up our CPU by using the new cpu_relax_yield.  
> 
> This seems something that would apply to most other virt stuff. Lets Cc
> a few more lists for that.
> 
> > Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > ---
> >  kernel/stop_machine.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
> > index ec9ab2f..1eb8266 100644
> > --- a/kernel/stop_machine.c
> > +++ b/kernel/stop_machine.c
> > @@ -194,7 +194,7 @@ static int multi_cpu_stop(void *data)
> >  	/* Simple state machine */
> >  	do {
> >  		/* Chill out and ensure we re-read multi_stop_state. */
> > -		cpu_relax();
> > +		cpu_relax_yield();
> >  		if (msdata->state != curstate) {
> >  			curstate = msdata->state;
> >  			switch (curstate) {
> > -- 
> > 2.5.5
> >   

This is the only caller of cpu_relax_yield()?

As a step to removing cpu_yield_lowlatency this series is nice so I
have no objection. But "general" kernel coders still have basically
no chance of using this properly.

I wonder what can be done about that. I've got that spin_do/while
series I'll rebase on top of this, but a spin_yield variant of them
is of no more help to the caller.

What makes this unique? Long latency and not performance critical?
Most places where we spin and maybe yield have been moved to arch
code, but I wonder whether we can make an easier to use architecture
independent API?

Thanks,
Nick
