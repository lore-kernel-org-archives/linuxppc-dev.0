Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id EFFDA679FD
	for <linuxppc-dev@ozlabs.org>; Thu, 26 May 2005 16:21:00 +1000 (EST)
Date: Wed, 25 May 2005 23:20:57 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050526062057.GA25579@gate.ebshome.net>
References: <1117000809.6395.92.camel@gaston>
	<0015d371e12596fecdefd971b4fb1e5a@freescale.com>
	<1117004659.6395.103.camel@gaston>
	<b9ca52306a8b84cc1e03ac72c65316cf@embeddededge.com>
	<1117057460.5076.19.camel@gaston>
	<80f48eb53b0f876138cde07a997791b6@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <80f48eb53b0f876138cde07a997791b6@embeddededge.com>
Cc: linuxppc-embedded@ozlabs.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: RFC: Deprecating io_block_mapping
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 26, 2005 at 02:00:11AM -0400, Dan Malek wrote:
> 
> >Well, The PCI IO space base just need to be in a global that is
> >referenced by _IO_BASE, it works fine, no need to hard code a mapping.
> 
> Sure you do.  No one ioremap()s PCI IO space.  It has to be hard wired
> somewhere.

Dan, you must be kidding. 44x ioremaps PCI IO space, 40x uses 
io_block_mapping for that, but this is just brain-damaged and should 
be fixed.

What is so special about PCI IO space that it must be "wired" ?

[snip]

> You are missing the point.  The reason for io_block_mapping() isn't
> to allocate virtual space for someone, it's to _wire_ a space using an
> efficient mapping method so someone else can call ioremap() and
> get that wired access.  

Wow, this is something new for me. So you are saying that 
io_block_mapping() was supposed to be used with ioremap()?

Could you point me to the port which actually does this?

So far I only saw io_block_mapping() used as a short-cut way _NOT_ to 
ioremap and get hard-coded v:p mapping and then use this knowledge to 
access physical address directly without ever calling ioremap(). And 
this is major source of problems.

Also, by this logic, if platform doesn't have BAT or CAMs or whatever, 
which effectively prevents creating this "efficient mapping" and 
hence stated purpose of io_block_mapping cannot be achieved, 
io_block_mapping() should be eliminated on this platform, right?

-- 
Eugene
