Message-ID: <3CC79510.BF265F98@timesys.com>
Date: Thu, 25 Apr 2002 11:03:04 +0530
From: ashish anand <ashish.anand@timesys.com>
MIME-Version: 1.0
To: steven blakeslee <thesbman@msn.com>, nanogui@linuxhacker.org,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: [nanogui] question concerning accessing RAM
References: <F22iAkAagmQ5WTaYeVs000056bc@hotmail.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


check if by any chance you have missed ioremapping the lcd framebuffer

steven blakeslee wrote:
>
> I'm working on a driver for embedded Linux 2.4 on a ppc board to use a 640
> by 480 LCD.  I've been able to set up the lcd registers and register the new
> frame buffer.  The problem is every time I try to use the frame buffer I get
> an error.
>
> Oops: kernel access of bad area, sig: 11
> NIP: C0107D7C XER: 00000000 LR: C0107D30 SP: C3AD7E70 REGS: c3ad7dc0 TRAP:
> 0300
> MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> DAR: C0111380, DSISR: 82000000
> TASK = c3ad6000[80] 'nano-X' Last syscall: 5
> last math 00000000 last altivec 00000000
> GPR00: C0111380 C3AD7E70 C3AD6000 00000000 00000000 00000000 C3BD9AEC
> C3BD9010
> GPR08: 0000001B C0111370 C3AD6000 38635619 24000022 10044D98 00000000
> 00000000
> GPR16: 00000000 00000000 00000000 00000000 00009032 03AD7F40 00000000
> C0002BC8
> GPR24: C00028E0 00000000 C01E6750 C3BD9A90 00000000 C025DA14 00000000
> C0262248
> Call backtrace:
> C0107D30 C00A5088 C00573AC C00572B0 C0057800 C0002984 7C0802A6
>
> I use alloc_bootmem_pages(PAGE_SIZE*75) to allocate the memory, I do this in
> m8xx_setup.c.  I get a pointer and use a for loop to modify the memory I
> just allocated, when the kernel initializes the lcd registers the
> appropriate color shows on the LCD.  The problem is after the kernel boots I
> am unable to modify this ram again.  I have tried using the frame buffer and
> also I have tried several modules.  If anyone can give advice I would
> appreciate it.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
