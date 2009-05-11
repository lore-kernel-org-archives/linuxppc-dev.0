Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 63E58DDD0C
	for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2009 16:56:11 +1000 (EST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 02/12] fs_enet: Add MPC5121 FEC support.
Date: Mon, 11 May 2009 08:56:58 +0200
References: <20090506224134.83F1583420E8@gemini.denx.de>
	<4b73d43f0905071902y3b51d36ct2a04c560b5acdfb9@mail.gmail.com>
	<20090508.005251.14244652.davem@davemloft.net>
In-Reply-To: <20090508.005251.14244652.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200905110856.59043.david.jander@protonic.nl>
Cc: David Miller <davem@davemloft.net>, wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 08 May 2009 09:52:51 David Miller wrote:
> From: John Rigby <jcrigby@gmail.com>
> Date: Thu, 7 May 2009 20:02:53 -0600
>
> > Also don't forget that the register map is the same on 512x, mx and
> > coldfire platforms but not on the other ppc platforms so if you want
> > to one binary to rule them all you will need to have an offest table
> > or some such.
>
> I would suggest using ->read_reg() ->write_reg() methods for abstracting
> this.  That's how we handle all of the different way ESP scsi chips
> have their registers wired up.
>
> I/O register reads take hundreds, if not thousands of CPU cycles so,
> relatively speaking, the indirection costs absolutely nothing.

I fear the memory-mapped I/O of the PowerPC SoC is *slightly* faster, so in 
terms of cycle count, this WILL matter, although depending on how much 
register-I/O the driver does, overall performance impact _may_ still be 
negligible. I suggest testing this (benchmarks) before and after the change.

Best regsards,

-- 
David Jander
Protonic Holland.
