Message-ID: <41EDEC3C1B88D51186EB00A0C9CFADF702FB0D@AMWMAIL>
From: Cindy Peters <cinpet@adaptivemicro.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: FW: NIP at 1FFC
Date: Tue, 20 Nov 2001 08:16:08 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


-----Original Message-----
From: Lucinda Schafer
Sent: Tuesday, November 20, 2001 7:54 AM
To: 'zjuzhou@yahoo.com.cn'; 'linuxppc-embedded@lists.linuxppc.org'
Cc: Cindy Peters
Subject: NIP at 1FFC


We have dealt with a similar kernel panic with the NIP always being at
1FFCh. After literally weeks of trying to figure it out, I put in a
"band-aid" of sorts that seems to work with no ill effects. You might want
to try it, as well.

The NIP gets decremented somehow as it jumps to 2000h on a syscall. I only
found one place in the kernel where the NIP purposely gets decremented, but
I couldn't make a hard connection to explain the problem.

We posted this problem previously, and it got dismissed by others as a
hardware problem.

In the powerpc-linux/linux/arch/ppc/kernel/head.S file, add the lines marked
/*LES 7/25/00*/ as shown:

	STD_EXCEPTION(0x1300, Trap_13, InstructionBreakpoint)
	STD_EXCEPTION(0x1400, SMI, SMIException)
	STD_EXCEPTION(0x1500, Trap_15, UnknownException)
	STD_EXCEPTION(0x1600, Trap_16, UnknownException)
	STD_EXCEPTION(0x1700, Trap_17, TAUException)
	STD_EXCEPTION(0x1800, Trap_18, UnknownException)
	STD_EXCEPTION(0x1900, Trap_19, UnknownException)
	STD_EXCEPTION(0x1a00, Trap_1a, UnknownException)
	STD_EXCEPTION(0x1b00, Trap_1b, UnknownException)
	STD_EXCEPTION(0x1c00, Trap_1c, UnknownException)
	STD_EXCEPTION(0x1d00, Trap_1d, UnknownException)
	STD_EXCEPTION(0x1e00, Trap_1e, UnknownException)
	STD_EXCEPTION(0x1f00, Trap_1f, UnknownException)

	. = 0x1FFC				/*LES 7/25/00*/
	bl	transfer_to_handler	/*LES 7/25/00*/

	STD_EXCEPTION(0x2000, RunMode, RunModeException)
	STD_EXCEPTION(0x2100, Trap_21, UnknownException)
	STD_EXCEPTION(0x2200, Trap_22, UnknownException)
	STD_EXCEPTION(0x2300, Trap_23, UnknownException)
	STD_EXCEPTION(0x2400, Trap_24, UnknownException)
	STD_EXCEPTION(0x2500, Trap_25, UnknownException)
	STD_EXCEPTION(0x2600, Trap_26, UnknownException)
	STD_EXCEPTION(0x2700, Trap_27, UnknownException)
	STD_EXCEPTION(0x2800, Trap_28, UnknownException)
	STD_EXCEPTION(0x2900, Trap_29, UnknownException)
	STD_EXCEPTION(0x2a00, Trap_2a, UnknownException)
	STD_EXCEPTION(0x2b00, Trap_2b, UnknownException)
	STD_EXCEPTION(0x2c00, Trap_2c, UnknownException)
	STD_EXCEPTION(0x2d00, Trap_2d, UnknownException)
	STD_EXCEPTION(0x2e00, Trap_2e, UnknownException)
	STD_EXCEPTION(0x2f00, Trap_2f, UnknownException)

	. = 0x3000


Lucinda Schafer
Staff Software Engineer
Adaptive Micro-Ware, Inc.
Fort Wayne, IN

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
