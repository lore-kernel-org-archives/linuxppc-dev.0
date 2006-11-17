Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7868167BF2
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 21:45:25 +1100 (EST)
Date: Fri, 17 Nov 2006 19:45:16 +0900 (JST)
Message-Id: <200611171045.kAHAjHLu020749@toshiba.co.jp>
To: arnd@arndb.de
Subject: Re: [PATCH 2/16] add hypervisor support for SPU
In-Reply-To: <200611160033.18959.arnd@arndb.de> 
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Arnd-san,

> On Wednesday 15 November 2006 19:26, Christoph Hellwig wrote:
> > On Wed, Nov 15, 2006 at 06:28:46PM +0900, Ishizaki Kou wrote:
> > > This patch adds hypervisor support for spu.
> > >
> > > Linux(GuestOS) needs to designate SPE ID number when it uses SPE on Beat,
> > > and must read the number from DT.
> >
> > In addition to the comments from Arnd which I'd like to second, what
> > do you need int_mask_lock for?  It's initialized but never used.
> 
> It's used in patch 14/16 for the hypervisor access. As far as I can
> see, it should be possible to use the existing register lock in it's
> place though. We should hold that lock before calling any of the
> priv1 accessors. In order to verify if this is done right,
> you could add BUG_ON(!spin_is_locked(&spu->register_lock));
> in the beat version of int_mask_{and,or,get,set}.

Should we hold spu->register_lock before calling 
int_mask_{and,or,get,set}, like as accessing registers?

If it's true, we will replace spu->int_mask_lock by spu->register_lock.
So we remove spu->int_mask_lock.  But we found a problem that
spu_irq_class_0_bottom calls int_mask_get without holding
spu->register_lock. We suspect that similar problems may exist.


Thank you,
Kou Ishizaki
Toshiba
