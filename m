Return-Path: <antonio.dibacco@aruba.it>
Received: from smtpa1.aruba.it (smtpa1.aruba.it [62.149.128.210])
	by ozlabs.org (Postfix) with SMTP id A60B967D2B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Oct 2006 06:13:48 +1100 (EST)
From: Antonio Di Bacco <antonio.dibacco@aruba.it>
To: linuxppc-embedded@ozlabs.org
Subject: enabling MDIO on ppc/8xx_io/fec.c causes ioctl problems
Date: Mon, 30 Oct 2006 20:07:29 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200610302007.30041.antonio.dibacco@aruba.it>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I enabled the use of MDIO in the fec.c driver but now the driver doesn't 
handle some ioctls that ifconfig sends to it. I saw that there is this code 
snippet in the driver:

#ifdef	CONFIG_USE_MDIO
	dev->do_ioctl = fec_enet_ioctl;

	for (i=0; i<NMII-1; i++)
		mii_cmds[i].mii_next = &mii_cmds[i+1];
	mii_free = mii_cmds;
#endif	/* CONFIG_USE_MDIO */

But fec_enet_ioctl treats only mii related ioctls.

What am I missing?

Thank you,
Antonio.
