Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AAE7D679F4
	for <linuxppc-dev@ozlabs.org>; Tue, 17 May 2005 06:31:11 +1000 (EST)
In-Reply-To: <4288E10A.9030408@mvista.com>
References: <1116222720.5095.86.camel@gaston>	<7d5cfed0ee1edade8050d2c4da94b3f1@freescale.com>	<c58d28ab50872f95d4c4a751d1768513@embeddededge.com>	<1116255938.5095.133.camel@gaston>	<fe487e7a8a89e65cfefd4f5dd39a982d@embeddededge.com>	<1116261725.5095.139.camel@gaston>
	<4288DFCB.2080208@mvista.com> <4288E10A.9030408@mvista.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2dd506f0a6d4b03e771c0bc9d80735e6@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Mon, 16 May 2005 16:31:01 -0400
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: linuxppc-dev@ozlabs.org, John Reiser <jreiser@BitWagon.com>
Subject: Re: 2GB address space limit on 32-bit PowerPC Macintosh
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 16, 2005, at 2:06 PM, Mark A. Greer wrote:

> Oops...
> /me unintentionally stepped into the middle of a flame war  :)

Just pee on it :-)

> To be clear, "offender" == board that has an io_block_mapping below 
> the 3 GB line.

That is one of the obvious changes. You are likely to find some other 
assumptions
that may need attention.  The problem with io_block_mapping is you just 
can't
remove it, you have to fix up all of the code that is based on the 
assumption these
spaces are mapped.  You are likely to find yourself in a situation 
where you need
access to some board control registers before VM is set up and you can 
call
ioremap().  So, you will find yourself doing some hack in head.S to map 
BAT
registers to get access to this, which is exactly what 
io_block_mapping() does,
only in a way that is obvious :-)

Thanks.


	-- Dan
