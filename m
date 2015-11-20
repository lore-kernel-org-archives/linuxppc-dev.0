Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 451D41A0066
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2015 08:17:53 +1100 (AEDT)
Date: Fri, 20 Nov 2015 21:17:46 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Scott Wood <scottwood@freescale.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 BOUET Serge <serge.bouet@c-s.fr>, BARABAN Luc <luc.baraban@c-s.fr>
Subject: Re: Recurring Oops in link_path_walk()
Message-ID: <20151120211745.GN22011@ZenIV.linux.org.uk>
References: <564F536F.9080109@c-s.fr>
 <20151120175643.GM22011@ZenIV.linux.org.uk>
 <1448045920.27264.207.camel@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1448045920.27264.207.camel@freescale.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 20, 2015 at 12:58:40PM -0600, Scott Wood wrote:

> > Looks like garbage in dentry->d_inode, assuming that reconstruction of
> > the mapping of line numbers to addresses is correct...  Not sure it is,
> > though; what's more, just how does LR manage to point to the insn right
> > after the call of dput(), of all things?
> 
> When "bl dput" is executed, LR gets set to the instruction after the bl. 
>  After dput returns, LR still has that value.  Presumably the call to mntput
> was skipped via the beq.  Nothing else modifies LR between the dput return and
> the faulting address.

OK, AFAICS it's this:
604)        do {
605)                struct path link = *path;
606)                void *cookie;
607) 
608)                res = follow_link(&link, nd, &cookie);
609)                if (res)
610)                        break;
611)                res = walk_component(nd, path, LOOKUP_FOLLOW);
612)                put_link(nd, &link, cookie);
and we are seeing assorted garbage as link.dentry->d_inode at put_link()
call.  What's really interesting, follow_link() has return 0, which means
that it must have passed through
849)        *p = dentry->d_inode->i_op->follow_link(dentry, nd);
with
825)        struct dentry *dentry = link->dentry;
upstream of that and link as seen by follow_link() is &link as seen by
caller (nested_symlink()); IOW, at that point link.dentry->d_inode used to
be a valid pointer.

Do you have something resembling a reproducer or a chance to get a crash
dump at that point?
