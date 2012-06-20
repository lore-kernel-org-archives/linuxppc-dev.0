Return-Path: <lethal@linux-sh.org>
Received: from linux-sh.org (linux-sh.org [111.68.239.195])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 63704B7000
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Jun 2012 14:13:04 +1000 (EST)
Date: Wed, 20 Jun 2012 12:59:51 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Build regressions/improvements in v3.5-rc3
Message-ID: <20120620035951.GC5623@linux-sh.org>
References: <1339962373-3224-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdVfLjgrtWoPpvbLf12+=ApE6W9dNcweqD-_2Benr-D7NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMuHMdVfLjgrtWoPpvbLf12+=ApE6W9dNcweqD-_2Benr-D7NQ@mail.gmail.com>
Cc: Chris Zankel <chris@zankel.net>, Linux-sh list <linux-sh@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jun 17, 2012 at 09:56:59PM +0200, Geert Uytterhoeven wrote:
> On Sun, Jun 17, 2012 at 9:46 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > JFYI, when comparing v3.5-rc3 to v3.5-rc2[3], the summaries are:
> > ??- build errors: +235/-10
> 
> Truckloads of powerpc "Unrecognized opcode" breakage, and
> 
That was my fault, should be fixed up by 2603efa31a.

>   + drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c: error: implicit
> declaration of function 'pci_iomap'
> [-Werror=implicit-function-declaration]:  => 90:3
>   + drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c: error: implicit
> declaration of function 'pci_iounmap'
> [-Werror=implicit-function-declaration]:  => 142:2
> 
Not sure about this one, it should find everything alright via:

	linux/io.h -> asm/io.h -> asm-generic/iomap.h -> asm-generic/pci_iomap.h

in the case that PCI is enabled. None of allyesconfig/modconfig enable
PCI for me though, so I'm unsure of how you got in to this configuration
to begin with?

> xtensa
> 
>   + error: "__ashrdi3" [fs/ntfs/ntfs.ko] undefined!:  => N/A
>   + error: "__lshrdi3" [fs/ntfs/ntfs.ko] undefined!:  => N/A
> 
> sh4/landisk_defconfig
> 
>   + error: "__ashrdi3" [fs/xfs/xfs.ko] undefined!:  => N/A
>   + error: "__lshrdi3" [drivers/mtd/mtd.ko] undefined!:  => N/A
>   + error: "__lshrdi3" [fs/xfs/xfs.ko] undefined!:  => N/A
> 
These seem to be the same issue on both platforms, EXPORT_SYMBOL()
doesn't work from lib-y. While it's straightforward to fix, I'm not able
to reproduce __lshrdi3/__ashrdi3 references in any of the above, which
compiler are you using?
