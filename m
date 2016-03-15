Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qPpWm3bQ6zDq6V
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 09:02:43 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin LaHaise <bcrl@kvack.org>,
 Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: build failure after merge of the aio tree
Date: Tue, 15 Mar 2016 23:02:29 +0100
Message-ID: <15874870.hBfxUomX5V@wuerfel>
In-Reply-To: <20160315162228.GP17923@kvack.org>
References: <20160315174634.6766cd88@canb.auug.org.au>
 <20160315161901.GA2713@sudip-laptop> <20160315162228.GP17923@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 15 March 2016 12:22:28 Benjamin LaHaise wrote:
> On Tue, Mar 15, 2016 at 04:19:02PM +0000, Sudip Mukherjee wrote:
> > On Tue, Mar 15, 2016 at 05:46:34PM +1100, Stephen Rothwell wrote:
> > > Hi Benjamin,
> > > 
> > > After merging the aio tree, today's linux-next build (powerpc
> > > ppc44x_defconfig) failed like this:
> > > 
> > > fs/built-in.o: In function `aio_thread_op_foo_at':
> > > aio.c:(.text+0x4dab4): undefined reference to `__get_user_bad'
> > > aio.c:(.text+0x4daec): undefined reference to `__get_user_bad'
> > > 
> > > Caused by commit
> > > 
> > >   150a0b4905f1 ("aio: add support for async openat()")
> > > 
> > > despite commit
> > > 
> > >   d2f7a973e11e ("aio: don't use __get_user() for 64 bit values")
> > > 
> > > This is due to a bug in the powerpc __get_user_check() macro (the return
> > > value is defined to be "unsigned long" which is only 32 bits on a 32
> > > bit platform).
> > 
> > m68k allmodconfig and all defs of m32r fails while building next-20160315.
> > 
> > regards
> > sudip
> 
> I've removed everything from the aio-next.git tree for now.  Will revisit 
> after the merge window.
> 

I've also sent a patch that fixes the link error on ARM and that should
work on all other architectures too.

	Arnd
