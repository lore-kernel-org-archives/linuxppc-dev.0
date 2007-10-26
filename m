Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 166FBDDDEB
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Oct 2007 02:34:03 +1000 (EST)
Date: Fri, 26 Oct 2007 20:30:58 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/2] PowerPC: Add 44x NDFC device-tree aware support
Message-ID: <20071026163058.GA11354@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tglx@linutronix.de, sr@denx.de, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I've worked in parallel with Stefan Roese on the new OF NDFC support.
This version (as well as Stefan's) is based on the original NDFC driver by Thomas Gleixner.
The major difference is that the original implements each chip connected NDFC banks as a
separate MTD device. Here I try to have one MTD device spread on all chips found.
However, the chips should have equal ID's and sizes, but I've never seen several different
chips attached to single ndfc. I'm adding ndfc_of as a separate file, since some other changes
have also been made (e.g. all i/o is made with ndfc_readl/writel inline functions).
The original version didn't handle driver removal well (it never calls del_mtd...),it's 
corrected here. I decided not to add ecc pos and oob layout to DTS, since we should be OK with
the default ones with NDFC.
This stuff has been tested on PowerPC 440EPx Sequoia board.
Any comments are greatly appreciated.
Thanks,
Valentine.
