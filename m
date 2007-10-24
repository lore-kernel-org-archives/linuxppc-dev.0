Return-Path: <tjernlund@tjernlund.se>
Received: from csmtp3.b-one.net (csmtp3.b-one.net [195.47.247.213])
	by ozlabs.org (Postfix) with ESMTP id AA11FDDEC6
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Oct 2007 07:38:57 +1000 (EST)
From: "Tjernlund" <tjernlund@tjernlund.se>
To: <i2c@lm-sensors.org>
Subject: i2c-mpc.c driver issues
Date: Wed, 24 Oct 2007 23:06:13 +0200
Message-ID: <019001c81681$b5d449c0$5267a8c0@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

While browsing the i2c-mpc.c driver I noticed some things that look odd
to me so I figured I report them. Could not find a maintainer in the MAINTANERS file
so I sent here, cc:ed linuxppc-dev as well.

1) There are a lot of return -1 error code that is propagated back to
   userspace. Should be changed to proper -Exxx codes.

2) mpc_read(), according to the comment below it sends a STOP condition here but
   this function does not known if this is the last read or not. mpc_xfer is
   the one that knows when the transaction is over and should send the stop, which it already
   does.

 /* Generate stop on last byte */
  if (i == length - 1)
       writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_TXAK);

 Jocke
