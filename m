Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 92F97DE007
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 19:12:03 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [net-next-2.6 PATCH v2] can: SJA1000: generic OF platform bus
	driver
Date: Tue, 26 May 2009 10:10:30 +0100
References: <4A16BAAE.3070401@grandegger.com>
	<200905242327.15139.arnd@arndb.de>
	<4A1A418D.3040207@grandegger.com>
In-Reply-To: <4A1A418D.3040207@grandegger.com>
MIME-Version: 1.0
Message-Id: <200905261010.31364.arnd@arndb.de>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Cc: Linux Netdev List <netdev@vger.kernel.org>, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 25 May 2009, Wolfgang Grandegger wrote:
> > Right, that makes sense. However, most drivers use the field to store the
> > physical address, not the iomap token. Maybe there should be a new field
> > in struct sja1000_priv for the virtual address, but that would be a change
> > to the base driver, not just to the OF portion.
> 
> Is that common practice? If yes, I will add a member to store the
> virtual address to struct sja1000_priv.

I grepped through the network driver for usage of ->base_addr, and
it's somewhat inconsistent. The majority of the users use it for
a physical address, but there are also a few that use it for the
__iomem token.

Casts between unsigned long and qualified (__iomem, __user, const, ...)
pointers do not cause a warning, but can easily lead to bugs when
another user casts to an unqualified pointer.

	Arnd <><
