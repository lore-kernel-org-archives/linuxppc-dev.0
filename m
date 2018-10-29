Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C72C2BC61
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 22:27:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDF9F2080A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 22:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="GpNAjtkN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF9F2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kTjX4qfKzDrYb
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 09:26:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="GpNAjtkN";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p00-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5300::7; helo=mo6-p00-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="GpNAjtkN"; 
 dkim-atps=neutral
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42kTft2sQrzDqT3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 09:24:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1540851872;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=VWchnpb7gPtv2DMML3+S7kzW17/98oIqaPZj9GDanmg=;
 b=GpNAjtkNx6ctatMpXRZWq4G58JrudqRWraJwX+DjHYYMzVMkdHTDb3j2maOHI7PYjQ
 LmYAQnhUHDW1rEaKcPgKVnhmq/l54u5n4knUhNRsM773CgTrT2EN/I5cKqTo+zJlMjf1
 xYB9jwgqxP9pfSfak7JBAGGPz+iX8TsaG4Qmh9EzJ4KbOWG0h0rpxND9F8ZXesENWUrR
 Opmo6gsw7n/XqjPYSRWHq2OfKqVOlFLxEaRF8LSX34w8NUmI31ClPsDs8QyFRmCDRyuw
 AHRWgR9N1My2ytyFbVcAO39eDCeQ0NBy+j2oVPr/92D518Mt2gMTTLXUqwnCMsTvZTiQ
 fk2Q==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7Claj5g1PFUMuPaOFFHIlc73iVjE"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:e1e0:2a1f:8ec:6b80]
 by smtp.strato.de (RZmta 44.3 AUTH) with ESMTPSA id Z0624cu9TMOV9Sl
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate)
 for <linuxppc-dev@lists.ozlabs.org>;
 Mon, 29 Oct 2018 23:24:31 +0100 (CET)
Subject: NXP P50XX/e5500: SMP doesn't work anymore with the latest Git kernel
To: linuxppc-dev@lists.ozlabs.org
References: <6bcb4b23-bb78-d1a5-7fd0-5f892115d302@xenosoft.de>
 <99266ac6-640c-b2a9-eef3-4e89ee1e0ad5@xenosoft.de>
 <f6ca1728-d312-1267-d9d7-18d2369f1bf7@xenosoft.de>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <ac15715d-5335-da80-6d1c-1d558fb3cebd@xenosoft.de>
Date: Mon, 29 Oct 2018 23:24:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f6ca1728-d312-1267-d9d7-18d2369f1bf7@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Little progress ...

I reverted the following two OF files of the commit 'Merge tag 
devicetree-for-4.20' and SMP works! The problematic code is somewhere in 
these two files.

a/include/linux/of.h
a/drivers/of/base.c

-- Christian


On 29 October 2018 at 6:00PM, Christian Zigotzky wrote:
> Hello,
>
> I figured out that the problem is in the OF source code of the commit: 
> Merge tag devicetree-for-4.20. [1]
>
> I reverted the following OF files and SMP works!
>
> drivers/of/base.c
> drivers/of/device.c
> drivers/of/of_mdio.c
> drivers/of/of_numa.c
> drivers/of/of_private.h
> drivers/of/overlay.c
> drivers/of/platform.c
> drivers/of/unittest-data/overlay_15.dts
> drivers/of/unittest-data/tests-overlay.dtsi
> drivers/of/unittest.c
> include/linux/of.h
>
> Cheers,
> Christian
>
> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b27186abb37b7bd19e0ca434f4f425c807dbd708
>
>
> On 29 October 2018 at 10:56AM, Christian Zigotzky wrote:
>> Hello,
>>
>> I have figured out that the commit 'devicetree-for-4.20' [1] is 
>> responsible for the SMP problem. I was able to revert this commit 
>> with 'git revert b27186abb37b7bd19e0ca434f4f425c807dbd708 -m 1' today.
>>
>> [master ec81438] Revert "Merge tag 'devicetree-for-4.20' of 
>> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux"
>> 138 files changed, 931 insertions(+), 1538 deletions(-)
>> rename Documentation/devicetree/bindings/arm/{atmel-sysregs.txt => 
>> atmel-at91.txt} (67%)
>> delete mode 100644 
>> Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.txt
>> delete mode 100644 
>> Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-scfg.txt
>> rename Documentation/devicetree/bindings/arm/{zte,sysctrl.txt => 
>> zte.txt} (62%)
>> delete mode 100644 Documentation/devicetree/bindings/misc/lwn-bk4.txt
>> create mode 100644 arch/c6x/boot/dts/linked_dtb.S
>> delete mode 100644 arch/nios2/boot/dts/Makefile
>> create mode 100644 arch/nios2/boot/linked_dtb.S
>> delete mode 100644 arch/powerpc/boot/dts/Makefile
>> delete mode 100644 arch/powerpc/boot/dts/fsl/Makefile
>> delete mode 100644 scripts/dtc/yamltree.c
>>
>> It solves the SMP problem! SMP works again on my P5020 board and on 
>> virtual e5500 QEMU machines.
>>
>> QEMU command: ./qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048 
>> -kernel /home/christian/Downloads/uImage-4.20-alpha5 -drive 
>> format=raw,file=/home/christian/Dokumente/ubuntu_MATE_16.04.3_LTS_PowerPC_QEMU/ubuntu_MATE_16.04_PowerPC.img,index=0,if=virtio 
>> -nic user,model=e1000 -append "rw root=/dev/vda3" -device virtio-vga 
>> -device virtio-mouse-pci -device virtio-keyboard-pci -soundhw es1370 
>> -smp 4
>>
>> Screenshot: 
>> https://plus.google.com/u/0/photos/photo/115515624056477014971/6617705776207990082
>>
>> Do we need a new dtb file or is it a bug?
>>
>> Thanks,
>> Christian
>>
>> [1] 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b27186abb37b7bd19e0ca434f4f425c807dbd708
>>
>>
>> On 28 October 2018 at 5:35PM, Christian Zigotzky wrote:
>>> Hello,
>>>
>>> SMP doesn't work anymore with the latest Git kernel (28/10/18 
>>> 11:12AM GMT) on my P5020 board and on virtual e5500 QEMU machines.
>>>
>>> Board with P5020 dual core CPU:
>>>
>>> [    0.000000] -----------------------------------------------------
>>> [    0.000000] phys_mem_size     = 0x200000000
>>> [    0.000000] dcache_bsize      = 0x40
>>> [    0.000000] icache_bsize      = 0x40
>>> [    0.000000] cpu_features      = 0x00000003008003b4
>>> [    0.000000]   possible        = 0x00000003009003b4
>>> [    0.000000]   always          = 0x00000003008003b4
>>> [    0.000000] cpu_user_features = 0xcc008000 0x08000000
>>> [    0.000000] mmu_features      = 0x000a0010
>>> [    0.000000] firmware_features = 0x0000000000000000
>>> [    0.000000] -----------------------------------------------------
>>> [    0.000000] CoreNet Generic board
>>>
>>>     ...
>>>
>>> [    0.002161] smp: Bringing up secondary CPUs ...
>>> [    0.002339] No cpu-release-addr for cpu 1
>>> [    0.002347] smp: failed starting cpu 1 (rc -2)
>>> [    0.002401] smp: Brought up 1 node, 1 CPU
>>>
>>> Virtual e5500 quad core QEMU machine:
>>>
>>> [    0.026394] smp: Bringing up secondary CPUs ...
>>> [    0.027831] No cpu-release-addr for cpu 1
>>> [    0.027989] smp: failed starting cpu 1 (rc -2)
>>> [    0.030143] No cpu-release-addr for cpu 2
>>> [    0.030304] smp: failed starting cpu 2 (rc -2)
>>> [    0.032400] No cpu-release-addr for cpu 3
>>> [    0.032533] smp: failed starting cpu 3 (rc -2)
>>> [    0.033117] smp: Brought up 1 node, 1 CPU
>>>
>>> QEMU command: ./qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048 
>>> -kernel 
>>> /home/christian/Downloads/vmlinux-4.20-alpha4-AmigaOne_X1000_X5000/X5000_and_QEMU_e5500/uImage-4.20 
>>> -drive 
>>> format=raw,file=/home/christian/Downloads/MATE_PowerPC_Remix_2017_0.9.img,index=0,if=virtio 
>>> -nic user,model=e1000 -append "rw root=/dev/vda" -device virtio-vga 
>>> -device virtio-mouse-pci -device virtio-keyboard-pci -usb -soundhw 
>>> es1370 -smp 4
>>>
>>> .config:
>>>
>>> ...
>>> CONFIG_SMP=y
>>> CONFIG_NR_CPUS=4
>>> ...
>>>
>>> Please test the latest Git kernel on your NXP P50XX boards.
>>>
>>> Thanks,
>>> Christian
>>>
>>
>>
>
>

