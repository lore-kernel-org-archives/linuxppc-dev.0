MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Reset for MPC8245
Date: Tue, 1 Jun 2004 10:56:37 -0700
Message-ID: <1F306944A986B144A9B8C8E0A2C21DED01191280@svr-ca-e2k1.usa.alliedtelesyn.com>
From: "Arunachalam, Saravanan" <Saravanan_Arunachalam@alliedtelesyn.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am trying to do Internal Hard Reset from the kernel for MPC8245 based
custom board. I tried the Machine check stop approach but it doesn't
work. I am able to successfully do from the u-boot bootloader. The
following code generates Instruction Exception at the instruction that
turns off MMU.

msr = mfmsr();

/* Interrupts and MMU off */
__asm__ __volatile__ ("mfmsr    %0":"=r" (msr));

msr &= ~0x1030;
__asm__ __volatile__ ("mtmsr    %0"::"r" (msr)); <--- Instruction Except
addr = 0xfff00100;
((void (*)(void)) addr) ();

If anyone has a solution to this, I would greatly appreciate it.

Thanks
Arun

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
