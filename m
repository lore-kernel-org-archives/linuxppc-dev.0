Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by bilbo.ozlabs.org (Postfix) with ESMTP id C00D8B6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 19 Jul 2009 04:37:02 +1000 (EST)
Date: Sat, 18 Jul 2009 22:04:48 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 0/4] net: Revive fixed link support
Message-ID: <20090718180448.GA3252@oksana.dev.rtsoft.ru>
References: <20090717065220.15652.93331.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090717065220.15652.93331.stgit@localhost.localdomain>
Cc: leoli@freescale.com, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	afleming@freescale.com, davem@davemloft.net
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 17, 2009 at 01:31:25AM -0600, Grant Likely wrote:
[...]
> Part of the problem I think is that the phylib code merges two separate
> constructs; the construct of an MDIO bus (on which many device may
> reside, not all of them PHYs), and the construct of an MII link whose
> speed and configuration need to be manipulated.  I've run into problems
> myself on how best to handle things like Ethernet switches which
> definitely do not behave like PHYs and the phylib state machine cannot
> be used on them.  It seems to me that the whole 'dummy phy' approach
> is just an artifact of the phylib model not being quite right yet.

Yep. With a bit of phylib rework we can remove all the MDIO emulation
stuff from phy/fixed.c driver, and leave there just speed/duplex/pause
assignments.

Though, I still believe that we should avoid two code paths in the
drivers. One of the code paths will be constantly broken if we do so.

> I
> want to investigate the possibility of separating the two concepts, but
> that will require a fair bit of thought and experimentation.

That would be great indeed.

[...]
> Anton, once again I don't have hardware to test this, so I rely on you
> to tell be if I screwed it up.  It has been compile tested.

Works fine here, thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
