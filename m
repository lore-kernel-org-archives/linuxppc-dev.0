Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1AB01DDF16
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 17:04:44 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	lBE64dPl025659
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 23:04:39 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lBE64b3F011812
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 00:04:38 -0600 (CST)
Subject: Re: [PATCH] Fix rounding bug in emulation for double floatoperating
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <BB2AC24A-6336-4270-9124-734BCC09F7DA@kernel.crashing.org>
References: <11972628522442-git-send-email-b13201@freescale.com>
	<20071210045616.GC29611@localhost.localdomain>
	<6EBEC19BF4A8F843BCD6B9155BBE2515C79D0D@zch01exm26.fsl.freescale.net>
	<AD0028E8-E305-443F-8872-C935D4E18F80@kernel.crashing.org>
	<1197343143.13519.2.camel@localhost.localdomain>
	<A069B515-C07A-4471-9473-7A7E29F12685@kernel.crashing.org>
	<1197448223.29372.12.camel@localhost.localdomain>
	<BB2AC24A-6336-4270-9124-734BCC09F7DA@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1197612373.10259.9.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 14 Dec 2007 14:06:14 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Liu Yu <B13201@freescale.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-12-14 at 13:46, Kumar Gala wrote:
> >> When I run this on a G5 (w/HW FP) I get:
> >>
> >> dmul 3fe0000000000000 * 1 = 0 expected 0 (PASS)
> >> dmul bfe0000000000000 * 1 = 8000000000000000 expected 0 (PASS)
> >> dmul 8000000000000001 * bfe0000000000000 = 0 expected 0 (PASS)
> >>
> >> ddiv 1 / 4000000000000000 = 0 expected 0 (PASS)
> >>
> >> and on the 85xx w/FP emu:
> >>
> >> dmul 3fe0000000000000 * 1 = 0 expected 0 (PASS)
> >> dmul bfe0000000000000 * 1 = 8000000000000000 expected 0 (PASS)
> >> dmul 8000000000000001 * bfe0000000000000 = 0 expected 0 (PASS)
> >>
> >> ddiv 1 / 4000000000000000 = 0 expected 0 (PASS)
> >>
> >> Maybe I'm missing where the error is.
> > I am missing ...
> > It is supposed to run based on previous IEEE 754 patch.
> > http://ozlabs.org/pipermail/linuxppc-dev/2007-February/031351.html
> 
> I'd really like to see to see a testcase show the issue with "classic 
> FP emu" on a 85xx system.
I can understand. 
You know, For a 85xx system without the previous patch or other
'classic' powerpc, it is hard to trigger this issue. Although I believe
it is a problem fixed up.
Do you have any idea?
Roy
