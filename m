Return-Path: <bhutchings@solarflare.com>
Received: from smarthost03.mail.zen.net.uk (smarthost03.mail.zen.net.uk
	[212.23.3.142]) by ozlabs.org (Postfix) with ESMTP id 26509DDE1C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Aug 2008 00:36:53 +1000 (EST)
Date: Mon, 18 Aug 2008 15:36:51 +0100
From: Ben Hutchings <bhutchings@solarflare.com>
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: [PATCH] Linux Device Driver for Xilinx LL TEMAC 10/100/1000
	Ethernet NIC
Message-ID: <20080818143649.GD7908@solarflare.com>
References: <48A7B01C.2070403@dlasys.net>
	<20080818123056.GA7908@solarflare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080818123056.GA7908@solarflare.com>
Cc: netdev@vger.kernel.org, linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I wrote:
> > +static struct net_device_stats *
> > +temac_get_stats(struct net_device *ndev)
> > +{
> > +    return netdev_priv(ndev);
> 
> Not even the right type.  Do you read your compiler warnings?

Sorry, I now see that this is correct, though it's very fragile - it will
silently break if struct temac_local is reordered.

struct net_device includes a stats buffer which you should be able to use
instead of adding your own in struct temac_local.

Ben.

-- 
Ben Hutchings, Senior Software Engineer, Solarflare Communications
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
