Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id D9F1568515
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Oct 2005 06:07:10 +1000 (EST)
Date: Wed, 12 Oct 2005 15:06:54 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: "Vikas Aggarwal" <va824363@albany.edu>
Message-Id: <20051012150654.57384af4.kim.phillips@freescale.com>
In-Reply-To: <1084.24.92.61.26.1126086971.squirrel@webmail.albany.edu>
References: <BDEHJGPIKNLKJJBCCFPLCEOOCPAA.listuser@epygi.de>
	<1084.24.92.61.26.1126086971.squirrel@webmail.albany.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: ads8272 SEC problem on 2.4.18
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

okay, the devtech team has ported the 2.4 SEC driver to 2.6 (and finally fixed this issue).  It is a direct port from the 2.4 driver - so whatever limitations exist in the 2.4 version will exist in this.  It's available on the Codewarrior BSP site:

http://www.metrowerks.com/MW/Develop/Embedded/Linux/DownloadBSP.htm

Use the MPC8272ADS 2.6 Kernel link.

Kim

On Wed, 7 Sep 2005 05:56:11 -0400 (EDT)
"Vikas Aggarwal" <va824363@albany.edu> wrote:

> I had the similar error with SEC1 for 8248. My RNG DPD could not generate
> desired result. After DPD address written my ISR was invoked but all i had
> is TEA error, or bus error etc when i checked the Status Registers.
> 
> regards
> -vikas
> 
> > HiHo!
> >
> > I am trying to get the SEC engine running on a ads8272
> > but i am completely stuck now. (It feels like the problem
> > we saw on this list last month, but there is still no solution
> > to that issue yet.
> >
> > Quick Problem description:
> >   initialize seems, ok, yet when i feed a single
> >   dpd (for DES EU) into channel 0, the engine
> >   seems to stuck during fetch. Nothing happens.
> >
> > Questions:
> > - Can someone help me out? (Not sure if this is the right list for this?)
> > - Do (open) sources for the SEC1 (motorola/freescale) engine exist for
> > vanilla linux?
> >   (I know of Arabella, but they are neither open nor for vanilla linux)
> >
> > ciao
> >   Markus
> >
> > P.S. some more details below
> > --------------------------------------------
> > more info:
> >  - i hopefully initialized it correctly
> >  - prepared a dpd
> >  - wrote it into fetch register
> >  - see that something happens: CurrentDescriptorPR changes
> >  - boing, that's it... no more
> >
> > some dumps:
> >  Before writing the fetch register:
> >   CryptoChannelConfigRegister (f0042008), 0x00000000 0x0000071c
> >   CryptoChannelPointerStatusRegister (f0042010), 0x00000000 0x00000007
> >   CryptoChannelCurrentDescriptorPointerRegister (f0042040), 0x00000000
> > 0x00000000
> >   CryptoChannelFetchDescriptorRegister (f0042048), 0x00000000 0x00000000
> >   CryptoChannelDescriptorBufferRegister 0 (f0042080), 0x00000000
> >
> >  after writing to fetch register
> >   CryptoChannelConfigRegister (f0042008), 0x00000000 0x0000071c
> >   CryptoChannelPointerStatusRegister (f0042010), 0x00000002 0x00000007
> >   CryptoChannelCurrentDescriptorPointerRegister (f0042040), 0x00000000
> > 0x002e9a98
> >   CryptoChannelFetchDescriptorRegister (f0042048), 0x00000000 0x00000000
> >   CryptoChannelDescriptorBufferRegister 0 (f0042080), 0x00000000
> >
> > CCPSR changes to 2 (error), but i don't know why?
> > Nothing else (at least nothing i can see) happens.
> > ------------------------------------------------------
> > markus schaefer  ---  software engineer
> > epygi labs de gmbh
> > herrenstrasse 23
> > d-76133 karlsruhe, germany
> > tel: +49 (721) 205 96 30  -- fax: +49 (721) 205 96 59
> > sip: 20444@sip.epygi.com
> > *email removed, but it is easy to guess*
> > http://www.epygi.de
> >
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


-- 
