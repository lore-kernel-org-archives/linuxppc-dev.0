From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>,
	Armin Kuster <akuster@mvista.com>
Subject: Re: 405 DMA api
Date: Mon, 25 Feb 2002 09:16:19 +0100
Message-Id: <20020225081619.25142@smtp.wanadoo.fr>
In-Reply-To: <3C795366.2040909@mvista.com>
References: <3C795366.2040909@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Hello,
>
>I would like to have the 405 dma share the same dma api as the current
>pmac. I propose to make the asm/dma.h _generic_ and move all the power
>Mac unique stuff into a seperate file such as "pmac_dma.h".  The dma.h
>would then be the gateway for other ppc archs by using "CONFIG_<arch>"
>to determine which hearder to pull in.  I made the pmac_pma.h as the
>default.  I have tested this on the  walnut and can only compile for the
>pmac.  I have included a patch and I  would like some feedback and to
>have the pmac_dma verified.
>
>files:
>include/asm-ppc/dma.h <- generic defines and config selection
>include/asm-ppc/pmac_dma.h     <- most code from dma.h
>include/asm-ppc/ppc405_dma.h <- changed func names
>arch/ppc/kernel/ppc405_dma.c <- changes to refect new header scheme

Well... except this isn't pmac dma. The pmac has a DBDMA controller
which is much different from the legacy DMA controller used here. What
you see in this dma.h file is, I bet, prep stuff.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
