Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id DAB07DDE48
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 01:18:38 +1100 (EST)
Date: Thu, 8 Nov 2007 17:16:11 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH 0/5] fixups for mpc8360 rev. 2.1 erratum #2 (RGMII Timing)
Message-ID: <20071108141611.GA5770@localhost.localdomain>
References: <20071105121530.5c38fbb7.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071105121530.5c38fbb7.kim.phillips@freescale.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	Li Yang <leoli@freescale.com>, jgarzik@pobox.com
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 05, 2007 at 12:15:30PM -0600, Kim Phillips wrote:
> Hello all,
> 
> the following patches fix RGMII timing for rev. 2.1 of the mpc8360,
> according to erratum #2 (erratum text included below).  Basically the
> most intrusive part is the addition of two new RGMII Internal Delay
> modes; one for TX delay only, and the other for RX delay only (i.e, not
> both at the same time).
> 
> Please review, and since this affects both netdev and powerpc trees,
> one maintainer should ack them for the other to push upstream (i.e,
> Kumar acks them, and Leo picks them up to go through netdev or the
> other way around; either way is fine with me).  I'm hoping they're
> trivial enough to go in 2.6.24.
> 
> Depending on how the review goes, a follow-on patch to u-boot will be
> sent out that fixes up the phy-connection-type in the device tree (from
> "rgmii-id" to "rgmii-rxid" iff on mpc8360rev2.1).

I've upgraded CPU to rev2.1, board rev0.3.

Applied 5/5 patches onto paulus/powerpc.git at e403149c92a. Here is
the results:

If I use -rxid, then geth not able to transmit anything.
With -txid geth not able to receive anything.

With just -id everything works fine though...


Maybe there should be another condition, in addition to cpu rev2.1?

> Thanks,
> 
> Kim
> 
> mpc8360 rev 2.1 erratum #2:
> -----------
> Recommended AC timings for chip 8360Rev2.1 UCC ETH RGMII  when working
> with Rev Pilot MDS for proper RGMII operation:
> 
> IMMR_BASE + 0x14A8[4:5] = 11 (clk delay for UCC 2)
> IMMR_BASE + 0x14A8[18:19] = 11 (clk delay for UCC 1)
> IMMR_BASE + 0x14AC[20:27] = 10101010 (data delay for both UCC's)
> 
> The Phy (Marvell 88e1111) should be configured NOT to work with RGMII
> delay for TxD.

Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
