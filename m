Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 14F01DDF1D
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 08:13:08 +1000 (EST)
Subject: Re: bug: mutex_lock() in interrupt conntext via phy_stop() in gianfar
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nate Case <ncase@xes-inc.com>
In-Reply-To: <1216681028.7559.993.camel@localhost.localdomain>
References: <20080718121008.GA28871@Chamillionaire.breakpoint.cc>
	<1216681028.7559.993.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 24 Jul 2008 08:12:48 +1000
Message-Id: <1216851168.11027.343.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	Li Yang <leoli@freescale.com>, Vitaly Bordug <vbordug@ru.mvista.com>,
	Sebastian Siewior <netdev@ml.breakpoint.cc>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-07-21 at 17:57 -0500, Nate Case wrote:
> On Fri, 2008-07-18 at 14:10 +0200, Sebastian Siewior wrote:
> > Commit 35b5f6b1a aka [PHYLIB: Locking fixes for PHY I/O potentially sleeping]
> > changed the phydev->lock from spinlock into a mutex. Now, the following
> > code path got triggered while NFS was unavailable:
> > 
> [snip]
> > |[  194.864733] BUG: sleeping function called from invalid context at /home/bigeasy/git/linux-2.6-powerpc/kernel/mutex.c:87
> > |[  194.875529] in_atomic():1, irqs_disabled():0
> > |[  194.879805] Call Trace:
> > |[  194.882250] [c0383d90] [c0006dd8] show_stack+0x48/0x184 (unreliable)
> > |[  194.888649] [c0383db0] [c001e938] __might_sleep+0xe0/0xf4
> > |[  194.894069] [c0383dc0] [c025a43c] mutex_lock+0x24/0x3c
> > |[  194.899234] [c0383de0] [c019005c] phy_stop+0x20/0x70
> > |[  194.904234] [c0383df0] [c018d4ec] stop_gfar+0x28/0xf4
> > |[  194.909305] [c0383e10] [c018e8c4] gfar_timeout+0x30/0x60
> > |[  194.914638] [c0383e20] [c01fe7c0] dev_watchdog+0xa8/0x144
> 
> Hmm..  I'm not sure what the best solution is to this.  Make the
> stop_gfar() call happen in a workqueue, and make a similar change to
> ucc_geth, fec_mpc52xx, and fs_enet? Modify phy_stop() to do the work in
> a workqueue conditionally if in interrupt context?  Between these two
> I'd lean toward the latter.
> 
> Does anyone have any better ideas?

Move the reset task to a workqueue.

Cheers,
Ben.
