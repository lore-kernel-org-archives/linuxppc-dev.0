Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 31C8DDDF5C
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 May 2007 14:29:34 +1000 (EST)
Received: from [206.223.20.140]
	by mx.dlasys.net with esmtp (Exim 4.63 #1 (Debian))
	id 1Hijx0-0008JH-2T
	for <linuxppc-embedded@ozlabs.org>; Tue, 01 May 2007 00:26:54 -0400
Message-ID: <4636C1D7.9090309@dlasys.net>
Date: Tue, 01 May 2007 00:28:07 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 2/5] [PPC] Merge common virtex header files
References: <1176622062492-git-send-email-grant.likely@secretlab.ca>
	<11766220692537-git-send-email-grant.likely@secretlab.ca>
	<11766220693636-git-send-email-grant.likely@secretlab.ca>
	<87d51sac8l.fsf@sleipner.barco.com>
	<528646bc0704271149w211bd5cbscb467123ab962703@mail.gmail.com>
	<87slai5vz3.fsf@sleipner.barco.com>
In-Reply-To: <87slai5vz3.fsf@sleipner.barco.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Peter Korsgaard wrote:
> GL> Alternate suggestion: Can we change virtex support to use the
> GL> structure defined in ppcboot.h instead?  (I've actually got that
> GL> change in my tree and was planning on posting it for review today
> GL> or tomorrow).  bd_t is a stinking ugly mess, but things would be
> GL> better if we standardize all virtex platforms on the stinking ugly
> GL> mess shared by almost all the other ppc embedded board ports.
>
> That's where the ugly mess pops up - RedBoot uses another
> (incompatible) bd_t definition than U-boot, E.G:
>
> typedef struct bd_info {
> 	unsigned int   bi_tag;        /* Should be 0x42444944 "BDID" */
>   
snip
> 	
> 	int            bi_flashwidth; /* Width (8,16,32,64) */
> 	unsigned char *bi_cmdline;    /* Pointer to command line */
> } bd_t;
>
> I should probably migrate to U-boot anyway, but still ..
>   

    Can we please not standardize on some specific implimentation of
bd_info ?
   
    We have our own bootloader - actually a monitor. It does alot of
things besides boot Linux.
    and it does so in less than 16K.
    our bd_info struct is used to pass info to OS's besides Linux.
    It does not have all the crap the u-boot bd_info has in it that has
no meaning for us.
    But it does have some things that are very specific to our
hardware/firmware.

    It took a quick look at Grant's virtex patches, and will try to test
them with our cards,
    as soon as I can, but the inclusion of a specific virtex bd_info
leapt out instantly as something
    I would have to patch.

    Besides, I am not current on the powerpc tree but isn't this kind of
thing what device trees are
    supposed to be about and don't we have to do that anyway to migrate
to the powerpc tree ?




-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
