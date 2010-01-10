Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8C344B6EF3
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jan 2010 08:32:36 +1100 (EST)
Subject: Re: PCI-PCI bridge scanning broken on 460EX
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Felix Radensky <felix@embedded-sol.com>
In-Reply-To: <4B4A4307.5050704@embedded-sol.com>
References: <4B388D9D.7010404@embedded-sol.com>
	<1262584539.2173.335.camel@pasglop> <4B41ADF1.1000400@embedded-sol.com>
	<4B49CE8A.7000609@embedded-sol.com> <1263155906.724.2.camel@pasglop>
	<4B4A4307.5050704@embedded-sol.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 11 Jan 2010 08:31:57 +1100
Message-ID: <1263159117.724.15.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	Feng Kan <fkan@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> OK, I'll try writing byte by byte. The funny thing is the u-boot also 
> writes the
> same value to PCI_PRIMARY_BUS register and it doesn't cause reset.

Maybe the bridge doesn't want to be programmed more than once on these
registers ? In any case, that's very very fishy.... I wonder if the
bridge is causing a PCI reset -upstream- (which would really be a weird
thing to do) and the 460 is turning that into a system reset ? Check if
there are ways to control how the 460 reacts to PCI resets...

In any case, it looks like a fucked up bridge to me. I don't suppose
you've seen anything in the bridge data sheet or errata sheet that could
explain what it's doing ?

Cheers,
Ben.
