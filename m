Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 234FD6861F
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Oct 2005 08:47:18 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: maz@misterjones.org
In-Reply-To: <wrpek6eeo94.fsf@wild-wind.fr.eu.org>
References: <wrpll0of535.fsf@wild-wind.fr.eu.org>
	<1129869509.6265.32.camel@gaston> <wrpek6eeo94.fsf@wild-wind.fr.eu.org>
Content-Type: text/plain
Date: Sat, 22 Oct 2005 08:42:08 +1000
Message-Id: <1129934528.7919.15.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: v2.6.13.4 : Bad page state at prep_new_page when booting with
	quik
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2005-10-21 at 20:08 +0200, Marc Zyngier wrote:

> I fear that... But even in such a case ,understanding what confuses
> the kernel would help a lot...
> 
> Thanks for your help,

Hrm... another thing you can do is have a look at the init_bandit()
routine. It does:

	/* read the word at offset 0x50 */
	out_le32(bp->cfg_addr, (1UL << BANDIT_DEVNUM) + BANDIT_MAGIC);
	udelay(2);
	magic = in_le32(bp->cfg_data);

What is the value of "magic" in both cases ?

As for the rest, well, printing out the various addresses where the
kernel is copied and/or decompresses itself may help...

Have you tried also netbooting directly vmlinux.coff ? (boot enet: might
work on OldWorld OF, you'll need a bootp server) That works with some
oldworlds, not all, depends if they have a working ethernet driver in
OF.

Ben.
