Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A754267C5F
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Nov 2006 07:41:18 +1100 (EST)
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <4560C121.30403@ru.mvista.com>
References: <200611192243.34850.sshtylyov@ru.mvista.com>
	<1163966437.5826.99.camel@localhost.localdomain>
	<20061119200650.GA22949@elte.hu>
	<1163967590.5826.104.camel@localhost.localdomain>
	<4560BDF5.400@ru.mvista.com>
	<1163968376.5826.110.camel@localhost.localdomain>
	<4560C121.30403@ru.mvista.com>
Content-Type: text/plain
Date: Mon, 20 Nov 2006 07:41:25 +1100
Message-Id: <1163968885.5826.116.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org, dwalker@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>     This is not implicit -- CPU has to read INTACK reg. on OpenPIC.

Which is what I meant... "implicit by reading the vector".

> Really implicit method is in action on x86 where CPU issues dual ACK bus cycle to get 
> the vector form 8259...

Which you can do on OpenPIC too. It's the same idea. The concept that
obtaining the vector performs the ack.

> > EOI is a more "high level" thing that some "intelligent" PICs that
> > automatically raise the priority do to restore the priority to what it
> > was before the interrupt occured.
> 
>     Thank you, I know. Even 8259 has the notion of priority and EOI works the 
> same way here.

Ok, so why would you need an ack there then while eoi is just what you
need ? :-)

Also, that's interesting what you are saying about 8259... I should be
able to convert ppc's i8259 to use fasteoi too...

Ben.
