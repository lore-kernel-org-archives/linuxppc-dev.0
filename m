Return-Path: <markc@mail.com>
Received: from smtp1.us4.outblaze.com (smtp1.us4.outblaze.com [205.158.62.78])
	by ozlabs.org (Postfix) with SMTP id 75FB867A6D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Apr 2006 00:39:30 +1000 (EST)
Message-ID: <00c201c65d75$b89e0b80$5800000a@CHUCK2>
From: "Mark Chambers" <markc@mail.com>
To: "gautam borad" <gautam@eisodus.com>,
	<linuxppc-embedded@ozlabs.org>
References: <443BB7E2.9040903@eisodus.com>
Subject: Re: kernel access of bad area, sig: 11  ( mpc852t)
Date: Tue, 11 Apr 2006 10:39:19 -0400
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Hi,
>    Im having problem porting linux kernel 2.4.21 to our mpc852T custom
> board.The kernel
> panics randomly with sig 11.
> The board boots up fine and we also get to the prompt.When we open 3-4
> telnet sessions
> and try to run some command the kernel panics.This is completely
> random.Sometimes it
> even panics before opening the telnet session.
>
> One of the oops dump is:
>
> -----------------------------------------------------------------------------------------------------------------------------
> Oops: kernel access of bad area, sig: 11
> NIP: C0019FD0 XER: 00000000 LR: C001A06C SP: C1C33AD0 REGS: c1c33a20
> TRAP: 0300    Not tainted
> MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> DAR: 725F6578, DSISR: 0000000B
> TASK = c1c32000[48] 'insmod' Last syscall: 5
> last math 00000000 last altivec 00000000
> GPR00: 7361726D C1C33AD0 C1C32000 00000000 C0113678 C0150000 C0150000
> C014B210
> GPR08: C014B210 C012D060 00000000 725F6578 04000024 00000000 00000000
> 00000000
> GPR16: 00000000 00000000 00000000 00000000 00001032 01C33BA0 00000000
> C0000000
> GPR24: C014BE38 C0150000 C0110000 C0110000 C0140000 00000001 00000000
> 00000001
> Call backtrace:
> C001A0C8 C0016174 C0015FEC C0015CC0 C0005E38 C0004668 C1C33D10
> C0004670 C004A380 C003FFD4 C00404D8 C0040AD4 C0040FF8 C00330D8
> C00334AC C000443C 1006EF48 1001FCF0 1002023C 10003A18 100036A0
> 300591AC 00000000
> -----------------------------------------------------------------------------------------------------------------------------
>
> The call trace back is of not much help because it is different on all 
> oops.
> We are using u-boot 1-1-3.
>
> Thanks in advance.
>

You almost certainly have SDRAM problems.  If you have thoroughly checked 
out the
complete address range statically, remember that burst accesses will not 
occur until the
cache is turned on, so your problem may be with bursting.  But you can also 
have severe
problems like a missing address line and linux still run for a few seconds.

Mark Chambers 
