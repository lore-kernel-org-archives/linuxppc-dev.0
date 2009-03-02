Return-Path: <jonsmirl@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id 83696DDEE7
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Mar 2009 13:15:24 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id d14so1302345and.39
	for <linuxppc-dev@ozlabs.org>; Sun, 01 Mar 2009 18:15:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <fa686aa40903011707q3c142942w962c52abaf915629@mail.gmail.com>
References: <1235575933-29691-1-git-send-email-w.sang@pengutronix.de>
	<fa686aa40902262131i6c75687foaf42daeb4fc7a3b7@mail.gmail.com>
	<20090301101815.GC23093@pengutronix.de>
	<fa686aa40903010648q238380acy34b58e04226d8014@mail.gmail.com>
	<9e4733910903010754q1b4d9fafy87668049653d5e21@mail.gmail.com>
	<fa686aa40903011447x1810f252m367d6c05cc567133@mail.gmail.com>
	<9e4733910903011637q246eb82al140e87242f695413@mail.gmail.com>
	<9e4733910903011646g43b151c2m7c6dfe80ac07e80a@mail.gmail.com>
	<fa686aa40903011707q3c142942w962c52abaf915629@mail.gmail.com>
Date: Sun, 1 Mar 2009 21:15:21 -0500
Message-ID: <9e4733910903011815q1a956be0x137bac80f2e21e72@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mpc52xx: add Phytec phyCORE-MPC5200B-IO board
	(pcm032)
From: Jon Smirl <jonsmirl@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Mar 1, 2009 at 8:07 PM, Grant Likely <grant.likely@secretlab.ca> wr=
ote:
> On Sun, Mar 1, 2009 at 5:46 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>> On Sun, Mar 1, 2009 at 7:37 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>>> Just tried it on pcm030. If I uncomment the reg line the kernel won't
>>> boot at all. I don't get any output.
>>
>> I hooked up a serial console instead of netcat.
>>
>> PCI: Probing PCI hardware
>> PCI: Scanning bus 0000:00
>> Machine check in kernel mode.
>> Caused by (from SRR1=3D41030): Transfer error ack signal
>> Oops: Machine check, sig: 7 [#1]
>> dspeak01
>
> Yeah, there current PCI driver in mainline expects the bootloader to
> set stuff up for PCI to work. =A0I've fixed some of it, and the fix is
> queued up in Ben's -next tree. =A0Can you try Ben's -next tree?

with benh-next...

Bytes transferred =3D 7681 (1e01 hex)
## Booting image at 00500000 ...
   Image Name:   Linux-2.6.29-rc5-efika
   Created:      2009-03-02   2:13:17 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1778436 Bytes =3D  1.7 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
   Booting using flat device tree at 0x400000
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 61028k/65536k available (3524k kernel code, 4448k reserved,
156k data, 122k bss, 168k init)
SLUB: Genslabs=3D12, HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D1, N=
odes=3D1
Calibrating delay loop... 66.28 BogoMIPS (lpj=3D110848)
Mount-cache hash table entries: 512
net_namespace: 296 bytes
NET: Registered protocol family 16
PCI: Probing PCI hardware
PCI: Scanning bus 0000:00
long pause
Machine check in kernel mode.
Caused by (from SRR1=3D41030): Transfer error ack signal
Oops: Machine check, sig: 7 [#1]
dspeak01
Modules linked in:
NIP: c001c3bc LR: c0158ed0 CTR: c001c32c
REGS: c3823de0 TRAP: 0200   Not tainted  (2.6.29-rc5-efika)
MSR: 00041030 <ME,IR,DR>  CR: 28000022  XER: 20000000
TASK =3D c3824000[1] 'swapper' THREAD: c3822000
GPR00: 80000000 c3823e90 c3824000 c3856000 00000000 00000000 00000004 c3823=
eb8
GPR08: c03a9848 fcffc000 000008bc 0020213c 82000022 ffefffff 03ffe000 fffff=
fff
GPR16: 00000001 00000000 007ffc00 00000000 00000000 03ff8838 00000000 00000=
004
GPR24: 00000000 00000000 c3823eb8 00000000 00000004 00000000 c03c0000 c3856=
000
NIP [c001c3bc] mpc52xx_pci_read_config+0x90/0xec
LR [c0158ed0] pci_bus_read_config_dword+0x4c/0x74
Call Trace:
[c3823e90] [c00915dc] ifind+0x18/0x6c (unreliable)
[c3823eb0] [c0158ed0] pci_bus_read_config_dword+0x4c/0x74
[c3823ee0] [c0279090] pci_scan_single_device+0x24/0x4b0
[c3823f10] [c0159f6c] pci_scan_slot+0x2c/0x84
[c3823f30] [c027bae8] pci_scan_child_bus+0x40/0x108
[c3823f50] [c0352c44] pcibios_init+0xdc/0x190
[c3823f70] [c00038f4] do_one_initcall+0x58/0x19c
[c3823fe0] [c034714c] kernel_init+0x74/0xe0
[c3823ff0] [c00133d4] kernel_thread+0x4c/0x68
Instruction dump:
817e0040 5400801e 7c004b78 5769063a 64008000 7d290378 7c0004ac 912b0000
7c0004ac 813e0044 7c0004ac 7d604c2c <0c0b0000> 4c00012c 2f9c0004 57601ef8
---[ end trace 31fd0ba7d8756001 ]---
Kernel panic - not syncing: Attempted to kill init!
Rebooting in 180 seconds..







>
> Thanks,
> g.
>
>> Modules linked in:
>> NIP: c001be94 LR: c0158cb4 CTR: c001be04
>> REGS: c3823de0 TRAP: 0200 =A0 Not tainted =A0(2.6.29-rc6-efika)
>> MSR: 00041030 <ME,IR,DR> =A0CR: 28000022 =A0XER: 20000000
>> TASK =3D c3824000[1] 'swapper' THREAD: c3822000
>> GPR00: 80000000 c3823e90 c3824000 c3856000 00000000 00000000 00000004 c3=
823eb8
>> GPR08: c03a9848 fcffc000 000008bc 0020213c 82000022 ffefffff 03ffe000 ff=
ffffff
>> GPR16: 00000001 00000000 007ffc00 00000000 00000000 03ff8838 00000000 00=
000004
>> GPR24: 00000000 00000000 c3823eb8 00000000 00000004 00000000 c03c0000 c3=
856000
>> NIP [c001be94] mpc52xx_pci_read_config+0x90/0xec
>> LR [c0158cb4] pci_bus_read_config_dword+0x4c/0x74
>> Call Trace:
>> [c3823e90] [c0091238] ifind+0x18/0x6c (unreliable)
>> [c3823eb0] [c0158cb4] pci_bus_read_config_dword+0x4c/0x74
>> [c3823ee0] [c0278a90] pci_scan_single_device+0x24/0x4b0
>> [c3823f10] [c0159d50] pci_scan_slot+0x2c/0x84
>> [c3823f30] [c027b2d4] pci_scan_child_bus+0x40/0x108
>> [c3823f50] [c0351c34] pcibios_init+0xdc/0x190
>> [c3823f70] [c00038f4] do_one_initcall+0x58/0x19c
>> [c3823fe0] [c034614c] kernel_init+0x74/0xe0
>> [c3823ff0] [c00133d4] kernel_thread+0x4c/0x68
>> Instruction dump:
>> 817e0040 5400801e 7c004b78 5769063a 64008000 7d290378 7c0004ac 912b0000
>> 7c0004ac 813e0044 7c0004ac 7d604c2c <0c0b0000> 4c00012c 2f9c0004 57601ef=
8
>> ---[ end trace 31fd0ba7d8756001 ]---
>> Kernel panic - not syncing: Attempted to kill init!
>> Rebooting in 180 seconds..
>>
>>
>> --
>> Jon Smirl
>> jonsmirl@gmail.com
>>
>
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>



--=20
Jon Smirl
jonsmirl@gmail.com
