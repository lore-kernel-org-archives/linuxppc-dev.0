Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 65E54DDE16
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 05:25:36 +1100 (EST)
Date: Wed, 14 Mar 2007 18:25:28 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 13/13] fix ps3fb glue allowing a modular build
Message-ID: <20070314182528.GN4095@ftp.linux.org.uk>
References: <E1HRPbU-0003Ha-Oq@ZenIV.linux.org.uk>
	<Pine.LNX.4.62.0703141040030.28462@pademelon.sonytel.be>
	<20070314160258.GK4095@ftp.linux.org.uk>
	<Pine.LNX.4.62.0703141715570.28462@pademelon.sonytel.be>
	<20070314170720.GL4095@ftp.linux.org.uk>
	<Pine.LNX.4.64.0703141016060.9690@woody.linux-foundation.org>
	<20070314175936.GM4095@ftp.linux.org.uk>
	<Pine.LNX.4.62.0703141907290.28462@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.62.0703141907290.28462@pademelon.sonytel.be>
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 14, 2007 at 07:09:40PM +0100, Geert Uytterhoeven wrote:
> On Wed, 14 Mar 2007, Al Viro wrote:
> > On Wed, Mar 14, 2007 at 10:30:31AM -0700, Linus Torvalds wrote:
> > > Maybe not "bool" vs "mbool", but it might be nice to have
> > > 
> > > 	bool FB_PS3
> > > 		depends strictly on FB
> > > 
> > > ie a "depends strictly" refuses to upgrade a bool dependency from "m" to 
> > > "y", while a regular depends allows it.
> > > 
> > > Or something.. The "depends strictly on X" thing would really be just a 
> > > mental shorthand for "depends on (X)=y" (it's actually longer to type, but 
> > > I think it's a bit more intuitive, thus "mental shortcut").
> > 
> > There's a fun side question, though: what should allmodconfig do?  FB=m,
> > FB_PS3=n?  Or FB=y, FB_PS3=y?
> 
> >From `make help':
> | New config selecting modules when possible
> 
> FB can be a module, so FB=m, FB_PS3=n.
> 
> It doesn't say anything about things that can't be modules :-)
> 
> But I agree the chances of getting a system that doesn't work increase...

No, I realize what kind of behaviour we'll get if we go for dependency on
FB=y.  However, if we really introduce a new kconfig primitive, it might
make sense to teach allmodconfig to deal with it.
