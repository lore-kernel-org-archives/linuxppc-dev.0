Date: Fri, 13 Jun 2003 04:20:45 -0400
From: Callebaut Benoit <callebaut@mailandnews.com>
To: "yong_guo" <yong_guo@scomcenter.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: RE :how to do:root filesystem on flash?
Message-ID: <3EEBA193@mailandnews.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I don't know the internals of the 860 for addressing but a generic answer can
be the following.
Linux doesn't care of the real start address of the flash.
So a good idea, if you don't need to update the kernel using Linux is to make
the flash appears smaller to Linux by changing the langth and eventually the
start address in the kernel.
Using the default block driver (found in /drivers/mtd/mtdblock.c) the root
filesystem must be burn at the start of the flash as defined for Linux.
If your registered name is /dev/flasha try with this name but take in account
that at boot time all the Linux system is not yet loaded. DevFS is not yet
loaded and Linux use at this moment a minimal device support code with fixed
names. So there is a lot of chance that your flash is still recognizd as
/dev/mtdblock0. To be sure of this take a look in init/main.c.
There is a table of known devices and the flash is defined at he last line as
{"mtdblock", 0X1F00}


>===== Original Message From "yong_guo" <yong_guo@scomcenter.com> =====
>----- Original Message -----
>From: "Callebaut Benoit" <callebaut@mailandnews.com>
>To: "linuxppc-embedded mailing list" <linuxppc-embedded@lists.linuxppc.org>
>Sent: Thursday, June 12, 2003 5:33 PM
>Subject: RE :how to do:root filesystem on flash?
>
>
>>
>> I,
>> 1 : Create a cramfs filesystem with the right endianess from your nfs
>> filesystem using mkcramfs.
>> Burn it into the flash( at the start of the flash).
>Is it must be burned from the start of the flash?  My u-boot bin code is
>burned at the start of the flash.
>
>>
>> 2 : In your kernel config set the "root=" option to : "/dev/mtdblock0"
>In my system, the flash is registered as /dev/flasha, should i pass the
>parameter "root=/dev/flasha" to kernel?
>
>> Enable Flash MTDBlock support and the right options like CFI,...
>> Set up the start of the flash and its length
>> Enable Cramfs in filesystem
>> Disable NFS as root filesystem.
>>
>> Rebuild your kernel and flash it.
>> Reboot the board en enjoy.
>>
>> PS : This question was already a 100 times answered. Search in the mailing
>> list before asking such a question.
>> Or maybe a better idea : One may build a FAQ or a list of Howtos on such
>> common questions.
>>
>> Benoit Callebaut
>>
>>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
