Return-Path: <tkil@scrye.com>
Received: from mail.scrye.com (unknown
 [IPv6:2001:470:b8bc:cafe:5054:ff:fedc:793f])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.scrye.com", Issuer "mail.scrye.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7CED1B6FC3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2012 03:15:32 +1000 (EST)
To: linuxppc-dev@lists.ozlabs.org
Subject: ppc/sata-fsl: orphan config value: CONFIG_MPC8315_DS
From: Anthony Foiani <tkil@scrye.com>
Date: Thu, 17 May 2012 11:08:18 -0600
Message-ID: <ghave7n25.fsf@dworkin.scrye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Robert P. J. Day" <rpjday@crashcourse.ca>, Jeff Garzik <jeff@garzik.org>,
 ashish kalra <ashish.kalra@freescale.com>, Adrian Bunk <bunk@stusta.de>
Reply-To: Anthony Foiani <tkil@scrye.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Greetings.

I was occasionally running into problems at boot time on an
MPC8315-based board (derived from the MPC831xRDB, apparently), using
SATA to talk to an SSD.  My vendor suggested that I enable
CONFIG_MPC8315_DS.

That symbol is only found once in the entire kernel codebase:

  $ git checkout v3.4-rc7
  HEAD is now at 36be505... Linux 3.4-rc7

  $ git grep -nH CONFIG_MPC8315_DS
  drivers/ata/sata_fsl.c:729:#ifdef CONFIG_MPC8315_DS

There is no kconfig support for it at all.

It was added in 2007; further, this is the only commit in the entire
git history that contains this string:

   commit e7eac96e8f0e57a6e9f94943557bc2b23be31471
   Author: ashish kalra <ashish.kalra@freescale.com>
   Date:   Wed Oct 31 19:28:02 2007 +0800

       ata/sata_fsl: Move MPC8315DS link speed limit workaround to specific ifdef
       
       Signed-off-by: ashish kalra <ashish.kalra@freescale.com>
       Signed-off-by: Li Yang <leoli@freescale.com>
       Signed-off-by: Jeff Garzik <jeff@garzik.org>

   diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
   index 5892472..e076e1f 100644
   --- a/drivers/ata/sata_fsl.c
   +++ b/drivers/ata/sata_fsl.c
   @@ -652,6 +652,7 @@ static int sata_fsl_port_start(struct ata_port *ap)
           VPRINTK("HControl = 0x%x\n", ioread32(hcr_base + HCONTROL));
           VPRINTK("CHBA  = 0x%x\n", ioread32(hcr_base + CHBA));
    
   +#ifdef CONFIG_MPC8315_DS
           /*
            * Workaround for 8315DS board 3gbps link-up issue,
            * currently limit SATA port to GEN1 speed
   @@ -664,6 +665,7 @@ static int sata_fsl_port_start(struct ata_port *ap)
           sata_fsl_scr_read(ap, SCR_CONTROL, &temp);
           dev_printk(KERN_WARNING, dev, "scr_control, speed limited to %x\n",
                           temp);
   +#endif
    
           return 0;
    }

This otherwise-unsupported variable was noted by Robert Day in 2008;
Adrian Bunk suggested a patch, but the Freescale folks said that it
was for a not-yet-mainlined board, so the patch was dropped:

   http://marc.info/?l=linux-ide&m=121783965216004&w=2

As Robert notied again in 2010, it still wasn't mainlined:

   http://marc.info/?l=linux-ide&m=121783965216004&w=2

And, obviously, it still isn't today.

Can the Freescale people tell us exactly what we should be testing to
determine when to enforce this restriction?  A config variable that
points to a non-existent board doesn't seem much help.

Thanks,
Tony
