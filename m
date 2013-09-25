Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 82E962C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 07:43:30 +1000 (EST)
Date: Wed, 25 Sep 2013 14:43:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hugh Dickins <hughd@google.com>
Subject: Re: linux-next: build failure after merge of the akpm tree
Message-Id: <20130925144328.c679dc74178e78e188386b5a@linux-foundation.org>
In-Reply-To: <alpine.LNX.2.00.1309251426150.2479@eggly.anvils>
References: <20130925110643.db5fa154bea3838ed6affa45@canb.auug.org.au>
 <20130925132612.d1685bc8fb72558eef6fb09d@linux-foundation.org>
 <alpine.LNX.2.00.1309251426150.2479@eggly.anvils>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org,
 Sergei Trofimovich <slyfox@gentoo.org>, linux-next@vger.kernel.org,
 Greg KH <greg@kroah.com>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 25 Sep 2013 14:32:14 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:

> On Wed, 25 Sep 2013, Andrew Morton wrote:
> > On Wed, 25 Sep 2013 11:06:43 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > Hi Andrew,
> > > 
> > > After merging the akpm tree, linux-next builds (powerpc allmodconfig)
> > > fail like this:
> > 
> > I can't get powerpc to build at all at present:
> > 
> >   CHK     include/config/kernel.release
> >   CHK     include/generated/uapi/linux/version.h
> >   CHK     include/generated/utsrelease.h
> >   CC      arch/powerpc/kernel/asm-offsets.s
> > In file included from include/linux/vtime.h:6,
> >                  from include/linux/hardirq.h:7,
> >                  from include/linux/memcontrol.h:24,
> >                  from include/linux/swap.h:8,
> >                  from include/linux/suspend.h:4,
> >                  from arch/powerpc/kernel/asm-offsets.c:24:
> > arch/powerpc/include/generated/asm/vtime.h:1:31: error: asm-generic/vtime.h: No such file or directory
> 
> That caught me too: include/asm-generic/vtime.h is a patch-unfriendly
> 0-length file in the git tree;

hm, this?


From: Andrew Morton <akpm@linux-foundation.org>
Subject: include/asm-generic/vtime.h: avoid zero-length file

patch(1) can't handle zero-length files - it appears to simply not create
the file, so my powerpc build fails.

Put something in here to make life easier.

Cc: Hugh Dickins <hughd@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/asm-generic/vtime.h |    1 +
 1 file changed, 1 insertion(+)

diff -puN /dev/null include/asm-generic/vtime.h
--- /dev/null
+++ a/include/asm-generic/vtime.h
@@ -0,0 +1 @@
+/* no content, but patch(1) dislikes empty files */
_



> I wonder what use it's supposed to have.

Frederic, can you please confirm that include/asm-generic/vtime.h is
supposed to be empty?

> (And I'm not very keen on the growing trend for symlinks in the git tree.)

ooh, that explains why I lost my arch/microblaze/boot/dts/system.dts.
