Return-Path: <SWarren@nvidia.com>
Received: from HQEMGATE01.nvidia.com (hqemgate01.nvidia.com [216.228.112.170])
	by ozlabs.org (Postfix) with ESMTP id 4D54167A7D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Mar 2005 13:28:20 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 24 Mar 2005 18:28:16 -0800
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B005FDAFB7@hqemmail02.nvidia.com>
From: "Stephen Warren" <SWarren@nvidia.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: MPC5200 IDE DMA and Machine checks due to TEA
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Does anyone have IDE DMA really working on the MPC5200. By this, I mean
working under load, with other peripherals on the PCI bus, using DMA
also for FEC and/or audio?

In the archive of this list, I've seen other posts on this subject (e.g.
back last June and earlier) and the status then was that people were
waiting on a new Bestcommm API (2.1?) to solve this. However, the
problem still seems to exist:

The reason I ask is that we keep on getting machine check exceptions
with DMA enabled.

We're using the MontaVista 3.1 kernel, with the Bestcomm API and IDE
driver from the latest Denx CVS tree.

I can't determine the cause of this crash, even by dumping a ton of
extra registers I don't see any clues, not even from running a PCI bus
analyzer. It seems like the CPU attempts to make a PCI access, but hits
TEA because something else is either locking the CPU out of the XLB, or
locking the PCI controller out of the external bus? We've made sure
external PCI peripherals aren't mastering the PCI bus. PCI analyzer
shows absolutely no sign of even an attempt at making this transaction
on the PCI bus (although I can't see the CPU's REQ#/GNT# pins with the
analyzer hookup I have)

One thing I do recall seeing is a note in (I think) the MPC5200
user-manual that ATA drivers should check a certain bit and wait for it
to be zero before initiating "new" transactions, or the XLB could hang.
Is this likely what's going on - is the ATA driver becoming confused and
issuing multiple transactions in parallel when it shouldn't? How on
earth would I check for this?

Does anyone have any clues, about the cause or how to procede debugging?
Thanks for any help!

Machine check in kernel mode.
Caused by (from SRR1=3D41030): Transfer error ack signal
MPC5200 XLB Arbitrator register dump:
        Conf:         0000a066
        Version       00000001
        Status        00000103
        Int Enable    00000000
        Addr Capture  4f000140 <- this is an address in the PCI
peripheral
        Bus Sig Capt  0000026a
        Addr Ten T/O  0fffffff
        Data Ten T/O  0fffffff
        Activity T/O  ffffffff
        Mstr Prio En  000000ff
        Mstr Prio     11111111
        Base Addr     00001f00
        Snoop Window  0000001d
PCI host register dump:
        GSCR          02020000
        TCR           00000000
        ICR           000000ff
        ISR           02000000
        ARB           00000000
SCPCI TX register dump:
        TPSR          00000000
        TSAR          00000000
        TTCR          07000000
        TER           00000000
        TNAR          00000000
        TLWR          00000000
        TDCR          00000000
        TSR           00000000
        TFSR          00030000
        TFCR          04000000
        TFAR          00000000
        TFRPR         00000000
        TFWPR         00000000
SCPCI RX register dump:
        RPSR          00000000
        RSAR          00000000
        RTCR          0c000000
        RER           00000000
        RNAR          00000000
        RDCR          00000000
        RSR           00000000
        RFSR          00010000
        RFCR          04000000
        RFAR          00000000
        RFRPR         00000000
        RFWPR         00000000
LPC register dump:
        Csel Status   00000000
SCLPC register dump:
        Enable        00000000
        BytesDone Sts 00ffff3e
        FIFO Status   00030000
ATA host register dump:
        Config        03000000
        Status        00000000
        Share Count   01000000
        FIFO Status   00010000
SDMA register dump:
        IntVec PTDCtl 0f0f0001
        Int Pending   00003020
        Int Mask      ffffcfd3
        Debug Ctl     00000000
        Debug Status  00000000
Module list:
        snd-pcm-oss: c510304c
        snd-mixer-oss: c50fbf48
        snd-ac97mgt: c50ed530
        snd-pcm: c50dbc0c
        snd-timer: c50d783c
        snd-page-alloc: c50d1f0c
        snd: c50c68a8
        NVMiniRM: c5081a5c
        : 00000000
Oops: machine check, sig: 7
NIP: C508FCAC XER: 20000000 LR: C508FCA4 SP: C1C17B80 REGS: c1c17ad0
TRAP: 0200    Tainted: P=20
MSR: 00041030 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK =3D c1c16000[183] 'nStantMedia' Last syscall: 5=20
last math 00000000 last altivec 00000000
GPR00: C508DE8C C1C17B80 C1C16000 0390F581 00000140 C1C17C40 00000008
00000000=20
GPR08: F0001200 C50C3F8C F0000500 00000000 84004842 1064FB3C 00000000
103D0000=20
GPR16: 3D3C3958 00000000 3D3C3948 3D3C39C8 00001032 01C17C30 00000000
C0005B0C=20
GPR24: C01E0000 00000000 C3975FA0 C01E0860 C1C17BA8 C39756A0 C3933800
C1C17BC8=20
Call backtrace:=20
C508DE8C C508DDAC C5082BF4 C0007334 C00073F0 C0005B0C C17570E4=20
C002C338 C002ED84 C007B5CC C007B944 C007BAF8 C007F2D4 C0048888=20
C004903C C0049378 C0049870 C003B81C C003BBF0 C00058DC 0FD3CC94=20
0FD13CD4 1020604C 101D76A4 101D56E0 1020D19C 1020D0AC 1020E794=20
0FF94B8C 0FD4ADC8=20

--=20
Stephen Warren, Software Engineer, NVIDIA, Fort Collins, CO
swarren@nvidia.com        http://www.nvidia.com/
swarren@wwwdotorg.org     http://www.wwwdotorg.org/pgp.html
