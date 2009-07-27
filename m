Return-Path: <eddie@embeddedarm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3D63FB6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jul 2009 06:15:10 +1000 (EST)
Received: from oz.embeddedARM.com (oz.embeddedarm.com [67.40.67.44])
	by ozlabs.org (Postfix) with ESMTP id 60297DDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2009 06:15:08 +1000 (EST)
Message-ID: <4A6E0AE2.3090600@embeddedarm.com>
Date: Mon, 27 Jul 2009 13:15:30 -0700
From: Eddie Dawydiuk <eddie@embeddedarm.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: image/wrapper script questions
References: <4A6DDF80.209@embeddedarm.com>
	<20090727183155.7FA16832E416@gemini.denx.de>
In-Reply-To: <20090727183155.7FA16832E416@gemini.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Wolfgang,

> In message <4A6DDF80.209@embeddedarm.com> you wrote:
>> I'm working on a custom board using an AMCC 440EP that is using a proprietary 
>> bootloader(optimized for fast boot time). Currently our bootloader loads a 
>> simpleImage.initrd into RAM and jumps into it. I originally chose to use a 
>> simpleImage with an initial ramdisk embedded because it was the simplest 
>> solution to debug the hardware and get a kernel and initial ramdisk running for 
>> development. For production I would prefer to put the initial ramdisk on it's 
> 
> Hm... isn't that an oxymoron? Trying to optimize  for  speed  on  one
> hand, and using an initrd which is one of the slowest ways to boot on
> the other hand?

We advertise the amount of time from a cold boot until one is sitting at a 
command prompt(< 2 s). A Debian filesystem(from Nand or SD card) is then mounted 
in the background. This gives one the power of Debian in a very short amount of 
time. From a technical stand point we have to use an initial ramdisk as we are a 
member of the SD association so we signed an NDA agreeing not to release any 
details of the SD spec. As a result we have code we can't release under the GPL 
so we have to load a proprietary SD card driver as a module.

I guess it depends upon how you define boot, that is we define it as how long it 
takes to get to a Linux shell prompt :) Even without the licensing issue I'm not 
sure we could boot faster(by the definition above) via some other method. All of 
the products I've seen that advertise a fast Linux boot time, boot to an initial 
ramdisk.

http://www.mvista.com/press_release_detail.php?fid=news/2009/Ultra-fast-boot.html

>> Thanks for any suggestions :)
> 
> Use another file system (and another fstype) and separate it from the
> kernel image.
> 
> See also http://www.denx.de/wiki/view/DULG/RootFileSystemSelection

Thanks for the link. Although, I'm not looking for info on optimizing boot time. 
Rather I'm looking for information on what the path of least resistance is to 
boot a kernel with an initrd being loaded from it's own partition. To clarify 
currently I am using a simpleImage.initrd which is a single image with the 
flattened device tree, kernel, and initial ramdisk in a single file. One can 
simply load this image in RAM(assuming 1 to 1 MMU mapping) and jump into it. Now 
what I would like to do is to load a kernel, device tree, and initial ramdisk 
into RAM at different locations.

I'm in the process of coming back up to speed on the low-level boot details of 
the powerpc kernel/architecture. It looks like one can accomplish this by 
loading R3 with the phys address of the device tree block, R4 with the phys 
address of the kernel, and R5 with Null. It also looks like the kernel, already 
has several routines which know about these details(prom_init() and __start()) 
and I was hoping I could reuse this code to accomplish this rather than 
rewriting the bootrom to handle this. That is I was hoping there is a boot 
wrapper image that would allow me to accomplish my goal of creating a single 
image containing a kernel and device tree block, and an interface to specify 
where the bootrom loads the initial ramdisk in RAM. I'll continue reading 
through the docs and code, but if anyone could provide any pointers on how to do 
this I would really appreciate it.

-- 
Best Regards,
________________________________________________________________
  Eddie Dawydiuk, Technologic Systems | voice:  (480) 837-5200
  16525 East Laser Drive              | fax:    (480) 837-5300
  Fountain Hills, AZ 85268            | web: www.embeddedARM.com
