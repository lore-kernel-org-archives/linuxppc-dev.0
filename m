Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 30EFDDDDFF
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 08:02:22 +1000 (EST)
Date: Sun, 15 Jul 2007 23:02:16 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] the wrong variable checked after request_irq()
Message-ID: <20070715220216.GF21668@ftp.linux.org.uk>
References: <E1IAAFp-00053g-Ti@ZenIV.linux.org.uk>
	<1184535638.25235.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1184535638.25235.15.camel@localhost.localdomain>
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

On Mon, Jul 16, 2007 at 07:40:38AM +1000, Benjamin Herrenschmidt wrote:
> On Sun, 2007-07-15 at 20:59 +0100, Al Viro wrote:
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Out of curiosity, how did you pick it up ? You have some automated tool
> to catch that (or sparse changes) or you just did -lots- of code
> inspection ?

While testing sparse changes, actually (comparing pointers to null
pointer constant spelled without a cast to void *)...  That gave several
hundred hits, most of them being immediately obvious (picking the lines
by file and line number and looking through the list had eliminated all
but about a dozen or two).  Several were not...
