Date: Thu, 9 Nov 2000 02:22:56 +0100
From: Claus <cl.en@gmx.net>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard Sleep Crash (Was: 2.2.18pre17 again)
Message-ID: <20001109022256.A261@olis.north.de>
Reply-To: cl.en@gmx.net
References: <19340928092653.6730@192.168.1.2> <Pine.LNX.4.10.10011032251480.26175-100000@opal.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.10011032251480.26175-100000@opal.biophys.uni-duesseldorf.de>; from schmitz@opal.biophys.uni-duesseldorf.de on Fri, Nov 03, 2000 at 22:53:11 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Moin Michael!

 >:
 >: Seems I've seen that message before ???
 >:
 >: > >Sep 18 00:35:03 apple kernel: Kernel panic: kernel access of bad area pc
 >: > >c00cf34c lr c00cfa88 address 24 tsk
 >: > >+pmud/297
 >: > >
 >: > >System.map-2.2.18pre4-ben1:
 >: > >c00cf218 t idepmac_sleep_device
 >: > >c00cf334 t idepmac_wake_device
 >: >
 >: > Please, try to disassemble idepmac_sleep_device with objdump and see
 >: > where exactly it crashes. Looks like there may be some bad pointer going
 >: > on there...
 >:
 >: Rather disassemble idepmac_wake_device (that's where tha PC falls IMHO).
 >:
 >: 	Michael


I've just had a snooze-pmud-cd_module crash, sorry it's not in log/messages.
I wrote this from the screen: pc c00d82cc lr c00d8aa8

2:02@pts/1 ~ > uname -a
Linux apple 2.2.18pre17-ben1 #38 Wed Oct 25 18:51:51 CEST 2000 ppc unknown

c00d82b4 <idepmac_wake_device>:
c00d82b4:       94 21 ff d0     stwu    r1,-48(r1)
c00d82b8:       7c 08 02 a6     mflr    r0
c00d82bc:       bf a1 00 24     stmw    r29,36(r1)
c00d82c0:       90 01 00 34     stw     r0,52(r1)
c00d82c4:       7c 7f 1b 78     mr      r31,r3
c00d82c8:       81 3f 00 54     lwz     r9,84(r31)
c00d82cc:       80 09 00 24     lwz     r0,36(r9)
^^^^^^^^
<snip>
c00d8720 <idepmac_notify_sleep>:
c00d8720:       94 21 ff c0     stwu    r1,-64(r1)
c00d8724:       7c 08 02 a6     mflr    r0
<snip>
c00d8970:       7f d9 00 2e     lwzx    r30,r25,r0
c00d8974:       3b 5d 00 01     addi    r26,r29,1
c00d8978:       2c 1e 00 00     cmpwi   r30,0
c00d897c:       41 82 01 2c     beq     c00d8aa8 <idepmac_notify_sleep+0x388>
<snip>
c00d8a98:       40 80 00 10     bge     c00d8aa8 <idepmac_notify_sleep+0x388>
c00d8a9c:       7f e3 fb 78     mr      r3,r31
c00d8aa0:       7f c4 f3 78     mr      r4,r30
c00d8aa4:       4b ff f8 11     bl      c00d82b4 <idepmac_wake_device>
c00d8aa8:       80 18 e3 d8     lwz     r0,-7208(r24)
^^^^^^^^
c00d8aac:       7f 5d d3 78     mr      r29,r26
c00d8ab0:       7c 1d 00 00     cmpw    r29,r0
c00d8ab4:       41 80 fe ac     blt     c00d8960 <idepmac_notify_sleep+0x240>
c00d8ab8:       38 60 00 00     li      r3,0
c00d8abc:       80 01 00 44     lwz     r0,68(r1)
c00d8ac0:       7c 08 03 a6     mtlr    r0
c00d8ac4:       ba c1 00 18     lmw     r22,24(r1)
c00d8ac8:       38 21 00 40     addi    r1,r1,64
c00d8acc:       4e 80 00 20     blr

c00d8ad0 <ide_dma_intr>:
c00d8ad0:       94 21 ff e0     stwu    r1,-32(r1)
<snip>


Regards



			Claus

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
