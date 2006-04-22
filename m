Return-Path: <listmember@orkun.us>
Received: from www65.dixiesys.com (ns65a.dixiesys.com [65.254.42.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1887C679E1
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 23 Apr 2006 04:50:48 +1000 (EST)
Message-ID: <444A7AF2.5010605@orkun.us>
Date: Sat, 22 Apr 2006 13:50:26 -0500
From: Tolunay Orkun <listmember@orkun.us>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: Upgrading cramfs root file system while running (DENX wrote that
	is not possible)
References: <20060421165548.A03E53526B7@atlas.denx.de>
In-Reply-To: <20060421165548.A03E53526B7@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: White <white@from-b.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Wolfgang Denk wrote:
> In message <44485B3F.8080308@orkun.us> you wrote:
>   
>> If your bootloader is U-Boot and you are using standard bootm command to 
>> boot, U-Boot decompresses the initrd image to RAM before passing the 
>> file system to Linux. So, you are not working with flash copy and 
>> updating the flash copy is not a problem at all. This applies to ext2, 
>> cramfs or squashfs based initrd.
>>     
>
> But it makes no sense to use cramfs or squashfs on a ramdisk.
> You *want* to run these directly from flash.
> But then, of course, you need alternate images (or other tricks)
> for full image updates.
>   
Well, we lose a couple of MB of RAM but squashfs as initrd has been 
reliable, very compact and since the file system is in RAM, it is faster 
and we can tune a bit for smaller cache etc. 

Image updates have been extremely easy as a result, we did not need to 
resort to alternate images and other tricks as a result. If you have 
more flexibility in RAM than in flash, our approach makes sense without 
complicating the matter much. I understand that not everyone might have 
this option.
> [Single file updates can be done using overlay file systems; see  the
> DULG for details.]
I know about the overlay fs. There is also unionfs that works similarly.

Best regards,
Tolunay
