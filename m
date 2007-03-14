Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 229B2DDE22
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 04:59:45 +1100 (EST)
Date: Wed, 14 Mar 2007 17:59:36 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 13/13] fix ps3fb glue allowing a modular build
Message-ID: <20070314175936.GM4095@ftp.linux.org.uk>
References: <E1HRPbU-0003Ha-Oq@ZenIV.linux.org.uk>
	<Pine.LNX.4.62.0703141040030.28462@pademelon.sonytel.be>
	<20070314160258.GK4095@ftp.linux.org.uk>
	<Pine.LNX.4.62.0703141715570.28462@pademelon.sonytel.be>
	<20070314170720.GL4095@ftp.linux.org.uk>
	<Pine.LNX.4.64.0703141016060.9690@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0703141016060.9690@woody.linux-foundation.org>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 14, 2007 at 10:30:31AM -0700, Linus Torvalds wrote:
> > Nope.  How can kconfig distinguish that from a boolean option in modular
> > driver?  bool *can* depend on tristate and be selected when tristate is
> > set to m.
> 
> Btw, this is one of those things that easily causes problems.
> 
> In many ways it would be nice if we had two different kinds of "bool": one 
> where "m" in the dependency chain means "y" is ok, and one where "m" means 
> "n".

*nod*

> Maybe not "bool" vs "mbool", but it might be nice to have
> 
> 	bool FB_PS3
> 		depends strictly on FB
> 
> ie a "depends strictly" refuses to upgrade a bool dependency from "m" to 
> "y", while a regular depends allows it.
> 
> Or something.. The "depends strictly on X" thing would really be just a 
> mental shorthand for "depends on (X)=y" (it's actually longer to type, but 
> I think it's a bit more intuitive, thus "mental shortcut").

There's a fun side question, though: what should allmodconfig do?  FB=m,
FB_PS3=n?  Or FB=y, FB_PS3=y?
