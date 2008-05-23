Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B8DDEDE13B
	for <linuxppc-dev@ozlabs.org>; Sat, 24 May 2008 08:48:24 +1000 (EST)
Subject: Re: MMIO and gcc re-ordering (Was: [PATCH] [POWERPC]
	Improve	(in|out)_beXX() asm code)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <4837339F.9060407@freescale.com>
References: <4833524C.3040207@freescale.com>
	<20080520.153947.84346222.davem@davemloft.net>
	<4833542E.3040608@freescale.com>
	<20080520.155326.195407196.davem@davemloft.net>
	<1211516683.8297.271.camel@pasglop>
	<Pine.LNX.4.64.0805221553400.8205@t2.domain.actdsltmp>
	<1211546197.8297.308.camel@pasglop> <1211547016.8297.310.camel@pasglop>
	<4837339F.9060407@freescale.com>
Content-Type: text/plain
Date: Fri, 23 May 2008 18:47:32 -0400
Message-Id: <1211582852.8297.347.camel@pasglop>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
	linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@linux-foundation.org>,
	Trent Piepho <tpiepho@freescale.com>, alan@lxorguk.ukuu.org.uk
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-05-23 at 16:14 -0500, Scott Wood wrote:

> As Trent pointed out, if you change to eieio in the accessors, that'd 
> require drivers to also use mmiowb() before spin_unlock(), which fewer 
> drivers currently do.

No, this is a totally different issue. And we keep track of the need
for a sync in spin_unlock already.

Ben.
