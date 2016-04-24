Return-Path: <runaway@candw.ms>
Received: from smtp754.redcondor.net (smtp754.redcondor.net [208.80.206.54])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qtH403YyYzDq64
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2016 03:51:58 +1000 (AEST)
Subject: Re: [PATCH v1 00/23] ata: sata_dwc_460ex: make it working again
To: Christian Lamparter <chunkeey@googlemail.com>
References: <1461262544-115408-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <4252844.GfFuvxr01B@debian64> <571CC4A7.8050808@candw.ms>
 <33998356.WVR1zQ2T7Q@debian64>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?=
 <mans@mansr.com>
From: Julian Margetson <runaway@candw.ms>
Message-ID: <571D07A4.6040904@candw.ms>
Date: Sun, 24 Apr 2016 13:51:32 -0400
MIME-Version: 1.0
In-Reply-To: <33998356.WVR1zQ2T7Q@debian64>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 4/24/2016 11:21 AM, Christian Lamparter wrote:
> On Sunday, April 24, 2016 09:05:43 AM Julian Margetson wrote:
>> On 4/23/2016 3:41 PM, Christian Lamparter wrote:
>>> There's a known errata for the 460EX, with the CPU lockup upon
>>> high AHB traffic:
>>> <http://lists.denx.de/pipermail/u-boot/2008-June/036078.html>
>>>
>>> "This patch implements a fix provided by AMCC so that the lockup upon
>>> simultanious traffic on AHB USB OTG, USB 2.0 and SATA doesn't occur
>>> anymore:..."
>>>
>>> This should be fixed by u-boot. However, there's no telling if
>>> there's more to this workaround in the dma engine. You could try
>>> to do the testing without anything connected to the USB ports
>>> and disable/remove all usb hcds modules. As for fixing this:
>>> I did a quick search but couldn't find any public information.
>>> There's always support@apm.com (contact them!), or maybe someone
>>> from the Amiga community knows more?
>>>
>>>
>> Tested with kernel with all USB disabled. No sata error messages
>> during the partition copy but the copying is quite slow.
> Ok. The CONFIG_DMADEVICES_DEBUG and CONFIG_DMADEVICES_VDEBUG option
> have quite a large overhead, if this fixed the issue for now you
> could try to disable them and look if the issue comes back or not.
> (also, you can drop the mdelay patch if it's still applied). If
> the issue doesn't come back, you could add your "Tested-by" tag
> too.
>
> Another thing, the sata dwc driver doesn't yet support NCQ. Do you
> know if the driver for the Amiga OS does?
>
>> so this does appear to be the problem.
> So, how to fix this? I know, there's an AHB DMA Arbiter. But I can't
> get any documentation for it from AMCC/APM. Maybe denx.de or someone
> from the Amiga community knows how to deal with it. In theory, we
> could try if limiting the burst length, pending dma request count or
> add code to retry failed dma transfers and reinit the usb-cores would
> help.
>
> Regards,
> Christian
>
>
Disabled

CONFIG_DMADEVICES_DEBUG and CONFIG_DMADEVICES_VDEBUG

Still see issues with the USB enabled.
With USB also disabled I was able to finish the partition copy. But 
again it is very slow.

(parted) mklabel msdos
Warning: The existing disk label on /dev/sda will be destroyed and all 
data on
this disk will be lost. Do you want to continue?
Yes/No? y
(parted) p
Model: ATA WDC WD5000AAKX-0 (scsi)
Disk /dev/sda: 500GB
Sector size (logical/physical): 512B/512B
Partition Table: msdos
Disk Flags:

Number  Start  End  Size  Type  File system  Flags

(parted) q
Information: You may need to update /etc/fstab.

root@Amigaone:/home/amigaone# dd if=/dev/sdb6 of=/dev/sda
43597824+0 records in
43597824+0 records out
22322085888 bytes (22 GB, 21 GiB) copied, 2825.93 s, 7.9 MB/s

Regards
Julian
