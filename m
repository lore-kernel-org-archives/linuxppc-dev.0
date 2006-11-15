Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 8AE4B67C1C
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 10:32:59 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/16] add hypervisor support for SPU
Date: Thu, 16 Nov 2006 00:33:18 +0100
References: <200611150928.kAF9SkJN021123@toshiba.co.jp>
	<20061115182636.GA21633@lst.de>
In-Reply-To: <20061115182636.GA21633@lst.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611160033.18959.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 15 November 2006 19:26, Christoph Hellwig wrote:
> On Wed, Nov 15, 2006 at 06:28:46PM +0900, Ishizaki Kou wrote:
> > This patch adds hypervisor support for spu.
> >
> > Linux(GuestOS) needs to designate SPE ID number when it uses SPE on Beat,
> > and must read the number from DT.
>
> In addition to the comments from Arnd which I'd like to second, what
> do you need int_mask_lock for?  It's initialized but never used.

It's used in patch 14/16 for the hypervisor access. As far as I can
see, it should be possible to use the existing register lock in it's
place though. We should hold that lock before calling any of the
priv1 accessors. In order to verify if this is done right,
you could add BUG_ON(!spin_is_locked(&spu->register_lock));
in the beat version of int_mask_{and,or,get,set}.

	Arnd <><
