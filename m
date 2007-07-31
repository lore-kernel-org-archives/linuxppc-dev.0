Return-Path: <ossthema@de.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DE947DDDE4
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 21:03:10 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.8/8.13.8) with ESMTP id l6VB2wnK135882
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 11:02:58 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.4) with
	ESMTP id l6VB2w09979114
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 13:02:58 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l6VB2fIg021735
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 13:02:42 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: Andrew Gallatin <gallatin@myri.com>
Subject: Re: [PATCH 0/4][RFC] lro: Generic Large Receive Offload for TCP
	traffic
Date: Tue, 31 Jul 2007 12:33:29 +0200
References: <200707301724.33865.ossthema@de.ibm.com>
	<46AE4AC9.6060109@myri.com>
In-Reply-To: <46AE4AC9.6060109@myri.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200707311233.31227.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jeff Garzik <jeff@garzik.org>,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>, Stefan Roscher <stefan.roscher@de.ibm.com>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Thanks for finding these bugs! I'll post an updated version soon (2 patches
with no separate Kconfig patches, one LRO and one eHEA patch). See comments below.

Thanks,
Jan-Bernd

On Monday 30 July 2007 22:32, Andrew Gallatin wrote:
> I was working on testing the myri10ge patch, and I ran into a few
> problems.  I've attached a patch to inet_lro.c to fix some of them,
> and a patch to myri10ge.c to show how to use the page based
> interface.  Both patches are signed off by Andrew Gallatin
> <gallatin@myri.com>
> 
> First, the LRO_MAX_PG_HLEN is still a problem.  Minimally sized 60
> byte frames still cause problems in lro_gen_skb due to skb->len
> going negative.  Fixed in the attached patch.  It may be simpler
> to just drop LRO_MAX_PG_HLEN to ETH_ZLEN, but I'm not sure if
> that is enough.  Are there "smart" NICs which might chop off padding
> themselves?

I'd tend to stick to an explicit check as implemented in your patch
for now

> 
> Second, you still need to set skb->ip_summed = CHECKSUM_UNNECESSARY
> when modified packets are flushed, else the stack will see bad
> checksums for packets from CHECKSUM_COMPLETE drivers using the
> skb interface.  Fixed in the attached patch.

I thought about it... As we do update the TCP checksum for aggregated
packets we could add a second ip_summed field in the net_lro_mgr struct 
used for aggregated packets to support HW that does not have any checksum helper
functionality. These drivers could set this ip_summed field to CHECKSUM_NONE, 
and thus leave the checksum check to the stack. I'm not sure if these old devices benefit
a lot from LRO. So what do you think?

> 
> Fourth, I did some traffic sniffing to try to figure out what's going
> on above, and saw tcpdump complain about bad checksums.  Have you tried
> running tcpdump -s 65535 -vvv?  Have you also seen bad checksums?
> I seem to see this for both page- and skb-based versions of the driver.
> 

Hmmm, can't confirm that. For our skb-based version I see
correct checksums for aggregated packets and for the page-based version as well.
I used: (tcpdump -i ethX -s 0 -w dump.bin) in combination with ethereal.
Don't see problems as well with your tcpdump command.
