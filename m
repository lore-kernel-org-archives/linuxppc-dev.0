Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BF64FDDDF9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Apr 2008 15:49:37 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JpGoP-0007bh-Vv
	for linuxppc-embedded@ozlabs.org; Thu, 24 Apr 2008 22:49:33 -0700
Message-ID: <16890712.post@talk.nabble.com>
Date: Thu, 24 Apr 2008 22:49:33 -0700 (PDT)
From: gforgcc <narendra.ka@lntemsys.com>
To: linuxppc-embedded@ozlabs.org
Subject: bringing up latest kernel on EP8248E problems....
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi geeks,
i am trying to bring up the latest kernel on EP8248 target,
i am using U-boot-1.3.2 and linux-2.6.25-rc8,
I had some problems when i tried to build the u-boot source ( first i did
""make ep8248_config"" and then ""make"") it was giving undefined reference
related to ft_board_setup() function so i altered the U-boot-1.3.2 source
code... i added the below code to the following file board/ep8248/ep8248.c

#if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
void ft_board_setup(void *blob, bd_t *bd)
{
        ft_cpu_setup(blob, bd);
}
#endif /* defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP) */


and also added the below lines to the file include/configs/ep8248.h by
looking into the corresponding .dts file in the kernel source....


/* pass open firmware flat tree */
#define CONFIG_OF_LIBFDT        1
#define CONFIG_OF_BOARD_SETUP   1

#define OF_CPU  "PowerPC,8248@0"
#define OF_SOC  "soc@f0000000"
#define OF_TBCLK        (bd->bi_busfreq / 4)
#define OF_STDOUT_PATH  "/soc@f0000000/serial@11a80"

Now afte doing the above 2 alterations i was able to build the u-boot-1.3.2
source for ep8248e....

then i created the uImage with the latest kernel source linux-2.6.25-rc8 and
put that uImage to the target...also i created the ep8248e.dtb from the dtc
(DEVICE TREE COMPILER) and put that to the target and passed this as an
argument to the bootm
I also cross checked in the U-boot environment for the fdt command ... it
was present
Finally when it hanged I started debugging using BDI2000.which helped me to
know atleast what is going wrong, i have added some printk's in the kernel
source but still i am not able to find where and what exactly is going
wrong, The first statement it is printing in the log buffer is
""Using Embedded Planet EP8248E machine description"" and thats it the next
message is
Unable to handle kernel paging request for data at address 0xbfff0000
Faulting instruction address:0xc0012070 (This nearest address to this
address in System.map file is cacheable_memzero)
and tracing like this i came to know that in the file
arch/powerpc/mm/ppc_mmu_32.c , here in the function __init MMU_init_hw() and
in the line n_hpteg = total_memory / (PAGE_SIZE * 8); probably it is getting
problem because when i tried to print the variable total_memory it is
printing zero !!! :( :(  so probably i am thinking it is not able to find
some memory for Hash table :(
Please share your knowledge and skills to solve this problem.. 
thanks... :)

-- 
View this message in context: http://www.nabble.com/bringing-up-latest-kernel-on-EP8248E-problems....-tp16890712p16890712.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
