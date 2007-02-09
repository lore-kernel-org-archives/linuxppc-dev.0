Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 6F0DCDDE4A
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 08:51:30 +1100 (EST)
Message-ID: <45CCECDD.8060502@freescale.com>
Date: Fri, 09 Feb 2007 15:51:25 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: Re: [PATCH] Check mac-address first in fsl_soc.c
References: <11710513671236-git-send-email-timur@freescale.com>
	<45CCE696.5070309@smiths-aerospace.com>
In-Reply-To: <45CCE696.5070309@smiths-aerospace.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jerry Van Baren wrote:

> If you want to check for common errors, add a check that the first byte 
> does not have the multicast flag set.  

Actually, I'm not checking for errors when I check for all zeros.  I'm checking 
for a situation where the property exists in the device tree, but it has not 
been initialized by U-Boot.

Some versions of U-Boot only update the local-mac-address property, but some 
device trees have both mac-address and local-mac-address in them.  In this case, 
mac-address will be all zeros, and the MAC address will be in local-mac-address.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
