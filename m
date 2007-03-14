Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 002F8DDE0E
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 08:42:03 +1100 (EST)
Message-ID: <45F86C25.1070301@freescale.com>
Date: Wed, 14 Mar 2007 16:41:57 -0500
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
> the tree.  I very much want v17 blobs because that removes my 
> "write-in-place" restrictions on changing the properties.

Here's an alternative idea I got from a colleage (Scott Wood).

Allow U-Boot to accept V17 DTBs.  When it modifies the DTB, it should change the version 
to 16, since that's the only version that it really knows.  U-Boot currently does not have 
the infrastructure to support multiple DTB versions.

The DTB that U-Boot passes to the kernel will say V16, but it will have the extra length 
field in the header.  Therefore, we need to update the documentation to say that 
compatibility implies that any DTB will still be able to read the DTB if the DTB version 
number has been changed to another compatible version.  So if your DTB is V17, and it has 
V17 data, any code that assumes a V16 DTB should still be able to read it.  That seems 
obvious, but is should be documented.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
