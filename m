Message-ID: <007501bfc49d$69ee2eb0$69f001dc@sjzhu.sps.mot.com>
From: "Shuangjun Zhu" <r44089@email.sps.mot.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PCMCIA support for 860
Date: Tue, 23 May 2000 17:58:13 +0800
MIME-Version: 1.0
Content-Type: text/plain;	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In arch/ppc/kernel/m8xx_setup.c:m8xx_ide_init_hwif_ports()
==============================================================
 base = (unsigned long) ioremap(PCMCIA_MEM_ADDR, 0x200);

 /* For the M-Systems ATA card, the first 8 registers map 1:1.
  * The following register, control/Altstatus, is located at 0x0e.
  * Following that, the irq offset, is not used, so we place it in
  * an unused location, 0x0a.
  */
 *p++ = base + 8;
=================================================================
This code means that ide_ioreg_t save the value as VMA, such 0xCxxxxxxx,
but in include/asm/io.h, it defined

#define outb(val, port)  out_8((unsigned char *)((port)+_IO_BASE), (val))

it uses the port as register offset, such as 0x10.

So, code access illegal address in macro
 SELECT_DRIVE in drivers/block/ide-probe.c: do_probe()



>
>In arch/ppc/mm/init.c, I have iorempa(_IO_BASE,_IO_BASE_SIZE),
>which _IO_BASE = 0x80000000,
>
>in macro SELECT_DRIVE in drivers/block/ide-probe.c: do_probe()
>OUT_BYTE((drive)->select.all, hwif->io_ports[IDE_SELECT_OFFSET])
>equal to OUT_BYTE((drive)->select.all, 0x80000000),
>then system illegal access, so what's wrong?
>
>Thanks in advanced!
>
>>
>>Hi,
>>
>>
>>
>>I recompiled the kernel (2.2.13, including fpu, damm, bossek patches) and
>>restarted it.
>>Then I used the rc.pcmcia to set the modules up. It fails because of...
>>
>>I found that system acess the illegal address 0x80000000,
>>in macro SELECT_DRIVE in drivers/block/ide-probe.c: do_probe()
>>
>>--------------------------------------------------------------------------
>>bash# ./rc.pcmcia start
>>Starting PCMCIA services: modulesLinux PCMCIA Card Services 3.1.10
>>  kernel build: 2.2.13 #496 Fri May 19 11:14:29 CST 2000
>>  options:  none
>>m8xx_pcmcia: Version 0.03, 14-Feb-2000, Magnus Damm
>>m8xx_pcmcia: FADS using SLOT_B with IRQ 13.
>> cardmgr.
>>H<30>Jan  1 00:35:21 cardmgr[131]: starting, version is 3.1.10
>>bash# A<30>Jan  1 00:35:22 cardmgr[131]: watching 1 sockets
>>A<30>Jan  1 00:35:22 cardmgr[131]: initializing socket 0
>>I<30>Jan  1 00:35:22 cardmgr[131]: socket 0: ATA/IDE Fixed Disk
>>a<30>Jan  1 00:35:22 cardmgr[131]: executing: 'insmod
>>/lib/modules/2.2.13/pcmci'
>>probing for hda: present=0, media=32, probetype=ATA
>>
>>
>>
>>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
