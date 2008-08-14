Return-Path: <sebastian@breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9B49BDDF12
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Aug 2008 17:33:36 +1000 (EST)
Date: Thu, 14 Aug 2008 09:33:19 +0200
From: Sebastian Siewior <sebastian@breakpoint.cc>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH / RFC] net: fix locking in ibm_newemac
Message-ID: <20080814073319.GA8716@Chamillionaire.breakpoint.cc>
References: <20080813182957.GA12612@www.tglx.de>
	<1218685554.8041.172.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <1218685554.8041.172.camel@pasglop>
Cc: netdev@vger.kernel.org, Sebastian Siewior <bigeasy@linutronix.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Benjamin Herrenschmidt | 2008-08-14 13:45:54 [+1000]:

>> The fix is to defer phy init until netdevice is registered / initialized.
>
>I think it's better instead to take the dev_mc_add() statement
>out of emac_configure().
I looked yesterday into that code and I saw that dev_mc_add() was called
by the network core itself. Now I'm sure it was definitly too late for
writing patches :)

>What about this patch instead, does it fix it for you ?
yep it does.

Sebastian
