Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.169])
	by ozlabs.org (Postfix) with ESMTP id 71B9FDE00B
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 02:34:33 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so1750522wfg.15
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jun 2008 09:34:32 -0700 (PDT)
Date: Mon, 30 Jun 2008 10:34:29 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH] [POWERPC] Xilinx: add compatibility for 'simple-bus'.
Message-ID: <20080630163429.GE17916@secretlab.ca>
References: <fa686aa40806281333i5ae1833fg561622640b5d3a4e@mail.gmail.com>
	<20080630034548.A10A81750069@mail131-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080630034548.A10A81750069@mail131-sin.bigfish.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, git <git@xilinx.com>, dwg@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Neuendorffer wrote:
> Grant Likely wrote:
> > > I think the easiest solution is to change the Kconfig so that
> > > PPC_UDBG_16550 is only selected based on !XILINX_VIRTEX.  I've done this
> > > in my tree, but I've been swamped with other things at the moment, so I
> > > haven't verified it.
> > 
> > This is an easy solution, but it is not a good one.  Doing so would
> > break UDBG on other 405 boards when building multiplatform kernels.
> > It would be better to teach legacy serial about the shift and offset.
> > Alternately, add code to add_legacy_soc_port() to skip it if the
> > shift/offset properties are present.
> 
> Is there really much of a chance of that, given the differences
> with the bootwrappers?  Does anyone care enough about legacy_serial
> for this to matter?   My impression was that legacy serial was not
> preferred anyway...

You never know, a single kernel build can be wrapped multiple times, and
besides, it is a trivial fix.  Just add a test for the presence of
reg-shift and bail if it is present.

I don't know much about the history of legacy serial, but I do not
support adding multiplatform restrictions when not needed.
legacy_serial may be crusty, but it does have the advantage of
supporting UDBG which is a useful feature.  It may or may not go away.

Cheers,
g.
