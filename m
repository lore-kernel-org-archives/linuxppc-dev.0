Return-Path: <ludo.vanput@gmail.com>
Received: from mail-bw0-f207.google.com (mail-bw0-f207.google.com
	[209.85.218.207])
	by bilbo.ozlabs.org (Postfix) with ESMTP id F18EFB7B60
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Sep 2009 23:08:34 +1000 (EST)
Received: by bwz3 with SMTP id 3so2238637bwz.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Sep 2009 06:08:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090914125129.GB12372@zod.rchland.ibm.com>
References: <5edaeed70909140536s53fb36ael4f0cb90abfe327e0@mail.gmail.com>
	<20090914125129.GB12372@zod.rchland.ibm.com>
Date: Mon, 14 Sep 2009 15:08:31 +0200
Message-ID: <5edaeed70909140608m3ddcda33y7f92b2dfd18ca92e@mail.gmail.com>
Subject: Re: Oops in IDE probing on ppc_440 when PCI is enabled in strapping
From: Ludo Van Put <ludo.vanput@gmail.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2009/9/14 Josh Boyer <jwboyer@linux.vnet.ibm.com>:
> On Mon, Sep 14, 2009 at 02:36:15PM +0200, Ludo Van Put wrote:
>>Hi,
>>
>>we're working with a PPC440GX on a board that has a.o. a compact flash sl=
ot.
>>We had the PCI subsystem of the ppc disabled in strapping for quite a whi=
le,
>>until we wanted to start using it.
>>However, when we enabled PCI in the strapping and in the (patched 2.6.10)
>
> 2.6.10? =A0Really? =A0If that is truly the case, you probably aren't goin=
g to get
> a whole lot of help from the list, since that kernel is pretty ancient.
>
I can only acknowledge that, but we're stuck to that kernel for now...

>>kernel configuration, we triggered an oops when probing for IDE devices (=
to
>>read out the first 512 bytes of the CF). I can see that the ioremap64 cal=
l
>>in the driver code for our CF returns a different address (compared to PC=
I
>>disabled in strapping), but using this address later on for accessing the=
 CF
>>goes wrong.
>
> Posting the oops output would perhaps help. =A0Or maybe not.
>
> josh
>

Here it goes, you never know:

Oops: kernel access of bad area, sig: 11 [#1]
PREEMPT
NIP: C0148050 LR: C013BC64 SP: C07CFEA0 REGS: c07cfdf0 TRAP: 0300    Not ta=
inted
MSR: 00021000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
DAR: E3093000, DSISR: 00000000
TASK =3D c07cdb70[1] 'swapper' THREAD: c07ce000
Last syscall: 120
GPR00: 00000000 C07CFEA0 C07CDB70 E3093000 DFE829FE 00000100 C01184E8 C021B=
270
GPR08: C0220000 C02D0F60 C07CDEF8 C07CDEF8 00000000 70000000 1FFF6400 00000=
001
GPR16: 00000001 FFFFFFFF 1FFF06C0 00000000 00000001 C0220000 C0280000 00029=
000
GPR24: 00000000 C02D0F60 C01F0000 C0148040 00000080 00000000 DFE82A00 C02D0=
FF0
NIP [c0148050] ide_insw+0x10/0x24
LR [c013bc64] ata_input_data+0x74/0x114
Call backtrace:
 c013e6a4 try_to_identify+0x2ec/0x5ec
 c013eaa8 do_probe+0x104/0x304
 c013f0c4 probe_hwif+0x358/0x6c4
 c0140068 ideprobe_init+0xa8/0x1a0
 c02a4ef8 ide_generic_init+0x10/0x28
 c0001324 init+0xc4/0x244
 c0004254 kernel_thread+0x44/0x60
Kernel panic - not syncing: Attempted to kill init!
 <0>Rebooting in 180 seconds..


ide_insw is a asm routine to read in 16bit words and swap them. Copied
from arch/ppc/kernel/misc.S. Works fine when PCI is disabled.

KR, Ludo
