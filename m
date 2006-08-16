Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 7315567B22
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 09:03:16 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/2]: powerpc/cell spidernet bottom half
Date: Thu, 17 Aug 2006 01:03:20 +0200
References: <44E34825.2020105@garzik.org> <200608162324.47235.arnd@arndb.de>
	<20060816225558.GM20551@austin.ibm.com>
In-Reply-To: <20060816225558.GM20551@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608170103.21097.arnd@arndb.de>
Cc: akpm@osdl.org, jeff@garzik.org, netdev@vger.kernel.org, jklewis@us.ibm.com,
	linux-kernel@vger.kernel.org, Jens.Osterkamp@de.ibm.com,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Thursday 17 August 2006 00:55 schrieb Linas Vepstas:
> > it only
> > seems to be hard to make it go fast using any of them.
>
> Last round of measurements seemed linear for packet sizes between
> 60 and 600 bytes, suggesting that the hardware can handle a
> maximum of 120K descriptors/second, independent of packet size.
> I don't know why this is.

Could well be related to latencies when going to the remote
node for descriptor DMAs. Have you tried if the hch's NUMA
patch or using numactl makes a difference here?

> > sounds like the right approach to simplify the code.
>
> Its not a big a driver. 'wc' says its 2.3 loc, which
> is 1/3 or 1/5 the size of tg3.c or the e1000*c files.

Right, I was thinking of removing a lock or another, not
throwing out half of the driver ;-)

	Arnd <><
