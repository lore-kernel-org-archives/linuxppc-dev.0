Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7DBD9DDF5F
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 10:47:35 +1100 (EST)
Message-ID: <47B2300B.4060101@freescale.com>
Date: Tue, 12 Feb 2008 17:47:23 -0600
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
	<20080212232639.GD21230@localhost.localdomain>
In-Reply-To: <20080212232639.GD21230@localhost.localdomain>
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

> I can pretty much guarantee you that someone will find that
> insufficient and want to expand the conditional representation.  This
> way madness lies.

Then let them.  We can have version numbers associated with the conditional 
expressions.  If they want to make more complex condition expressions, they can 
bump the version number and define a spec and write code to parse it.

> No.  As Grant says, that's not what the version number is for.  It
> represents the version of the encoding, not the content.  If you must
> version the content (which you should try really hard to avoid) the
> correct way is to add versioning properties to the root node.

And that's why I prefer updating the DTB format to allow attaching conditional 
expressions to nodes.  This would then necessitate bumping the version number. 
Older U-Boots will reject this new DTB.  We can also modify DTC to support 
conditional nodes, so that if a customer has an older U-Boot he can't update, he 
can use DTC to generate a V17 DTB that has the conditionals already processed.

-- 
Timur Tabi
Linux kernel developer at Freescale
