Return-Path: <bzolnier@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by ozlabs.org (Postfix) with ESMTP id B69FCDDF50
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 06:56:56 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so122012fgg.39
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 13:56:54 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] [IDE] alim15x3: disable init_hwif_ali15x3 for PowerPC
Date: Tue, 29 Apr 2008 23:01:38 +0200
References: <20080429161914.GA4980@polina.dev.rtsoft.ru>
In-Reply-To: <20080429161914.GA4980@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Message-Id: <200804292301.39037.bzolnier@gmail.com>
Content-Type: text/plain;
  charset="utf-8"
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 29 April 2008, Anton Vorontsov wrote:
> We don't need init_hwif_ali15x3() on the PowerPC systems either.
> 
> Before:
> 
> ALI15X3: IDE controller (0x10b9:0x5229 rev 0xc8) at  PCI slot 0001:03:1f.0
> ALI15X3: 100% native mode on irq 19
>     ide0: BM-DMA at 0x1120-0x1127
>     ide1: BM-DMA at 0x1128-0x112f
> hda: SONY DVD RW AW-Q170A, ATAPI CD/DVD-ROM drive
> hda: UDMA/66 mode selected
> ide0: Disabled unable to get IRQ 14.
> ide0: failed to initialize IDE interface
> ide1: Disabled unable to get IRQ 15.
> ide1: failed to initialize IDE interface
> 
> After:
> 
> ALI15X3: IDE controller (0x10b9:0x5229 rev 0xc8) at  PCI slot 0001:03:1f.0
> ALI15X3: 100% native mode on irq 19
>     ide0: BM-DMA at 0x1120-0x1127
>     ide1: BM-DMA at 0x1128-0x112f
> hda: SONY DVD RW AW-Q170A, ATAPI CD/DVD-ROM drive
> hda: UDMA/66 mode selected
> ide0 at 0x1100-0x1107,0x110a on irq 19
> ide1 at 0x1110-0x1117,0x111a on irq 19
> hda: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
> 
> ide0 works well, though I can't test ide1, it isn't traced out on
> the board.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

applied, thanks
