Date: Sat, 23 Jun 2001 06:20:48 -0700
From: Matt Porter <mporter@mvista.com>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-commit@fsmlabs.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: patch for SBS K2: don't initialise the L2 cache
Message-ID: <20010623062048.A4239@cx258813-a.chnd1.az.home.com>
References: <0106210201.AA22756@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0106210201.AA22756@ivan.Harhan.ORG>; from msokolov@ivan.Harhan.ORG on Wed, Jun 20, 2001 at 07:01:01PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jun 20, 2001 at 07:01:01PM -0700, Michael Sokolov wrote:
> Hi there,
>
> Below is a patch to linuxppc_2_4_devel for the SBS K2 board. The current
> linuxppc_2_4_devel when booting on the K2 does its own L2 cache initialisation.
> This is no good. L2 cache initialisation should be left to the board firmware.
> The way the current linuxppc_2_4_devel sets up the L2 cache on the K2 works for
> a really ancient K2 we've had laying in the office since before the Flood (it
> was on that board that I reported success with linuxppc_2_4_devel earlier), but
> it blows up on all K2s of any recency (since April of last year I think). It
> certainly doesn't work on the K2s that are being shipped now (rev J), as SBS
> has changed (corrected) the L2 cache hardware on the new K2 revisions.

The only firmware available to date for an SBS K2 is PMON.  PMON does not
configure the L2 cache.  Older rev boards used a differential clock.  I've
finally received the new docs, so I'm updating the port to read the
single-ended/differential l2clk onboard register so it sets the L2CR
accordingly.  If docs were provided as they were updated with this new
feature, then the port would have been working.

When a firmware release is made available that properly sets up the L2CR
then I'll be happy to remove the L2CR setup code, not before.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
