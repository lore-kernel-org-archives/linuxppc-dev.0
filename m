Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 19706DDF92
	for <linuxppc-dev@ozlabs.org>; Fri,  8 May 2009 17:53:06 +1000 (EST)
Date: Fri, 08 May 2009 00:52:51 -0700 (PDT)
Message-Id: <20090508.005251.14244652.davem@davemloft.net>
To: jcrigby@gmail.com
Subject: Re: [PATCH 02/12] fs_enet: Add MPC5121 FEC support.
From: David Miller <davem@davemloft.net>
In-Reply-To: <4b73d43f0905071902y3b51d36ct2a04c560b5acdfb9@mail.gmail.com>
References: <20090506224134.83F1583420E8@gemini.denx.de>
	<fa686aa40905070709r7478837fnefb094d46f03ae0e@mail.gmail.com>
	<4b73d43f0905071902y3b51d36ct2a04c560b5acdfb9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, kosmo@semihalf.com, wd@denx.de, dzu@denx.de,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: John Rigby <jcrigby@gmail.com>
Date: Thu, 7 May 2009 20:02:53 -0600

> Also don't forget that the register map is the same on 512x, mx and
> coldfire platforms but not on the other ppc platforms so if you want
> to one binary to rule them all you will need to have an offest table
> or some such.

I would suggest using ->read_reg() ->write_reg() methods for abstracting
this.  That's how we handle all of the different way ESP scsi chips
have their registers wired up.

I/O register reads take hundreds, if not thousands of CPU cycles so,
relatively speaking, the indirection costs absolutely nothing.
