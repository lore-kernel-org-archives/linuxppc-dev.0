Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao11.cox.net (fed1rmmtao11.cox.net [68.230.241.28])
	by ozlabs.org (Postfix) with ESMTP id 9491A67A6D
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Mar 2005 03:29:21 +1100 (EST)
Date: Wed, 2 Mar 2005 09:29:18 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
Message-ID: <20050302092918.A30946@cox.net>
References: <20050218101245.D11439@cox.net> <4216FD64.9020509@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4216FD64.9020509@pobox.com>;
	from jgarzik@pobox.com on Sat, Feb 19, 2005 at 03:48:36AM -0500
Cc: netdev@oss.sgi.com, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] emac: filter illegal frame sizes
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, Feb 19, 2005 at 03:48:36AM -0500, Jeff Garzik wrote:
> Matt Porter wrote:
> > Fix to drop frames that are too large for the current MTU.
> 
> What is this fixing?
> 
> You should be passing all frames up to the software stack.

I was originally fixing the issue where the driver was only allocating
rx buffers big enough for the configured MTU and got a bit
overzealous. I pulled out the filtering hunks so we always allocate
skbs large enough to handle a full size jumbo frame and pass everything
up to the stack...new patch to follow.

-Matt
