Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7A180DDE3F
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 05:07:15 +1000 (EST)
In-Reply-To: <469E3E3F.8050302@freescale.com>
References: <20070718013302.GE15238@ld0162-tx32.am.freescale.net>
	<3F44085F-8A67-4134-95A3-39897F2A84FD@kernel.crashing.org>
	<469E3E3F.8050302@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <71A8ECC1-931F-42AE-98B1-A4B90E4B5980@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 06/61] 8xx: Don't call non-existent Soft_emulate_8xx from
	SoftwareEmulation.
Date: Wed, 18 Jul 2007 13:24:58 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 18, 2007, at 11:22 AM, Scott Wood wrote:

> Kumar Gala wrote:
>> On Jul 17, 2007, at 8:33 PM, Scott Wood wrote:
>>> On arch/ppc, Soft_emulate_8xx was used when full math emulation was
>>> turned off to emulate a minimal subset of floating point load/store
>>> instructions, to avoid needing a soft-float toolchain.  This  
>>> function
>>> is called, but not present, on arch/powerpc, causing a build error
>>> if floating point emulation is turned off.
>>>
>>> As soft-float toolchains are now common, I'm deleting the call  
>>> rather
>>> than moving Soft_emulate_8xx over to arch/powerpc.
>> We should move the Soft_emulate_8xx code over.  I see no reason  
>> to  break a usage model that existed in arch/ppc.
>
> According to the comment in softemu8xx.c, the only reason for it  
> was that "it was easier than trying to get the libraries compiled  
> for software floating point."  Given that soft-float toolchains are  
> easily had now, and that full emulation could be used if one really  
> needs to work with hard-float binaries, I don't really see the need  
> for this...
>
> If you want to move it over and test it, though, be my guest. :-)

I don't see any reason to break people that might not have updated  
their toolchains.  There is no reason for us to drop a feature like  
this w/o some additional warning.

I think its fine to just move the code over from arch/powerpc and  
than in the future we can deal with removing it in a more "proper"  
manor.

- k
