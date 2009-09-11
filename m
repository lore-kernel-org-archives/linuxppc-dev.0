Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.181])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B735CB7093
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 15:12:33 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: AW: PowerPC PCI DMA issues (prefetch/coherency?)
Date: Fri, 11 Sep 2009 07:12:11 +0200
References: <1251926572.10090.17.camel@Adam>
	<9D1E2BDCB5C57B46B56E6D80843439EB090397EC@SDCEXCHANGE01.ad.amcc.com>
	<1252637074.8566.56.camel@pasglop>
In-Reply-To: <1252637074.8566.56.camel@pasglop>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200909110712.11858.sr@denx.de>
Cc: Andrea Zypchen <azypchen@intldata.ca>, Pravin Bathija <pbathija@amcc.com>,
	lebon@lebon.org.ua, Prodyut Hazarika <phazarika@amcc.com>,
	tburns@datacast.com, azilkie@datacast.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 11 September 2009 04:44:34 Benjamin Herrenschmidt wrote:
> On Thu, 2009-09-10 at 13:30 -0700, Pravin Bathija wrote:
> > There is also a patch that was submitted for 440EPX a couple of years
> > back. The 440EPX SOC causes hangs with Memory Read Multiple (MRM)
> > commands. Whether MRM is used or not depends on the value of
> > PCI_CACHE_LINE_SIZE register. I see that the changes are no longer
> > present in linux 2.6.30+ kernels. Although the patch certainly resolved
> > the hang issue with Silicon Image 680 PATA card as the 680 driver
> > attempts to use MRM commands - I don't know if it would resolve the data
> > corruption issue. It is certainly worth trying in my opinion. Below is a
> > link to the patch submission:
> >
> > http://git.denx.de/?p=linux-2.6-denx.git;a=commit;h=cffefde924123e685327
> > 48dd58fcb780eab5e219
> 
> The changes in the above repository is a quick hack that can't be merged
> as-is (and afaik hasn't been submitted).
> 
> If indeed we need to clamp the PCI cache line size on those critters,
> then we need something in ppc4xx_pci.c to detect the need, set
> pci_cache_line_size to 0 and eventually fixup the existing values in
> devices in case u-boot don't have them right.
> 
> Care to send a patch ? :-)

It's already there. See commit:

5ce4b59653b2c2053cd9a011918ac1e4747f24cc

powerpc/4xx: Workaround for PPC440EPx/GRx PCI_28 Errata


Cheers,
Stefan
