Return-Path: <mark@bish.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1F255B7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jul 2009 04:34:06 +1000 (EST)
Received: from vincent.bish.net (bish.net [209.241.232.100])
	by ozlabs.org (Postfix) with ESMTP id B7F07DDD1C
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Jul 2009 04:34:05 +1000 (EST)
Message-ID: <20090709141648.ws3ak25ewwogwsc0@www.bish.net>
Date: Thu, 09 Jul 2009 14:16:48 -0400
From: Mark Bishop <mark@bish.net>
To: spi-devel-general@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Subject: Questions in spi_mpc83xx.c
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I haven't seen this before - the '##' in the function name.  This is ANCII C?

#define MPC83XX_SPI_TX_BUF(type)				\
u32 mpc83xx_spi_tx_buf_##type(struct mpc83xx_spi *mpc83xx_spi)	\
{								\
	u32 data;						\
....


Also, I have a SPI chip here that will drive MISO high when it is  
ready to accept more data.  It acts like a hardware handshake.  I was  
thinking about making changes to the controller source (spi_mpc83xx.c,  
in my case) to support this.

This is the only SPI chip contained on this system so I am not worried  
about affecting other SPI devices hooked to the controller.

What are people's opinion on this as far as right place to implement,  
and I could use a push as to where in the controller to make mods if  
appropriate.

And if it isn't obvious already I am still learning a bit as to how  
the SPI sub-system is organized.   I have taken apart the  
documentation in the kernel Documentation/spi directory and am reading  
all the code in drivers/spi.
