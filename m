Return-Path: <linas@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8598A67B52
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 12:14:46 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBD1EaB9012404
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 20:14:36 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kBD1Ean2196702
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 20:14:36 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kBD1Eaqp027248
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 20:14:36 -0500
Date: Tue, 12 Dec 2006 19:14:35 -0600
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Subject: Re: [PATCH] drivers/net: spidernet driver on Celleb
Message-ID: <20061213011435.GN4329@austin.ibm.com>
References: <200612120525.kBC5PpWC009418@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200612120525.kBC5PpWC009418@toshiba.co.jp>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: netdev@vger.kernel.org, jim@jklewis.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 12, 2006 at 02:25:50PM +0900, Ishizaki Kou wrote:
> 
> Following are the changes.
> -This patch enables auto-negotiation.
> -Loading firmware is done when spidernet_open() is called.
> -And this patch adds other several small changes for Celleb. 
> -This patch is not tested on CellBlade.

I just tested this, and it does not work. Jim Lewis is gone
until the new year. However, as he was leaving, he grumbled something
about how autonegotiation simply won't work on the spider. 
(I didn't think to ask about the details). Perhaps he'll 
look at his email soon?

I've been trying to figure out how to modify the patch to make it 
work anyway, but so far, no success. 

Basically, in genmii_poll_link(), 
  status = phy_read(phy, MII_BMSR);
    status & BMSR_LSTATUS will always be zero.

So I tried ignoring this value, and calling setup_forced()
However, this still doesn't get the thing working.
I am somewhat at a loss to see why right now, since
I don't see what may be causing this.

--linas
