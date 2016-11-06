Return-Path: <boris.brezillon@free-electrons.com>
Received: from mail.free-electrons.com (up.free-electrons.com [163.172.77.33])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tBrgJ1J1XzDvHY
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 10:02:04 +1100 (AEDT)
Date: Sun, 6 Nov 2016 23:55:08 +0100
From: Boris Brezillon <boris.brezillon@free-electrons.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mtd@lists.infradead.org, Sylvain Lemieux
 <slemieux.tyco@gmail.com>, Josh Wu <rainyfeeling@outlook.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, Stefan Agner <stefan@agner.ch>, Vladimir
 Zapolskiy <vz@mleia.com>, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>,
 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Richard Weinberger
 <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Kamal Dasu
 <kdasu.kdev@gmail.com>, bcm-kernel-feedback-list@broadcom.com,
 linuxppc-dev@lists.ozlabs.org, Wenyou Yang <wenyou.yang@atmel.com>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/22] mtd: nand: return error code of
 nand_scan(_ident,_tail) on error
Message-ID: <20161106235508.52374ac3@bbrezillon>
In-Reply-To: <1478256190-7452-1-git-send-email-yamada.masahiro@socionext.com>
References: <1478256190-7452-1-git-send-email-yamada.masahiro@socionext.com>
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

On Fri,  4 Nov 2016 19:42:48 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> nand_scan(), nand_scan_ident(), nand_scan_tail() return
> an appropriate negative value on error.
> 
> Most of drivers return the value from them on error,
> but some of them return the fixed error code -ENXIO
> (and a few return -ENODEV).
> 
> This series make those drivers return more precise error code.

Applied and fixed the bug I found in patch 13.

Thanks,

Boris

> 
> 
> Masahiro Yamada (22):
>   mtd: nand: ams-delta: return error code of nand_scan() on error
>   mtd: nand: cmx270: return error code of nand_scan() on error
>   mtd: nand: cs553x: return error code of nand_scan() on error
>   mtd: nand: gpio: return error code of nand_scan() on error
>   mtd: nand: mpc5121: return error code of nand_scan() on error
>   mtd: nand: tmio: return error code of nand_scan() on error
>   mtd: nand: orion: return error code of nand_scan() on error
>   mtd: nand: pasemi: return error code of nand_scan() on error
>   mtd: nand: plat_nand: return error code of nand_scan() on error
>   mtd: nand: atmel: return error code of nand_scan_ident/tail() on error
>   mtd: nand: brcmnand: return error code of nand_scan_ident/tail() on
>     error
>   mtd: nand: fsmc: return error code of nand_scan_ident/tail() on error
>   mtd: nand: lpc32xx: return error code of nand_scan_ident/tail() on
>     error
>   mtd: nand: mediatek: return error code of nand_scan_ident/tail() on
>     error
>   mtd: nand: mxc: return error code of nand_scan_ident/tail() on error
>   mtd: nand: omap2: return error code of nand_scan_ident/tail() on error
>   mtd: nand: vf610: return error code of nand_scan_ident/tail() on error
>   mtd: nand: cafe: return error code of nand_scan_ident() on error
>   mtd: nand: hisi504: return error code of nand_scan_ident() on error
>   mtd: nand: pxa3xx: return error code of nand_scan_ident() on error
>   mtd: nand: nandsim: remove unneeded checks for nand_scan_ident/tail()
>   mtd: nand: socrates: use nand_scan() for nand_scan_ident/tail() combo
> 
>  drivers/mtd/nand/ams-delta.c         |  5 ++---
>  drivers/mtd/nand/atmel_nand.c        | 10 ++++------
>  drivers/mtd/nand/brcmnand/brcmnand.c | 10 ++++++----
>  drivers/mtd/nand/cafe_nand.c         |  5 ++---
>  drivers/mtd/nand/cmx270_nand.c       |  4 ++--
>  drivers/mtd/nand/cs553x_nand.c       |  5 ++---
>  drivers/mtd/nand/fsmc_nand.c         |  9 ++++-----
>  drivers/mtd/nand/gpio.c              |  5 ++---
>  drivers/mtd/nand/hisi504_nand.c      |  4 +---
>  drivers/mtd/nand/lpc32xx_mlc.c       | 10 ++++------
>  drivers/mtd/nand/lpc32xx_slc.c       |  9 +++------
>  drivers/mtd/nand/mpc5121_nfc.c       |  4 ++--
>  drivers/mtd/nand/mtk_nand.c          |  4 ++--
>  drivers/mtd/nand/mxc_nand.c          | 10 ++++------
>  drivers/mtd/nand/nandsim.c           |  4 ----
>  drivers/mtd/nand/omap2.c             |  9 ++++-----
>  drivers/mtd/nand/orion_nand.c        |  5 ++---
>  drivers/mtd/nand/pasemi_nand.c       |  5 ++---
>  drivers/mtd/nand/plat_nand.c         |  5 ++---
>  drivers/mtd/nand/pxa3xx_nand.c       |  5 +++--
>  drivers/mtd/nand/socrates_nand.c     | 12 ++----------
>  drivers/mtd/nand/tmio_nand.c         |  6 +++---
>  drivers/mtd/nand/vf610_nfc.c         | 10 ++++------
>  23 files changed, 62 insertions(+), 93 deletions(-)
> 
