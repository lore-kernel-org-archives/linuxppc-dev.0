Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C63FD1A0384
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2015 11:39:43 +1100 (AEDT)
Date: Sat, 10 Oct 2015 11:39:43 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Chris Metcalf <cmetcalf@ezchip.com>, <linux-next@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [GIT PULL] strscpy powerpc fix for 3.4
Message-ID: <20151010113943.5d124b42@canb.auug.org.au>
In-Reply-To: <5615B87A.80206@ezchip.com>
References: <20151008094444.10d9cc68@canb.auug.org.au>
 <5615B87A.80206@ezchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Linus,

On Wed, 7 Oct 2015 20:27:38 -0400 Chris Metcalf <cmetcalf@ezchip.com> wrote:
>
> On 10/7/2015 6:44 PM, Stephen Rothwell wrote:
> >
> > After merging Linus' tree, today's linux-next build (powerpc
> > ppc64_defconfig) failed like this:
> >
> > lib/string.c: In function 'strscpy':
> > lib/string.c:209:4: error: implicit declaration of function 'zero_bytemask' [-Werror=implicit-function-declaration]
> >      *(unsigned long *)(dest+res) = c & zero_bytemask(data);
> >      ^
> >
> > Caused by commit
> >
> >    30035e45753b ("string: provide strscpy()")
> 
> I posted a change equivalent to yours earlier today:
> 
> http://lkml.kernel.org/r/1444229188-19640-1-git-send-email-cmetcalf@ezchip.com
> 
> I also did no testing, but since the rest of the PPC code is similar to the
> asm-generic version, I believe the zero_bytemask() definition should be OK.
> 
> It probably should go through Linus' tree, like the previous set of patches.
> I just pushed it up to the linux-tile tree for Linus to grab as:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/cmetcalf/linux-tile.git strscpy
> 
> Chris Metcalf (1):
>        arch/powerpc: provide zero_bytemask() for big-endian
> 
>   arch/powerpc/include/asm/word-at-a-time.h | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> -- 
> Chris Metcalf, EZChip Semiconductor
> http://www.ezchip.com

Can you please do this pull as most of the powerpc build testing is
failing at the moment ... :-(

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
