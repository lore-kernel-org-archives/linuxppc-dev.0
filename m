From: "Mike O'Brien" <mobrien@airfiber.com>
To: "'Wolfgang Denk'" <wd@denx.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Hanging in Init 
Date: Thu, 2 Aug 2001 09:18:22 -0700
Message-ID: <000d01c11b6e$c0648450$6865a8c0@airfiber.com>
MIME-Version: 1.0
In-Reply-To: <20010801183803.09CD210CAF@denx.denx.de>
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks...

Since I am trying to use a vxWorks bootloader which sets IMMR
to 0x02200000 I added the following code right after interrupts
are turned off in head.S:

        lis     r4, 0xf0000000@ha
        addi    r4, r4, 0xf0000000@l
        mtspr   IMMR, r4    /* initialize the IMMR register */

This seems to work.  The kernel starts to boot but ends up hanging
alittle earlier.  I am not sure yet if the hang is related to these
changes.  Do you see any problem with changing IMMR in the head.S?

Thanks,
Mike

.
.
.
i2c-core.o: i2c core module
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
pty: 256 Unix98 ptys configured
block: queued sectors max/low 20485kB/6828kB, 64 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Machine check in kernel mode.
Caused by (from SRR1=9032): Unknown values in msr
Oops: machine check, sig: 7
NIP: C010D3C8 XER: 20000000 LR: C010D368 SP: C01F9E40 REGS: c01f9d90 TRAP:
0200
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c01f8000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: 000110C0 C01F9E40 C01F8000 0000001E C008AAC0 C0090000 C0090000
00000030
GPR08: 00000000 0002FD3D C0124DD4 FE000004 84000024 00000000 00000000
00000000
GPR16: 00000000 00000000 00000000 00000000 00000000 C00F0000 C01CDE70
C01F9E48
GPR24: F0000A00 C01CDE00 FFFF9000 C01CDC00 F00009C0 F0003C00 F0002A48
00000000
Call backtrace:
C010D368 C010C4BC C010C4F8 C010D944 C010A934 C0109C70 C0105830
C0105900 C00023C0 C0004F00

-Mike

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Wolfgang
Denk
Sent: Wednesday, August 01, 2001 11:38 AM
To: Mike O'Brien
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Hanging in Init



In message <000101c11ab4$0fc48f60$6865a8c0@airfiber.com> you wrote:
>
> I have been trying to get a custom PPC860 board up using MonteVista's Hard
> Hat
> 2.0 distribution using a vxWorks bootrom.  I have made alot of progress in
> the last
> few days but have got stuck at the point here init is executed.  The IMMR
is
> set
> to 0x02200000.  I ran across some old posts on the list referring to this
> being set
> too low for linux.  Could this be the problem?  If not does anyone have
any

Sure. Your system will crash as soon as the first  user-land  program
is running.

See
http://penguinppc.org/usr/embedded/howto/PowerPC-Embedded-HOWTO-10.html#ss10
.2

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"The algorithm to do that is extremely nasty. You might want  to  mug
someone with it."                   - M. Devine, Computer Science 340



-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Wolfgang
Denk
Sent: Wednesday, August 01, 2001 11:38 AM
To: Mike O'Brien
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Hanging in Init



In message <000101c11ab4$0fc48f60$6865a8c0@airfiber.com> you wrote:
>
> I have been trying to get a custom PPC860 board up using MonteVista's Hard
> Hat
> 2.0 distribution using a vxWorks bootrom.  I have made alot of progress in
> the last
> few days but have got stuck at the point here init is executed.  The IMMR
is
> set
> to 0x02200000.  I ran across some old posts on the list referring to this
> being set
> too low for linux.  Could this be the problem?  If not does anyone have
any

Sure. Your system will crash as soon as the first  user-land  program
is running.

See
http://penguinppc.org/usr/embedded/howto/PowerPC-Embedded-HOWTO-10.html#ss10
.2

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"The algorithm to do that is extremely nasty. You might want  to  mug
someone with it."                   - M. Devine, Computer Science 340


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
