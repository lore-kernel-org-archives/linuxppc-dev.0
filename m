Return-Path: <bwaite@irobot.com>
Received: from irobot.com (smtp1.irobot.com [66.238.211.203])
	by ozlabs.org (Postfix) with ESMTP id B4CEB68992
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Dec 2005 01:39:42 +1100 (EST)
From: Brian Waite <bwaite@irobot.com>
To: linuxppc-embedded@ozlabs.org
Date: Tue, 20 Dec 2005 09:27:35 -0500
References: <kw3bkovcup.fsf@lamorak.int.avalon.com.au>
	<20051220010136.GA31165@mag.az.mvista.com>
In-Reply-To: <20051220010136.GA31165@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200512200927.35976.bwaite@irobot.com>
Subject: Re: linux DMA capabilities in MV64460
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Monday 19 December 2005 8:01 pm, Mark A. Greer wrote:
> >
> > up the mv64460.  One source told me:
> >   > In order to do PCI bursts, you'll need to use a DMA engine.  The
> >   > MV64460 does contain a DMA engine, but you'd need to write a driver
> >   > to access it.
>
> That is not correct (assuming the quote is not out of context).
> The bridge supports bursting on the PCI bus as long as the bridge is
> configured correctly and the PCI device is making an appropriate request.
> Note, however, that there are many errata for the Marvell parts including
> some with cache coherency.
There are many many errata regarding cache coherency. Also, the PCI bandwidth 
the bridge is capable of with coherency enabled is very small. You will most 
likely need to use sw coherency for any real speed.
> If your system is running with coherency on, 
> you may have to limit your bursts to 32 bytes (i.e., the size of one
> cache line).
You will have to limit your self to 32 byte bursts with coherency. This is a 
requirement not an errata. 

> > Is there a summary of what is possible and/or not possible with the 4
> > IDMA channels on the mv64460?
>
> The only real documentation is the bridge's user manual from Marvell.
> Unfortunately, you must sign an NDA to get access to it so I can't share
> mine with you.  You will need access to that info to get very far so I
> recommend you contact the people in your company that can make that
> happen, ASAP.
Ask for the errata sheets while your at it. You WILL need them :)
You really do need the chipset docs to do anything intelligent with the IDMA 
controllers.

Thanks
Brian
