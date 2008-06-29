Return-Path: <glikely@secretlab.ca>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.224])
	by ozlabs.org (Postfix) with ESMTP id D6904DDF1D
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Jun 2008 15:52:52 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id d8so2683793qbc.37
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 22:52:51 -0700 (PDT)
Date: Sat, 28 Jun 2008 23:52:48 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: John Linn <John.Linn@xilinx.com>
Subject: Re: [PATCH] [RFC] powerpc: Xilinx: adding virtex5 powerpc 440 support
Message-ID: <20080629055248.GH13876@secretlab.ca>
References: <20080623213556.3378316a@zod.rchland.ibm.com>
	<20080624210750.A21E314006F@mail88-wa4.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080624210750.A21E314006F@mail88-wa4.bigfish.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 24, 2008 at 03:07:48PM -0600, John Linn wrote:
> Hi Grant,
> 
> It appears that you designed the simpleImage around Xilinx FPGAs.

Yes.

> Since we have to initialize the 16550 UART in the bootstrap and there's
> no boot loader, were you thinking we would add the 16550 initialization
> to simpleboot.c?

Yes; or at least break out the common routine to be called by all
simpleImage targets and have a virtex-specific 'frontend' to it called
simpleboot-virtex405.c.

> 
> Why do we want a flat binary rather than an elf file for the target?

'Cause a flat binary can be loaded anywhere in RAM and is smaller than
an ELF image (no headers).

g.
