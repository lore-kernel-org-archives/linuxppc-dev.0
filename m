Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9D344DDE42
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 04:07:24 +1100 (EST)
Date: Wed, 14 Mar 2007 17:07:20 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 13/13] fix ps3fb glue allowing a modular build
Message-ID: <20070314170720.GL4095@ftp.linux.org.uk>
References: <E1HRPbU-0003Ha-Oq@ZenIV.linux.org.uk>
	<Pine.LNX.4.62.0703141040030.28462@pademelon.sonytel.be>
	<20070314160258.GK4095@ftp.linux.org.uk>
	<Pine.LNX.4.62.0703141715570.28462@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.62.0703141715570.28462@pademelon.sonytel.be>
Cc: linuxppc-dev@ozlabs.org, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 14, 2007 at 05:17:45PM +0100, Geert Uytterhoeven wrote:
> 	Hi Al,
> 
> On Wed, 14 Mar 2007, Al Viro wrote:
> > On Wed, Mar 14, 2007 at 10:50:16AM +0100, Geert Uytterhoeven wrote:
> > > On Wed, 14 Mar 2007, Al Viro wrote:
> > > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > 
> > > NAK
> > 
> > Lovely...  Consider that one withdrawn, please.  FWIW, if we leave it bool
> > (and flip_ctl mess alone would make a good reason for that) we probably want
> > to have it depend on FB=y
> 
> What's the advantage of making FB_PS3 depend on FB=y vs. plain FB?
> In both cases it can be enabled if FB=y only, right? Or am I missing something?

Nope.  How can kconfig distinguish that from a boolean option in modular
driver?  bool *can* depend on tristate and be selected when tristate is
set to m.
