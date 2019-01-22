Return-Path: <SRS0=/GF9=P6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D88C282C3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 19:43:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F020621726
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 19:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="bQ0juL1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F020621726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43kf442HWyzDqQT
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 06:43:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="bQ0juL1A"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43kf2L2QXBzDqLh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 06:42:18 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43kf2F3MF7z9tyKh;
 Tue, 22 Jan 2019 20:42:13 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=bQ0juL1A; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id kA5-yYeOW7_Q; Tue, 22 Jan 2019 20:42:13 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43kf2F23kjz9tyKg;
 Tue, 22 Jan 2019 20:42:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548186133; bh=+KekxATCYu05Vh7xen1ZqSBOL2BEkK7k9PxuT3Lg7pQ=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=bQ0juL1ALuH/dViqR66+sK0gKsvTQED9WolB6g3oq/cxF66zc38Jpld6XcjLBd2z4
 V+WqfgviZH4E/kuVuHiIVZL3SOhAFpzuOf9RMc2YDT8h2K4NaStu+hMyDtxjyMb94x
 FSx3GGYoYHrBA6yas6B6zbUo6n5qF4LgrZPvuj5U=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 588818B7F1;
 Tue, 22 Jan 2019 20:42:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 2Hi5xSpod367; Tue, 22 Jan 2019 20:42:13 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9BE5C8B7CE;
 Tue, 22 Jan 2019 20:42:12 +0100 (CET)
Subject: Re: [PATCH v13 00/10] powerpc: Switch to CONFIG_THREAD_INFO_IN_TASK
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>,
 Mike Rapoport <rppt@linux.ibm.com>
References: <cover.1547195976.git.christophe.leroy@c-s.fr>
 <87zhrx2bf1.fsf@concordia.ellerman.id.au>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <07e60b5a-611c-9863-f300-68a4f9ad2efd@c-s.fr>
Date: Tue, 22 Jan 2019 20:42:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <87zhrx2bf1.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 19/01/2019 à 11:23, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> The purpose of this serie is to activate CONFIG_THREAD_INFO_IN_TASK which
>> moves the thread_info into task_struct.
>>
>> Moving thread_info into task_struct has the following advantages:
>> - It protects thread_info from corruption in the case of stack
>> overflows.
>> - Its address is harder to determine if stack addresses are
>> leaked, making a number of attacks more difficult.
>>
>> Changes since v12:
>>   - Patch 1: Taken comment from Mike (re-introduced the 'panic' in case memblock allocation fails in setup_64.c
>>   - Patch 1: Added alloc_stack() function in setup_32.c to also panic in case of allocation failure.
> 
> Hi Christophe,
> 
> I can't get this series to boot on qemu mac99. I'm getting eg:
> 
> [    0.981514] NFS: Registering the id_resolver key type
> [    0.981752] Key type id_resolver registered
> [    0.981868] Key type id_legacy registered
> [    0.995711] Unrecoverable exception 0 at 0 (msr=0)
> [    0.996091] Oops: Unrecoverable exception, sig: 6 [#1]
> [    0.996314] BE PAGE_SIZE=4K MMU=Hash PowerMac
> [    0.996617] Modules linked in:
> [    0.996869] CPU: 0 PID: 416 Comm: modprobe Not tainted 5.0.0-rc2-gcc-7.3.0-00043-g53f2de798792 #342
> [    0.997138] NIP:  00000000 LR: 00000000 CTR: 00000000
> [    0.997309] REGS: ef237f50 TRAP: 0000   Not tainted  (5.0.0-rc2-gcc-7.3.0-00043-g53f2de798792)
> [    0.997508] MSR:  00000000 <>  CR: 00000000  XER: 00000000
> [    0.997712]
> [    0.997712] GPR00: 00000000 ef238000 00000000 00000000 00000000 00000000 00000000 00000000
> [    0.997712] GPR08: 00000000 00000000 00000000 00000000 00000000 00000000 c006477c ef13d8c0
> [    0.997712] GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    0.997712] GPR24: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    0.998671] NIP [00000000]   (null)
> [    0.998774] LR [00000000]   (null)
> [    0.998895] Call Trace:
> [    0.999030] Instruction dump:
> [    0.999320] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> [    0.999546] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 60000000 XXXXXXXX XXXXXXXX XXXXXXXX
> [    1.000023] ---[ end trace 925ea3419844fe68 ]---

No such issue on my side. Do you have a ramdisk with anythink special or 
a special config ? I see your kernel is modprobing something, know what 
it is ?

Especially, what is the amount of memory in your config ? On my side 
there is 128M:

Memory: 120292K/131072K available (6116K kernel code, 572K rwdata, 2036K 
rodata,
  340K init, 191K bss, 10780K reserved, 0K cma-reserved, 0K highmem)
Kernel virtual memory layout:
   * 0xfffcf000..0xfffff000  : fixmap
   * 0xff800000..0xffc00000  : highmem PTEs
   * 0xfef36000..0xff800000  : early ioremap
   * 0xc9000000..0xfef36000  : vmalloc & ioremap

This means the addresses in which your kernel faults are in vmalloc 
area. It's not normal I believe, is it ?

On my side it gives the following on qemu mac99 (I have no disk).

[...]
Initialise system trusted keyrings
workingset: timestamp_bits=30 max_order=15 bucket_order=0
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
Key type asymmetric registered
Asymmetric key parser 'x509' registered
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler mq-deadline registered
io scheduler kyber registered
Using unsupported 800x600 (null) at 81000000, depth=32, pitch=3200
Console: switching to colour frame buffer device 100x37
fb0: Open Firmware frame buffer device on /pci@f2000000/QEMU,VGA@e
Generic non-volatile memory driver v1.1
brd: module loaded
loop: module loaded
MacIO PCI driver attached to Keylargo chipset
Macintosh Cuda and Egret driver.
mesh: configured for synchronous 5 MB/s
st: Version 20160209, fixed bufsize 32768, s/g segs 256
Detected ADB keyboard, type ANSI.
input: ADB keyboard as /devices/virtual/input/input0
random: fast init done
input: ADB mouse as /devices/virtual/input/input1
pata-macio 0.00020000:ata-3: Activating pata-macio chipset KeyLargo 
ATA-3, Apple
  bus ID 0
scsi host0: pata_macio
ata1: PATA max MWDMA2 irq 16
pata-macio 0.00021000:ata-3: Activating pata-macio chipset KeyLargo 
ATA-3, Apple
  bus ID 1
scsi host1: pata_macio
ata2: PATA max MWDMA2 irq 18
pcnet32: pcnet32.c:v1.35 21.Apr.2008 tsbogend@alpha.franken.de
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-pci: OHCI PCI platform driver
ohci-pci 0000:00:0d.0: OHCI PCI host controller
ohci-pci 0000:00:0d.0: new USB bus registered, assigned bus number 1
ohci-pci 0000:00:0d.0: irq 28, io mem 0x80080000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
usbcore: registered new interface driver appletouch
rtc-generic rtc-generic: registered as rtc0
APM Battery Driver
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
oprofile: using timer interrupt.
Initializing XFRM netlink socket
NET: Registered protocol family 17
NET: Registered protocol family 15
Key type dns_resolver registered
drmem: No dynamic reconfiguration memory found
Loading compiled-in X.509 certificates
rtc-generic rtc-generic: setting system clock to 2019-01-22T19:35:11 UTC 
(154818
5711)
Warning: unable to open an initial console.
ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
cdrom: Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi generic sg0 type 5
VFS: Cannot open root device "(null)" or unknown-block(8,1): error -6
Please append a correct "root=" boot option; here are the available 
partitions:
0100            4096 ram0
  (driver?)
0101            4096 ram1
  (driver?)
0102            4096 ram2
  (driver?)
0103            4096 ram3
  (driver?)
0104            4096 ram4
  (driver?)
0105            4096 ram5
  (driver?)
0106            4096 ram6
  (driver?)
0107            4096 ram7
  (driver?)
0108            4096 ram8
  (driver?)
0109            4096 ram9
  (driver?)
010a            4096 ram10
  (driver?)
010b            4096 ram11
  (driver?)
010c            4096 ram12
  (driver?)
010d            4096 ram13
  (driver?)
010e            4096 ram14
  (driver?)
010f            4096 ram15
  (driver?)
0b00         1048575 sr0
  driver: sr
Kernel panic - not syncing: VFS: Unable to mount root fs on 
unknown-block(8,1)
CPU: 0 PID: 1 Comm: swapper Not tainted 5.0.0-rc3+ #790
Call Trace:
[c7837e60] [c003dcf0] panic+0x12c/0x2e8 (unreliable)
[c7837ec0] [c07fc824] mount_block_root+0x1fc/0x2c0
[c7837f10] [c07fcc54] prepare_namespace+0x198/0x1d4
[c7837f30] [c000539c] kernel_init+0x18/0x10c
[c7837f40] [c00131d8] ret_from_kernel_thread+0x14/0x1c
Rebooting in 180 seconds..

Christophe
