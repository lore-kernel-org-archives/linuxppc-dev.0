Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 278BF67A3A
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Nov 2006 01:29:22 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/16] add hypervisor support for SPU
Date: Fri, 17 Nov 2006 15:01:40 +0100
References: <200611171045.kAHAjHLu020749@toshiba.co.jp>
In-Reply-To: <200611171045.kAHAjHLu020749@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611171501.40316.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 17 November 2006 11:45, Ishizaki Kou wrote:
> > It's used in patch 14/16 for the hypervisor access. As far as I can
> > see, it should be possible to use the existing register lock in it's
> > place though. We should hold that lock before calling any of the
> > priv1 accessors. In order to verify if this is done right,
> > you could add BUG_ON(!spin_is_locked(&spu->register_lock));
> > in the beat version of int_mask_{and,or,get,set}.
>
> Should we hold spu->register_lock before calling
> int_mask_{and,or,get,set}, like as accessing registers?

yes

> If it's true, we will replace spu->int_mask_lock by spu->register_lock.
> So we remove spu->int_mask_lock. =A0But we found a problem that
> spu_irq_class_0_bottom calls int_mask_get without holding
> spu->register_lock. We suspect that similar problems may exist.

They should be changed then in the caller.

	Arnd <><
