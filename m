Return-Path: <mederle_nicolas@yahoo.fr>
Received: from smtp003.mail.ukl.yahoo.com (smtp003.mail.ukl.yahoo.com
	[217.12.11.34]) by ozlabs.org (Postfix) with SMTP id 05971DDE04
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 00:29:54 +1000 (EST)
Message-ID: <46963AF4.7030209@yahoo.fr>
Date: Thu, 12 Jul 2007 16:30:12 +0200
From: Nicolas Mederle <mederle_nicolas@yahoo.fr>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org,  linuxppc-embedded@ozlabs.org
Subject: The kernel source in RAM is covered by data
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

    I have port Linux on a PowerPc board. I have the following problems, 
the kernel source is covered by data.
For example, after the kernel unzip by the loader, I have this mapping :
                   _start:
00000000: nop
00000004: nop
00000008: nop
                   __start:
0000000c: mr      r31,r3
00000010: mr      r30,r4
00000014: li      r24,0
00000018: bl      early_init
0000001c: bl      mmu_off
                   __after_mmu_off:
00000020: bl      clear_bats
00000024: bl      flush_tlbs
00000028: bl      initial_bats
0000002c: bl      setup_disp_bat
00000030: bl      reloc_offset

When the kernel launch the init process, I have an PageFault error. And 
the mapping is the following :
                   _start:
00000000: .long   0
00000004: .long   0xB0
00000008: .long   0x67DC28
                   __start:
0000000c: .long   0x3C5FD0
00000010: .long   0x1031C
00000014: .long   0x8001032
00000018: .long   0
0000001c:  .long   4
                   __after_mmu_off:
00000020: .long   1
00000024: .long   0x10590
00000028: .long   0x1032
0000002c: .long   0x1031C
00000030: .long   0x320000

Why the kernel space is modified? I have forgot a config in the kernel 
config? the advanced setup kernel config is the following :
    CONFIG_ADVANCED_OPTIONS=y
    CONFIG_HIGHMEM_START=0xfe000000
    CONFIG_LOWMEM_SIZE_BOOL=y
    CONFIG_LOWMEM_SIZE=0x30000000
    CONFIG_KERNEL_START_BOOL=y
    CONFIG_KERNEL_START=0x0
    # CONFIG_TASK_SIZE_BOOL is not set
    CONFIG_TASK_SIZE=0x80000000
    CONFIG_BOOT_LOAD_BOOL=y
    CONFIG_BOOT_LOAD=0x00400000

Thanks for your feedback,
Nicolas MEDERLE.

-- 
Cordialement,

Nicolas MEDERLE. 
