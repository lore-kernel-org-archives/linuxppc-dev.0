Return-Path: <SRS0+9bc0dae761e93ec26ee7+1234+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AD0B5DDDF0
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jan 2007 18:03:09 +1100 (EST)
Subject: Re: 2.6.20-rc4 Kernel Oops on Maple
From: David Woodhouse <dwmw2@infradead.org>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20070108210417.GA8122@localdomain>
References: <1168289034.2610.214.camel@darkside.terraplex.com>
	<20070108210417.GA8122@localdomain>
Content-Type: text/plain
Date: Tue, 09 Jan 2007 15:03:15 +0800
Message-Id: <1168326195.14763.312.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-01-08 at 15:04 -0600, Nathan Lynch wrote:
> Owen Stampflee wrote:
> > I'm seeing both a sig 5 and a sig 11 in two backtraces during boot on a
> > Maple-based board... both vanilla 2.6.17.13 and 2.6.18.1 work fine on
> > this board.
> > 
> > Anyone have any ideas on what got broken?

> http://patchwork.ozlabs.org/linuxppc/patch?id=8840

... which triggers a WARN_ON() which is _supposed_ to be otherwise
harmless. Unfortunately due to another bug in BUG() handling, the
warning actually kills the machine instead of just bitching a bit:
http://patchwork.ozlabs.org/linuxppc/patch?id=8811
 
-- 
dwmw2
