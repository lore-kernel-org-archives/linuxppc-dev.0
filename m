Date: Wed, 2 Jan 2002 22:05:58 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200201030605.g0365wE00267@dave.home>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problem w/driver writing to User Space
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Didn't this come up before? I thought Dan or someone answered this very
question.

You do the ioremap in kernel space, so the resultant address can't be used
as an address to put_user. Just treat it as a pointer directly:

*(UINT32 *)(plxPtr+ PCI9054_EEPROM_CTRL_STAT) |= (1<<16); // turn on
*(UINT32 *)(plxPtr+ PCI9054_EEPROM_CTRL_STAT) &= ~(1<<16); //turn off

If it ever worked I would think it is just a fluke, maybe you're forcing
the user space to appear like the kernel space.

-Dave

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
