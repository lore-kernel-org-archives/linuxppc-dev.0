Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id BC442DE042
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 02:44:21 +1100 (EST)
In-Reply-To: <20090110195040.GA19945@lisas.de>
References: <1231601482-28123-1-git-send-email-adrian@lisas.de>
	<c613a7e0a88e249894bafe6d2183fbf2@bga.com>
	<20090110195040.GA19945@lisas.de>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6550a303b71331432a805ad98ca38103@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] powerpc: Add support to access the flash on SLOF based
	systems
Date: Mon, 12 Jan 2009 09:51:23 -0600
To: Adrian Reber <adrian@lisas.de>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 10, 2009, at 1:50 PM, Adrian Reber wrote:

> On Sat, Jan 10, 2009 at 11:52:56AM -0600, Milton Miller wrote:
>> On Sun Jan 11 at 02:31:22 EST in 2009, Adrian Reber wrote:
>>> This adds support for a simple character device to access the
>>> flash for SLOF based systems like the PowerStation, QS2x and
>>> PXCAB. In the SLOF git there is a user space program with
>>> which the content of the flash for SLOF based systems can
>>> be displayed and modified. This can be used to add a Linux
>>> image to the flash and then directly boot the kernel from the
>>> flash.
>>>
>>> Signed-off-by: Adrian Reber <adrian at lisas.de>
>>> ---
>>>
>>> This is based on the mmio NVRAM driver. I am not sure how useful this
>>> is for anybody else but I am posting it anyway, hoping to get some
>>> feedback. Also hoping it can be included at one point.
>>
>>
>> Normally such drivers are written and mtd drivers.
>>
>> If slof were not an of implementation I would just say put the right
>> properties on the node in the device tree, but the kernel should adapt
>> to real OF.  It should be easy to write a driver to hook up a mtd
>> platform device if this is a direct mapped flash.
>
> The reason why I did not use mtd is that part of the flash is used by
> the firmware image and I do not know if that works with mtd, if only a
> part of the flash can be used. SLOF does also a "CRC" check over the
> firmware image, so that image must have valid SLOF "CRC". The flash is
> a direct mapped flash, but the size of the firmware can vary.


But you later say you will only be using this driver to read the flash.

>>> +       spin_lock_irqsave(&slof_flash_lock, flags);
>>> +
>>> +       memcpy_fromio(tmp, slof_flash_start + *ppos, count);
>>> +
>>> +       spin_unlock_irqrestore(&slof_flash_lock, flags);
>>> +
>>
>> Why do you need a spinlock?  Why does it need to be irq safe?
>
> I must confess I copied that code from the nvram driver and I do not
> know if it is necessary.

I'm not sure which driver you ar referring to here.  Which file name?

Its not required for memcpy_fromio.  If you have no indirect indexing 
or writing to require exclusing against concurrent access ...

>
>> This decision is also driving the malloc of the temporary buffer, and
>> you are intentionally returning a short read to userspace.
>>
>>> +
>>> +const struct file_operations slof_flash_fops = {
>>> +       .owner = THIS_MODULE,
>>> +       .llseek = slof_flash_llseek,
>>> +       .read = slof_flash_read,
>>> +};
>>> +
>>
>> You mentioned userspace reflashing the image, but this driver seems to
>> be read only access.
>
> This driver is read only. I am writing the new flash image using the
> RTAS functionality to update the firmware flash. Using this device I 
> can
> use a userspace tool to add a file to the flash. The tool puts the
> result on the local filesystem. Then using the normal RTAS flash update
> it can be rewritten. That way I can add a kernel (with a ramdisk) to 
> the
> flash and then let SLOF boot that kernel. This is especially 
> interesting
> for the PXCAB Cell based PCI Express card.

Ok you need to highlight that you will be using the platform support to 
write the image.  Reading the patch (again) it would appear that you 
are just reading the size of the node from the device tree.  Regardless 
even if you are trying to cover the whole rom or a portion, read-ony 
access should be safe, if not secure.

>>
>>
>> Can you identify slof from the information in the /openprom node?  I
>
> Yes I can identify SLOF from the model property in the /openprom node. 
> I
> did not do it because there is almost no code accessing the /openprom
> node and therefore I did not read it.
>
>> don't think all js20 and 21 use slof, although the IBM provided 
>> firmware
>> may also work with this driver.
>
> There are probably only very few js20/js21 which are using SLOF. I do
> not think the original IBM product firmware for those blades mentions
> anything about js20/js21 in the compatible node. I do not have access 
> to
> such a system but the compatible node usually has some product number,
> if I remember it correctly.
>
> I am pretty sure that the original js20/js21 firmware does not have the
> flash in the device tree, because RTAS is supposed to be the only valid
> way to access the flash.
>
>>> +       if ((slof_flash_len <= 0) || (!slof_flash_addr)) {
>>> +               printk(KERN_WARNING "SLOF FLASH: address or length is
>>> 0\n");
>>> +               rc = -EIO;
>>> +               goto out;
>>> +       }
>>
>> Why are these warnings?   again, debug is more approprate
>
> Copied from the NVRAM driver. Will change it to debug.

Thanks.  These would still apply to a mtd driver.

>>> +
>>> +       rc = misc_register(&slof_flash_dev);
>>
>> And as I said, this should be a mtd driver.
>
> Thanks for the review. Should it also be a mtd driver with the firmware
> at the beginning of the flash with an unknown size?
>
> I would also prefer to continue to use the RTAS flash update
> functionality to write the flash instead of reimplementing it in the
> operating system.

I don't have a problem  with that, but it should have been mentioned up 
front.
>
> My main motivation for this code was to have a way to access the
> firmware image. The firmware image is using some kind of simple
> filesystem. I want to be able to modify that filesystem and flash it
> again. The advantage if I put something in SLOF's filesystem is that I
> can access that file (in my case boot it) with existing functionality
> provided by SLOF.

Is SLOF just exposing the user image part of the flash device?  Or is 
it the raw flash device?

I need to keep this quick, but am intrested in a few more details.  My 
first reaction is its yet another random misc-device, but I confess to 
having written one for internal consumption.  But as a misc device it 
will need to go through lkml review to be merged.

milton
