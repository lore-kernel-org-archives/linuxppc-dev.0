Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Thu, 24 Apr 2003 13:52:54 +0900
Message-Id: <200304240452.h3O4qrq04070@www.cnetia.com>
From: randy kim <randy@cnetia.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: cache init problems - (non multi-mimed mail )  
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Reply-To: randy@cnetia.com
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi..

I have a problem for porting PPC-BOOT to STT755EMC.

Here is my BD spec.

CPU: MPC750 ( main core ) + MPC8260 ( companion only )
L2 cache:  1M
SDRAM on 60x bus: 64M
SDRAM on Local bus: 32M
FLASH: 8MB
10/100 Base T port on FFC2
Dual RS232 port residing SMC1 & SMC2.


The problem is  cache.
Whenever boot process reach at cache init code,
all system is stoped!. No more progress!
But if the cache init code is commented out from boot codes,
Everything's fine except perfomence.

I don't know why the code doesn't work. please help..

Here is the code i used.

        /* icache_enable */
        mfspr   r3, HID0
        li      r5, HID0_ICFI|HID0_ILOCK
        andc    r3, r3, r5
        ori     r3, r3, HID0_ICE
        ori     r5, r3, HID0_ICFI
        mtspr   HID0, r5
        mtspr   HID0, r3
        isync

 /* dcache_enable */
        mfspr   r3,HID0
        ori     r3,r3,HID0_DCE | HID0_DCFI
        sync
        mtspr   HID0,r3

Thanks

ps ) sorry for my previous Multi-mimed mail.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
