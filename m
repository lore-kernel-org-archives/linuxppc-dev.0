Return-Path: <glikely@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.195])
	by ozlabs.org (Postfix) with ESMTP id A0A5668110
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Aug 2005 07:39:00 +1000 (EST)
Received: by rproxy.gmail.com with SMTP id a36so250123rnf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Aug 2005 14:38:59 -0700 (PDT)
Date: Wed, 24 Aug 2005 15:35:21 -0600
To: Tom Rini <trini@kernel.crashing.org>
Message-ID: <20050824213521.GA5397@siegfried.thelikelysolution.ca>
References: <20050823224702.GA3864@siegfried.thelikelysolution.ca>
	<20050824183520.GC15735@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050824183520.GC15735@smtp.west.cox.net>
From: Grant Likely <glikely@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
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

On Wed, Aug 24, 2005 at 11:35:20AM -0700, Tom Rini wrote:
> On Tue, Aug 23, 2005 at 04:47:02PM -0600, Grant Likely wrote:
> 
> > [PATCH] Allow ns16550.c to get base baud from rs_table instead of BAUD_BASE
> > 
> > REPOST: fixed formating problems in original patch
> > 
> > Modifies serial_init to get base baud rate from the rs_table entry instead
> > of BAUD_BASE.  Will default back to BAUD_BASE if base_baud is not set.
> > 
> > This patch eliminates duplication between the SERIAL_PORT_DFNS macro and
> > BAUD_BASE.  Without the patch, if a port set the baud rate in
> > SERIAL_PORT_DFNS, but did not update BASE_BAUD, the BASE_BAUD value
> > would still be used.
> > 
> > Rather; serial_init() should look first in SERIAL_PORT_DFNS and use
> > BASE_BAUD as a backup.
> > 
> > Signed-off-by: Grant Likely <grant.likely@gdcanada.com>
> 
> With everything in-tree, this is fine as baud_base is always set to
> BASE_BAUD, but I'm wondering why this was done.  Did you do a port and
> not follow on this?  It looks like today you could get away without
> defining BASE_BAUD correctly (8250_early uses and needs this to be
> correct, but I don't think this is frequently used, yet).  But I'm not
> sure what we gain here.  Thanks.
I stumbled across this while working on moving v2pro to the platform
bus.  (I'm also trying to isolate xparameter.h as much as possible to
avoid recompiling the world everytime I get a new bitstream).  I've got
the base baud for each port in the rs_table.

IMHO it doesn't seem right to have part of the serial parameters pulled
from rs_table and the base baud pulled from elseware.  ie. it looked
like a latent bug to me, so I wrote the patch.  I've also got the
impression that the serial subsystem is trying to move away from
depending on BASE_BAUD

Cheers,
g.
