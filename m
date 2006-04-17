Return-Path: <akshaymishra@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.239])
	by ozlabs.org (Postfix) with ESMTP id EE9BF67A5A
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Apr 2006 21:35:35 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 71so419821wri
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Apr 2006 04:35:33 -0700 (PDT)
Message-ID: <460643480604170435m5f0c27efmab8326234c69e9e2@mail.gmail.com>
Date: Mon, 17 Apr 2006 17:05:33 +0530
From: "Akshay Mishra" <akshaymishra@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: kernel access of bad area, sig: 11 ( mpc852t)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>> Hi,
>> Im having problem porting linux kernel 2.4.21 to our mpc852T custom
>> board.The kernel
>> panics randomly with sig 11.
>> The board boots up fine and we also get to the prompt.When we open 3-4
>> telnet sessions
>> and try to run some command the kernel panics.This is completely
>> random.Sometimes it
>> even panics before opening the telnet session.
>>
>> One of the oops dump is:
>>
>> ------------------------------------------------------------------------=
------------
\
>>                 -----------------------------------------
>> Oops: kernel access of bad area, sig: 11
>> NIP: C0019FD0 XER: 00000000 LR: C001A06C SP: C1C33AD0 REGS: c1c33a20
>> TRAP: 0300    Not tainted
>> MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
>> DAR: 725F6578, DSISR: 0000000B
>> TASK =3D c1c32000[48] 'insmod' Last syscall: 5
>> last math 00000000 last altivec 00000000
>> GPR00: 7361726D C1C33AD0 C1C32000 00000000 C0113678 C0150000 C0150000
>> C014B210
>> GPR08: C014B210 C012D060 00000000 725F6578 04000024 00000000 00000000
>> 00000000
>> GPR16: 00000000 00000000 00000000 00000000 00001032 01C33BA0 00000000
>> C0000000
>> GPR24: C014BE38 C0150000 C0110000 C0110000 C0140000 00000001 00000000
>> 00000001
>> Call backtrace:
>> C001A0C8 C0016174 C0015FEC C0015CC0 C0005E38 C0004668 C1C33D10
>> C0004670 C004A380 C003FFD4 C00404D8 C0040AD4 C0040FF8 C00330D8
>> C00334AC C000443C 1006EF48 1001FCF0 1002023C 10003A18 100036A0
>> 300591AC 00000000
>> ------------------------------------------------------------------------=
------------
\
>> -----------------------------------------
>> The call trace back is of not much help because it is different on all
>> oops.
>> We are using u-boot 1-1-3.
>>
>> Thanks in advance.
>>

>You almost certainly have SDRAM problems.  If you have thoroughly checked
>out the
>complete address range statically, remember that burst accesses will not
>occur until the
>cache is turned on, so your problem may be with bursting.  But you can als=
o
>have severe
>problems like a missing address line and linux still run for a few seconds=
.
>
>Mark Chambers

We've checked the SDRAM. The timings (UPM) look fine. The problem
however is that linux does not hang until after a few processes are
started.
If we boot to linux and leave it as it is, everything is fine and the
board remains working. However each time a few processes (4-5 telnet
sessions for eg.) are started the system either panics or hangs (goes
dead).

Thanks in advance,
Akshay
