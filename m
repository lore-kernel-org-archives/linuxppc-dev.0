Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4F599DE348
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jun 2008 23:10:54 +1000 (EST)
Date: Thu, 5 Jun 2008 13:54:44 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: Linux 2.6.26-rc5 (G5 SATA broken)
Message-ID: <20080605135444.7a1e5158@core>
In-Reply-To: <Pine.LNX.4.64.0806051255340.28792@blonde.site>
References: <alpine.LFD.1.10.0806042018060.3473@woody.linux-foundation.org>
	<20080605112436.GA4533@aepfle.de>
	<Pine.LNX.4.64.0806051255340.28792@blonde.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Olaf Hering <olaf@aepfle.de>, Jeff Garzik <jeff@garzik.org>, Linus,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Linux, Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> And the patch I'm finding successful is below: I won't sign it off,
> for all I know it's reverting part of what Alan is trying to achieve;
> but I expect it'll help towards the right fix.

Its the right fix 

	ata_sff_check_altstatus() is a routine which does the altstatus
check and may or may not call the helper

	ata_sff_check_status() is a default method for ap->ops->

This lunatic naming leads to mistakes 8(
