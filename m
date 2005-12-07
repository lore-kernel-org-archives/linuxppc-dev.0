Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id AA41B6888E
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Dec 2005 04:35:57 +1100 (EST)
Date: Wed, 7 Dec 2005 09:35:54 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Wade Farnsworth <wfarnsworth@mvista.com>
Message-ID: <20051207173554.GA21578@gate.ebshome.net>
References: <1133968527.8299.50.camel@rhino.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1133968527.8299.50.camel@rhino.az.mvista.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Transmit timeouts on 440GX Ocotea on 10baseT-HD network
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Dec 07, 2005 at 08:15:28AM -0700, Wade Farnsworth wrote:
> Hi Eugene,
> 
> I'm seeing some "NETDEV WATCHDOG: eth0: transmit timed out" messages on
> the Ocotea when it's connected to a 10baseT hub, and it's put under
> heavy load.  I'm using the most current 2.6 git tree.
> 
> This can be reproduced by ssh'ing into the Ocotea and running the
> command "ping <host-machine> -A -s 1200", then also doing the same ping
> command from the host to the Ocotea.  The pings will be successful for a
> short time, then all transmits on the Ocotea will stop for a few seconds
> (usually preceded by a few duplicate packets).  Transmits begin again
> once the timeout occurs. /proc/net/dev doesn't report any errors, just a
> few dropped packets.
> 
> Do you know what might be causing the EMAC to stop transmitting in this
> situation?

Hmm, I think this should have been fixed in the latest 2.6. Check 
that you tree has this patch:

	[PATCH] ibm_emac: fix graceful stop timeout handling

It went in on 01 Dec. Although this fix assumed FDX operation for 
timeouts, without collisions. Maybe I was too optimistic thinking that 
nobody uses 10/HDX :).

Try making STOP_TIMEOUT_10 bigger, say twice as big.

If this doesn't help, I'll send you patch with enables some additional 
debugging, so I can check that stop you are experiencing is the same 
problem I had last month.

-- 
Eugene
