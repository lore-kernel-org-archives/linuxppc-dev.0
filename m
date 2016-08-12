Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p04-ob.smtp.rzone.de (mo6-p04-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5304::6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9fXL029TzDr1k
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 19:21:37 +1000 (AEST)
Subject: [pasemi] Internal CompactFlash (CF) card device not recognised after
 the powerpc-4.8-1 merge
To: Julian Margetson <runaway@candw.ms>,
 luigi burdo <intermediadc@hotmail.com>,
 Darren Stevens <darren@stevens-zone.net>, Steven Jeffery
 <sajeffer@gmail.com>, "R.T.Dickinson" <rtd@a-eon.com>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, Pat Wall <pjwall@mac.com>,
 Pat Wall <pjwall@me.com>, "contact@a-eon.com" <contact@a-eon.com>,
 "matthew@a-eon.biz" <matthew@a-eon.biz>, Kevin Saunders <kfs1971@gmail.com>,
 Lyle Hazelwood <lylehaze@gmail.com>, EntwicklerX <mail@entwickler-x.de>,
 "xray@relec.ch" <xray@relec.ch>, Steve-David Marguet <steve@esdeem.ch>,
 George Sokianos <walkero@gmail.com>, =?UTF-8?Q?Sinan_G=c3=bcrkan?=
 <sinan.amigaone@gmail.com>, Mike <michael.heltne@gmail.com>,
 Thomas Ferreira <macsociety@me.com>, Christian Zigotzky <info@xenosoft.de>,
 "pjs@pjsa.net" <pjs@pjsa.net>, Ben Cato Malkenes <ben.cato@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Olof Johansson <olof@lixom.net>,
 npiggin@gmail.com, shc_work@mail.ru, tj@kernel.org
References: <86E27593-C6C2-4BBA-995E-95A97BB8CB12@xenosoft.de>
 <8878883b-bd51-b7c9-ee5b-927e481e5d30@xenosoft.de>
 <8a3764d2-7fc1-1967-f557-146a3df16894@xenosoft.de>
 <1d98af3c-f585-967b-1413-58d34fad20af@xenosoft.de>
 <f6a4c3c1-f452-f4fc-1d36-b2bed81f32a3@xenosoft.de>
 <630b12ba-344e-7964-d6f5-001bc91e013a@xenosoft.de>
 <ab25ff79-fe91-8b7d-87ee-9625c4b0ec48@xenosoft.de>
 <b079bae9-566a-7539-b9cc-30f0edc46b11@xenosoft.de>
 <f2c917aa-594b-b96b-dc07-4bb26c082ef9@xenosoft.de>
 <3a1191c8-cf37-b040-0245-4e9aa77b59fe@xenosoft.de>
 <af9f0ac4-767a-b743-202a-7fee0aad7d70@xenosoft.de>
 <155dfbf5-8050-8a2e-44fa-1ceb53ccb8cf@xenosoft.de>
 <13b19298-3f5b-1602-8edc-76038f61e2db@xenosoft.de>
 <d88b1b80-f5a4-b50b-a886-2b0a91603149@xenosoft.de>
 <dfb5d87b-9297-be7b-1c70-d3398848ec6b@candw.ms>
 <f4e143b1-e758-b97b-d745-5c25bbcb0b28@xenosoft.de>
 <405fa68b-3ab3-4bbc-f751-7d0c2fa39ff1@candw.ms>
 <9ac75c41-aa11-9cd1-e235-3296a24eb6eb@xenosoft.de>
 <6f953e9a-2bcc-7bf6-88bc-1868d34afa4b@xenosoft.de>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <b92ef9d6-c58f-efe5-b4ea-df7acb19df9c@xenosoft.de>
Date: Fri, 12 Aug 2016 11:20:35 +0200
MIME-Version: 1.0
In-Reply-To: <6f953e9a-2bcc-7bf6-88bc-1868d34afa4b@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I meant, I reverted the setup.c.

- Christian

On 12 August 2016 at 11:00 AM, Christian Zigotzky wrote:
> Hi All,
>
> I reverted the commit 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/diff/arch/powerpc/platforms/pasemi/setup.c?id=bad60e6f259a01cf9f29a1ef8d435ab6c60b2de9. 
> It boots but it doesn't find any partitions.
>
> Cheers,
>
> Christian
>
> On 11 August 2016 at 5:03 PM, Christian Zigotzky wrote:
>> Hi All,
>>
>> I was able to patch the RC1 with the Nemo and PHB-numbering patch. 
>> Additionally I added some printks in the file pata_of_platform.c. I 
>> wanted to know which values have the following variables:
>>
>> ctl_res = io_res;
>> io_res.start += 0x800;
>> ctl_res.start = ctl_res.start + 0x80e;
>> io_res.end = ctl_res.start-1;
>>
>> It compiled without any problems but unfortunately I didn't see any 
>> printk outputs of these variables. The output of pata_of_platform is 
>> missing too. I see this output in the dmesg of the kernel 4.7 but I 
>> don't see it in the dmesg of the kernel 4.8.
>>
>> I have the feeling, that pata_of_platform doesn't work anymore. Maybe 
>> this is the reason, why the CF card doesn't work anymore.
>>
>> Maybe this is the problem: 
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/diff/arch/powerpc/platforms/pasemi/setup.c?id=bad60e6f259a01cf9f29a1ef8d435ab6c60b2de9
>>
>> Do you have any hints for me?
>>
>> Cheers,
>>
>> Christian
>>
>> On 05 August 2016 at 11:42 PM, Darren Stevens wrote:
>>> Hello Nicholas
>>>
>>> On 06/08/2016, Nicholas Piggin wrote:
>>>>
>>>> Hi Christian,
>>> On 05 August 2016 at 1:41 PM, Christian Zigotzky wrote:
>>>
>>> Hi All,
>>>
>>>
>>>
>>> The internal PASEMI CompactFlash (CF) card device doesn't work anymore
>>> after the powerpc-4.8-1 merge. That means the code for the internal CF
>>> card device in the Nemo patch doesn't work after the first PowerPC
>>> merge. The CompactFlash (CF) card slot is wired to the CPU local bus.
>>> It is typically used to hold the Linux kernel. I know it isn't well to
>>> use an own patch for that but I think it is a good time to integrate
>>> the PASEMI internal CompactFlash (CF) card device to the official
>>> kernel. What do you think? I am not a programmer so I can't integrate
>>> the source code for the internal CF card device. But maybe you can
>>> take the patch and integrate it.
>>>
>>>
>>>
>>> We use the following patch for the kernel 4.7:
>>>
>>>
>>>
>>>      diff -rupN a/drivers/ata/pata_of_platform.c
>>> b/drivers/ata/pata_of_platform.c
>>>
>>>      --- a/drivers/ata/pata_of_platform.c   2016-08-05
>>> 09:58:41.410569036 +0200
>>>
>>>      +++ b/drivers/ata/pata_of_platform.c   2016-08-05
>>> 09:59:54.414288884 +0200
>>>
>>>      @@ -41,14 +41,36 @@ static int pata_of_platform_probe(struct
>>>
>>>             return -EINVAL;
>>>
>>>          }
>>>
>>>
>>>
>>>      -   ret = of_address_to_resource(dn, 1, &ctl_res);
>>>
>>>      -   if (ret) {
>>>
>>>      -      dev_err(&ofdev->dev, "can't get CTL address from "
>>>
>>>      -         "device tree\n");
>>>
>>>      -      return -EINVAL;
>>>
>>>      +   if (of_device_is_compatible(dn, "electra-ide")) {
>>>
>>>      +      /* Altstatus is really at offset 0x3f6 from the primary 
>>> window
>>>
>>>      +       * on electra-ide. Adjust ctl_res and io_res accordingly.
>>>
>>>      +       */
>>>
>>>      +      ctl_res = io_res;
>>>
>>>      +      ctl_res.start = ctl_res.start+0x3f6;
>>>
>>>      +      io_res.end = ctl_res.start-1;
>>>
>>>      +
>>>
>>>      +#ifdef CONFIG_PPC_PASEMI_SB600
>>>
>>>      +       } else if (of_device_is_compatible(dn, "electra-cf")) {
>>>
>>>      +               /* Task regs are at 0x800, with alt status @ 0x80e
>>> in the primary window
>>>
>>>      +                * on electra-cf. Adjust ctl_res and io_res
>>> accordingly.
>>>
>>>      +                */
>>>
>>>      +               ctl_res = io_res;
>>>
>>>      +               io_res.start += 0x800;
>>>
>>>      +               ctl_res.start = ctl_res.start + 0x80e;
>>>
>>>      +               io_res.end = ctl_res.start-1;
>>>
>>>      +#endif
>>>
>>>      +   } else {
>>>
>>>      +      ret = of_address_to_resource(dn, 1, &ctl_res);
>>>
>>>      +      if (ret) {
>>>
>>>      +         dev_err(&ofdev->dev, "can't get CTL address from "
>>>
>>>      +            "device tree\n");
>>>
>>>      +         return -EINVAL;
>>>
>>>      +      }
>>>
>>>          }
>>>
>>>
>>>
>>>          irq_res = platform_get_resource(ofdev, IORESOURCE_IRQ, 0);
>>>
>>>      +   if (irq_res)
>>>
>>>      +      irq_res->flags = 0;
>>>
>>>
>>>
>>>          prop = of_get_property(dn, "reg-shift", NULL);
>>>
>>>          if (prop)
>>>
>>>      @@ -65,6 +87,11 @@ static int pata_of_platform_probe(struct
>>>
>>>             dev_info(&ofdev->dev, "pio-mode unspecified, assuming
>>> PIO0\n");
>>>
>>>          }
>>>
>>>
>>>
>>>      +#ifdef CONFIG_PPC_PASEMI_SB600
>>>
>>>      +       irq_res = 0;                    // force irq off (doesn't
>>> seem to work)
>>>
>>>      +#endif
>>>
>>>      +
>>>
>>>      +
>>>
>>>          pio_mask = 1 << pio_mode;
>>>
>>>          pio_mask |= (1 << pio_mode) - 1;
>>>
>>>
>>>
>>>      @@ -74,7 +101,11 @@ static int pata_of_platform_probe(struct
>>>
>>>
>>>
>>>       static struct of_device_id pata_of_platform_match[] = {
>>>
>>>          { .compatible = "ata-generic", },
>>>
>>>      -   { },
>>>
>>>      +   { .compatible = "electra-ide", },
>>>
>>>      +#ifdef CONFIG_PPC_PASEMI_SB600
>>>
>>>      +       { .compatible = "electra-cf",},
>>>
>>>      +#endif
>>>
>>>      +   {},
>>>
>>>       };
>>>
>>>       MODULE_DEVICE_TABLE(of, pata_of_platform_match);
>>>
>>>
>>>
>>> dmesg with the kernel 4.7:
>>>
>>>
>>>
>>> zcat /var/log/dmesg.1.gz | grep -i ata7
>>>
>>>
>>>
>>>      [    2.939788] ata7: PATA max PIO0 no IRQ, using PIO polling mmio
>>> cmd 0xf0000800 ctl 0xf000080e
>>>
>>>      [    3.099186] ata7.00: CFA: SanDisk SDCFB-256, HDX 2.33, max PIO4
>>>
>>>      [    3.099191] ata7.00: 501760 sectors, multi 0: LBA
>>>
>>>      [    3.099199] ata7.00: configured for PIO
>>>
>>>
>>>
>>> The dmesg of the latest Git kernel doesn't have any output of our
>>> internal CF card device.
>>>
>>>
>>>
>>> Could you please integrate our PASEMI CF card device again?
>>>
>>>
>>>
>>> Thanks,
>>>
>>>
>>>
>>> Christian
>>>
>>>
>>>
>>>> As for your driver support, it would indeed be a good idea to
>>>> get it supported in the upstream kernel. You should post a
>>>> new mail about that. Take a look at these 3 commits:
>>>>
>>>> 61f7162117d4767875825abf2f6ed1eeebbcceed
>>>> 9cd55be4d22376893d2818ce3c0e5706a3d74121
>>>> ca99140a63b7326ee9a38f64c326317f2c63b594
>>>>
>>>> Your patch comes from code based on the second one. The last
>>>> commit removed it, and says that it is not the best way to
>>>> implement it. You could cc this list and some of the people
>>>> involved with those commits and ask ask for advice about
>>>> getting your driver supported.
>>> Actually, it's almost supported by the base PASemi code anyway, 
>>> there is a
>>> PCMCIA driver in setup.c, but our hardware has been changed enough 
>>> to make it
>>> hang the system when used. I should probably take another look and 
>>> see If I
>>> can fix that. The other option would be to move the above patch to 
>>> where we
>>> add our rtc platform device. One thing that does confuse me is the 
>>> interrupt,
>>> it's attached to GPIO 0, so should be on the mpic int 0 (or maybe 
>>> 16?)but I
>>> could never get it to work.
>>>
>>> Regards
>>> Darren
>>>
>>>
>>
>>
>>
>
>
