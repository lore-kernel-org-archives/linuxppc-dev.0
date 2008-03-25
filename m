Return-Path: <Haiying.Wang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5EBADDE1CA
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 03:35:30 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m2PGYvLU005598
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 09:35:27 -0700 (MST)
Received: from az33exm23.fsl.freescale.net (az33exm23.am.freescale.net
	[10.64.32.8])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m2PGYv1M026721
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 11:34:57 -0500 (CDT)
Subject: Re: how to use head_fsl_booke.S:abort to restart
From: Haiying Wang <Haiying.Wang@freescale.com>
To: Philippe De Muyter <phdm@macqel.be>
In-Reply-To: <20080325161513.GB15991@frolo.macqel>
References: <20080325161513.GB15991@frolo.macqel>
Content-Type: text/plain
Date: Tue, 25 Mar 2008 12:34:55 -0400
Message-Id: <1206462895.2960.10.camel@r54964-12.am.freescale.net>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

8540 doesn't have RSTCR register. You should not use fsl_rstcr_restart
for reboot your 8540 board.

Haiying

On Tue, 2008-03-25 at 17:15 +0100, Philippe De Muyter wrote:
> Hi all,
> 
> I have a mpc8540 board that could reboot when driven by a ARCH=ppc linux,
> but that hangs now in arch/powerpc/sysdev/fsl_soc.c:fsl_rstcr_restart when
> asked to reboot with a ARCH=powerpc linux.
> 
> I have found that if I call arch/powerpc/kernel/head_fsl_booke.S:abort from
> there, my board reboots correctly, but I feel that's not the right place
> to put that call.  Where/how should I do that ?
> 
> Philippe
> 
> PS : Does arch/powerpc/sysdev/fsl_soc.c:fsl_rstcr_restart actually work
> for mpc8540_ads boards ?
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
