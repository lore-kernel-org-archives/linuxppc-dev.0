Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DA771DDE9E
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Nov 2007 12:52:30 +1100 (EST)
Message-ID: <474783D9.2070700@pobox.com>
Date: Fri, 23 Nov 2007 20:52:25 -0500
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] ibm_newemac: Fix possible lockup on close
References: <20071120035134.970DCDDE9E@ozlabs.org>
In-Reply-To: <20071120035134.970DCDDE9E@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> It's a bad idea to call flush_scheduled_work from within a
> netdev->stop because the linkwatch will occasionally take the
> rtnl lock from a workqueue context, and thus that can deadlock.
> 
> This reworks things a bit in that area to avoid the problem.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 

applied #upstream-fixes (2.6.24-rc)
