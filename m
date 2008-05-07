Return-Path: <SRS0+9d6426c59dd8b4fa22d3+1718+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EED5BDDE21
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 20:54:00 +1000 (EST)
Subject: Re: jffs2 and unaligned access
From: David Woodhouse <dwmw2@infradead.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
In-Reply-To: <20080507102724.GE4326@pengutronix.de>
References: <20080507102724.GE4326@pengutronix.de>
Content-Type: text/plain
Date: Wed, 07 May 2008 11:53:49 +0100
Message-Id: <1210157630.25560.884.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-05-07 at 12:27 +0200, Sascha Hauer wrote:
> memcpy_from/to_io() use word aligned accesses on the io side of memory.
> The MPC5200 local plus bus where our flashes are connected does not
> allow unaligned accesses, so we have to use the io versions of memcpy.

But this region of flash is marked as suitable for execute-in-place,
otherwise the point() function wouldn't be working to give a direct
pointer to it. It sounds like we shouldn't be allowing that.

Which in turn means that perhaps we should have a property in the
corresponding node in the device-tree which indicates that it's not
suitable for direct access?

-- 
dwmw2
