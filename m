Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p04-ob.smtp.rzone.de (mo6-p04-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5304::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5Q0r1lsrzDqV1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 21:43:07 +1000 (AEST)
Subject: [pasemi] Internal CompactFlash (CF) card device not recognised after
 the powerpc-4.8-1 merge
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 luigi burdo <intermediadc@hotmail.com>,
 Darren Stevens <darren@stevens-zone.net>, Julian Margetson
 <runaway@candw.ms>, Steven Jeffery <sajeffer@gmail.com>,
 "R.T.Dickinson" <rtd@a-eon.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Pat Wall <pjwall@mac.com>, Pat Wall <pjwall@me.com>,
 "contact@a-eon.com" <contact@a-eon.com>,
 "matthew@a-eon.biz" <matthew@a-eon.biz>, Kevin Saunders <kfs1971@gmail.com>,
 Lyle Hazelwood <lylehaze@gmail.com>, EntwicklerX <mail@entwickler-x.de>,
 "xray@relec.ch" <xray@relec.ch>, Steve-David Marguet <steve@esdeem.ch>,
 George Sokianos <walkero@gmail.com>, =?UTF-8?Q?Sinan_G=c3=bcrkan?=
 <sinan.amigaone@gmail.com>, Mike <michael.heltne@gmail.com>,
 Thomas Ferreira <macsociety@me.com>, Christian Zigotzky <info@xenosoft.de>,
 "pjs@pjsa.net" <pjs@pjsa.net>, Ben Cato Malkenes <ben.cato@gmail.com>,
 Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
References: <86E27593-C6C2-4BBA-995E-95A97BB8CB12@xenosoft.de>
 <aed83bc1-e574-1a9f-de58-480c9164865c@xenosoft.de>
 <2d94a278-d1d8-b484-e9ca-aedf18051e1a@xenosoft.de>
 <a84c2b93-4dac-9148-9ae2-0824491d1f50@xenosoft.de>
 <ae855392-570c-e125-b71f-2d5bf0c33eef@xenosoft.de>
 <d869fc32-ba80-529e-06dd-481ecf533642@xenosoft.de>
 <8b0682d3-866a-31dd-f01b-3510f84307dc@xenosoft.de>
 <2847029a-e3a4-8099-b72f-89d5731baaed@xenosoft.de>
 <4e97a4dd-3fe0-84aa-47f0-29d1544c9f8c@xenosoft.de>
 <72eed836-767c-402a-576a-8049db34d281@xenosoft.de>
 <8878883b-bd51-b7c9-ee5b-927e481e5d30@xenosoft.de>
 <8a3764d2-7fc1-1967-f557-146a3df16894@xenosoft.de>
 <1d98af3c-f585-967b-1413-58d34fad20af@xenosoft.de>
 <f6a4c3c1-f452-f4fc-1d36-b2bed81f32a3@xenosoft.de>
 <3fd5ecda-7e1f-52ec-6f11-ed603d2dcd76@xenosoft.de>
 <1470221638.12584.82.camel@kernel.crashing.org>
 <57A34254.6090702@xenosoft.de> <871t23k91w.fsf@concordia.ellerman.id.au>
 <ec7d4fbb-3823-c4fc-0152-4f5cd6dd9c88@xenosoft.de >
 <87r3a3cwgr.fsf@concordia.ellerman.id.au>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <030efdf4-7b13-864e-7202-0630a604bcdc@xenosoft.de>
Date: Fri, 5 Aug 2016 13:41:30 +0200
MIME-Version: 1.0
In-Reply-To: <87r3a3cwgr.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

The internal PASEMI CompactFlash (CF) card device doesn't work anymore 
after the powerpc-4.8-1 merge. That means the code for the internal CF 
card device in the Nemo patch doesn't work after the first PowerPC 
merge. The CompactFlash (CF) card slot is wired to the CPU local bus. It 
is typically used to hold the Linux kernel. I know it isn't well to use 
an own patch for that but I think it is a good time to integrate the 
PASEMI internal CompactFlash (CF) card device to the official kernel. 
What do you think? I am not a programmer so I can't integrate the source 
code for the internal CF card device. But maybe you can take the patch 
and integrate it.

We use the following patch for the kernel 4.7:

     diff -rupN a/drivers/ata/pata_of_platform.c 
b/drivers/ata/pata_of_platform.c
     --- a/drivers/ata/pata_of_platform.c   2016-08-05 
09:58:41.410569036 +0200
     +++ b/drivers/ata/pata_of_platform.c   2016-08-05 
09:59:54.414288884 +0200
     @@ -41,14 +41,36 @@ static int pata_of_platform_probe(struct
            return -EINVAL;
         }

     -   ret = of_address_to_resource(dn, 1, &ctl_res);
     -   if (ret) {
     -      dev_err(&ofdev->dev, "can't get CTL address from "
     -         "device tree\n");
     -      return -EINVAL;
     +   if (of_device_is_compatible(dn, "electra-ide")) {
     +      /* Altstatus is really at offset 0x3f6 from the primary window
     +       * on electra-ide. Adjust ctl_res and io_res accordingly.
     +       */
     +      ctl_res = io_res;
     +      ctl_res.start = ctl_res.start+0x3f6;
     +      io_res.end = ctl_res.start-1;
     +
     +#ifdef CONFIG_PPC_PASEMI_SB600
     +       } else if (of_device_is_compatible(dn, "electra-cf")) {
     +               /* Task regs are at 0x800, with alt status @ 0x80e 
in the primary window
     +                * on electra-cf. Adjust ctl_res and io_res 
accordingly.
     +                */
     +               ctl_res = io_res;
     +               io_res.start += 0x800;
     +               ctl_res.start = ctl_res.start + 0x80e;
     +               io_res.end = ctl_res.start-1;
     +#endif
     +   } else {
     +      ret = of_address_to_resource(dn, 1, &ctl_res);
     +      if (ret) {
     +         dev_err(&ofdev->dev, "can't get CTL address from "
     +            "device tree\n");
     +         return -EINVAL;
     +      }
         }

         irq_res = platform_get_resource(ofdev, IORESOURCE_IRQ, 0);
     +   if (irq_res)
     +      irq_res->flags = 0;

         prop = of_get_property(dn, "reg-shift", NULL);
         if (prop)
     @@ -65,6 +87,11 @@ static int pata_of_platform_probe(struct
            dev_info(&ofdev->dev, "pio-mode unspecified, assuming PIO0\n");
         }

     +#ifdef CONFIG_PPC_PASEMI_SB600
     +       irq_res = 0;                    // force irq off (doesn't 
seem to work)
     +#endif
     +
     +
         pio_mask = 1 << pio_mode;
         pio_mask |= (1 << pio_mode) - 1;

     @@ -74,7 +101,11 @@ static int pata_of_platform_probe(struct

      static struct of_device_id pata_of_platform_match[] = {
         { .compatible = "ata-generic", },
     -   { },
     +   { .compatible = "electra-ide", },
     +#ifdef CONFIG_PPC_PASEMI_SB600
     +       { .compatible = "electra-cf",},
     +#endif
     +   {},
      };
      MODULE_DEVICE_TABLE(of, pata_of_platform_match);

dmesg with the kernel 4.7:

zcat /var/log/dmesg.1.gz | grep -i ata7

     [    2.939788] ata7: PATA max PIO0 no IRQ, using PIO polling mmio 
cmd 0xf0000800 ctl 0xf000080e
     [    3.099186] ata7.00: CFA: SanDisk SDCFB-256, HDX 2.33, max PIO4
     [    3.099191] ata7.00: 501760 sectors, multi 0: LBA
     [    3.099199] ata7.00: configured for PIO

The dmesg of the latest Git kernel doesn't have any output of our 
internal CF card device.

Could you please integrate our PASEMI CF card device again?

Thanks,

Christian
