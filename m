Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wW8f223nbzDqGr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 May 2017 03:58:02 +1000 (AEST)
Date: Sun, 21 May 2017 19:57:53 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
cc: Arnd Bergmann <arnd@arndb.de>, Mark Gross <mark.gross@intel.com>,
 Tejun Heo <tj@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/9] timers: provide a "modern" variant of timers
In-Reply-To: <20170518084136.GA5331@lst.de>
Message-ID: <alpine.DEB.2.20.1705211920280.3023@nanos>
References: <20170516114812.10660-1-hch@lst.de>
 <20170516114812.10660-3-hch@lst.de>
 <CAK8P3a106wR4h_muGGF7S7uh5UrH-OcJObMfVgk22P9brP5Bjg@mail.gmail.com>
 <20170518082448.GB3812@lst.de> <20170518084136.GA5331@lst.de>
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

On Thu, 18 May 2017, Christoph Hellwig wrote:
> On Thu, May 18, 2017 at 10:24:48AM +0200, Christoph Hellwig wrote:
> > > b) give the union a name (breaks any reference to timer_list->func in C code):
> > > 
> > >  +       union {
> > >  +               void            (*func)(struct timer_list *timer);
> > >  +               void            (*function)(unsigned long);
> > >  +       } u;
> > 
> > I'll look into that, as it seems a lot safer, and places outside
> > the timer code shouldn't really touch it (although I bet they do,
> > so more fixes for this series..)
> 
> Meh.  All the old init_timer users set function directly, so
> I guess we need to use the other approach.

There is another possibility. Create a coccinelle script which wraps all

      timer.function = f;
      timer->function = f;

assignements into a helper timer_set_function(timer, func) and ask Linus to
run it right before the next -rc. That handles everything in tree and the
few new instances in next can be addressed with patches sent to the
maintainers.

Thanks,

	tglx




      
