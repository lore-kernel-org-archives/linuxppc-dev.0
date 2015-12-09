Return-Path: <andrew@lunn.ch>
Received: from vps0.lunn.ch (vps0.lunn.ch [178.209.37.122])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C9B791A0809
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Dec 2015 14:25:42 +1100 (AEDT)
Date: Wed, 9 Dec 2015 04:07:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] sbc8641: drop bogus PHY IRQ entries from DTS file
Message-ID: <20151209030729.GA2093@lunn.ch>
References: <1449614642-8161-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1449614642-8161-1-git-send-email-paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 08, 2015 at 05:44:02PM -0500, Paul Gortmaker wrote:
> This file was originally cloned off of the MPC8641D-HPCN reference
> platform, which actually had a PHY IRQ line connected.  However
> this board does not.  The bogus entry was largely inert and went
> undetected until commit 321beec5047af83db90c88114b7e664b156f49fe
> ("net: phy: Use interrupts when available in NOLINK state") was
> added to the tree.
> 
> With the above commit, the board fails to NFS boot since it sits
> waiting for a PHY IRQ event that of course never arrives.  Removing
> the bogus entries from the DTS file fixes the issue.

Hi Paul

Originally the interrupt is used for detecting the link has gone
down. That would of also been bogus before. Have you tried this?  If
that is also broken, maybe you need to add a fixes: tag so that it
gets back ported?

     Andrew
