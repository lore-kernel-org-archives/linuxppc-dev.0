Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DAFD1DDECC
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 02:22:30 +1000 (EST)
Message-ID: <469E3E3F.8050302@freescale.com>
Date: Wed, 18 Jul 2007 11:22:23 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 06/61] 8xx: Don't call non-existent Soft_emulate_8xx from
	SoftwareEmulation.
References: <20070718013302.GE15238@ld0162-tx32.am.freescale.net>
	<3F44085F-8A67-4134-95A3-39897F2A84FD@kernel.crashing.org>
In-Reply-To: <3F44085F-8A67-4134-95A3-39897F2A84FD@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Jul 17, 2007, at 8:33 PM, Scott Wood wrote:
> 
>> On arch/ppc, Soft_emulate_8xx was used when full math emulation was
>> turned off to emulate a minimal subset of floating point load/store
>> instructions, to avoid needing a soft-float toolchain.  This function
>> is called, but not present, on arch/powerpc, causing a build error
>> if floating point emulation is turned off.
>>
>> As soft-float toolchains are now common, I'm deleting the call rather
>> than moving Soft_emulate_8xx over to arch/powerpc.
> 
> 
> We should move the Soft_emulate_8xx code over.  I see no reason to  
> break a usage model that existed in arch/ppc.

According to the comment in softemu8xx.c, the only reason for it was 
that "it was easier than trying to get the libraries compiled for 
software floating point."  Given that soft-float toolchains are easily 
had now, and that full emulation could be used if one really needs to 
work with hard-float binaries, I don't really see the need for this...

If you want to move it over and test it, though, be my guest. :-)

-Scott
