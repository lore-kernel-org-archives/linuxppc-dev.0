Return-Path: <d.grab@hima.com>
Received: from hima.com (mail.hima.com [80.146.244.10])
	by ozlabs.org (Postfix) with SMTP id 1953667BC9
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Jul 2005 19:08:47 +1000 (EST)
Received: from SN7606 ([192.168.100.10])
	by hima.com (mail.hima.com [212.116.4.129]) (MDaemon.PRO.v8.0.3.R)
	with ESMTP id md50000034534.msg
	for <linuxppc-embedded@ozlabs.org>; Wed, 06 Jul 2005 11:08:25 +0200
From: "David Grab" <d.grab@hima.com>
To: <wd@denx.de>
Date: Wed, 6 Jul 2005 11:07:13 +0200
Message-ID: <000c01c5820a$19fc5be0$f201a8c0@SN7606>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20050705160149.3BDF7353A5E@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: AW: AW: initrd rootfs ramdisk
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>> >But the kernel prints the boot parameters just fine.
>>
>> Maybe because i defined it in kernel configuration! But from u-boot i
don´t
>> get any arguments.

>Then you must be using a wrong image type. Are you sure you use "make
>uImage" to build your kernel image for U-Boot?

No, i´m using kernel 2.6.11.6 from kernel.org. It´s compiled with the actual
ELDK and made with "make uImage".

>> I thougt i can give the linux kernel position from u-boot where initrd is
>> located, but i have the same problem.

>You don;t. U-Boot passes this information automatically.

>> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
>> loop: loaded (max 8 devices)
>> VFS: Cannot open root device "<NULL>" or unknown-block(3,1)
>> Please append a correct "root=" boot option
>> Kernel panic - not syncing: VFS: Unable to mount root fs on
>> unknown-block(3,1)

>Block device 3, 1 is /dev/hda1 - is your ramdisk known to be working?

Ramdisk is from ELDK build with mkimage like mentioned in FAQ.


I debugged to see what happens. First of all machine init in
\arch\ppc\kernel\setup.c is called. In this function a call to platform_init
is made. But the platform init of my own board files are called not the
implementation of setup.c which is only available if
CONFIG_PPC_MULTIPLATFORM is set. In my own platform_init is only a call to
find_bootinfo which is resulting in NULL because rec->tag is 0. That´s the
reason why parse_bootinfo don´t set the CMD_LINE, etc..

struct bi_record *find_bootinfo(void)
{
	struct bi_record *rec;

	rec = (struct bi_record *)_ALIGN((ulong)__bss_start+(1<<20)-1,(1<<20));
	if ( rec->tag != BI_FIRST ) {
		/*
		 * This 0x10000 offset is a terrible hack but it will go away when
		 * we have the bootloader handle all the relocation and
		 * prom calls -- Cort
		 */
		rec = (struct bi_record
*)_ALIGN((ulong)__bss_start+0x10000+(1<<20)-1,(1<<20));
		if ( rec->tag != BI_FIRST )
			return NULL;
	}
	return rec;
}

In this line rec is set to 0xc0300000
rec = (struct bi_record *)_ALIGN((ulong)__bss_start+(1<<20)-1,(1<<20));

if definitions are in both lines true because rec->tag is 0

in this line rec address is also 0xc0300000
rec = (struct bi_record
*)_ALIGN((ulong)__bss_start+0x10000+(1<<20)-1,(1<<20));


The following line in my own board.c platform_init gets the board
information. So u-boot pass the informations quite well.

	if (r3)
		__res = *(bd_t *)(r3 + KERNELBASE);

So what is wrong with my find_bootinfo function? Why is rec->tag zero?

Thx for advice,

David
