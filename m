Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 01F6F67BC9
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 02:09:45 +1000 (EST)
Message-ID: <453E3AAC.9040403@freescale.com>
Date: Tue, 24 Oct 2006 11:09:16 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: pci_set_power_state() failure and breaking suspend
References: <1161672898.10524.596.camel@localhost.localdomain>
	<200610241400.06047.rjw@sisk.pl>
In-Reply-To: <200610241400.06047.rjw@sisk.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>,
	linux1394-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rafael J. Wysocki wrote:
> On Tuesday, 24 October 2006 08:54, Benjamin Herrenschmidt wrote:
>>However, this raises the question of do we actually want to prevent
>>machines to suspend when they have a PCI device that don't have the PCI
>>PM capability ? I'm asking that because I can easily imagine that sort
>>of construct growing into more drivers (sounds logical if you don't
>>think) and I can even imagine somebody thinking it's a good idea to slap
>>a __must_check on pci_set_power_state() ... 
> 
> 
> As far as the suspend to RAM is concerned, I don't know.
> 
> For the suspend to disk we can ignore the error if we know that the device
> in question won't do anything like a DMA transfer into memory while we're
> creating the suspend image.

I think it should be ignored for suspend-to-RAM as well; even if a 
device or two is consuming unnecessary power, it's better than not being 
able to suspend at all, causing more things to consume unnecessary power.

At most, a warning should be issued so the user knows what's going on, 
and can choose whether to suspend to disk instead (or choose to complain 
to the device manufacturer).

-Scott
