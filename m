Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 0CE8BDDEFA
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 22:38:51 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Tue, 02 Oct 2007 14:38:49 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <1191279244.6310.32.camel@pasglop>
Message-ID: <20071002123849.242670@gmx.net>
MIME-Version: 1.0
References: <20071001210025.314240@gmx.net> <20071001211120.156280@gmx.net>	
	<d3eb2341d21ed1f9f7e71f097878731f@kernel.crashing.org>
	<1191279244.6310.32.camel@pasglop>
Subject: Re: Problem with OF interrupt parsing code
To: benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Tue, 02 Oct 2007 07:39:47 +1000
> Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> CC: linuxppc-dev@ozlabs.org
> Betreff: Re: Problem with OF interrupt parsing code

> Part of your problem is that interrupt-parent property. You shouldn't
> have such a property in a PCI host bridge. It's not technically illegal,
> but it's triggering the "loop" you've been experiencing.
Okay, I'll remove this one.

> If you want the parsing to fail for PCI devices (to get the fallback to
> config space values), you need to make sure it does fail. 
> 
> Another option is to put an empty interrupt-map in there. That will
> guarantee failure.
> 
> But that's all very ugly. I don't understand why you don't setup a
> proper map either from your bootloader, zImage wrapper or even prom_init
> or platform code.
I know that it's ugly, but the problem is how to distinguish the boards.
The only real difference I know of is the PCI interrupt mapping. The
northbridges chip revision for example is always the same, but CPU type,
amount of memory and PCI devices can appear in all possible combinations.
The firmware doesn't tell me, which board the kernel is runnning on, so I
would like to rely on this fall back here until I get the chance to
update the firmware (which is beyond my control).

Gerhard
-- 
Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen! 
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
