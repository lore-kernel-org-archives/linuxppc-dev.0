Return-Path: <sam@ravnborg.org>
Received: from pqueueb.post.tele.dk (pqueueb.post.tele.dk [193.162.153.10])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 0EB3DB7184
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 22 Jun 2009 20:11:51 +1000 (EST)
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
	by pqueueb.post.tele.dk (Postfix) with ESMTP id B4AE67FF5
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 22 Jun 2009 11:39:34 +0200 (CEST)
Date: Mon, 22 Jun 2009 11:41:43 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] fbdev: work around old compiler bug
Message-ID: <20090622094143.GA8121@uranus.ravnborg.org>
References: <20090622180420.2e0424e4.sfr@canb.auug.org.au>
	<20090622183415.46fa786b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090622183415.46fa786b.sfr@canb.auug.org.au>
Cc: James Simmons <jsimmons@infradead.org>,
	Linus <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>,
	Krzysztof Helt <krzysztof.h1@poczta.fm>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 22, 2009 at 06:34:15PM +1000, Stephen Rothwell wrote:
> On Mon, 22 Jun 2009 18:04:20 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > When building with a 4.1.x compiler on powerpc64 (at least) we get
> > this error:
> 
> Ignore this, it causes more problems:
> 
> drivers/video/logo/logo_linux_clut224.c:548: error: logo_linux_clut224_clut causes a section type conflict
> 
> I'll work on a better solution.

I have no time to experiemnt atm.
But I have seen this before.
It happens when we mix up const and non-const stuff.

I would assume the simple solution is to replace _initconst with _initdata
for all users.
If you get it to work with powerpc then it works for everyone (or so it is usually).

	Sam
