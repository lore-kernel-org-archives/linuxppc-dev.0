Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.175])
	by ozlabs.org (Postfix) with ESMTP id E2789DE961
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 04:53:28 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so1800667wfg.15
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jun 2008 11:53:26 -0700 (PDT)
Date: Mon, 30 Jun 2008 12:53:17 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] powerpc: Xilinx: PS2: Added new XPS PS2 driver
Message-ID: <20080630185317.GB19249@secretlab.ca>
References: <20080630142451.516A41D1006C@mail57-sin.bigfish.com>
	<20080630171628.GF17916@secretlab.ca>
	<20080630135531.ZZRA012@mailhub.coreip.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080630135531.ZZRA012@mailhub.coreip.homeip.net>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, linux-input@vger.kernel.org,
	John Linn <john.linn@xilinx.com>, Sadanand <sadanan@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 30, 2008 at 02:10:23PM -0400, Dmitry Torokhov wrote:
> Hi Grant, John,
> 
> On Mon, Jun 30, 2008 at 11:16:28AM -0600, Grant Likely wrote:
> > On Mon, Jun 30, 2008 at 07:24:48AM -0700, John Linn wrote:
<snip>
> > > +/*
> > > + * sxps2_write() sends a byte out through the PS/2 interface.
> > > + *
> > > + * The sole purpose of drvdata->tx_end is to prevent the driver
> > > + * from locking up in the do {} while; loop when nothing is connected
> > > + * to the given PS/2 port. That's why we do not try to recover
> > > + * from the transmission failure.
> > > + * drvdata->tx_end needs not to be initialized to some "far in the
> > > + * future" value, as the very first attempt to xps2_send() a byte
> > > + * is always successful, and drvdata->tx_end will be set to a proper
> > > + * value at that moment - before the 1st use in the comparison.
> > > + */
> > 
> > Good comment block.
> > 
> > nitpick: can you reformat the comment blocks to be in kerneldoc format?
> > That will allow the automatic document generation tools to parse it.
> > 
> > see: Documentation/kernel-doc-nano-HOWTO.txt
> 
> This is an internal function so its not going to be exposed in
> kerneldoc though.

Just to complete this discussion, quoting from kernel-doc-nano-HOWTO.txt:

  "We also recommend providing kernel-doc formatted documentation
  for private (file "static") routines, for consistency of kernel
  source code layout.  But this is lower priority and at the
  discretion of the MAINTAINER of that kernel source file."

but it's just a nitpick, and I'll say nothing more about it.

g.
