Return-Path: <b.zolnierkie@samsung.com>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 004DB1A007F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Feb 2016 01:35:39 +1100 (AEDT)
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0O2101VMA1VCLC70@mailout1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Thu, 04 Feb 2016 23:35:36 +0900 (KST)
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH] powerpc: convert amigaone_defconfig to use libata PATA
 drivers
Date: Thu, 04 Feb 2016 15:35:08 +0100
Message-id: <2550250.nXgBuiRPBT@amdc1976>
In-reply-to: <56B26E7F.70307@gmx.net>
References: <1454514630-29269-1-git-send-email-b.zolnierkie@samsung.com>
 <1454514630-29269-12-git-send-email-b.zolnierkie@samsung.com>
 <56B26E7F.70307@gmx.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

On Wednesday, February 03, 2016 10:17:51 PM Gerhard Pircher wrote:
> Am 2016-02-03 um 16:50 schrieb Bartlomiej Zolnierkiewicz:
> > IDE subsystem has been deprecated since 2009 and the majority
> > (if not all) of Linux distributions have switched to use
> > libata for ATA support exclusively.  However there are still
> > some users (mostly old or/and embedded non-x86 systems) that
> > have not converted from using IDE subsystem to libata PATA
> > drivers.  This doesn't seem to be good thing in the long-term
> > for Linux as while there is less and less PATA systems left
> > in use:
> > 
> > * testing efforts are divided between two subsystems
> > 
> > * having duplicate drivers for same hardware confuses users
> > 
> > This patch converts amigaone_defconfig to use libata PATA
> > drivers.
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> > Build tested only.
> > If you have affected hardware please test.  Thank you.
> > 
> >  arch/powerpc/configs/amigaone_defconfig | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/powerpc/configs/amigaone_defconfig b/arch/powerpc/configs/amigaone_defconfig
> > index 84f1b41..55a4929 100644
> > --- a/arch/powerpc/configs/amigaone_defconfig
> > +++ b/arch/powerpc/configs/amigaone_defconfig
> > @@ -46,12 +46,6 @@ CONFIG_PARPORT_PC_FIFO=y
> >  CONFIG_BLK_DEV_FD=y
> >  CONFIG_BLK_DEV_LOOP=y
> >  CONFIG_BLK_DEV_RAM=y
> > -CONFIG_IDE=y
> > -CONFIG_BLK_DEV_IDECD=y
> > -# CONFIG_IDEPCI_PCIBUS_ORDER is not set
> > -CONFIG_BLK_DEV_GENERIC=y
> > -CONFIG_BLK_DEV_SIIMAGE=y
> > -CONFIG_BLK_DEV_VIA82CXXX=y
> >  CONFIG_SCSI=y
> >  CONFIG_BLK_DEV_SD=y
> >  CONFIG_CHR_DEV_ST=y
> > @@ -62,6 +56,10 @@ CONFIG_SCSI_CONSTANTS=y
> >  CONFIG_SCSI_SYM53C8XX_2=y
> >  CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=0
> >  # CONFIG_SCSI_SYM53C8XX_MMIO is not set
> > +CONFIG_ATA=y
> > +CONFIG_PATA_SIL680=y
> > +CONFIG_PATA_VIA=y
> > +CONFIG_ATA_GENERIC=y
> >  CONFIG_NETDEVICES=y
> >  CONFIG_VORTEX=y
> >  CONFIG_8139CP=y
> > 
> Thanks for cleaning up the defconfig file!
> 
> libata drivers work fine on the amigaone platform (tested on all three
> first-gen AmigaOne machines). BTW: could it be that CONFIG_ATA_SFF=y
> and CONFIG_ATA_BMDMA=y are missing in the patch?

Thank you for testing!

When it comes to CONFIG_ATA_SFF and CONFIG_ATA_BMDMA there is no need
to explicitly enable them because once CONFIG_ATA is enabled they both
are also enabled by default (they both have 'default y' in Kconfig).

[ defconfig changes in the patch were obtained by:
  - doing 'make amigaone_defconfig'
  - changing IDE options to libata ones using 'make menuconfig'
  - doing 'make savedefconfig'
  - doing 'diff -u arch/powerpc/configs/amigaone_defconfig defconfig'
  so there should be no missing options etc. ]

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
