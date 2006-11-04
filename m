Return-Path: <jsurf@heckheck.com>
Received: from alnrmhc13.comcast.net (alnrmhc13.comcast.net [206.18.177.53])
	by ozlabs.org (Postfix) with ESMTP id EBB9867BDC
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  5 Nov 2006 06:19:25 +1100 (EST)
Message-ID: <454CE55C.3040901@heckheck.com>
Date: Sat, 04 Nov 2006 14:09:16 -0500
From: Jim Heck <jsurf@heckheck.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Kernel oops running 2.6.17 kernel on RPXlite DW involving DP memory
	in network initialization
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I've been trying to get a 2.6.x kernel working with the RPXlite DW 
system from Embedded Planet.  I'm getting an oops in the initialization 
of the network driver.  I have done the basic crash analysis, and it 
appears to have to do with the allocation of DP Ram for buffer 
descriptors during initialization of the loopback device.  The address 
being allocated appears to cause a bus fault.  I was hoping someone more 
familiar with the 8xx network code (or the RPXlite specifically) might 
recognize what's going on here.  Find my analysis below.

Thanks for any help,

-Jim Heck

I'm using the GCC Powerpc cross compiler and tools from the ELDK 4.0 
http://www.denx.de/wiki/DULG/ELDK

The kernel source code is stock 2.6.17 from kernel.org, with one 
modification to the /arch/ppc/platforms/rpxlite.h file to remove the 
bd_t struct definition and replace it with

#include <asm/ppcboot.h>

This was necessary to get it to work with u-boot.

I also tried the 2.6.15 source code in the ELDK, but had similar 
symptoms (I debugged only the 2.6.17 code).

*****RPXLite DW Syslog

001c0e74: 6c3a2043 504d2064 72697665 72202452    l: CPM driver $R
001c0e84: 65766973 696f6e3a 20302e30 3220240a    evision: 0.02 $.
001c0e94: 3c363e63 706d5f75 6172743a 20574152    <6>cpm_uart: WAR
001c0ea4: 4e494e47 3a206e6f 20554152 54206465    NING: no UART de
001c0eb4: 76696365 7320666f 756e6420 6f6e2070    vices found on p
001c0ec4: 6c617466 6f726d20 62757321 0a3c363e    latform bus!.<6>
001c0ed4: 63706d5f 75617274 3a207468 65206472    cpm_uart: the dr
001c0ee4: 69766572 2077696c 6c206775 65737320    iver will guess
001c0ef4: 636f6e66 69677572 6174696f 6e2c2062    configuration, b
001c0f04: 75742074 68697320 6d6f6465 20697320    ut this mode is
001c0f14: 6e6f206c 6f6e6765 72207375 70706f72    no longer suppor
001c0f24: 7465642e 0a3c343e 52414d44 49534b20    ted..<4>RAMDISK
001c0f34: 64726976 65722069 6e697469 616c697a    driver initializ
001c0f44: 65643a20 31362052 414d2064 69736b73    ed: 16 RAM disks
001c0f54: 206f6620 34303936 4b207369 7a652031     of 4096K size 1
001c0f64: 30323420 626c6f63 6b73697a 650a3c36    024 blocksize.<6
001c0f74: 3e6c6f6f 703a206c 6f616465 6420286d    >loop: loaded (m
001c0f84: 61782038 20646576 69636573 290a3c34    ax 8 devices).<4
001c0f94: 3e4a4148 2041626f 75742074 6f20646d    >JAH About to dm
001c0fa4: 615f616c 6c6f635f 636f6865 00000000    a_alloc_cohe....
001c0fb4: 00000000 00000000 00000000 00000000    ................
001c0fc4: 00000000 00000000 00000000 343e4a41    ............4>JA
001c0fd4: 48205265 7475726e 20666972 73742070    H Return first p
001c0fe4: 6167652e 20416464 72657373 20666631    age. Address ff1
001c0ff4: 30303030 300a3c34 3e4f6f70 733a206b    00000.<4>Oops: k
001c1004: 65726e65 6c206163 63657373 206f6620    ernel access of
001c1014: 62616420 61726561 2c207369 673a2031    bad area, sig: 1
001c1024: 31205b23 315d0a3c 343e4e49 503a2043    1 [#1].<4>NIP: C
001c1034: 30314237 38383820 4c523a20 00000000    01B7888 LR: ....
001c1044: 00000000 00000000 00000000 30303030    ............0000
001c1054: 30300a3c 343e5245 47533a20 63303238    00.<4>REGS: c028
001c1064: 62653930 20545241 503a2030 33303020    be90 TRAP: 0300
001c1074: 20204e6f 74207461 696e7465 64202028      Not tainted  (
001c1084: 322e362e 31372d31 290a3c34 3e4d5352    2.6.17-1).<4>MSR
001c1094: 3a203030 30303930 3332203c 45452c4d    : 00009032 <EE,M
001c10a4: 452c4952 2c44523e 20204352 3a203234    E,IR,DR>  CR: 24
001c10b4: 30303230 32322020 5845523a 20343030    002022  XER: 400
001c10c4: 30443037 460a3c34 3e444152 3a203334    0D07F.<4>DAR: 34
001c10d4: 32303230 30302c20 44534953 523a2043    202000, DSISR: C
001c10e4: 32303030 3030300a 3c343e54 00000000    2000000.<4>T....
001c10f4: 00000000 00000000 00000000 00000000    ................
001c1104: 00000000 00000000 00000000 00000000    ................
001c1114: 00000000 00000000 00000000 47505230    ............GPR0
001c1124: 303a2043 30314237 38374320 43303238    0: C01B787C C028
001c1134: 42463430 20433032 38364145 00000000    BF40 C0286AE....
001c1144: 00000000 00000000 00000000 00000000    ................
001c1154: 00000000 00000000 00000000 00000000    ................
001c1164: 00000000 00000000 00000000 00000000    ................
001c1174: 00000000 00000000 00000000 00000000    ................
001c1184: 00000000 00000000 00000000 00000000    ................
001c1194: 00000000 00000000 00000000 00000000    ................
001c11a4: 00000000 00000000 00000000 30343030    ............0400
001c11b4: 30303030 20303038 30303030 30200a3c    0000 00800000 .<
001c11c4: 363e4750 5231363a 20303346 46463139    6>GPR16: 03FFF19
001c11d4: 30204646 46464646 46462030 30303030    0 FFFFFFFF 00000
001c11e4: 30303020 43303138 30303030 20433031    000 C0180000 C01
001c11f4: 38303030 30204641 32303041 32302046    80000 FA200A20 F
001c1204: 46464639 30303020 43303330 31453630    FFF9000 C0301E60
001c1214: 200a3c36 3e475052 32343a20 00000000     .<6>GPR24: ....
001c1224: 00000000 00000000 00000000 00000000    ................
001c1234: 00000000 00000000 00000000 44303020    ............D00
001c1244: 33343230 32303030 20433033 30314539    34202000 C0301E9
001c1254: 30204646 31303030 30302033 34323032    0 FF100000 34202
001c1264: 30303020 0a3c343e 43616c6c 20547261    000 .<4>Call Tra
001c1274: 63653a0a 3c343e5b 43303238 00000000    ce:.<4>[C028....


***** /arch/ppc/8xx_io/enet.c starting at line 841

    bpd = cep->rx_bd_base;
    k = 0;

    /* JAH Add debug */
    printk("JAH About to dma_alloc_coherent.\n");

    for (i=0; i<CPM_ENET_RX_PAGES; i++) {

            printk("JAH Start first page.\n");

        /* Allocate a page.
        */
        ba = (unsigned char *)dma_alloc_coherent(NULL, PAGE_SIZE,
                &mem_addr, GFP_KERNEL);
            printk("JAH Return first page. Address %08x\n", ba);
        /* BUG: no check for failure */

        /* Initialize the BD for every fragment in the page.
        */
        for (j=0; j<CPM_ENET_RX_FRPPG; j++) {
            bdp->cbd_sc = BD_ENET_RX_EMPTY | BD_ENET_RX_INTR;
            bdp->cbd_bufaddr = mem_addr;
            cep->rx_vaddr[k++] = ba;
            mem_addr += CPM_ENET_RX_FRSIZE;
            ba += CPM_ENET_RX_FRSIZE;
            bdp++;
        }
    }

    /* JAH Add debug */
    printk("JAH Finished dma_alloc_coherent.\n");

***** from stack stack and disassembly analysis, failure at line
bdp->cbd_sc = BD_ENET_RX_EMPTY | BD_ENET_RX_INTR;


*****dissasembly

c01b783c:    4b e6 2c 0d     bl      c001a448 <printk>
c01b7840:    3b 20 00 00     li      r25,0
c01b7844:    3e 60 c0 18     lis     r19,-16360
c01b7848:    3e 80 c0 18     lis     r20,-16360
c01b784c:    3a c0 90 00     li      r22,-28672
c01b7850:    3b b7 00 30     addi    r29,r23,48
c01b7854:    38 73 ef 6c     addi    r3,r19,-4244
c01b7858:    4b e6 2b f1     bl      c001a448 <printk>
c01b785c:    38 81 00 08     addi    r4,r1,8
c01b7860:    38 a0 00 d0     li      r5,208
c01b7864:    38 60 10 00     li      r3,4096
c01b7868:    4b e4 de 31     bl      c0005698 <__dma_alloc_coherent>
c01b786c:    7c 64 1b 78     mr      r4,r3
c01b7870:    7c 7e 1b 78     mr      r30,r3
c01b7874:    38 74 ef 84     addi    r3,r20,-4220
c01b7878:    4b e6 2b d1     bl      c001a448 <printk>
c01b787c:    7f 9f e3 78     mr      r31,r28
c01b7880:    39 7d 00 0c     addi    r11,r29,12
c01b7884:    39 40 00 00     li      r10,0
c01b7888:    b2 df 00 00     sth     r22,0(r31)
c01b788c:    80 01 00 08     lwz     r0,8(r1)
c01b7890:    2f 8a 00 01     cmpwi   cr7,r10,1
c01b7894:    90 1f 00 04     stw     r0,4(r31)
c01b7898:    93 cb 00 00     stw     r30,0(r11)
c01b789c:    81 21 00 08     lwz     r9,8(r1)
c01b78a0:    3b de 08 00     addi    r30,r30,2048
c01b78a4:    39 29 08 00     addi    r9,r9,2048
c01b78a8:    91 21 00 08     stw     r9,8(r1)
c01b78ac:    3b ff 00 08     addi    r31,r31,8
c01b78b0:    39 6b 00 04     addi    r11,r11,4
c01b78b4:    39 4a 00 01     addi    r10,r10,1
c01b78b8:    40 be ff d0     bne-    cr7,c01b7888 <scc_enet_init+0x264>


*****failure based on NIP at c01b7888 in sth at c01b7888

*****value of r31 (bpd in source code) is 34202000

*****cep->rx_bd_base allocated in /arch/ppc/8xx_io/enet.c lines 751-753

    /* Allocate space for the buffer descriptors in the DP ram.
     * These are relative offsets in the DP ram address space.
     * Initialize base addresses for the buffer descriptors.
     */
    dp_offset = cpm_dpalloc(sizeof(cbd_t) * RX_RING_SIZE, 8);
    ep->sen_genscc.scc_rbase = dp_offset;
    cep->rx_bd_base = cpm_dpram_addr(dp_offset);

    dp_offset = cpm_dpalloc(sizeof(cbd_t) * TX_RING_SIZE, 8);
    ep->sen_genscc.scc_tbase = dp_offset;
    cep->tx_bd_base = cpm_dpram_addr(dp_offset);


*****referring to commproc.c line 441

void *cpm_dpram_addr(uint offset)
{
    return ((immap_t *)IMAP_ADDR)->im_cpm.cp_dpmem + offset;
}
EXPORT_SYMBOL(cpm_dpram_addr);


*****The memory at 0x34202000 doesn't map nicely...

u-boot>md 0x34202000 0x100
34202000:Bus Fault @ 0x03fe9ea0, fixup 0x00000000
Machine check in kernel mode.
Caused by (from msr): regs 03faea60 Unknown values in msr
NIP: 03FE9EA0 XER: 6000D07F LR: 03FE9E74 REGS: 03faea60 TRAP: 0200 DAR: 
03FF9F0CMSR: 00009002 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 00

GPR00: 03FE9E74 03FAEB50 00000000 00000000 03FAE9FC 00000010 00000001 
00000030
GPR08: 00000001 FA202811 FA202808 FA200808 00000000 FFFFEFFD 04000000 
04FD7000
GPR16: 03FFF190 FFFFFFFF 00000000 C0180000 03FAEB58 00000100 03FAEB58 
03FAEB58
GPR24: 00000004 03FAEB58 00000400 00000010 34202000 03FAEF94 04000A80 
00000000
Call backtrace:
machine check


U-Boot 1.1.5 (Oct 24 2006 - 14:28:06)

CPU:   PPC823EZTnnB2 at 48 MHz: 16 kB I-Cache 8 kB D-Cache
Board: RPXlite_DW
DRAM:  64 MB
FLASH: 16 MB
In:    serial
Out:   serial
Err:   serial
Net:   SCC ETHERNET
Hit any key to stop autoboot:  0
u-boot>
