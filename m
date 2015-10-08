Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D6F831A037E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 05:45:47 +1100 (AEDT)
Date: Thu, 8 Oct 2015 11:45:41 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Chris Metcalf <cmetcalf@ezchip.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [GIT PULL] strscpy powerpc fix for 3.4
Message-ID: <20151008184541.GA8373@roeck-us.net>
References: <20151008094444.10d9cc68@canb.auug.org.au>
 <5615B87A.80206@ezchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5615B87A.80206@ezchip.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 07, 2015 at 08:27:38PM -0400, Chris Metcalf wrote:
> On 10/7/2015 6:44 PM, Stephen Rothwell wrote:
> >Hi Linus,
> >
> >After merging Linus' tree, today's linux-next build (powerpc
> >ppc64_defconfig) failed like this:
> >
> >lib/string.c: In function 'strscpy':
> >lib/string.c:209:4: error: implicit declaration of function 'zero_bytemask' [-Werror=implicit-function-declaration]
> >     *(unsigned long *)(dest+res) = c & zero_bytemask(data);
> >     ^
> >
> >Caused by commit
> >
> >   30035e45753b ("string: provide strscpy()")
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
Wonder if Linus is going to realize that you meant 4.3 in your subject line,
not 3.4.

Guenter

> git://git.kernel.org/pub/scm/linux/kernel/git/cmetcalf/linux-tile.git strscpy
> 
> Chris Metcalf (1):
>       arch/powerpc: provide zero_bytemask() for big-endian
> 
>  arch/powerpc/include/asm/word-at-a-time.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> -- 
> Chris Metcalf, EZChip Semiconductor
> http://www.ezchip.com
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
