Return-Path: <cyrilbur@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yQqWk06TDzDqwS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 09:53:05 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id m18so12928025pgd.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 15:53:04 -0700 (PDT)
Message-ID: <1509403976.9461.1.camel@gmail.com>
Subject: Re: [PATCH v4 00/10] Allow opal-async waiters to get interrupted
From: Cyril Bur <cyrilbur@gmail.com>
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 stewart@linux.vnet.ibm.com, dwmw2@infradead.org,
 computersforpeace@gmail.com,  sjitindarsingh@gmail.com
Date: Tue, 31 Oct 2017 09:52:56 +1100
In-Reply-To: <20171030101537.7c40d29a@bbrezillon>
References: <20171010033302.20854-1-cyrilbur@gmail.com>
 <20171030101537.7c40d29a@bbrezillon>
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

On Mon, 2017-10-30 at 10:15 +0100, Boris Brezillon wrote:
> On Tue, 10 Oct 2017 14:32:52 +1100
> Cyril Bur <cyrilbur@gmail.com> wrote:
> 
> > V4: Rework and rethink.
> > 
> > To recap:
> > Userspace MTD read()s/write()s and erases to powernv_flash become
> > calls into the OPAL firmware which subsequently handles flash access.
> > Because the read()s, write()s or erases can be large (bounded of
> > course my the size of flash) OPAL may take some time to service the
> > request, this causes the powernv_flash driver to sit in a wait_event()
> > for potentially minutes. This causes two problems, firstly, tools
> > appear to hang for the entire time as they cannot be interrupted by
> > signals and secondly, this can trigger hung task warnings. The correct
> > solution is to use wait_event_interruptible() which my rework (as part
> > of this series) of the opal-async infrastructure provides.
> > 
> > The final patch in this series achieves this. It should eliminate both
> > hung tasks and threads locking up.
> > 
> > Included in this series are other simpler fixes for powernv_flash:
> > 
> > Don't always return EIO on error. OPAL does mutual exclusion on the
> > flash and also knows when the service processor takes control of the
> > flash, in both of these cases it will return OPAL_BUSY, translating
> > this to EIO is misleading to userspace.
> > 
> > Handle receiving OPAL_SUCCESS when it expects OPAL_ASYNC_COMPLETION
> > and don't treat it as an error. Unfortunately there are too many drivers
> > out there with the incorrect behaviour so this means OPAL can never
> > return anything but OPAL_ASYNC_COMPLETION, this shouldn't prevent the
> > code from being correct.
> > 
> > Don't return ERESTARTSYS if token acquisition is interrupted as
> > powernv_flash can't be sure it hasn't already performed some work, let
> > userspace deal with the problem.
> > 
> > Change the incorrect use of BUG_ON() to WARN_ON() in powernv_flash.
> > 
> > Not for powernv_flash, a fix from Stewart Smith which fits into this
> > series as it relies on my improvements to the opal-async
> > infrastructure.
> > 
> > V3: export opal_error_code() so that powernv_flash can be built=m
> > 
> > Hello,
> > 
> > Version one of this series ignored that OPAL may continue to use
> > buffers passed to it after Linux kfree()s the buffer. This version
> > addresses this, not in a particularly nice way - future work could
> > make this better. This version also includes a few cleanups and fixups
> > to powernv_flash driver one along the course of this work that I
> > thought I would just send.
> > 
> > The problem we're trying to solve here is that currently all users of
> > the opal-async calls must use wait_event(), this may be undesirable
> > when there is a userspace process behind the request for the opal
> > call, if OPAL takes too long to complete the call then hung task
> > warnings will appear.
> > 
> > In order to solve the problem callers should use
> > wait_event_interruptible(), due to the interruptible nature of this
> > call the opal-async infrastructure needs to track extra state
> > associated with each async token, this is prepared for in patch 6/10.
> > 
> > While I was working on the opal-async infrastructure improvements
> > Stewart fixed another problem and he relies on the corrected behaviour
> > of opal-async so I've sent it here.
> > 
> > Hello MTD folk, traditionally Michael Ellerman takes powernv_flash
> > driver patches through the powerpc tree, as always your feedback is
> > very welcome.
> 
> Just gave my acks on patches 1 to 4 and patch 10 (with minor comments
> on patch 3 and 10). Feel free to take the patches directly through the
> powerpc tree.
> 

Hi Boris, thanks very much for the acks. 

All good points - I'll fix that up in a v2

Thanks again,

Cyril

> > 
> > Thanks,
> > 
> > Cyril
> > 
> > Cyril Bur (9):
> >   mtd: powernv_flash: Use WARN_ON_ONCE() rather than BUG_ON()
> >   mtd: powernv_flash: Don't treat OPAL_SUCCESS as an error
> >   mtd: powernv_flash: Remove pointless goto in driver init
> >   mtd: powernv_flash: Don't return -ERESTARTSYS on interrupted token
> >     acquisition
> >   powerpc/opal: Make __opal_async_{get,release}_token() static
> >   powerpc/opal: Rework the opal-async interface
> >   powerpc/opal: Add opal_async_wait_response_interruptible() to
> >     opal-async
> >   powerpc/powernv: Add OPAL_BUSY to opal_error_code()
> >   mtd: powernv_flash: Use opal_async_wait_response_interruptible()
> > 
> > Stewart Smith (1):
> >   powernv/opal-sensor: remove not needed lock
> > 
> >  arch/powerpc/include/asm/opal.h              |   4 +-
> >  arch/powerpc/platforms/powernv/opal-async.c  | 183 +++++++++++++++++++--------
> >  arch/powerpc/platforms/powernv/opal-sensor.c |  17 +--
> >  arch/powerpc/platforms/powernv/opal.c        |   2 +
> >  drivers/mtd/devices/powernv_flash.c          |  83 +++++++-----
> >  5 files changed, 194 insertions(+), 95 deletions(-)
> > 
> 
> 
