To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: "Embedded Linux PPC list" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: list of 2.6-related migration issues for embedded programmers?
References: <Pine.LNX.4.60.0407200830400.4974@localhost.localdomain>
From: "Linh Dang" <linhd@nortelnetworks.com>
Date: Tue, 20 Jul 2004 09:19:05 -0400
In-Reply-To: <Pine.LNX.4.60.0407200830400.4974@localhost.localdomain> (Robert
 P. J. Day's message of "Tue, 20 Jul 2004 08:32:27 -0400")
Message-ID: <wn5isci95py.fsf@linhd-2.ca.nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 20 Jul 2004, rpjday@mindspring.com wrote:

> On Tue, 20 Jul 2004, Linh Dang wrote:
>
>>
>> On 20 Jul 2004, wd@denx.de wrote:
>>
>>> In message <wn5zn5v8nl8.fsf@linhd-2.ca.nortel.com> you wrote:
>>>>
>>>> - I failed to see what in initramfs mechanism would prevent
>>>> one from having "separated images which can be updated
>>>> independently of each other."
>>>
>>> initramfs gets linked with the kernel into one image, similar to
>>
>> But you don't have to. What ever you can do with the good-old
>> initrd image you can do with the new initramfs (really cpio
>> archive) image. The main difference is the creation: genext2fs vs
>> cpio.
>>
>> I just happen to use zImage.initrd (where ramdisk.image.gz is a
>> cpio archive) in our project because it's the most appropriate for
>> our situation.
>
> i have to agree with wolfgang here -- how would you create and use
> an initramfs image separately from the kernel image?  the only
> possibility i can see based on my perusal is to incorporate the
> initramfs into the zImage.initrd.

Hmm, I will have to try it (when I have time). From reading the kernel
code, the kernel itself doesn't care where the initramfs came from
(whether it's in the .ramdisk section or it's passed from the
bootloader). The kernel decompresses the data at initrd_start and look
for cpio magic. if that failed, it'll try to use the data as a
compress fs image.

I've never tried uboot because we have our own custom bootloader here
(for our own proprietary boards) so I have no idea about uboot's
features/limitations.

Regards

--
L.D.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
