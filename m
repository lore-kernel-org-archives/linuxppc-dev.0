Return-Path: <littelld@verizon.net>
Received: from vms173005pub.verizon.net (vms173005pub.verizon.net
	[206.46.173.5]) by ozlabs.org (Postfix) with ESMTP id 5EEB6DDF19
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Sep 2008 23:21:42 +1000 (EST)
Received: from [192.168.1.106] ([96.226.142.190]) by vms173005.mailsrvcs.net
	(Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
	with ESMTPA id <0K6Z00DGGBMOLFZ0@vms173005.mailsrvcs.net> for
	linuxppc-embedded@ozlabs.org; Wed, 10 Sep 2008 07:20:48 -0500 (CDT)
Date: Wed, 10 Sep 2008 07:20:41 -0500
From: Dave Littell <littelld@verizon.net>
Subject: Re: initramfs too large?
In-reply-to: <48C76AFF.6090205@coritel.it>
To: linuxppc-embedded@ozlabs.org
Message-id: <48C7BB99.1070902@verizon.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
References: <48C719BB.1050807@verizon.net> <48C76AFF.6090205@coritel.it>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Marco Stornelli wrote:
> Hi Dave,
> 
> if I well understood you've done a "manual" operation very ugly. You can
> adjust the default settings in the kernel menu under device
> drivers/block devices and set the number of ramdisk device and the
> default size. You can use even the kernel command line option
> "ramdisk_size" to tell to the kernel the size of the ramdisk size you
> are using.
> 
> Regards.
> 

Hi Marco,

Thanks for the reply.  I believe the ramdisk settings are OK, but I'll
post them later to confirm.  I did try changing those settings, but that
didn't help.

Is the kernel command-line option "ramdisk_size" or "ramdisk-size" for
2.6.18?


Thanks,
Dave


> 
> Dave Littell ha scritto:
>> Hi all,
>>
>> I believe my initramfs has grown beyond some limit, but I'm at a loss to
>> know how to correct it.  We recognized that we would have to allow a
>> larger initramfs than the defaults provided, so I modified the following
>> (on a 2.6.18 kernel):
>>
>> 1. .../arch/powerpc/boot/wrapper: A "-Ttext=0x1000000" was added to the
>> ld args.
>>
>> 2. .../arch/powerpc/boot/zImage.lds.S: The ALIGN() directive was changed
>>  to use 16 instead of 4.
>>
>> I thought I was finished and everything seemed to be working well with
>> an initramfs CPIO archive size of approx. 9 MB.  However, we just had
>> another size increase (to a CPIO archive size of approx. 12 MB) and now
>> I'm rewarded with this at boot:
>>
>> ## Booting image at 08000000 ...
>>    Image Name:   Linux-2.6.18_pro500-440epx_eval
>>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>>    Data Size:    7113720 Bytes =  6.8 MB
>>    Load Address: 01000000
>>    Entry Point:  01000410
>>    Verifying Checksum ... OK
>>    Uncompressing Kernel Image ... OK
>> CPU clock-frequency <- 0x27bc86ae (667MHz)
>> CPU timebase-frequency <- 0x27bc86ae (667MHz)
>> /plb: clock-frequency <- 9ef21ab (167MHz)
>> /plb/opb: clock-frequency <- 4f790d5 (83MHz)
>> /plb/opb/ebc: clock-frequency <- 34fb5e3 (56MHz)
>> /plb/opb/serial@ef600300: clock-frequency <- a8c000 (11MHz)
>> /plb/opb/serial@ef600400: clock-frequency <- a8c000 (11MHz)
>> /plb/opb/serial@ef600500: clock-frequency <- a8c000 (11MHz)
>> /plb/opb/serial@ef600600: clock-frequency <- a8c000 (11MHz)
>> Memory <- <0x0 0x0 0x10000000> (256MB)
>> ENET0: local-mac-address <- 00:80:3f:0d:80:0d
>> ENET1: local-mac-address <- 79:60:04:ea:d9:a1
>>
>> zImage starting: loaded at 0x01000000 (sp: 0x0ff182e8)
>> Allocating 0x904dc0 bytes for kernel ...
>> gunzipping (0x00000000 <- 0x0100d000:0x01912c90)...done 0x8de100 bytes
>>
>> Linux/PowerPC load: console=ttyS0,115200 console=ttyMTD3
>> Finalizing device tree... flat tree at 0x191f3a0
>>
>> Here it sits, forever.  I poked around a bit with the JTAG and found (in
>> one instance) that probe_machine() (from setup_common.c) was taking a
>> DataTLBError exception because it appears the machine descriptors are
>> scrubbed to 0.  I added some debug code to setup_common.c, but on the
>> next attempted boot the JTAG showed that DataTLBError exceptions in
>> identify_cpu() (cputable.c).
>>
>> If I reduce the size of initramfs back to it's original size the system
>> runs just fine.  So, I'm guessing the larger initramfs is somehow
>> stomping on something, but have no idea how to proceed to resolve this.
>>
>>
>> Thanks very much,
>> Dave
>>
>>
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
>>   
> 
