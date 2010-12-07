Return-Path: <mason@postdiluvian.org>
Received: from porklips.postdiluvian.org (postdiluvian.org [128.30.54.21])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E785FB7043
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  8 Dec 2010 05:23:21 +1100 (EST)
Date: Tue, 7 Dec 2010 13:23:17 -0500
From: Mark Mason <mason@postdiluvian.org>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: MPC831x (and others?) NAND erase performance improvements
Message-ID: <20101207182317.GA23155@postdiluvian.org>
References: <20101207031554.GA12731@postdiluvian.org>
	<AE90C24D6B3A694183C094C60CF0A2F6D8ABEB@saturn3.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8ABEB@saturn3.aculab.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Laight <David.Laight@ACULAB.COM> wrote:

> > The problem cropped up when there was a lot of traffic to the NAND
> > (Samsung K9WAGU08U1B-PIB0), with the NAND being on the LBC along with
> > a video chip that needed constant and prompt attention.
> > 
> > What I would see is that, as the writes happened, the erases would
> > wind up batched and issued all at once, such that frequently 400-700
> > erases were issued in rapid succession with a 1ms LBC BUSY cycle per
> > erase.
> 
> Are those just the reads of the status register polling to
> determine when the sector erase has completed ?

No, it's not, since it isn't polling the status register.  It's using
a hardware line from the NAND to indicate that the NAND is busy.  That
one hardware line is shared between all devices on the bus, so if one
device says it's busy then all bus traffic stops until the NAND
deasserts the busy line.
