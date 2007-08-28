Return-Path: <miroslaw.dach@psi.ch>
Received: from MAILSEND01.psi.ch (mailsend01.psi.ch [129.129.191.53])
	by ozlabs.org (Postfix) with ESMTP id B247DDDF55
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Aug 2007 21:18:39 +1000 (EST)
Date: Tue, 28 Aug 2007 13:18:37 +0200 (CEST)
From: Miroslaw Dach <miroslaw.dach@psi.ch>
To: Grant Likely <grant.likely@secretlab.ca>, Leonid <Leonid@a-k-a.net>
Subject: Re: Linux doesn not boot from u-boot on ML403
In-Reply-To: <fa686aa40708270753u1411796fv698d3b39ee908599@mail.gmail.com>
Message-ID: <Pine.LNX.4.44.0708281300570.31877-100000@slslc02.psi.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have done additional test with my u-boot and linux kernel.

I have downloaded u-boot(.elf) and zImage.elf via jtag to SDRAM:

The SDRAM has 32 MB: 
Address Map for Processor ppc405_0
  (0x00000000-0x01ffffff) DDR_SDRAM_1   plb

The steps I have doe are as following:

1. XMD% dow -data zImage.elf 0xe00000
2. XMD% dow u-boot.elf
        section, .text: 0x00800000-0x0081513c
        section, .resetvec: 0x0081513c-0x00815140
        section, .rodata: 0x00815140-0x00817ce0
        section, .reloc: 0x00817d00-0x00818674
        section, .data: 0x00818674-0x00818b08
        section, .data.rel: 0x00818b08-0x00818b34
        section, .data.rel.local: 0x00818b34-0x00818f6c
        section, .u_boot_cmd: 0x00818f6c-0x008191dc
        section, .bss: 0x00819200-0x0081dd04
Downloaded Program u-boot.elf
Setting PC with program start addr = 0x00800100
PC reset to 0x00800100, Clearing MSR Register

3. XMD% run

------------------------------------------------------------------
                output on the serial port
------------------------------------------------------------------
 
U-Boot 1.2.0 (Aug 28 2007 - 11:56:19)


U-Boot: checkboard
DRAM:  U-Boot: initdram
32 MB
Using default environment

In:    serial
Out:   serial
Err:   serial
Hit any key to stop autoboot:  0 
=> 

U-Boot 1.2.0 (Aug 27 2007 - 14:23:15)


U-Boot: checkboard
DRAM:  U-Boot: initdram
32 MB
Using default environment

In:    serial
Out:   serial
Err:   serial
Hit any key to stop autoboot:  0 
=> bootelf 0xe00000
Loading .text @ 0x00400000 (14028 bytes)
Loading .data @ 0x00404000 (995328 bytes)
Clearing .bss @ 0x004f7000 (8504 bytes)
## Starting application at 0x00400000 ...

loaded at:     00400000 004F9138
board data at: 004F7120 004F7138
relocated to:  004040B4 004040CC
zimage at:     00404E59 004F6EE8
avail ram:     004FA000 01FFFFFF

Linux/PPC load: console=ttyUL0,9600 root=/dev/nfs rw 
nfsroot=129.117.144.113:/opt/eldk41/ppc_4xx,tcp  
ip=::::virtex4-mirek:eth0:dhcp panic=1
Uncompressing Linux...


After that system just hangs.

I do not understand why it is possible to run zImage.elf straight from jtag
but it hangs when started from u-boot.

Is it any fundamental problem with running Linux from u-boot on ML403 
(Virtex-4) boards?

Best Regards

Mirek
