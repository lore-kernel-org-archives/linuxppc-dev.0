Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 76E4CDDF6A
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 10:50:46 +1100 (EST)
Message-ID: <47B230C6.9010105@freescale.com>
Date: Tue, 12 Feb 2008 17:50:30 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>, Grant Likely <grant.likely@secretlab.ca>,
	linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: Could the DTS experts look at this?
References: <47ACE630.8090101@pikatech.com>
	<20080211235409.GB18348@localhost.localdomain>
	<20080211235652.GC18348@localhost.localdomain>
	<200802120121.45349.arnd@arndb.de> <47B1BEE7.4050808@freescale.com>
	<fa686aa40802121058u6c6e4ba9s3ced2e35950745ea@mail.gmail.com>
	<47B1EEA8.4040904@freescale.com>
	<fa686aa40802121134i4bc0c9bep30920a5afdeb240c@mail.gmail.com>
	<47B1F763.9000404@freescale.com>
	<20080212233548.GE21230@localhost.localdomain>
In-Reply-To: <20080212233548.GE21230@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:

> You don't.  If your agent takes a dtb, dtb layout and agent must
> match.

So what I would like to see is a way for the agent to validate the dtb.  U-Boot 
could currently validate the SOC's compatible field.  However, if we add a 
special node that contains rules for modifying the rest of the tree, the only 
possible way to block older, incompatible U-Boots from accepting the tree is to 
bump the version number.  Since that is not the right thing to do, the best 
approach is to define a new node type that has conditional expression attached 
to it.  Then we can bump the version.

> In fact, in one way of looking at it that's always what happens: the
> dtb format is defined for passing hardware information from the
> bootloader to the kernel; nothing else.  Passing a dtb *into* the
> bootloader is just a bootloader implementation convenience, because
> the possible variations on an output tree are small, so it's useful to
> have a skeleton tree built-in.  But in order for the bootloader to
> process those variations correctly, the skeleton *must* be in the
> right format.  dtb input to a bootloader must match the bootloaders
> expectations.  This has always been true, and will continue to be
> true.

The problem with this approach is that you're replacing data with code, and that 
always makes things more difficult.

-- 
Timur Tabi
Linux kernel developer at Freescale
