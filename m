Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id D6B1CDDF08
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Aug 2008 20:44:29 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KTaJd-0000Y6-UC
	for linuxppc-embedded@ozlabs.org; Thu, 14 Aug 2008 03:44:25 -0700
Message-ID: <18979320.post@talk.nabble.com>
Date: Thu, 14 Aug 2008 03:44:25 -0700 (PDT)
From: wangyanlong <killyouatonce@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: How to use ramdisk on the ml300?
In-Reply-To: <f944af2a0808140004w70948283nde0978d34d1db261@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <931ae8260808132008i1cac2e91kc76c099ecc574cd0@mail.gmail.com>
	<f944af2a0808140004w70948283nde0978d34d1db261@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi JensWirth,
    Thanks  for your reply :). I have some questions here.
    (1)You told me "make simpleImage.virtex405-ml300",i only know "make
zImage" and "make zImage.initrd" ,what it is this command mean???
    (2)What is dts ? I don't know what is this :(
Regards,
YanLong:)

  

Jens Wirth wrote:
> 
> Hi Yanlong,
> 
> On Thu, Aug 14, 2008 at 5:08 AM, yanlong wang <killyouatonce@gmail.com>
> wrote:
>>      If i want use ramdisk on the ml300 , i must use u-boot in my system
>> ?
>>     many thanks
> 
> I suppose you want to use an initial ram filesystem as
> rootfs to boot your system?
> 
> You have to point CONFIG_INITRAMFS_SOURCE="" to a cpio
> archive or a directory which contains your rootfs. If
> you use a directory structure then you should set your
> uid/gid to make the build process convert the owner
> to root:
> 
> # if your uid/gid is 500:
> CONFIG_INITRAMFS_ROOT_UID=500
> CONFIG_INITRAMFS_ROOT_GID=500
> 
> Don't forget to set CONFIG_BLK_DEV_RAM=y to be able
> to use a ramdisk at all.
> 
> I'm also using the ml300 board and I create my kernel
> with: make simpleImage.virtex405-ml300
> 
> My dts is arch/powerpc/boot/dts/virtex405-ml300.dts.
> There is no kernel boot command line needed to use
> the initramfs in my case (I only set up my console
> to the uart). Just download the image
> arch/powerpc/boot/simpleImage.virtex405-ml300.elf
> with xmd to your ml300 and run it.
> 
> I hope this works for you.
> 
> Regards
> Jens
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/How-to-use-ramdisk-on-the-ml300--tp18975066p18979320.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
