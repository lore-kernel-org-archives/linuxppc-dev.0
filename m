Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F03E0DDE17
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Aug 2008 19:56:35 +1000 (EST)
Message-ID: <48B524CC.6020309@pobox.com>
Date: Wed, 27 Aug 2008 05:56:28 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [PATCH] ibm_newemac: Don't call dev_mc_add() before device is
	registered
References: <1219008563.28339.15.camel@pasglop>
In-Reply-To: <1219008563.28339.15.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev <netdev@vger.kernel.org>, Sebastian Siewior <bigeasy@linutronix.de>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> We must not call dev_mc_add() from within our HW configure which happens
> before we initialize and register the netdev. Do it in open() instead.
> 
> Thanks to Sebastian Siewior for tracking it down. 
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> This fixes an uninitialized spinlock warning (and possibly more).
> 
> Please apply.

applied
