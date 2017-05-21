Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wW7fw0zXXzDqLl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 May 2017 03:13:44 +1000 (AEST)
Date: Sun, 21 May 2017 19:13:27 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
cc: Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Mark Gross <mark.gross@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: RFC: better timer interface
In-Reply-To: <CAK8P3a3_Rjz9gTmayN1w8HrFHWY+wakeFgQSYRTAADJzF6zKJA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1705211859410.3023@nanos>
References: <20170516114812.10660-1-hch@lst.de>
 <CAK8P3a1FoR_usw7du3ZRMF+PPhJ712EpArL_e1bLVNs7BYBu-w@mail.gmail.com>
 <20170516155132.GA1494@lst.de>
 <CAK8P3a3_Rjz9gTmayN1w8HrFHWY+wakeFgQSYRTAADJzF6zKJA@mail.gmail.com>
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

On Tue, 16 May 2017, Arnd Bergmann wrote:
> On Tue, May 16, 2017 at 5:51 PM, Christoph Hellwig <hch@lst.de> wrote:
> > Yes, that sounds useful to me as well.  As you said it's an independent
> > but somewhat related change.  I can add it to my series, but I'll
> > need a suggestions for a good and short name.  That already was the
> > hardest part for the setup side :)
> 
> If we keep the unusual *_timer() naming (rather than timer_*() as hrtimer
> has), we could use one of
> 
> a) start_timer(struct timer_list *timer, unsigned long ms);
> b) restart_timer(struct timer_list *timer, unsigned long ms);
> c) mod_timer_ms(struct timer_list *timer, unsigned long ms);
>     mod_timer_sec(struct timer_list *timer, unsigned long sec);

Please make new functions prefixed with timer_ and get rid of that old
interface completely. It's horrible.
 
timer_init()
timer_start(timer, ms, abs)
timer_start_on(timer, ms, abs, cpu)
timer_cancel(timer, sync)

Is all what's required to make up a new milliseconds based interface.

We really do not need all that mod/restart/ whatever variants. Where is the
point of those?

Thanks,

	tglx
