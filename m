Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3C0BEDE009
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 05:15:23 +1000 (EST)
Message-ID: <470A81BC.5020203@freescale.com>
Date: Mon, 08 Oct 2007 14:15:08 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC][PATCH] Move TASK_SIZE to 0xc0000000 for ppc32
References: <Pine.LNX.4.64.0710081242280.10079@blarg.am.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0710081242280.10079@blarg.am.freescale.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Pantelis Antoniou <panto@intracom.gr>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> Guys,
> 
> Here's a cut at a patch that cleans up the TASK_SIZE issue.  We now have
> TASK_SIZE @ 0xc0000000 for everything except PREP and use PAGE_OFFSET in
> SW TLB handlers.  I'm assuming 8xx will get a cleanup patch from
> PAGE_OFFSET testing (Dan :).

I'd rather this patch exclude 8xx along with PReP for now; the 8xx TLB 
handlers could be made to accept arbitrary task sizes, but not without 
slightly slowing them down (not that they're currently optimal -- IIUC, 
using the hardware tablewalk assist is expensive due to serialization on 
mtspr, and it doesn't really do anything that rlwimi can't do).  I'm not 
sure it's worth it -- does anyone really need more than 2GB userspace on 
an 8xx?

At the very least, we should have the 8xx patch in place before turning 
it on.

-Scott
