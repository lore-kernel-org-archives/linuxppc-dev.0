Message-ID: <000c01beea21$27e39840$68f102de@sjzhu>
Reply-To: "Shuangjun Zhu (r44089)" <r44089@email.sps.mot.com>
From: "Shuangjun Zhu" <r44089@email.sps.mot.com>
To: "Magnus Damm" <damm@kieraypc01.p.y.ki.era.ericsson.se>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: How to enable data cache for MPC860
Date: Thu, 19 Aug 1999 16:59:30 +0800
MIME-Version: 1.0
Content-Type: text/plain;	charset="gb2312"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Are there any problems in following code,
It seems that there are some problems for accessing VRAM.

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
MD_RESETVAL=0x04000000 # Value of register at reset 
BOOT_IMMR=0xff000000
MI_EVALID=0x00000200 # Entry is valid 
MI_PS8MEG=0x0000000c # 8M page size 
MI_SVALID=0x00000001 # Segment entry is valid 
MI_BOOTINIT=0x000009fd
MD_EVALID=0x00000200 # Entry is valid 
MD_PS8MEG=0x0000000c # 8M page size
MD_SVALID=0x00000001 # Segment entry is valid
IDC_INVALL=0x0c000000 # Invalidate all 
IDC_ENABLE=0x02000000 # Cache enable 
MSR_IR=(1<<5)      # Instruction MMU enable */
MSR_DR=(1<<4)      # Data MMU enable */


 tlbia   # Invalidate all TLB entries 
 li r8, 0
 mtspr 784, r8 # Set instruction control to zero 
 lis r8, 0x1400
 mtspr 792, r8 # Set data TLB control 

 #
 # Now map the lower 8 Meg into the TLBs.  For this quick hack,
 # we can load the instruction and data TLB registers with the
 # same values.
 #
    mfspr   r8,792
    ori     r8,r8,0x1f00      # set TBL idx to 31 
    mtspr   792, r8
 lis r8, 0 #Create vaddr for TLB 
 ori r8, r8, MI_EVALID # Mark it valid 
 mtspr 787, r8
 mtspr 795, r8
 li r8, MI_PS8MEG  # Set 8M byte page 
 ori r8, r8, MI_SVALID # Make it valid 
 mtspr 789, r8
 mtspr 797, r8
 li r8, MI_BOOTINIT  # Create RPN for address 0 #
 mtspr 790, r8  # Store TLB entry 
 mtspr 798, r8

# lis r8, 0x4000      # Set the protection mode 
# mtspr 786, r8
# mtspr 794, r8

 # We will get these from a configuration file as soon as I verify
 # the extraneous bits don't cause problems in the TLB.
 #
   
 # Map another 8 MByte at immr=0xff000000 to get the processor
 # internal registers (among other things).
 #
    lis     r8, 0xff00         # Create vaddr for TLB #
    ori     r8, r8, MD_EVALID       # Mark it valid 
    mtspr   795, r8
    li      r8, MD_PS8MEG           # Set 8M byte page 
    ori     r8, r8, MD_SVALID       # Make it valid 
    mtspr   797, r8
    lis     r8, 0xff00         # Create paddr for TLB 
    ori     r8, r8, MI_BOOTINIT|0x2 # Inhibit cache -- Cort 
    mtspr   798, r8
    
 # Map another 8 MByte at VRAM=0x0c000000
 #
    lis     r8, 0x0C00         # Create vaddr for TLB #
    ori     r8, r8, MD_EVALID       # Mark it valid 
    mtspr   795, r8
    li      r8, MD_PS8MEG           # Set 8M byte page 
    ori     r8, r8, MD_SVALID       # Make it valid 
    mtspr   797, r8
    lis     r8, 0x0C00         # Create paddr for TLB 
    ori     r8, r8, MI_BOOTINIT|0x2 # Inhibit cache -- Cort 
    mtspr   798, r8
    
 # Map another 8 MByte at VRAM=0x0c800000
 #
    lis     r8, 0x0C80         # Create vaddr for TLB #
    ori     r8, r8, MD_EVALID       # Mark it valid 
    mtspr   795, r8
    li      r8, MD_PS8MEG           # Set 8M byte page 
    ori     r8, r8, MD_SVALID       # Make it valid 
    mtspr   797, r8
    lis     r8, 0x0C80         # Create paddr for TLB 
    ori     r8, r8, MI_BOOTINIT|0x2 # Inhibit cache -- Cort 
    mtspr   798, r8
    
 # Map another 8 MByte at Flash ROM =0x04000000
 #
    lis     r8, 0x0400         # Create vaddr for TLB #
    ori     r8, r8, MD_EVALID       # Mark it valid 
    mtspr   795, r8
    li      r8, MD_PS8MEG           # Set 8M byte page 
    ori     r8, r8, MD_SVALID       # Make it valid 
    mtspr   797, r8
    lis     r8, 0x0400         # Create paddr for TLB 
    ori     r8, r8, MI_BOOTINIT|0x2 # Inhibit cache -- Cort 
    mtspr   798, r8
    
 # Map another 8 MByte at ISA=0x06000000
 #
    lis     r8, 0x0600         # Create vaddr for TLB #
    ori     r8, r8, MD_EVALID       # Mark it valid 
    mtspr   795, r8
    li      r8, MD_PS8MEG           # Set 8M byte page 
    ori     r8, r8, MD_SVALID       # Make it valid 
    mtspr   797, r8
    lis     r8, 0x0600         # Create paddr for TLB 
    ori     r8, r8, MI_BOOTINIT|0x2 # Inhibit cache -- Cort 
    mtspr   798, r8
    
#    mfspr   r8,792
#    oris    r8,r8,0x0800            # set RSV2D 
#    mtspr   792, r8
    
# For a debug option, I left this here to easily enable
# the write through cache mode
#
# lis r8, DC_SFWT@h
# mtspr DC_CST, r8
# lis r8, IDC_ENABLE@h
# mtspr DC_CST, r8
#

turn_on_mmu:
 mfmsr r0
 ori r0,r0,MSR_DR|MSR_IR
 mtspr SRR1,r0
 lis r0,start_here@h
 ori r0,r0,start_here@l
 mtspr SRR0,r0
 SYNC
 rfi    # enables MMU 


start_here:
 # Since the cache is enabled according to the information we
 # just loaded into the TLB, invalidate and enable the caches here.
 # We should probably check/set other modes....later.
 #/

 lis r8, 0x0A00
 mtspr 560, r8      #IC_CST
 mtspr 568, r8      #DC_CST

 lis r8, 0x0c00
 mtspr 560, r8      #IC_CST
 mtspr 568, r8      #DC_CST

 lis r8, 0x0200
 mtspr 560, r8
 mtspr 568, r8

; load OS from FLASH ROM to DRAM   
   bl  main
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-----Original Message-----
From: Magnus Damm <damm@kieraypc01.p.y.ki.era.ericsson.se>
To: Shuangjun Zhu (r44089) <r44089@email.sps.mot.com>
Cc: linuxppc-dev@lists.linuxppc.org <linuxppc-dev@lists.linuxppc.org>
Date: Thursday, August 19, 1999 3:08 PM
Subject: Re: How to enable data cache for MPC860


>
>
>>   I have a MPC860 board, which there are some memory space like VRAM or ISA.
>> I donot know how to enable data cache for DRAM, and will not effect
>> the accessing VRAM and ISA.
>
>You will need to use the mmu and use page tables that describes the IO
>regions
>as non-cacheable, and the dram tables as cacheable.
>using the mmu will probably increase the performance because the cpu can
>use
>speculative instruction fetch.
>
>have a look in head.S in the linux kernel source.
>you will see how the cache is turned on and tables are reserved.
>and finnaly is the mmu turned on.
>
>please note that the cache should be invalidated, which not is done in
>the
>linux source code. it should be done in the bootcode that runs before
>linux.
>have a look in the manual.
>
>i think motorola has some example code too if you look around at their
>website.
>
>cheers /
>
>magnus
>
>

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
