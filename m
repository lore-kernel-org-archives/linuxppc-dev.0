Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id AB9FFDDDF3
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 08:20:35 +1100 (EST)
Message-ID: <45F8671D.1010905@freescale.com>
Date: Wed, 14 Mar 2007 16:20:29 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: Re: [dtc] Add support for flat device tree format version 17
References: <20070313062240.GA22737@localhost.localdomain>
	<45F863DF.5050709@freescale.com>
	<45F864E8.40501@smiths-aerospace.com>
In-Reply-To: <45F864E8.40501@smiths-aerospace.com>
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

Jerry Van Baren wrote:

> The best solution, which I'm making progress on but slowly, is to pull 
> David Gibson's libfdt utilities into u-boot and use them to manipulate 
> the tree.  

I don't think that will help, because the problem is how do you update a device tree that 
you don't know everything about?

 > I very much want v17 blobs because that removes my
> "write-in-place" restrictions on changing the properties.

Another idea which just came to light is to have the compatibility field be only useful to 
code that just *reads* the DTB.  Any code that *writes* the DTB should look it.

Since the kernel only reads the DTB, it can use the compatibility field.  Since U-Boot 
writes to the DTB, it should currently only accept true V16 DTBs.

If the kernel were to ever write to the DTB, then it would have to be as restrictive.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
