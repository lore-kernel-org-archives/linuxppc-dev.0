Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <000801c2ccbc$74641830$5e207aa1@fish>
From: "Jason Park" <jason@amadeus.kist.re.kr>
To: "Wolfgang Denk" <wd@denx.de>
Cc: "LINUX MAILING LIST" <linuxppc-embedded@lists.linuxppc.org>
References: <20030204082910.650EFC608E@atlas.denx.de>
Subject: Re: Still having problems trying to get it to boot: PPCBOOT, MPC8260 
Date: Wed, 5 Feb 2003 11:14:59 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Please explain what you changed; the config.mk for the  ep8260  board
> reads "TEXT_BASE = 0xFFF00000" which looks OK to me.

i did set TEXT_BASE = 0xFFF00000
i changed the makefile to pick the appropriate Cross Compiler.

ifndef CROSS_COMPILE
ifeq ($(HOSTARCH),ppc)
CROSS_COMPILE =
else
##  #ifeq ($(CPU),mpc8xx)
##  CROSS_COMPILE = ppc_8xx-
##  #endif
##  #ifeq ($(CPU),ppc4xx)
##  #CROSS_COMPILE = ppc_4xx-
##  #endif
##  #ifeq ($(CPU),mpc824x)
##  #CROSS_COMPILE = ppc_82xx-
##  #endif
ifeq ($(CPU),mpc8260)
CROSS_COMPILE = ppc_82xx-
endif
##  #ifeq ($(CPU),74xx_7xx)
##  #CROSS_COMPILE = ppc_74xx-)
##  #endif

##ifeq ($(ARCH),ppc)
##CROSS_COMPILE = ppc_8xx-
##endif
##ifeq ($(ARCH),arm)
##CROSS_COMPILE = arm_920TDI-
endif
endif
##endif

> Type "reset" and "info" and check where the PC is  pointing  to.  You
> may  have  a  problem with your BDI's config file so the CPU does not
> get stopped immediately after a reset, but  only  after  some  delay.
> This  might explain that "reset" and "go" does not work. Also, please
> note that  thge  reset  entry  point  is  at  offset  0x100,  so  "go
> 0xfff00000" is definitely wrong - try "go 0xfff00100" instead.

reset
info (PC: 0xfff00100)
go (it is actually running now.. but im not sure if it is running properly)
halt (PC: 0x03fdc420)

and.. this is what is at
md 0xfff00000
fff00000 : 10101010 10101010 40404040 40404040  ........@@@@@@@@
fff00010 : 02020202 02020202 45454545 45454545  ........EEEEEEEE
fff00020 : 00000000 00000000 00000000 00000000  ................
fff00030 : 00000000 00000000 00000000 00000000  ................
fff00040 : 00000000 00000000 00000000 00000000  ................
fff00050 : 00000000 00000000 00000000 00000000  ................
fff00060 : 00000000 00000000 00000000 00000000  ................
fff00070 : 00000000 00000000 00000000 00000000  ................
fff00080 : 00000000 00000000 00000000 00000000  ................
fff00090 : 00000000 00000000 00000000 00000000  ................
fff000a0 : 00000000 00000000 00000000 00000000  ................
fff000b0 : 00000000 00000000 00000000 00000000  ................
fff000c0 : 00000000 00000000 00000000 00000000  ................
fff000d0 : 00000000 00000000 00000000 00000000  ................
fff000e0 : 00000000 00000000 00000000 00000000  ................
fff000f0 : 00000000 00000000 00000000 00000000  ................

the output of the target board is just garbage characters now.

Tb.?.???
b?..???...?.a.B.?..?.V.?

Thanks,
Jason Park


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
