MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: ppcboot 8260 LXT971A 
Date: Mon, 30 Jun 2003 11:49:45 +0200
Message-ID: <30C145E544071F4FB8B627789F7910BD328FF4@csy-exchange1.giat.intra>
From: "ARIBAUD Albert" <A.ARIBAUD@giat-industries.fr>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> > My problem had something to do with MII state change
> interrupts not being detected properly, so the Ethernet
> driver was not told when the line went up after
> autonegociation, and thus never sent any packet.
>
> Assuming your hardware is OK this means you  have  misconfigured  the
> Linux kernel (wrong MII interrupt?)
>
> Best regards,
>
> Wolfgang Denk

Hi Wolfgang,

As far as I remember, the hardware designer and I had checked that: we were using the right interrupt, it was triggered and the interrupt driver received it, but somehow in the driver the line state evolution from 'init' to 'up' was lost.

Unfortunately, we did not have enough time for messing with the kernel then (1), so we tried alternatives, and disabling MDIO worked, so we did not investigate further. If you think it could be useful, I could reproduce that setting and do some tracing.

All the best,

Albert.

(1) I can't believe I just wrote that, considering that I have just modified i2c-algo-8xx.c extensively (and i2c-rpx.c also, but more slightly) to get I2C_RDWR ioctl working, two days before project deadline. :)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
