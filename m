Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4A8D81A0066
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2015 04:56:50 +1100 (AEDT)
Date: Fri, 20 Nov 2015 17:56:44 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 BOUET Serge <serge.bouet@c-s.fr>, BARABAN Luc <luc.baraban@c-s.fr>
Subject: Re: Recurring Oops in link_path_walk()
Message-ID: <20151120175643.GM22011@ZenIV.linux.org.uk>
References: <564F536F.9080109@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <564F536F.9080109@c-s.fr>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 20, 2015 at 06:07:59PM +0100, Christophe Leroy wrote:
> Al,
> 
> We've been running Kernel 3.18 for several monthes on our embedded
> boards, and we have a recurring Oops in link_path_walk()
> It doesn't happen very often (approximatly once every month on one
> board among a set of 50 boards, never the same board).
> 
> Here below is the last oops I got, with kernel 3.18.22. It crashes
> at address 0xc00b75ac. Here below is the full desassembly of
> link_path_walk() so that you can see exactly the offending line.
> 
> The address it fails at is always the same (link_path_walk+0x414)
> but the oopsing data address is each time different. I added all
> Oops I got below after the disassembly (on different sub-versions of
> 3.18).

Looks like garbage in dentry->d_inode, assuming that reconstruction of
the mapping of line numbers to addresses is correct...  Not sure it is,
though; what's more, just how does LR manage to point to the insn right
after the call of dput(), of all things?
