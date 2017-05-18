Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wT45P46PjzDqdW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 May 2017 18:26:01 +1000 (AEST)
Date: Thu, 18 May 2017 10:25:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
 Mark Gross <mark.gross@intel.com>, Tejun Heo <tj@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 9/9] timers: remove old timer initialization macros
Message-ID: <20170518082558.GC3812@lst.de>
References: <20170516114812.10660-1-hch@lst.de>
 <20170516114812.10660-10-hch@lst.de>
 <CAK8P3a0OSuU+0GU9fdwF7ShuctiwZ3L=5zDuD_-HCA=M2_yP-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAK8P3a0OSuU+0GU9fdwF7ShuctiwZ3L=5zDuD_-HCA=M2_yP-g@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 16, 2017 at 09:43:34PM +0200, Arnd Bergmann wrote:
> > - * Don't use the macros below, use DECLARE_TIMER and INIT_TIMER with their
> > + * Don't use the macro below, use DECLARE_TIMER and INIT_TIMER with their
> >   * improved callback signature above.
> >   */
> > -#define __TIMER_INITIALIZER(_function, _expires, _data, _flags) { \
> > +#define DEFINE_TIMER(_name, _function, _expires, _data)                \
> > +       struct timer_list _name = {                             \
> >                 .entry = { .next = TIMER_ENTRY_STATIC },        \
> >                 .function = (_function),                        \
> >                 .expires = (_expires),                          \
> >                 .data = (_data),                                \
> > -               .flags = (_flags),                              \
> >                 __TIMER_LOCKDEP_MAP_INITIALIZER(                \
> >                         __FILE__ ":" __stringify(__LINE__))     \
> >         }
> 
> Not sure what to do about it, but I notice that the '_expires'
> argument is completely
> bogus, I don't see any way it could be used in a meaningful way, and the only
> user that passes anything other than zero is arch/mips/mti-malta/malta-display.c
> and that seems to be unintentional.

DEFINE_TIMER is the old macro and instead of fixing it up I'll just
make sure the new DECLARE_TIMER gets rid of it.
