Return-Path: <srinivas.surabhi@wipro.com>
Received: from wip-ectls-mx3.wipro.com (wip-ectls-mx3.wipro.com
	[203.101.113.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wip-ectls-mx3.wipro.com",
	Issuer "certserv.wipro.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D271467A7C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Feb 2005 14:19:04 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 16 Feb 2005 08:48:58 +0530
Message-ID: <EF9B29C78F41FA488927FCBC7750AF0E011DA5D1@hyd-mdp-msg.wipro.com>
From: <srinivas.surabhi@wipro.com>
To: <wd@denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Mounta Vista Linux prompt on serial console 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


>> Do not ignore this error. How big is your cramfs image? How  much
RAM
>> do you have?

cramfs is 2.7MB where as the RAM size is 32MB. While building ofcourse
the RAMDISK size was told as 8MB. This I mentioned in the devrocket
kernel configuration.

Just FYI. Kernel Image was 640KB.

Here I have one doubt while building the uBoot image using mkImage with
multi option where was the FileSystem image getting downloaded ? and how
the downloaded location was known to the kernel Image for pointing out
the File System image location. The options -a and -e are applicable
only for first image, isn't it? First image I mean the kernel Image. I
was giving -a 0x0 and -e 0x0 since while building the kernel the kernel
base address was mentioned 0.

...
>> Is there any chance that you built your cramfs image on a x08 (or any
>> other little-endian) system and forgot  to  give  the  "-r"  (reverse
>> endian-ness of filesystem) option to mkcramfs??

YES. You are right I am building the image on x86 (Windows platform).
But I checked the build log it used the -r option. The default build was
cpio format and after that using fstool converting to CRAMS and the
option -r was present .I believe that devrocket of MountaVista has
makefiles specific to OS i.e for Windows, because while installation it
asks for what type of OS do you want to have the Image Development
environment.

Thanks & Regards
Surabhi Srinivas


-----Original Message-----
From: wd@denx.de [mailto:wd@denx.de]=0D
Sent: Wednesday, February 16, 2005 1:30 AM
To: Srinivas Surabhi (WT01 - EMBEDDED & PRODUCT ENGINEERING SOLUTIONS)
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Mounta Vista Linux prompt on serial console=0D

In message
<EF9B29C78F41FA488927FCBC7750AF0E011DA5CB@hyd-mdp-msg.wipro.com> you
wrote:
>=0D
> My replies in blue tagged with surabhi

Don't do this. Email is a plain text medium only.

Read the netiquette, and quote properly.

> [surabhi --- start] could you please guide me how to provide a working
> file system on SDRAM before decompressing the Linux Image on SDRAM. Is
> it really related to init process failed.

It is obviously related -there was a clear  error  message  that  the
uncompressing of the cramfs filesystem failed.

> Is the below doesn't mean that the mounted one is working one ?
> "VFS: Mounted root (cramfs filesystem) readonly.
>  Mounted devfs on /dev "

No, not at all. You can for example mount an empty  filesystem  -  it
will mount perfectly fine, but it still doesn't work.


You should also read my message until the end; I asked:


>> Do not ignore this error. How big is your cramfs iage? How  much  RAM
>> do you have?

cramfs is 2.7MB where as the RAM size is 32MB. While building ofcourse
the RAMDISK size was told as 8MB. This I mentioned in the devrocket
kernel configuration.

...
>> Is there any chance that you built your cramfs image on a x08 (or any
>> other little-endian) system and forgot  to  give  the  "-r"  (reverse
>> endian-ness of filesystem) option to mkcramfs??

YES. You are right I am building the image on x86 (Windows platform).
But I checked the build log it used the -r option. The default build was
cpio format and after that using fstool converting to CRAMS and the
option -r was present .I believe that devrocket of MountaVista has
makefiles specific to OS i.e for Windows, because while installation it
asks for what type of OS do you want to have the Image Development
environment.

Thanks & Regards
Surabhi Srinivas


=0D

Best regards,

Wolfgang Denk

--=0D
See us @ Embedded World, Nuremberg, Feb 22 - 24,  Hall 10.0 Booth 310
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Looks clean and obviously correct to me, but then _everything_ I
write always looks obviously correct to me.  - Linus Torvalds in
<Pine.LNX.4.10.10012090054360.791-100000@penguin.transmeta.com>



Confidentiality Notice=0D

The information contained in this electronic message and any attachments to=
 this message are intended
for the exclusive use of the addressee(s) and may contain confidential or=
 privileged information. If
you are not the intended recipient, please notify the sender at Wipro or=
 Mailadmin@wipro.com immediately
and destroy all copies of this message and any attachments.
