Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E6BE3B7B5F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 19:27:57 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 50D4FDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 19:27:56 +1000 (EST)
Subject: Re: Extending virtio_console to support multiple ports
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@linux.intel.com>
In-Reply-To: <20090827100809.5f0aa0a7@linux.intel.com>
References: <1251181044-3696-1-git-send-email-amit.shah@redhat.com>
	<20090826112718.GA11117@amit-x200.redhat.com>
	<20090826154552.GA31910@amit-x200.redhat.com>
	<1251346023.20467.21.camel@pasglop>
	<20090827100809.5f0aa0a7@linux.intel.com>
Content-Type: text/plain
Date: Thu, 27 Aug 2009 19:27:23 +1000
Message-Id: <1251365243.20467.47.camel@pasglop>
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	miltonm@bga.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com,
	brueckner@linux.vnet.ibm.com, Amit Shah <amit.shah@redhat.com>,
	virtualization@lists.linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-08-27 at 10:08 +0100, Alan Cox wrote:
> >  - Then, are we certain that there's no case where the tty layer will
> > call us with some lock held or in an atomic context ? To be honest,
> > I've totally lost track of the locking rules in tty land lately so it
> > might well be ok, but something to verify.
> 
> Some of the less well behaved line disciplines do this and always have
> done.

That was also my understanding but heh, I though that maybe you may have
fixed all of that already :-)

So at this stage, I think the reasonably thing to do is to stick to the
spinlock, but we can try to make it a bit smarter, and we can definitely
attempt to fix the case Amit pointed out where we call resize without a
lock while it seems to expect it (though we also need to be careful
about re-entrancy I believe).

Cheers,
Ben.
