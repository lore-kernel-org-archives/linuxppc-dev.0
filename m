Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 39C6CDE128
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 07:14:15 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9BLECdA003850
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 17:14:12 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9BLECol545288
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 17:14:12 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9BLE2JV030307
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 17:14:02 -0400
Subject: Re: [PATCH 4/4 v2] [POWERPC] Kilauea defconfig file
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20071011201232.GD4247@loki.buserror.net>
References: <200710111408.34207.sr@denx.de>
	<1192107771.5534.120.camel@localhost.localdomain>
	<200710111531.13022.sr@denx.de>
	<20071011201232.GD4247@loki.buserror.net>
Content-Type: text/plain
Date: Thu, 11 Oct 2007 16:13:39 -0500
Message-Id: <1192137219.3061.2.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-10-11 at 15:12 -0500, Scott Wood wrote:
> On Thu, Oct 11, 2007 at 03:31:12PM +0200, Stefan Roese wrote:
> > Yes, good catch. Since I'm not using the bootwrapper, I should be able to get 
> > rid of WANT_DEVICE_TREE too. But it seems to be autoselected in 
> > arch/powerpc/platforms/Kconfig.cputype for 40x and most other "embedded" 
> > CPU's. Any idea why this is the case?
> 
> Probably copying from 83xx, 85xx, etc, which set it on the entire CPU family
> because there's a wrapper platform that covers the entire family.  AFAICT,
> there are only board wrappers for 4xx, so individual boards should be
> selecting WANT_DEVICE_TREE.

Probably.  Seems somewhat redundant at this point to move it into the
individual board options though.

> In any case, you can just set DEVICE_TREE to an empty string if you only
> want the regular uImage.

Well, he wants the raw uImage, and a separate DTB to be spit out as far
as I can tell.  So we don't want an empty string here, but what's there
currently doesn't do the latter part either.

josh
