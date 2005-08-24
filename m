Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao02.cox.net (fed1rmmtao02.cox.net [68.230.241.37])
	by ozlabs.org (Postfix) with ESMTP id 53A9E680A7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Aug 2005 04:35:22 +1000 (EST)
Received: from opus ([68.107.143.141]) by fed1rmmtao02.cox.net
	(InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
	id <20050824183521.XZRZ3209.fed1rmmtao02.cox.net@opus>
	for <linuxppc-embedded@ozlabs.org>; Wed, 24 Aug 2005 14:35:21 -0400
Date: Wed, 24 Aug 2005 11:35:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Message-ID: <20050824183520.GC15735@smtp.west.cox.net>
References: <20050823224702.GA3864@siegfried.thelikelysolution.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050823224702.GA3864@siegfried.thelikelysolution.ca>
Subject: Re: [PATCH] Allow ns16550.c to get base baud from rs_table instead
	of BAUD_BASE
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Aug 23, 2005 at 04:47:02PM -0600, Grant Likely wrote:

> [PATCH] Allow ns16550.c to get base baud from rs_table instead of BAUD_BASE
> 
> REPOST: fixed formating problems in original patch
> 
> Modifies serial_init to get base baud rate from the rs_table entry instead
> of BAUD_BASE.  Will default back to BAUD_BASE if base_baud is not set.
> 
> This patch eliminates duplication between the SERIAL_PORT_DFNS macro and
> BAUD_BASE.  Without the patch, if a port set the baud rate in
> SERIAL_PORT_DFNS, but did not update BASE_BAUD, the BASE_BAUD value
> would still be used.
> 
> Rather; serial_init() should look first in SERIAL_PORT_DFNS and use
> BASE_BAUD as a backup.
> 
> Signed-off-by: Grant Likely <grant.likely@gdcanada.com>

With everything in-tree, this is fine as baud_base is always set to
BASE_BAUD, but I'm wondering why this was done.  Did you do a port and
not follow on this?  It looks like today you could get away without
defining BASE_BAUD correctly (8250_early uses and needs this to be
correct, but I don't think this is frequently used, yet).  But I'm not
sure what we gain here.  Thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
