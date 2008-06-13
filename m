Return-Path: <ricardo.ribalda@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by ozlabs.org (Postfix) with ESMTP id DB444DDE21
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jun 2008 04:20:39 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so2843511fga.39
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 11:20:37 -0700 (PDT)
Message-ID: <aa76a2be0806131120i44396eafw66046f7fe68bb4d8@mail.gmail.com>
Date: Fri, 13 Jun 2008 20:20:37 +0200
From: "Ricardo Ribalda Delgado" <ricardo.ribalda@uam.es>
Sender: ricardo.ribalda@gmail.com
To: linuxppc-dev@ozlabs.org
Subject: Xilinx EDK 10.1 and XUPV2P: A little report
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello list

   I have tried to port Linux 2.6 (xilinx git) to a XUPV2P board
running a system implemented with EDK10.1 (Linux Version). I have
fail, and I think I now why, this is a little report written for
saving you some time (and maybe solving my problem if I am doing
something wrong)

The board is not supported by EDK 10.1, but I have found a Board
Support File form https://wiki.ittc.ku.edu that seems to work. To
start I have created a design that consists on a ppc, the mpmc, an
uartlite, an interrupt manager and some bram. The "basic programs"
worked ok on it.

 I have downloaded the kernel form xilinx git and adapted the
xparameters file to fit my design.

 I have created a toolchain using OpenEmbedded and compiled the kernel
with it, then I have downloaded the binary to the board and everything
works fine until "Now booting the kernel"

  Debugging the kernel I have found that the system crashes (Exception
0x700) setting the mmu inside "start_here" (head_4xx.S)...

  Because it was a crash in the "very beginning" of my kernel live I
developed some simple apps to tests all my peripherals and they worked
ok in real mode: All of them worked OK

  BUT I have created a small piece of code that tests the peripherals
in virtual mode and when the program is linked to the ram the system
crashes!! Strangely, it works ok when it runs from bram.....

   The same code works perfectly on a design created with EDK 8.1 and
the kernel also works fine.

   I attach the source code of my test app and the OpenEmbedded
parameters I have used.



                                      Best Regards



-----------------

main:

.globl main

my_code:

bl uart

tlbia
isync

lis r3,my_code@h
ori r3,r3,my_code@l
mr r4,r3
iccci r0,r3

/*PID*/
li r0,0
mtpid r0
sync

mem_map:
/*RAM*/
lis r3,0@h
ori r3,r3,0@l
mr r4,r3
rlwinm  r4,r4,0,0,21
ori     r4,r4,768
rlwinm  r3,r3,0,0,21
ori     r3,r3,960  /*16M*/
li      r0,0
tlbwelo r4,r0
tlbwehi r3,r0

/*BRAM*/
lis r3,0xffff0000@h
ori r3,r3,0xffff0000@l
mr r4,r3
rlwinm  r4,r4,0,0,21
ori     r4,r4,768
rlwinm  r3,r3,0,0,21
ori     r3,r3,448 /* 64K */
li      r0,1
tlbwelo r4,r0
tlbwehi r3,r0

/*UARTLITE*/
lis r3,0x40600000@h
ori r3,r3,0x40600000@l
mr r4,r3
rlwinm  r4,r4,0,0,21
ori     r4,r4,263
rlwinm  r3,r3,0,0,21
ori     r3,r3,448 /*64K*/
li      r0,2
tlbwelo r4,r0
tlbwehi r3,r0

sync

on_mmu:
lis r0,0
ori r0,r0,4146
mtsrr1 r0
lis     r0,bucle@h
ori     r0,r0,bucle@l
mtsrr0  r0
rfi
b .


uart:
lis r11,0x4060000c@h
ori r11,r11,0x4060000c@l
li r14,0x0
stb r14,0x0(r11)
lis     r11,0x40600008@h
ori     r11,r11,0x40600008@l
busy:
lwz     r10,0(r11)
andi.   r12,r10,8
bne+ busy
lis r11,0x40600004@h
ori r11,r11,0x40600004@l
li r14,0x32
stb r14,0x0(r11)
br


rw_ram:
lis     r11,0x100000@h
ori     r11,r11,0x100000@l
lwz     r10,0(r11)
lis r11,0x100000@h
ori r11,r11,0x100000@l
li r10,0xcc
stb r10,0x0(r11)
br

rw_rom:
lis     r11,0xfffffffc@h
ori     r11,r11,0xfffffffc@l
lwz     r10,0(r11)
lis r11,0xfffffffc@h
ori r11,r11,0xfffffffc@l
li r10,0xcc
stb r10,0x0(r11)
br

bucle:
bl rw_ram
bl uart
bl rw_rom

bl bucle


-------------------


OpenEmbedded Parameters:
PREFERRED_VERSION_gcc = "4.2.1"
PREFERRED_VERSION_gcc-cross = "4.2.1"
PREFERRED_VERSION_gcc-cross-initial = "4.2.1"
PREFERRED_VERSION_binutils = "2.18"
PREFERRED_VERSION_binutils-cross = "2.18"
PREFERRED_VERSION_glibc = "2.5"
PREFERRED_VERSION_glibc-intermediate = "2.5"
PREFERRED_VERSION_linux-libc-headers = "2.6.25"

-- 
Ricardo Ribalda
http://www.eps.uam.es/~rribalda/
