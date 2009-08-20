Return-Path: <sr@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3D640B7087
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 20 Aug 2009 15:01:43 +1000 (EST)
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.182])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4CF67DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Aug 2009 15:01:40 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: u-boot@lists.denx.de
Subject: Re: [U-Boot] NAND  ECC Error with wrong SMC ording bug
Date: Thu, 20 Aug 2009 07:01:21 +0200
References: <19081.57584.173693.798535@cargo.ozlabs.ibm.com>
	<4A8C87E6.6070702@amcc.com>
	<20090820003851.1a532444@lappy.seanm.ca>
In-Reply-To: <20090820003851.1a532444@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200908200701.21076.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, Feng Kan <fkan@amcc.com>,
	linux-mtd@lists.infradead.org, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 20 August 2009 06:38:51 Sean MacLennan wrote:
> > I see other boards using SMC as well, can someone comment on the
> > change I am proposing.
> > Should I change the correction algorithm or the calculate function?
> > If the later is preferred
> > it would mean the change must be pushed in both U-Boot and Linux.
>
> Odds are the calculate function is wrong. The correction algo is used
> by many nand drivers, I *assume* it is correct. The calculate function
> was set to agree with u-boot (1.3.0).

Yes, it seems that you changed the order in the calculation function while 
reworking the NDFC driver for arch/powerpc. So we should probably change this 
order back to the original version. And change it in U-Boot as well.

BTW: I didn't see any problems with ECC so far with the current code. Feng, 
how did you spot this problem?

Cheers,
Stefan

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-0 Fax: (+49)-8142-66989-80 Email: office@denx.de
