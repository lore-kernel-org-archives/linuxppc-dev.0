Return-Path: <listmail@conspiracy.net>
Received: from ns.traffictel.com (mail.conspiracy.net [209.189.226.94])
	by ozlabs.org (Postfix) with ESMTP id AB5D22BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Dec 2004 14:43:56 +1100 (EST)
Message-ID: <41D0D368.3080702@conspiracy.net>
Date: Mon, 27 Dec 2004 21:30:48 -0600
From: "paul.bilke" <listmail@conspiracy.net>
MIME-Version: 1.0
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
References: <313680C9A886D511A06000204840E1CF0A64741C@whq-msgusr-02.pit.comms.marconi.com>
In-Reply-To: <313680C9A886D511A06000204840E1CF0A64741C@whq-msgusr-02.pit.comms.marconi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: simple bootloader 2.6.10-rc3 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This sounds extremely  familiar to me, and wd has already fixed it for 
me, and I suspect for you to.
If you are running a duet variant (870,880,885) there is a CPU errata 
which was the cause in my case.
Look here http://www.freescale.com/files/32bit/doc/errata/MPC885CE.pdf
and at the CPU15 section.  Moving things around in the kernel sometimes 
makes this go away but really its just hidden.
In my case it would explode in zlib_inflate also.  Putting some output 
in the routine would move it so it did not fail but since
these loops were executed 1000's of times it would take many minutes to 
boot.
I hired Wolfgang to implement the suggested work around and I believe he 
has put the necessary code into his 2.4 tree already.
It should be possable to port to you kernel, whatever it is.  As I 
remember it would fail with the instruction pointer always ending in 000.


Hopefully this will help

Paul Bilke

Povolotsky, Alexander wrote:

>Hi,
>
>I have in .config
>...
>CONFIG_ADVANCED_OPTIONS=y
>CONFIG_HIGHMEM_START=0xfe000000
># CONFIG_LOWMEM_SIZE_BOOL is not set
>CONFIG_LOWMEM_SIZE=0x30000000
>CONFIG_KERNEL_START_BOOL=y
>CONFIG_KERNEL_START=0xc0000000
># CONFIG_TASK_SIZE_BOOL is not set
>CONFIG_TASK_SIZE=0x80000000
># CONFIG_CONSISTENT_START_BOOL is not set
>CONFIG_CONSISTENT_START=0xff100000
># CONFIG_CONSISTENT_SIZE_BOOL is not set
>CONFIG_CONSISTENT_SIZE=0x00200000
>CONFIG_BOOT_LOAD_BOOL=y
>CONFIG_BOOT_LOAD=0x00400000
>...
>
>I get (I did not include ramdisk/initrd into the image loaded) :
>
>loaded at:     00180000 00268160
>relocated to:  00400000 004E8160
>board data at: 004E6124 004E6140
>relocated to:  0040509C 004050B8
>zimage at:     00405891 004E5926
>avail ram:     004E9000 02000000
>
>Is above dispostion looks correct ?
>
>Then load_kernel() (in arch/ppc/boot/simple/misc-embedded.c) fails during
>uncompressing kernel whithin: 
>
>gunzip(0, 0x400000, zimage_start, &zimage_size);
>
>Specifically within gunzip() (in arch/ppc/boot/common/misc-common.c) it
>fails after successfully passing 
>through zlib_inflateInit2() .  I think it fails in in zlib_inflate() .
>
>Any ideas/advise ?
>Why second argument while calling gunzip() is set to 0x400000 ?
>
>Thanks,
>Alex 
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>  
>
