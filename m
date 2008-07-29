Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 90B71DE21E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jul 2008 05:39:24 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m6TJd3D8007458 for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Jul 2008 12:39:03 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m6TJd2VI010233
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Jul 2008 14:39:02 -0500 (CDT)
Date: Tue, 29 Jul 2008 14:39:01 -0500
From: Scott Wood <scottwood@freescale.com>
To: Matvejchikov Ilya <matvejchikov@gmail.com>
Subject: Re: No output from SMC1 console with the 2.6.26 kernel (8xx based
	board)
Message-ID: <20080729193901.GC8051@ld0162-tx32.am.freescale.net>
References: <8496f91a0807281243y2193dad5hc758444fe0a10258@mail.gmail.com>
	<488E2510.7070209@freescale.com>
	<8496f91a0807282310r5e70fe01v85b2ff2da7a80416@mail.gmail.com>
	<488F385B.9030504@nanometrics.ca>
	<8496f91a0807291136v172b3b16t170088faf3f30b5b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8496f91a0807291136v172b3b16t170088faf3f30b5b@mail.gmail.com>
Cc: Ben Gardiner <BenGardiner@nanometrics.ca>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Jul 29, 2008 at 10:36:30PM +0400, Matvejchikov Ilya wrote:
> Have you tired to run 2.6.25 kernel? With 2.6.25.4 my console works
> fine! I suspect there is something like a regression....

Did you use CONFIG_PPC_CPM_NEW_BINDING in 2.6.25?  It became mandatory in
2.6.26.  Also, try commenting out cpm_setbrg() calls in case the
frequency is not being set properly.

2.6.26 introduced the allocation of the CPM2 SMC parameter RAM area; what
did your device node look like in 2.6.25?  What happens if you use that
device tree with 2.6.26?

-Scott
