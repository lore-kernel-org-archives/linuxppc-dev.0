Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 9F76D67D60
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Oct 2006 06:19:21 +1100 (EST)
Date: Mon, 30 Oct 2006 22:19:19 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Antonio Di Bacco <antonio.dibacco@aruba.it>
Subject: Re: enabling MDIO on ppc/8xx_io/fec.c causes ioctl problems
Message-ID: <20061030221919.6b2087f4@vitb.ru.mvista.com>
In-Reply-To: <200610302007.30041.antonio.dibacco@aruba.it>
References: <200610302007.30041.antonio.dibacco@aruba.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 30 Oct 2006 20:07:29 +0100
Antonio Di Bacco <antonio.dibacco@aruba.it> wrote:

> I enabled the use of MDIO in the fec.c driver but now the driver doesn't 
> handle some ioctls that ifconfig sends to it. I saw that there is this code 
> snippet in the driver:
> 
> #ifdef	CONFIG_USE_MDIO
> 	dev->do_ioctl = fec_enet_ioctl;
> 
> 	for (i=0; i<NMII-1; i++)
> 		mii_cmds[i].mii_next = &mii_cmds[i+1];
> 	mii_free = mii_cmds;
> #endif	/* CONFIG_USE_MDIO */
> 
> But fec_enet_ioctl treats only mii related ioctls.
> 
> What am I missing?
> 
The 8xx_io/ stuff is obsoleted long ago. You should use drivers/fs_enet/* for your FEC eth instead.
arch/ppc/mpc885_setup.c can hand some guidance on ho to do that.


-- 
Sincerely, 
Vitaly
