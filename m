Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BCBBEDE008
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 11:24:25 +1100 (EST)
In-Reply-To: <20070125104540.65a1f557@localhost>
References: <20061218163846.337fed65@localhost> <45882913.2000609@acm.org>
	<20061220154517.6341fce6@localhost>
	<200612210111.28186.arnd@arndb.de>
	<20070125104540.65a1f557@localhost>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DA5708FC-F9AB-4782-A48D-40B26990A24F@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 1/1] updated version, fixed the compiler warning
Date: Thu, 25 Jan 2007 01:24:01 +0100
To: Christian Krafft <krafft@de.ibm.com>
Cc: Christian@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	openipmi-developer@lists.sourceforge.net,
	Krafft <krafft@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> This patch adds support for of_platform_driver to the ipmi_si module.
> When loading the module, the driver will be registered to of_platform.
> The driver will be probed for all devices with the type ipmi. It's  
> supporting
> devices with compatible settings ipmi-kcs, ipmi-smic and ipmi-bt.
> Only ipmi-kcs could be tested.

I'm still saying that because of this, and because they might
never be used and as such be unnecessary baggage, you shouldn't
add SMIC and BT support.

> Signed-off-by: Christian Krafft <krafft@de.ibm.com>
> Acked-by: Heiko J Schick <schihei@de.ibm.com>

>  #define DEFAULT_REGSPACING	1
> +#define DEFAULT_REGSIZE		DEFAULT_REGSPACING

Just #define it as 1 I'd say.  Esp. for KCS interfaces, it can't
ever be anything else there.

> +	if (regsize && proplen!=4) {

Whitespace problem (a few times in this file).

> +	info->si_type		= (enum si_type) match->data;

Do you need the cast here?  Oh I suppose you do, why else
did you add it (and it teaches the world as a whole once
again that enums in C are bloody useless almost always).

> +static int __devexit ipmi_of_remove(struct of_device *dev)
> +{
> +	/* should call
> +	 * cleanup_one_si(dev->dev.driver_data); */
> +	return 0;
> +}

While I know this isn't really your problem, no one who
isn't touching the IPMI code will ever fix it, so...  nudge
nudge, wink wink.

> (void *)(unsigned long) SI_KCS

Yes I do hate enums.

> +	.name		= "ipmi",

Shouldn't this name be "ipmi-kcs" etc.?  Just asking :-)

Cheers,


Segher
