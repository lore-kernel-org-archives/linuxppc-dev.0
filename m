Message-ID: <013a01bfc3cf$9ced0990$69f001dc@sjzhu.sps.mot.com>
From: "Shuangjun Zhu" <r44089@email.sps.mot.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PCMCIA support for 860
Date: Mon, 22 May 2000 17:24:58 +0800
MIME-Version: 1.0
Content-Type: text/plain;	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In arch/ppc/mm/init.c, I have iorempa(_IO_BASE,_IO_BASE_SIZE),
which _IO_BASE = 0x80000000,

in macro SELECT_DRIVE in drivers/block/ide-probe.c: do_probe()
OUT_BYTE((drive)->select.all, hwif->io_ports[IDE_SELECT_OFFSET])
equal to OUT_BYTE((drive)->select.all, 0x80000000),
then system illegal access, so what's wrong?

Thanks in advanced!

>
>Hi,
>
>
>
>I recompiled the kernel (2.2.13, including fpu, damm, bossek patches) and
>restarted it.
>Then I used the rc.pcmcia to set the modules up. It fails because of...
>
>I found that system acess the illegal address 0x80000000,
>in macro SELECT_DRIVE in drivers/block/ide-probe.c: do_probe()
>
>--------------------------------------------------------------------------
>bash# ./rc.pcmcia start
>Starting PCMCIA services: modulesLinux PCMCIA Card Services 3.1.10
>  kernel build: 2.2.13 #496 Fri May 19 11:14:29 CST 2000
>  options:  none
>m8xx_pcmcia: Version 0.03, 14-Feb-2000, Magnus Damm
>m8xx_pcmcia: FADS using SLOT_B with IRQ 13.
> cardmgr.
>H<30>Jan  1 00:35:21 cardmgr[131]: starting, version is 3.1.10
>bash# A<30>Jan  1 00:35:22 cardmgr[131]: watching 1 sockets
>A<30>Jan  1 00:35:22 cardmgr[131]: initializing socket 0
>I<30>Jan  1 00:35:22 cardmgr[131]: socket 0: ATA/IDE Fixed Disk
>a<30>Jan  1 00:35:22 cardmgr[131]: executing: 'insmod
>/lib/modules/2.2.13/pcmci'
>probing for hda: present=0, media=32, probetype=ATA
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
