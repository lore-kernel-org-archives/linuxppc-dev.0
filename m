Return-Path: <greg@kroah.com>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D4F28DDF32
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 16:00:00 +1100 (EST)
Date: Wed, 13 Feb 2008 20:43:23 -0800
From: Greg KH <greg@kroah.com>
To: Martin Mares <mj@ucw.cz>, paulus@samba.org, anton@samba.org
Subject: Re: /proc/bus/pci and domains
Message-ID: <20080214044323.GB1176@kroah.com>
References: <mj+md-20080213.154522.9237.albireo@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <mj+md-20080213.154522.9237.albireo@ucw.cz>
Cc: linuxppc-dev@ozlabs.org,
	Linux-PCI Mailing List <linux-pci@atrey.karlin.mff.cuni.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 13, 2008 at 04:53:55PM +0100, Martin Mares wrote:
> Hi Greg et al.,
> 
> I have noticed that lspci with the proc back-end does not work properly
> on ppc64. The problem turned out to be a strange hack in drivers/pci/proc.c
> causing the following behavior on machines with multiple PCI domains:
> The directory names under /proc/bus/pci/ have a domain number added (which
> is not backward compatible, but at least consistent), but on the other hand
> /proc/bus/pci/devices contains bus numbers without the domains, happily
> making multiple entries with the same bus and device number.
> 
> Is there any serious reason for this behavior?

I have no idea, it sounds like a PPC specific thing, not anything the
PCI core does, right?  So I'll add the ppc list to the cc: and ask if
anyone there has any ideas?

Rest of the original email follows...

> 
> The original /proc/bus/pci/ (as I have designed it years ago) does not
> have any means of carrying the domain numbers, so it cannot be solved
> in a backward-compatible way, but the inconsistency between the list of
> devices and the actual directories leaves me puzzled.
> 
> Wouldn't it be better to make the same backward-incompatible change
> in /proc/bus/pci/devices, so that at least new programs can use the
> thing?
> 
> Of course, all this is of minor importance as all new programs know
> how to use the sysfs anyway (I have found the problem only because
> I forgot to mount sysfs to a chroot), but if we want to keep /proc/bus/pci/,
> we should fix it.
> 
> 				Have a nice fortnight
> -- 
> Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
> Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
> Entropy isn't what it used to be.
