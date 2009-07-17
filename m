Return-Path: <glikely@secretlab.ca>
Received: from mail-px0-f181.google.com (mail-px0-f181.google.com
	[209.85.216.181])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 2E69AB806F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jul 2009 17:31:50 +1000 (EST)
Received: by mail-px0-f181.google.com with SMTP id 11so451959pxi.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jul 2009 00:31:50 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v2 0/4] net: Revive fixed link support
To: avorontsov@ru.mvista.com, davem@davemloft.net, afleming@freescale.com,
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 17 Jul 2009 01:31:25 -0600
Message-ID: <20090717065220.15652.93331.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: leoli@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series is based on the "Net: Revive fixed link support" series
posted by Anton Vorontsov on June 26.

On June 26, Anton Vorontsov wrote:
> The fixed link support is broken since The Big OF MDIO Rework,
> the rework simply removed most of the code that was needed for
> fixed links.
> 
> Too bad I didn't notice this earlier, I saw a bunch of patches
> on the ml, but unfortunately I didn't look very close presuming
> that Grant knew what he was doing. :-) And obviously I didn't
> test linux-next on anything that requires a fixed link.
> 
> Anyway, here are four patches. The first one adds the fixed link
> support to a framework, otherwise we'd duplicate the code across
> the drivers (as we did previously), and I tried to keep drivers'
> changes minimal.

I took issue with the approach on the basis of
a) I find the whole dummy phy approach to be a hack and an abuse of the
   mdio bus,
b) Handling the lack of a phy is trivial and should just be done within
   the MAC driver itself, and
c) the approach caused all drivers using of_phy_connect() to parse the
   'fixed-link' property, when only three drivers actually define and
   use it.

I wrote and posted a competing patch which removed the usage of a dummy
phy and made each driver handle the lack of a phy gracefully.  However,
Anton rightly pointed out that my patch still leaves the regression of
userspace no longer being able to use ethtool to query the link speed
because the affected drivers all depend on phylib for the ethtool
ioctl implementations.

Part of the problem I think is that the phylib code merges two separate
constructs; the construct of an MDIO bus (on which many device may
reside, not all of them PHYs), and the construct of an MII link whose
speed and configuration need to be manipulated.  I've run into problems
myself on how best to handle things like Ethernet switches which
definitely do not behave like PHYs and the phylib state machine cannot
be used on them.  It seems to me that the whole 'dummy phy' approach
is just an artifact of the phylib model not being quite right yet. I
want to investigate the possibility of separating the two concepts, but
that will require a fair bit of thought and experimentation.

Right now this is a regression situation during the 2.6.31
stabilization, so I don't think it is appropriate to write a new set
of ioctl handlers at this late stage when there is another solution.
I've reworked Anton's patches to constrain the effects to just the
three drivers which use 'fixed-link'.

It kills me to leave the dummy phy approach in place, but the
alternative is to invasive and risky to apply at this stage.
It irks me to say so, but I think Anton's approach of reenabling
the dummy phy is the right think to do,

Anton, once again I don't have hardware to test this, so I rely on you
to tell be if I screwed it up.  It has been compile tested.

Cheers,
g.


--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
