Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9B4DCDDDF4
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 23:11:49 +1100 (EST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IzslO-0005mc-Ml
	for linuxppc-dev@ozlabs.org; Wed, 05 Dec 2007 11:50:02 +0000
Received: from artipc9.vub.ac.be ([134.184.26.59])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Wed, 05 Dec 2007 11:50:02 +0000
Received: from fhimpe by artipc9.vub.ac.be with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Wed, 05 Dec 2007 11:50:02 +0000
To: linuxppc-dev@ozlabs.org
From: Frederik Himpe <fhimpe@telenet.be>
Subject: Re: [PATCH v2] Fix hardware IRQ time accounting problem.
Date: Wed, 5 Dec 2007 11:39:25 +0000 (UTC)
Message-ID: <fj62ld$6eo$1@ger.gmane.org>
References: <20071204055144.GR24243@bakeyournoodle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: news <news@ger.gmane.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 04 Dec 2007 16:51:44 +1100, Tony Breeds wrote:

> The commit fa13a5a1f25f671d084d8884be96fc48d9b68275 (sched: restore
> deterministic CPU accounting on powerpc), unconditionally calls
> update_process_tick() in system context.  In the deterministic
> accounting case this is the correct thing to do.  However, in the
> non-deterministic accounting case we need to not do this, and results in
> the time accounted as hardware irq time being artificially elevated.
> 
> Also this patch collapses 2 consecutive '#ifdef
> CONFIG_VIRT_CPU_ACCOUNTING' checks in time.h into one for neatness.

I can confirm this patch fixed the problem for me. Thank you!

-- 
Frederik Himpe
