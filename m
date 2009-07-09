Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 78659B707F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Jul 2009 12:42:45 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A83E9DDDA0
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Jul 2009 12:42:44 +1000 (EST)
Message-Id: <C24F167C-66C5-4FC4-9221-E6BDC8606189@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Alan Modra <amodra@bigpond.net.au>
In-Reply-To: <20090708233954.GA3181@bubble.grove.modra.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: binutils 2.19 issue with kernel link
Date: Wed, 8 Jul 2009 21:40:19 -0500
References: <09159ADA-39F9-419E-AE46-4CFAE612AFB9@kernel.crashing.org>
	<20090708233954.GA3181@bubble.grove.modra.org>
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	bug-binutils@gnu.org, Edmar Wienskoski-RA8797 <Edmar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 8, 2009, at 6:39 PM, Alan Modra wrote:

> On Wed, Jul 08, 2009 at 05:41:39PM -0500, Kumar Gala wrote:
>> If we modify the linker script:
>>
>>      _end2 = .;
>>      _end3 = ALIGN(4096);
>>      _end4 = ALIGN(PAGE_SIZE);
>>      . = ALIGN(PAGE_SIZE);
>>      _end = . ;
>>      PROVIDE32 (end = .);
>>
>> and the result is:
>>
>> 00001000 A _end
>> c067f678 A _end2
>> c0680000 A _end3
>> c0680000 A _end4
>
> Possibly some section with a zero vma is being placed before _end.
> Generate a link map to see if this is so.

In the broken (ALIGN) case we have:

  .bss           0x00000000c05d3018        0x0 lib/lib.a(klist.o)
  .bss           0x00000000c05d3018        0x0 lib/lib.a(sha1.o)
  .bss           0x00000000c05d3018        0x0 .tmp_kallsyms3.o
  *(COMMON)
                 0x00000000c05d3018                __bss_stop = .

.PPC.EMB.apuinfo
                 0x0000000000000000       0x24
  .PPC.EMB.apuinfo
                 0x0000000000000000       0x1c arch/powerpc/kernel/ 
head_fsl_booke.o
  .PPC.EMB.apuinfo

In the non-ALIGN case we have:

                 0x00000000c05d3018                _end = .
                 0x00000000c05d3018                PROVIDE (end, .)
LOAD arch/powerpc/kernel/head_fsl_booke.o
LOAD init/built-in.o
START GROUP
LOAD usr/built-in.o
LOAD arch/powerpc/kernel/built-in.o
LOAD arch/powerpc/mm/built-in.o
LOAD arch/powerpc/lib/built-in.o
LOAD arch/powerpc/sysdev/built-in.o
LOAD arch/powerpc/platforms/built-in.o
LOAD arch/powerpc/math-emu/built-in.o
LOAD kernel/built-in.o
LOAD mm/built-in.o
LOAD fs/built-in.o
LOAD ipc/built-in.o
LOAD security/built-in.o
LOAD crypto/built-in.o
LOAD block/built-in.o
LOAD lib/lib.a
LOAD lib/built-in.o
LOAD drivers/built-in.o
LOAD sound/built-in.o
LOAD firmware/built-in.o
LOAD net/built-in.o
END GROUP
LOAD .tmp_kallsyms3.o
OUTPUT(vmlinux elf32-powerpc)

.PPC.EMB.apuinfo
                 0x0000000000000000       0x24
  .PPC.EMB.apuinfo
                 0x0000000000000000       0x1c arch/powerpc/kernel/ 
head_fsl_booke.o
