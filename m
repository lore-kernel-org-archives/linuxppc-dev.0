Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 71846B7D47
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  5 Jun 2010 06:04:41 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o54K4b59007929 for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 4 Jun 2010 13:04:37 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o54KG7Pl025928
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 4 Jun 2010 15:16:07 -0500 (CDT)
Message-ID: <4C095C53.60002@freescale.com>
Date: Fri, 04 Jun 2010 15:04:35 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: kerstin jonsson <kerstin.jonsson@ericsson.com>
Subject: Re: fsl_rio.c build problem
References: <4C08E25E.8000200@ericsson.com>
In-Reply-To: <4C08E25E.8000200@ericsson.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/04/2010 06:24 AM, kerstin jonsson wrote:
> Hi,
>
> I'm using:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>
> and building for ARCH=powerpc - mpc85xx_defconfig
>
> arch/powerpc/sysdev/fsl_rio.c will not build due to a missing
> MCSR_MASK bitmask definition.
>
> The attached patch is based on code found in
>
> git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git
>
> and - at the least - will fix the build problem.

Can we remove the use of MCSR_MASK from fsl_rio.c instead?  I don't see 
what it's accomplishing here.  MCSR_MASK will be wrong on e500mc, so 
exporting it as something that looks generic doesn't seem right.

MCSR_BUS_RBERR also needs to change on e500mc -- you'll probably get 
MCSR_LDG.

-Scott
