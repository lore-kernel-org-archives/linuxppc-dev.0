Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3FC58B7257
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 12:44:47 +1000 (EST)
Subject: RE: AW: PowerPC PCI DMA issues (prefetch/coherency?)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pravin Bathija <pbathija@amcc.com>
In-Reply-To: <9D1E2BDCB5C57B46B56E6D80843439EB090397EC@SDCEXCHANGE01.ad.amcc.com>
References: <1251926572.10090.17.camel@Adam><4A9F78AF.4010206@oxtel.com>
	<1251971849.15089.28.camel@pasglop><1251993890.2548.14.camel@Adam>
	<0CA0A16855646F4FA96D25A158E299D606F60795@SDCEXCHANGE01.ad.amcc.com>
	<1252432873.2548.41.camel@Adam>
	<0CA0A16855646F4FA96D25A158E299D606F60B70@SDCEXCHANGE01.ad.amcc.com>
	<4AA7AD65.7070403@lebon.org.ua> <4AA7B0EC.4000106@datacast.com>
	<4AA7B7EA.2090500@lebon.org.ua> <4AA95941.20506@datacast.com>
	<9D1E2BDCB5C57B46B56E6D80843439EB090397EC@SDCEXCHANGE01.ad.amcc.com>
Content-Type: text/plain
Date: Fri, 11 Sep 2009 12:44:34 +1000
Message-Id: <1252637074.8566.56.camel@pasglop>
Mime-Version: 1.0
Cc: Andrea Zypchen <azypchen@intldata.ca>, lebon@lebon.org.ua,
	Prodyut Hazarika <phazarika@amcc.com>, tburns@datacast.com,
	linuxppc-dev@lists.ozlabs.org, azilkie@datacast.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-09-10 at 13:30 -0700, Pravin Bathija wrote:

> There is also a patch that was submitted for 440EPX a couple of years
> back. The 440EPX SOC causes hangs with Memory Read Multiple (MRM)
> commands. Whether MRM is used or not depends on the value of
> PCI_CACHE_LINE_SIZE register. I see that the changes are no longer
> present in linux 2.6.30+ kernels. Although the patch certainly resolved
> the hang issue with Silicon Image 680 PATA card as the 680 driver
> attempts to use MRM commands - I don't know if it would resolve the data
> corruption issue. It is certainly worth trying in my opinion. Below is a
> link to the patch submission:
> 
> http://git.denx.de/?p=linux-2.6-denx.git;a=commit;h=cffefde924123e685327
> 48dd58fcb780eab5e219

The changes in the above repository is a quick hack that can't be merged
as-is (and afaik hasn't been submitted).

If indeed we need to clamp the PCI cache line size on those critters,
then we need something in ppc4xx_pci.c to detect the need, set
pci_cache_line_size to 0 and eventually fixup the existing values in
devices in case u-boot don't have them right.

Care to send a patch ? :-)

Cheers,
Ben
