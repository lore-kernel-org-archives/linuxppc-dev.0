Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7F0A9DDE47
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 09:50:03 +1000 (EST)
In-Reply-To: <1179530872.32247.423.camel@localhost.localdomain>
References: <200705172142.26739.sshtylyov@ru.mvista.com>
	<f9afbdb49bc1f935153305315770bccd@kernel.crashing.org>
	<464CB071.5050504@ru.mvista.com>
	<9095839480a9686d9c40aa6143edb804@kernel.crashing.org>
	<464CB460.40905@ru.mvista.com>
	<97d47c2261fe9cd3f1a6c864278a6ab6@kernel.crashing.org>
	<1179464690.32247.370.camel@localhost.localdomain>
	<1179466769.3658.0.camel@localhost.localdomain>
	<1179472096.32247.394.camel@localhost.localdomain>
	<464DAD06.2060504@ru.mvista.com>
	<1179530872.32247.423.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <51b3a75638604c9dd7ed60a10f0ed934@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2.6.21-rt2] PowerPC: decrementer clockevent driver
Date: Sat, 19 May 2007 01:49:59 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Dave Liu <r63238@freescale.com>, mingo@elte.hu, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I find it extremely silly to implement it as edge anyway. The EE line 
> is
> level triggered, and having a mix of edge and level on the same
> exception without a clean way to retrigger the DEC one other than
> waiting one tick is just causing trouble.

It isn't edge triggered, it just automatically clears the
decrementer exception condition at its source when taken
(on certain implementations -- others leave it to software
to clear it).


Segher
