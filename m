Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x22d.google.com (mail-pf0-x22d.google.com
 [IPv6:2607:f8b0:400e:c00::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40KKxW4hwlzDrbT
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Apr 2018 16:23:27 +1000 (AEST)
Received: by mail-pf0-x22d.google.com with SMTP id l27so5280109pfk.12
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Apr 2018 23:23:27 -0700 (PDT)
Date: Mon, 9 Apr 2018 16:23:14 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 5/6] powerpc/powernv: implement opal_put_chars_nonatomic
Message-ID: <20180409162314.20e486c3@roar.ozlabs.ibm.com>
In-Reply-To: <1523253475.11062.10.camel@kernel.crashing.org>
References: <20180409054056.27292-1-npiggin@gmail.com>
 <20180409054056.27292-6-npiggin@gmail.com>
 <1523253475.11062.10.camel@kernel.crashing.org>
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

On Mon, 09 Apr 2018 15:57:55 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Mon, 2018-04-09 at 15:40 +1000, Nicholas Piggin wrote:
> > The RAW console does not need writes to be atomic, so implement a
> > _nonatomic variant which does not take a spinlock. This API is used
> > in xmon, so the less locking thta's used, the better chance there is
> > that a crash can be debugged.  
> 
> I find the term "nonatomic" confusing...

I guess it is to go with the "atomic" comment for the hvsi console
case -- all characters must get to the console together or not at
all.

> don't we have a problem if we
> start hitting OPAL without a lock where we can't trust
> opal_console_write_buffer_space anymore ? I think we need to handle
> partial writes in that case. Maybe we should return how much was
> written and leave the caller to deal with it.

Yes, the _nonatomic variant doesn't use opal_console_write_buffer_space
and it does handle partial writes by returning written bytes (although
callers generally tend to loop at the moment, we might do something
smarter with them later).

> I was hoping (but that isn't the case) that by nonatomic you actually
> meant calls that could be done in a non-atomic context, where we can do
> msleep instead of mdelay. That would be handy for the console coming
> from the hvc thread (the tty one).

Ah right, no. However we no longer loop until everything is written, so
the hvc console driver (or the console layer) should be able to deal with
that with sleeping. I don't think we need to put it at this level of the
driver, but I don't know much about the console code.

Thanks,
Nick
