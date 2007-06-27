Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A8FAFDDF21
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 06:43:51 +1000 (EST)
In-Reply-To: <8fa84ed4810eb9aca18739bf709e71d9@kernel.crashing.org>
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
	<C84F154C-EBC9-471F-A1E1-635A385E684A@freescale.com>
	<8fa84ed4810eb9aca18739bf709e71d9@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <41E15EC0-D16E-4A9F-BCA8-1E126F6D95A7@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 09/15] [POWERPC] 86xx: Add uli1575 pci-bridge sector to
	MPC8641HPCN dts file.
Date: Wed, 27 Jun 2007 15:43:39 -0500
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 27, 2007, at 3:39 PM, Segher Boessenkool wrote:

>>> -		ranges = <0 f8000000 00100000>;
>>> -		reg = <f8000000 00100000>;	// CCSRBAR 1M
>>> +		ranges = <00001000 f8001000 000ff000
>> [...]
>>> +		reg = <f8000000 00001000>;	// CCSRBAR
>>
>> This can't be right, and I suspect it will break any kernel access to
>> the first 0x1000 bytes of the CCSR_BAR space.  reg should actually
>> describe the register space of the SOC.  If ranges needs to specify
>> that, too, they should be able to be redundant.  But this looks like
>> a big hack, to me.  Am I missing something?
>
> "reg" and "ranges" can never overlap really.
>
> Is this the special case where the PHB is visible in
> PCI configuration space?
>
> Or, please explain what CCSR_BAR is...

Its a 1M MMIO register space on the SOC (all device registers on the  
SOC live there).

- k
