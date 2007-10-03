Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 38F13DDE44
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 03:58:00 +1000 (EST)
Date: Wed, 3 Oct 2007 13:02:10 -0500
From: Olof Johansson <olof@lixom.net>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] [9/11] pasemi_mac: clear out old errors on interface open
Message-ID: <20071003180210.GA19319@lixom.net>
References: <20071002212421.GA2282@lixom.net>
	<20071002212739.GJ2282@lixom.net> <4703D568.6000000@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4703D568.6000000@pobox.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 03, 2007 at 01:46:16PM -0400, Jeff Garzik wrote:
> Olof Johansson wrote:
>> pasemi_mac: clear out old errors on interface open
>> Clear out any pending errors when an interface is brought up. Since the 
>> bits
>> are sticky, they might be from interface shutdown time after firmware has
>> used it, etc.
>> Signed-off-by: Olof Johansson <olof@lixom.net>
>
> In general, interface-open should completely reset and initialize the 
> hardware.  does pasemi_mac not do that?

There's no explicit way to reset just one interface besides disabling it
(which we do at close, and re-enable at open). It seems that some of
the error bits are sticky across disable/enable, which is why this was
needed. Also, they're RW1C, so writing 0 doesn't remove them (need to
write 1 to clear).

The only other dependency from firmware at this time is the setting of mac
addresses, something that will be taken care of once we allow override of
them via ethtool, since we'd need to program them from the driver then
no matter what. Right now we assume that firmware has programmed it.


-Olof
