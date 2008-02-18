Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 84940DE022
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 07:42:36 +1100 (EST)
Subject: Re: [Patch 0/2] powerpc: avoid userspace poking to legacy ioports
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jean Delvare <khali@linux-fr.org>
In-Reply-To: <20080218211519.2b159ade@hyperion.delvare>
References: <20080213182800.5c6940a8@de.ibm.com>
	<20080213183506.7f3e3145@de.ibm.com> <1202935374.7296.44.camel@pasglop>
	<20080218211519.2b159ade@hyperion.delvare>
Content-Type: text/plain
Date: Tue, 19 Feb 2008 07:42:03 +1100
Message-Id: <1203367323.6740.21.camel@pasglop>
Mime-Version: 1.0
Cc: parabelboi@bopserverein.de, Christian Krafft <krafft@de.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Maybe Christian's patch can be improved to not do the check on these?
> As long as /dev/port exists, it seems reasonable that the kernel should
> behave, no matter what I/O ports are accessed from user-space.

nonsense.

 /dev/mem exists for example, but you are still not supposed to go
bang all over the place in it.

> > I hate that sensors_detect.. or for that matter any other userland code
> > that pokes random ports like that. It should die.
> 
> What do you propose as a replacement?

Dunno, something less scary, like knowing where your sensors are on a
given machine... honestly, it's just scary the risk you guys are taking
by banging random IO ports.

At the very least, that shouldn't be done on non-x86.

> And how is userland code poking at random ports different from kernel
> code poking at random ports? We could move sensors-detect inside the
> kernel (and I have some plan to do that) but I fail to see how this
> would solve this particular problem.

It wouldn't, but at least I could NAK it or make it CONFIG_X86 :-)

Ben.
