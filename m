Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH 00/15] change default_llseek action
Date: Wed, 15 Sep 2010 18:37:29 +0200
References: <1284495763-7506-1-git-send-email-arnd@arndb.de>
	<9828.1284565136@localhost>
In-Reply-To: <9828.1284565136@localhost>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201009151837.30026.arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Samuel Ortiz <samuel@sortiz.org>,
	David Airlie <airlied@linux.ie>, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org,
	Tony Lindgren <tony@atomide.com>, Julia Lawall <julia@diku.dk>,
	Jeremy Kerr <jk@ozlabs.org>, linux-fsdevel@vger.kernel.org,
	linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 15 September 2010, Valdis.Kletnieks@vt.edu wrote:
>   Show Details
>   On Tue, 14 Sep 2010 22:22:28 +0200, Arnd Bergmann said:
> 
> > This changes all instances of struct file_operations in
> > the kernel to have a .llseek operation and then changes
> > the default to no_llseek, which returns -ESPIPE, which
> > is what we had decided some time ago in a discussion
> > with Christoph Hellwig.
> 
> I don't suppose there's any clean way to throw a build error or a
> printk_on_once() or something if we encounter an unconverted 'struct
> file_operations', is there? I have this creeping fear that this patch will go
> upstream during the merge window - as will 12 new staging/ drivers from authors
> who didn't get the memo yet.
> 
> Other than the "missed converting a new usage" issue, it looks OK to me.

One advantage of the scripted approach is that I can run the script
repeatedly, and send a patch after -rc1 fixing up all the new file
operations.

Moreover, any new drivers are by definition not regressions and staging
drivers are expected to have issues. IIRC the most common llseek operation
is 'noop_llseek', which usually means it should have been 'no_llseek' to
start with, but since this has been in a released kernel, some random
user application might expect a seek on that file to succeed without
error.

	Arnd
