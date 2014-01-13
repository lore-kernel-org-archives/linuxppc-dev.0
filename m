Return-Path: <ydroneaud@opteya.com>
Message-ID: <1389605449.1585.9.camel@localhost.localdomain>
Subject: Re: [PATCH 02/13] ppc/cell: use get_unused_fd_flags(0) instead of
 get_unused_fd()
From: Yann Droneaud <ydroneaud@opteya.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 13 Jan 2014 10:30:49 +0100
In-Reply-To: <1389567961.4672.111.camel@pasglop>
References: <cover.1372777600.git.ydroneaud@opteya.com>
 <72f6f9ae898a664033f6b958bc7976b994544963.1372777600.git.ydroneaud@opteya.com>
 <1389567961.4672.111.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Benjamin,

Le lundi 13 janvier 2014 à 10:06 +1100, Benjamin Herrenschmidt a écrit :
> On Tue, 2013-07-02 at 18:39 +0200, Yann Droneaud wrote:
> > Macro get_unused_fd() is used to allocate a file descriptor with
> > default flags. Those default flags (0) can be "unsafe":
> > O_CLOEXEC must be used by default to not leak file descriptor
> > across exec().
> > 
> > Instead of macro get_unused_fd(), functions anon_inode_getfd()
> > or get_unused_fd_flags() should be used with flags given by userspace.
> > If not possible, flags should be set to O_CLOEXEC to provide userspace
> > with a default safe behavor.
> > 
> > In a further patch, get_unused_fd() will be removed so that
> > new code start using anon_inode_getfd() or get_unused_fd_flags()
> > with correct flags.
> > 
> > This patch replaces calls to get_unused_fd() with equivalent call to
> > get_unused_fd_flags(0) to preserve current behavor for existing code.
> > 
> > The hard coded flag value (0) should be reviewed on a per-subsystem basis,
> > and, if possible, set to O_CLOEXEC.
> > 
> > Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
> 
> Should I merge this (v5 on patchwork) or let Al do it ?
> 

Please merge it directly: patches from the previous patchsets were
picked individually by each subsystem maintainer after proper review
regarding setting close on exec flag by default.

> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 

Thanks a lot.

> > ---
> >  arch/powerpc/platforms/cell/spufs/inode.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
> > index f390042..88df441 100644
> > --- a/arch/powerpc/platforms/cell/spufs/inode.c
> > +++ b/arch/powerpc/platforms/cell/spufs/inode.c
> > @@ -301,7 +301,7 @@ static int spufs_context_open(struct path *path)
> >  	int ret;
> >  	struct file *filp;
> >  
> > -	ret = get_unused_fd();
> > +	ret = get_unused_fd_flags(0);
> >  	if (ret < 0)
> >  		return ret;
> >  
> > @@ -518,7 +518,7 @@ static int spufs_gang_open(struct path *path)
> >  	int ret;
> >  	struct file *filp;
> >  
> > -	ret = get_unused_fd();
> > +	ret = get_unused_fd_flags(0);
> >  	if (ret < 0)
> >  		return ret;
> >  
> 
> 

Note:
latest patch (from v5 patchset) is at
http://lkml.kernel.org/r/fe27abcfab5563d36a3e5e58ff36e5500c39be6a.1388952061.git.ydroneaud@opteya.com
v5 patchset is at
http://lkml.kernel.org/r/cover.1388952061.git.ydroneaud@opteya.com

Regards.

-- 
Yann Droneaud
OPTEYA
