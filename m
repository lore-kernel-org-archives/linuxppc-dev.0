Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B3E91DDF66
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 05:57:46 +1000 (EST)
In-Reply-To: <11829070192461-git-send-email-galak@kernel.crashing.org>
References: <11829070051484-git-send-email-galak@kernel.crashing.org>
	<11829070063989-git-send-email-galak@kernel.crashing.org>
	<11829070073637-git-send-email-galak@kernel.crashing.org>
	<11829070091056-git-send-email-galak@kernel.crashing.org>
	<11829070102887-git-send-email-galak@kernel.crashing.org>
	<11829070111239-git-send-email-galak@kernel.crashing.org>
	<1182907013252-git-send-email-galak@kernel.crashing.org>
	<1182907014549-git-send-email-galak@kernel.crashing.org>
	<1182907015126-git-send-email-galak@kernel.crashing.org>
	<11829070192461-git-send-email-galak@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C84F154C-EBC9-471F-A1E1-635A385E684A@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH 09/15] [POWERPC] 86xx: Add uli1575 pci-bridge sector to
	MPC8641HPCN dts file.
Date: Wed, 27 Jun 2007 14:57:34 -0500
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 26, 2007, at 20:16, Kumar Gala wrote:

> From: Wade Farnsworth <wfarnsworth@mvista.com>
>
> This adds device nodes for the PCI bridges as well as the ISA  
> devices on
> the newer revision MPC8641HPCN.  It also adds the PCI ranges to the  
> soc
> node so that address translation for the ISA devices works properly.

>
> -		ranges = <0 f8000000 00100000>;
> -		reg = <f8000000 00100000>;	// CCSRBAR 1M
> +		ranges = <00001000 f8001000 000ff000
[...]
> +		reg = <f8000000 00001000>;	// CCSRBAR


This can't be right, and I suspect it will break any kernel access to  
the first 0x1000 bytes of the CCSR_BAR space.  reg should actually  
describe the register space of the SOC.  If ranges needs to specify  
that, too, they should be able to be redundant.  But this looks like  
a big hack, to me.  Am I missing something?


Andy
