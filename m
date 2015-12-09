Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5310E1A00A3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 01:40:04 +1100 (AEDT)
Date: Wed, 9 Dec 2015 09:39:51 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, <netdev@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] sbc8641: drop bogus PHY IRQ entries from DTS file
Message-ID: <20151209143951.GM22885@windriver.com>
References: <1449614642-8161-1-git-send-email-paul.gortmaker@windriver.com>
 <20151209030729.GA2093@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20151209030729.GA2093@lunn.ch>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Re: [PATCH] sbc8641: drop bogus PHY IRQ entries from DTS file] On 09/12/2015 (Wed 04:07) Andrew Lunn wrote:

> On Tue, Dec 08, 2015 at 05:44:02PM -0500, Paul Gortmaker wrote:
> > This file was originally cloned off of the MPC8641D-HPCN reference
> > platform, which actually had a PHY IRQ line connected.  However
> > this board does not.  The bogus entry was largely inert and went
> > undetected until commit 321beec5047af83db90c88114b7e664b156f49fe
> > ("net: phy: Use interrupts when available in NOLINK state") was
> > added to the tree.
> > 
> > With the above commit, the board fails to NFS boot since it sits
> > waiting for a PHY IRQ event that of course never arrives.  Removing
> > the bogus entries from the DTS file fixes the issue.
> 
> Hi Paul
> 
> Originally the interrupt is used for detecting the link has gone
> down. That would of also been bogus before. Have you tried this?  If

Haven't tried it, but chances are you are right.

> that is also broken, maybe you need to add a fixes: tag so that it
> gets back ported?

Nobody noticed in the past ~7 years or so, but I guess I can point Greg
at it once it is present in mainline.  The main reason I'd Cc'd netdev
is just to possibly save anyone else the investigation if they ran into
the same issue on a different board -which seems highly probable IMHO.

Paul.
--

> 
>      Andrew
