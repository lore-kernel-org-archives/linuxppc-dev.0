Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (unknown [217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 04C7F679F3
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 May 2005 18:46:44 +1000 (EST)
Date: Tue, 24 May 2005 09:46:20 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: Koen Peeters <atm@cellink.net>
Message-Id: <20050524094620.0630e177.ajz@cambridgebroadband.com>
In-Reply-To: <42924071.7010804@cellink.net>
References: <20050523145953.3a2044ef.ajz@cambridgebroadband.com>
	<42924071.7010804@cellink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-atm-general@lists.sourceforge.net, linuxppc-embedded@ozlabs.org
Subject: Re: [Linux-ATM-General] Memory mapping the PHY on CR826
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Koen,

Well spotted!  Unfortunately this is not the problem.  I got the base
address and mask the wrong way round in my email but they are the right
way round in my code.  Oops.

I tried your OR8 settings but they didn't work either.  I think there
may be a problem with the addressing on the CR826 board as the PM5350
address line 0 doesn't seem to go anywhere on the schematics!

Alex

On Mon, 23 May 2005 22:43:29 +0200
Koen Peeters <atm@cellink.net> wrote:

> Hi Alex,
> 
> I have got the Microsys board but I believe
> you sort of mixed up the 2 registers :
> 
> try :
> 
>     memctl->memc_br8 = 0xe0400821; // base 0xe0400000; default
>     timings;
>                                    //  bank valid; 8bit port; GPCM
>                                    local;
>     memctl->memc_or8 = 0xffff8820; // min banksize; addressline config
> 
> Please verify the or8 setting with the actual board configuration.
> 
> 
> Alex Zeffertt wrote:
> > Hi all,
> > 
> > Does anyone here have *any* code for memory mapping the PM5350 ATM
> > phy on the Microsys CR826 board?
> > 
> > I've just purchased this board from Microsys and I'm trying to get
> > the atm8260 ATM device driver to work on it - unfortunately I cannot
> > seem to memory map the phy.  My current settings are:
> > 
> > 
> >   memctl->memc_or8 = 0xe0400ef4; // base 0xe0400000; default timings
> >   memctl->memc_br8 = 0xffff8821; // min banksize; 8bit port; GPCM
> >   local;
> >                                  //  bank valid
> > 
> > Has anybody done this already?
> > 
> > TIA,
> > 
> > Alex
> > 
> > 
> > -------------------------------------------------------
> > This SF.Net email is sponsored by Oracle Space Sweepstakes
> > Want to be the first software developer in space?
> > Enter now for the Oracle Space Sweepstakes!
> > http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
> > _______________________________________________
> > Linux-atm-general mailing list
> > Linux-atm-general@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-atm-general
> 
> 
> -- 
> -------------------------------------------------
> Koen Peeters
> Cellink bvba
> Catherinalaan 37, 3110 Rotselaar, Belgium
> web : http://www.cellink.net/
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by Oracle Space Sweepstakes
> Want to be the first software developer in space?
> Enter now for the Oracle Space Sweepstakes!
> http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
> _______________________________________________
> Linux-atm-general mailing list
> Linux-atm-general@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-atm-general
