Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 244ED688C7
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Dec 2005 05:01:29 +1100 (EST)
Date: Thu, 8 Dec 2005 10:01:26 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: "Ruslan V. Sushko" <rsushko@ru.mvista.com>
Message-ID: <20051208180126.GA20921@gate.ebshome.net>
References: <1134045255.28438.4.camel@mephisto.spb.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1134045255.28438.4.camel@mephisto.spb.rtsoft.ru>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Netpoll controller support for PPC EMAC driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Dec 08, 2005 at 03:34:15PM +0300, Ruslan V. Sushko wrote:
> This patch adds netpoll controller support for PPC EMAC driver
> 
> Signed-off-by: Ruslan V. Sushko <rsushko@ru.mvista.com>

NAK. Please see long discussion on netdev couple of months ago about 
netpoll and how it is horribly broken.

In short, to implement netpoll support in EMAC driver requires full 
locking re-do (all locks must be IRQ disabling). I'm not gonna do 
this, because it's wrong approach.

If you want netpoll support, figure out a way to do this correctly, 
without penalizing users of EMAC driver by switching to IRQ locks.

-- 
Eugene
