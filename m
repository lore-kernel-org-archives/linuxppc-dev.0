Message-ID: <3E2FFCF9.8030308@bluewin.ch>
Date: Thu, 23 Jan 2003 15:32:25 +0100
From: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
MIME-Version: 1.0
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: Leonardo Pereira Santos <lsantos@pd3.com.br>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>,
	Wolfgang Denk <wd@denx.de>
Subject: Re: PCMCIA on TQM8xxL
References: <3E2FBB5E.E16D577E@imc-berlin.de> <3E2FBF48.6040200@bluewin.ch> <3E2FC0F1.41C65F18@imc-berlin.de> <200301231155.20895.lsantos@pd3.com.br> <3E2FF5F6.B0F5CE15@imc-berlin.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 01/23/2003 03:02 PM Steven Scholz wrote:
>
> Leonardo Pereira Santos wrote:
>>
>>
>> 1) Define _IO_BASE and _IO_BASE_SIZE in arch/ppc/platforms/tqm8xxl.h
>> 2) just copy and paste the line of code for the RPX to TQM8xxL section in
>> arch/ppc/kernel/m8xx_setup.c m8xx_map_io(), as you pointed. If there's no
>> #ifdef CONFIG_TQM8XXL (or something like that), just create one near the ones
>> already defined for FADS, RPX, MBX. For example, for my FADS board, its
>> section looks like this:
>>
>> #ifdef CONFIG_FADS
>>         io_block_mapping(BCSR_ADDR, BCSR_ADDR, BCSR_SIZE, _PAGE_IO);
>>         io_block_mapping(_IO_BASE,_IO_BASE,_IO_BASE_SIZE, _PAGE_IO);
>> #endif
> ...
>
> I know. That's what I did.
>
> The problem is:
>
> DENX claims that PCMCIA is working on TQM8xxL using ELDK 2.0 and their linux CVS
> tree.
> But I can't see how! Since there's no remapping of _IO_BASE for TQM8xxL.
>
> Maybe I just have to wait until Wolfgang Denk is online again!

It's also not working on my TQM8xxL starter kit and I remember vaguely
that Wolfgang mentioned that the PCMCIA support ist not yet fully
implemented and tested (compared with our 2.4.4 kernel). But even with
io_block_mapping(_IO_BASE, ...) I still get an Oops in do_probe():

ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
PCMCIA slot B: phys mem e0000000...ec000000 (size 0c000000)
Card ID: HITACHI FLASH 5.0
 Fixed Disk Card
 IDE interface
 [silicon] [unique] [single] [sleep] [standby] [idle] [low power]
Oops: kernel access of bad area, sig: 11
NIP: C00B69FC XER: 8000AA7F LR: C00B69D8 SP: C01F9EF0 REGS: c01f9e40
TRAP: 0300

Thanks,

Wolfgang.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
