Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 4A1E367CA7
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 04:48:22 +1100 (EST)
Message-ID: <45803CE3.4030600@freescale.com>
Date: Wed, 13 Dec 2006 11:48:19 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: joakim.tjernlund@transmode.se
Subject: Re: latest linux git doesn't compile ucc_geth_phy.c and ucc_geth.c
References: <1166013887.30422.54.camel@gentoo-jocke.transmode.se>
In-Reply-To: <1166013887.30422.54.camel@gentoo-jocke.transmode.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Joakim Tjernlund wrote:
> drivers/net/ucc_geth.c:4083:45: macro "INIT_WORK" passed 3 arguments,
> but takes just 2
> drivers/net/ucc_geth.c: In function `ucc_geth_open':
> drivers/net/ucc_geth.c:4083: error: `INIT_WORK' undeclared (first use in
> this function)
> drivers/net/ucc_geth.c:4083: error: (Each undeclared identifier is
> reported only once
> drivers/net/ucc_geth.c:4083: error: for each function it appears in.)
> drivers/net/ucc_geth.c: At top level:
> drivers/net/ucc_geth.c:3924: warning: 'ugeth_phy_change' defined but not
> used
> make[2]: *** [drivers/net/ucc_geth.o] Error 1
> 
> drivers/net/ucc_geth_phy.c:71: error: conflicting types for 'phy_read'
> include/linux/phy.h:355: error: previous declaration of 'phy_read' was
> here
> drivers/net/ucc_geth_phy.c:71: error: conflicting types for 'phy_read'
> include/linux/phy.h:355: error: previous declaration of 'phy_read' was
> here
> drivers/net/ucc_geth_phy.c:72: error: conflicting types for 'phy_write'
> include/linux/phy.h:356: error: previous declaration of 'phy_write' was
> here
> drivers/net/ucc_geth_phy.c:72: error: conflicting types for 'phy_write'
> include/linux/phy.h:356: error: previous declaration of 'phy_write' was
> here

I just posted two patches to linuxppc-dev that fix these problems.  The message 
are titled:

[PATCH] Update ucc_geth.c for new workqueue structure
[PATCH] Fix phy_read/write redefinition errors in ucc_geth_phy.c

I've tested these on an 8360EMDS, and Kumar has reviewed and signed off on the 
code, so I think they're good.  Please let me know if they're not.


-- 
Timur Tabi
Linux Kernel Developer @ Freescale
