Return-Path: <phenning@vastech.co.za>
Received: from www6.jnb1.host-h.net (www6.jnb1.host-h.net [196.22.132.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D7C9ADE444
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 00:54:35 +1100 (EST)
Received: from [196.213.226.33] (helo=[172.16.63.116])
	by www6.jnb1.host-h.net with esmtpa (Exim 4.66)
	(envelope-from <phenning@vastech.co.za>) id 1LKByU-0000WL-Sv
	for linuxppc-dev@ozlabs.org; Tue, 06 Jan 2009 15:28:03 +0200
Message-ID: <49635C62.5090307@vastech.co.za>
Date: Tue, 06 Jan 2009 15:28:02 +0200
From: Pieter <phenning@vastech.co.za>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Trouble moving custom MPC8548 board to U-boot 1.3
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

I have spent quite some time trying to move from U-Boot 1.2 to a newer
version.. I am stuck at the initialization of the ram. The ram checksum
fails and gives me a "total memory of 0". (the board has 512MB and work
when booting uboot 1.2)

can anyone pls. point me in the right direction?

My console output is as follows:

    U-Boot 2008.10-00334-g90665e3-dirty-svn1154 (Jan  6 2009 -
    13:40:47)           
                                                                                   

    CPU:   8548E, Version: 1.1,
    (0x80390011)                                       
    Core:  E500, Version: 1.0,
    (0x80210010)                                        
    Clock
    Configuration:                                                           

           CPU:990  MHz, CCB:396 
    MHz,                                             
           DDR:198  MHz (396 MT/s data rate), LBC:49.500
    MHz                       
    L1:    D-cache 32 kB
    enabled                                                   
           I-cache 32 kB
    enabled                                                   
    Board: Equus
    MPC8548                                                           
        PCI1: 64 bit, 66 MHz,
    sync                                                 
    I2C:  
    ready                                                                   

    DRAM: 
    Initializing                                                            

    fsl_ddr_sdram                                                                  

    starting at step 1
    (STEP_GET_SPD)                                              
    SPD checksum unexpected. Checksum in SPD = 27, computed SPD =
    74               
    DIMM 0: failed
    checksum                                                        
    Error: compute_dimm_parameters non-zero returned FATAL value for
    memctl=0 dimm=0
    Programming controller
    0                                                       
    No dimms present on controller 0; skipping
    programming                         
    total_memory =
    0                                                               
    DDR: only 16M, 32M, 64M, 128M, 256M, 512M, 1G and 2G are
    supported.            
        DDR: 64
    MB                                                                 
    Top of RAM usable for U-Boot at:
    04000000                                      
    Reserving 266k for U-Boot at:
    03fb0000                                         
    Reserving 136k for malloc() at:
    03f8e000                                       
    Reserving 72 Bytes for Board Info at:
    03f8dfb8                                 
    Reserving 64 Bytes for Global Data at:
    03f8df78                                
    Stack Pointer at:
    03f8df58                                                     
    New Stack Pointer is: 03f8df58

My DDR configuration is as follows:

    /* DDR Setup */
    #define CONFIG_VERY_BIG_RAM           

    #define CONFIG_FSL_DDR2
    #undef CONFIG_FSL_DDR_INTERACTIVE
    #define CONFIG_SPD_EEPROM           
    #define CONFIG_DDR_SPD
    #define CONFIG_DDR_DLL                   
    #define CONFIG_DDR_2T_TIMING       
    #define CONFIG_DDR_ECC
    #undef     CONFIG_ECC_INIT_VIA_DDRCONTROLLER   

    #define CONFIG_MEM_INIT_VALUE                    0xDeadBeef
    #define CONFIG_SYS_DDR_SDRAM_BASE            0x00000000
    #define CONFIG_SYS_SDRAM_BASE                   
    CONFIG_SYS_DDR_SDRAM_BASE
    #define CONFIG_NUM_DDR_CONTROLLERS        1
    #define CONFIG_DIMM_SLOTS_PER_CTLR        1
    #define CONFIG_CHIP_SELECTS_PER_CTRL    2

thanks pieter
