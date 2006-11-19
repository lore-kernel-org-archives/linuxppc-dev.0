Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1BCBD67C09
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Nov 2006 07:24:45 +1100 (EST)
Date: Sun, 19 Nov 2006 21:23:48 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
Message-ID: <20061119202348.GA27649@elte.hu>
References: <200611192243.34850.sshtylyov@ru.mvista.com>
	<1163966437.5826.99.camel@localhost.localdomain>
	<20061119200650.GA22949@elte.hu>
	<1163967590.5826.104.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1163967590.5826.104.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, dwalker@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> > dont worry, it's -rt only stuff.
> 
> Still, I'm curious :-) Besides, there have been people talking about 
> having -rt work on ppc64 so ...

ok :)

> What do you need an ack() for on fasteoi ? On all fasteoi controllers 
> I have, ack is implicit by obtaining the vector number and all there 
> is is an eoi...

it's a compatibility hack only. Threaded handlers are a different type 
of flow, but often the fasteoi handler is not changed to the threaded 
handler so i changed it to be a threaded handler too.

threaded handlers need a mask() + an ack(), because that's the correct 
model to map them to kernel threads - threaded handlers can be delayed 
for a long time if something higher-prio is preempting them.

	Ingo
