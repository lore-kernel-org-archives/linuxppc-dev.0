Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0190.outbound.protection.outlook.com [207.46.163.190])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 53BE42C00CA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Mar 2014 09:26:44 +1100 (EST)
Message-ID: <1394835987.12479.119.camel@snotra.buserror.net>
Subject: Re: [PATCH 9/9] powerpc/pm: support deep sleep feature on T1040
From: Scott Wood <scottwood@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
Date: Fri, 14 Mar 2014 17:26:27 -0500
In-Reply-To: <20140313074613.GD26692@pek-khao-d1.corp.ad.wrs.com>
References: <1394168285-32275-1-git-send-email-chenhui.zhao@freescale.com>
 <1394168285-32275-9-git-send-email-chenhui.zhao@freescale.com>
 <1394586624.13761.132.camel@snotra.buserror.net>
 <20140312055755.GA17203@pek-khao-d1.corp.ad.wrs.com>
 <1394646185.13761.145.camel@snotra.buserror.net>
 <20140313074613.GD26692@pek-khao-d1.corp.ad.wrs.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Chenhui Zhao <chenhui.zhao@freescale.com>,
 Jason.Jin@freescale.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-03-13 at 15:46 +0800, Kevin Hao wrote:
> On Wed, Mar 12, 2014 at 12:43:05PM -0500, Scott Wood wrote:
> > > Shouldn't we use "readback, sync" here? The following is quoted form t4240RM:
> > >   To guarantee that the results of any sequence of writes to configuration
> > >   registers are in effect, the final configuration register write should be
> > >   immediately followed by a read of the same register, and that should be
> > >   followed by a SYNC instruction. Then accesses can safely be made to memory
> > >   regions affected by the configuration register write.
> > 
> > I agree that the sync before the readback is probably not necessary,
> > since transactions to the same address should already be ordered.
> > 
> > A sync after the readback helps if you're trying to order the readback
> > with subsequent memory accesses, though in that case wouldn't a sync
> > alone (no readback) be adequate?
> 
> No, we don't just want to order the subsequent memory access here.
> The 'write, readback, sync' is the required sequence if we want to make
> sure that the writing to CCSR register does really take effect.
> 
> >  Though maybe not always -- see the
> > comment near the end of fsl_elbc_write_buf() in
> > drivers/mtd/nand_fsl_elbc.c.  I guess the readback does more than just
> > make sure the device has seen the write, ensuring that the device has
> > finished the transaction to the point of acting on another one.
> 
> Agree.
> 
> > 
> > The data dependency plus isync sequence, which is done by the normal I/O
> > accessors used from C code, orders the readback versus all future
> > instructions (not just I/O).  The delay loop is not I/O.
> 
> According to the PowerISA, the sequence 'load, date dependency, isync' only
> order the load accesses. 

The point is to order the delay loop after the load, not to order
storage versus storage.

This is a sequence we're already using on all of our I/O loads
(excluding accesses like in this patch that don't use the standard
accessors).  I'm confident that it works even if it's not
architecturally guaranteed.  I'm not sure that there exists a clear
architectural way of synchronizing non-storage instructions relative to
storage instructions.

Given that isync is documented as preventing any execution of
instructions after the isync until all previous instructions complete,
it doesn't seem to make sense for the architecture to explicitly talk
about loads (as opposed to any other instruction) following a load,
dependent conditional branch, isync sequence.

> So if we want to order all the storage access as well
> as execution synchronization, we should choose sync here.

Do we need execution synchronization or context synchronization?

The t4240 RM section that talks about a readback and a sync is in the
context of subsequent memory operations ("Then accesses can safely be
made to memory regions affected..."), not arbitrary instructions.  There
are also a couple other places in the RM where isync is recommended
instead (when setting LAWs or CCSRBAR), even though those also only
involve memory accesses.

In any case, this is not performance critical and thus it's better to
oversynchronize than undersynchronize.

-Scott
