Return-Path: <alan@akb.net>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id 9AE8BDDDE7
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 27 Sep 2008 09:00:40 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m33so620641wag.9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Sep 2008 16:00:39 -0700 (PDT)
Message-ID: <bfa0697f0809261600p7e1af4a6va360d0782cec8257@mail.gmail.com>
Date: Fri, 26 Sep 2008 17:00:39 -0600
From: embedded <embedded@akb.net>
Sender: alan@akb.net
To: linuxppc-embedded@ozlabs.org
Subject: FCC1 failing on large packet PINGS, while FCC2 is successful
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

We've found a way to get ping to fail all of the time by increasing
the size of the ping messages.  When we use the max in Windows of
65500, every ping to the first FCC1 Ethernet is dropped.  However,
when we ping with a size of 65500 to the second FCC2 Ethernet
everything is fine and all echos are successful.

In windows:
ping -l 64000 172.24.100.11  -t

It definitely seems to be a problem with the mpc, but I'm not sure
where to look.  Board? KErnel? boot loader?  The two Ethernet devices
should be configured identically, and looking through the kernel code,
it seems that there aren't any preferred treatment differences.  Could
the problem be in the bit-banging mdio control, or should I look
within fs_enet?  We've got this reproducing on all of our boards and
it could also reside in the board setup...

Does anyone with experience on the ep8248 and/or mpc8272 family,
fs_enet-* code have any ideas where I should look next?

-Alan


FCC1/2 registers
=============
gfmr1: 0x2000003c
fpsmr1: 0x14000080
ftodr1: 0x1400
fdsr1: 0xd555
fcce1: 0x00080100
fccm1: 0x001b0000
fccs1: 0x00
ftirr1_phy0: 0x00
ftirr1_phy1: 0x00
ftirr1_phy2: 0x00
ftirr1_phy3: 0x00
gfmr2: 0x2000003c
fpsmr2: 0x14000080
ftodr2: 0x1400
fdsr2: 0xd555
fcce2: 0x00080100
fccm2: 0x001b0000
fccs2: 0x00
ftirr2_phy0: 0x00
ftirr2_phy1: 0x00
ftirr2_phy2: 0x00
ftirr2_phy3: 0x00

FCC1/2 PRAM
=================
e0008400 : 0x0180  RIPTR
e0008402 : 0x01a0  TIPTR
e0008404 : 0x0000  ----
e0008406 : 0x0600  MRBLR (maximum receive buffer length
e0008408 : 0x30a0  RSTATE(receive internal state
e000840a : 0x0000
e000840c : 0x0795  RBASE
e000840e : 0xe000
e0008410 : 0x2c80  RBDSTAT      ---------now 8400   went to 8c00
e0008412 : 0x0040  RBDLEN
e0008414 : 0x0796  RBDPTR
e0008416 : 0x1010
e0008418 : 0x3004  TSTATE
e000841a : 0x0000
e000841c : 0x0795  TBASE
e000841e : 0xe100
e0008420 : 0x0000  TBDSTAT
e0008422 : 0x0000  TBDLEN
e0008424 : 0x0000  TDPTR
e0008426 : 0x0000
e0008428 : 0x0795  RBPTR
e000842a : 0xe0f8
e000842c : 0x0795  TBPTR
e000842e : 0xe100
e0008430 : 0xdebb  RCRC
e0008432 : 0x20e3
e0008434 : 0xffff  ----
e0008436 : 0xffff  ----
e0008438 : 0x0000  TCRC
e000843a : 0x0000
e000843c : 0x0000  ----
e000843e : 0x0000  ----

e0008500 : 0x0200  RIPTR
e0008502 : 0x0220  TIPTR
e0008504 : 0x0000  ----
e0008506 : 0x0600  MRBLR (maximum receive buffer length
e0008508 : 0x30a0  RSTATE(receive internal state
e000850a : 0x0000
e000850c : 0x0796  RBASE
e000850e : 0x2000
e0008510 : 0x0c80  RBDSTAT         now 8400  now 8c00
e0008512 : 0x0040  RBDLEN
e0008514 : 0x07b1  RBDPTR
e0008516 : 0xc010
e0008518 : 0x3004  TSTATE
e000851a : 0x0000
e000851c : 0x0796  TBASE
e000851e : 0x2100
e0008520 : 0x0000  TBDSTAT
e0008522 : 0x0000  TBDLEN
e0008524 : 0x0000  TDPTR
e0008526 : 0x0000
e0008528 : 0x0796  RBPTR
e000852a : 0x2018
e000852c : 0x0796  TBPTR
e000852e : 0x2100
e0008530 : 0xdebb  RCRC
e0008532 : 0x20e3
e0008534 : 0xffff  ----
e0008536 : 0xffff  ----
e0008538 : 0x0000  TCRC
e000853a : 0x0000
e000853c : 0x0000  ----
e000853e : 0x0000  ----
