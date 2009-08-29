Return-Path: <jamie@shareable.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 19411B70D7
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 29 Aug 2009 11:50:50 +1000 (EST)
Received: from mail2.shareable.org (mail2.shareable.org [80.68.89.115])
	by ozlabs.org (Postfix) with ESMTP id A1F81DDD01
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Aug 2009 11:50:49 +1000 (EST)
Date: Sat, 29 Aug 2009 02:15:17 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Alan Cox <alan@linux.intel.com>
Subject: Re: [Qemu-devel] Re: Extending virtio_console to support multiple
	ports
Message-ID: <20090829011517.GG8036@shareable.org>
References: <1251181044-3696-1-git-send-email-amit.shah@redhat.com>
	<20090826112718.GA11117@amit-x200.redhat.com>
	<20090826154552.GA31910@amit-x200.redhat.com>
	<1251346023.20467.21.camel@pasglop>
	<20090827100809.5f0aa0a7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090827100809.5f0aa0a7@linux.intel.com>
Cc: kvm@vger.kernel.org, borntraeger@de.ibm.com, qemu-devel@nongnu.org,
	miltonm@bga.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, brueckner@linux.vnet.ibm.com,
	Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alan Cox wrote:
> >  - Then, are we certain that there's no case where the tty layer will
> > call us with some lock held or in an atomic context ? To be honest,
> > I've totally lost track of the locking rules in tty land lately so it
> > might well be ok, but something to verify.
> 
> Some of the less well behaved line disciplines do this and always have
> done.

I had a backtrace in my kernel log recently which looked like that,
while doing PPP over Bluetooth RFCOMM.  Resulted in AppArmor
complaining that it's hook was being called in irq context.

-- Jamie
