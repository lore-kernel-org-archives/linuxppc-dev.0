MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Reset for MPC8245
Date: Tue, 1 Jun 2004 13:59:48 -0600
Message-ID: <065ACD8E84315E4394C835E398C8D5EB089D8A@cossmgmbx02.email.corp.tld>
From: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of
> Arunachalam, Saravanan
> Sent: Tuesday, June 01, 2004 1:57 PM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: Reset for MPC8245
>
>
>
> Hi,
>
> I am trying to do Internal Hard Reset from the kernel for
> MPC8245 based
> custom board. I tried the Machine check stop approach but it doesn't
> work. I am able to successfully do from the u-boot bootloader. The
> following code generates Instruction Exception at the instruction that
> turns off MMU.
>
> msr = mfmsr();
>
> /* Interrupts and MMU off */
> __asm__ __volatile__ ("mfmsr    %0":"=r" (msr));
>
> msr &= ~0x1030;
> __asm__ __volatile__ ("mtmsr    %0"::"r" (msr)); <---
> Instruction Except
> addr = 0xfff00100;
> ((void (*)(void)) addr) ();
>
> If anyone has a solution to this, I would greatly appreciate it.
>
> Thanks
> Arun


I don't know if it is a solution, but I'm suspicious of the line " addr = 0xfff00100;".  The key to doing a machine check reset is (a) reconfiguring the MSR to do a reset on a machine check and (b) causing a machine check to occur.  Item (b) is typically done by jumping to a memory location that doesn't exist.  I suspect that in your case, location 0xfff00100 _does_ exist: it is the reset vector in your ROM.

Try setting addr to an invalid location.

gvb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
