Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EFA7ADDED0
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 02:01:49 +1000 (EST)
Message-ID: <467FE6E5.1070403@freescale.com>
Date: Mon, 25 Jun 2007 11:01:41 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: fix MAC address entries for 83xx, 85xx, and
	86xx device trees
References: <11825407952085-git-send-email-timur@freescale.com>
	<70d005ce549921cc56481fe0b26faaa4@kernel.crashing.org>
	<467FDA2C.8020607@freescale.com>
	<05ae4090f00e42580b7dcbf0619cc0b7@kernel.crashing.org>
In-Reply-To: <05ae4090f00e42580b7dcbf0619cc0b7@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:

> Yup, they're both marked for removal so let's just remove them
> at the same time.

As soon as Paul creates a "for-2.6.25" branch, that's when I was planning on doing it.

> Does the kernel provide a warning to users of too-old firmware^Wuboot
> telling them to update btw?

Nope.  The current U-Boot code updates mac-address and/or local-mac-address, whichever 
ones exist.  If neither exists, it doesn't do anything.  If both exists, it updates both 
with the same value.  This makes it DTS-agnostic, so to speak.

The kernel looks at each of the properties and uses the first one that has a valid MAC 
address.  Again, this is U-Boot- and DTS-agnostic.

Some older U-Boots would panic if the property it looks for didn't exist.  Some Linux 
drivers would simply not find a MAC address and then fail to load.

In other words, the current U-Boot and Linux code is written to not care what the other 
one does.  I have no plans to remove the code in the kernel that looks for obsolete 
entries (I'm talking about function of_get_mac_address), because it's "safe".

However, now that you mention it, I could update function of_get_mac_address() to display 
a warning if it only finds the 'address' property.  That property is definitely wrong and 
should never be in the DTS or any device tree passed to the kernel.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
