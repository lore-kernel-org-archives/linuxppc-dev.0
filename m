Return-Path: <gregkh@suse.de>
Received: from mx2.suse.de (ns2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4B19EDE12F
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 03:29:15 +1100 (EST)
Date: Wed, 11 Mar 2009 09:26:23 -0700
From: Greg KH <gregkh@suse.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC] drivers/base: Add bus_register_notifier_alldev() variant
Message-ID: <20090311162623.GE21831@suse.de>
References: <20090306160818.404.92700.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090306160818.404.92700.stgit@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 06, 2009 at 09:10:19AM -0700, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> bus_register_notifier_alldev() is a variation on bus_register_notifier()
> which also triggers the notifier callback for devices already on the bus
> and already bound to drivers.
> 
> This function is useful for the case where a driver needs to get a
> reference to a struct device other than the one it is bound to and
> it is not known if the device will be bound before or after this
> function is called.  For example, an Ethernet device connected to
> a PHY that is probed separately.

Can't you just walk the list of all devices already on the bus to get
"notified" of them, and then register your notifier handler as well (or
register it first, and then walk the list, which is pretty much what
your patch does)?

I see this api addition as just confusing people as to which one they
should register for :)

thanks,

greg k-h
