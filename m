Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114BAECDE44
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 13:41:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C536420664
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 13:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="asXpNZo7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C536420664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42lTyV430WzF3FX
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 00:41:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="asXpNZo7";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p01-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5301::11; helo=mo6-p01-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="asXpNZo7"; 
 dkim-atps=neutral
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5301::11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lTv46rPXzF310
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 00:38:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1540993114;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=TngtiFCzJeuyIf9U/uC4YxN3kQwjnMo5u5Wxl0/0jUE=;
 b=asXpNZo7PB5XtH3DGOMDiJqcAgyC4fLTMKT3+V+wQGxlU9seVauiPHgSysT8+Np8nM
 3WeJFX/TdtszR8Ypi7ov1SYJo45I0slbwzBxkhWalnuEcP28K8McIooCqjPdadjoBoE5
 v1QRMmz3GkFex3o9SY3zemVaXwpR4IiVrAv9+JOPfI2Xcuww5xIVo4gkDu346Sj75E4n
 SyuCSP7oy1OxJ52f+cwLIwu9k97VsqqXqQcGDsGSekl3Ut3lFOq6/wHnOUynpOR+zXlj
 HQLL0nq5ZxOEtjF3TBWGgMq1GPlZLeAL6wYfLXkDARZxmKvtetDEn0TnrZy+A+jSZFU5
 xPTQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7Clbhp9bayqLMHIFV3bP6ZGRVRmKHA=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:d842:f065:35df:e394]
 by smtp.strato.de (RZmta 44.3 AUTH) with ESMTPSA id Z0624cu9VDcXJJI
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate)
 for <linuxppc-dev@lists.ozlabs.org>;
 Wed, 31 Oct 2018 14:38:33 +0100 (CET)
Subject: Re: NXP P50XX/e5500: SMP doesn't work anymore with the latest Git
 kernel
To: linuxppc-dev@lists.ozlabs.org
References: <6bcb4b23-bb78-d1a5-7fd0-5f892115d302@xenosoft.de>
 <99266ac6-640c-b2a9-eef3-4e89ee1e0ad5@xenosoft.de>
 <f6ca1728-d312-1267-d9d7-18d2369f1bf7@xenosoft.de>
 <ac15715d-5335-da80-6d1c-1d558fb3cebd@xenosoft.de>
 <87o9bafe12.fsf@concordia.ellerman.id.au>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <e7d36359-48bc-6433-f74f-c36f8d14d50d@xenosoft.de>
Date: Wed, 31 Oct 2018 14:38:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87o9bafe12.fsf@concordia.ellerman.id.au>
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

Hi Michael,

Many thanks for this good explanation. I will try to learn more about 
bisecting. Sometimes the problem is the time. I usually work for a Linux 
first level support for our AmigaOne machines. That means my main work 
is end user support. Therefore I have to learn more about second and 
third level Linux support.

Cheers,
Christian

On 31 October 2018 at 2:20PM, Michael Ellerman wrote:
> Christian Zigotzky <chzigotzky@xenosoft.de> writes:
>
>> Little progress ...
>>
>> I reverted the following two OF files of the commit 'Merge tag
>> devicetree-for-4.20' and SMP works! The problematic code is somewhere in
>> these two files.
>>
>> a/include/linux/of.h
>> a/drivers/of/base.c
> Hi Christian,
>
> Trying to debug things by reverting like this can work, but it's quite
> error prone and is usually only used *after* a bisect has identified the
> suspect code, or if a bisect can't work for some reason.
>
> I know you said you'd had trouble bisecting in the past, but this one
> should be a good one to practice on.
>
> You already identified that the merge of the devicetree changes was the
> problem, ie.
>
>    b27186abb37b Merge tag 'devicetree-for-4.20' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
>
>
> So you do:
>    $ git show b27186abb37b
>    commit b27186abb37b7bd19e0ca434f4f425c807dbd708
>    Merge: 0ef7791e2bfb d061864b89c3
>    Author: Linus Torvalds <torvalds@linux-foundation.org>
>    Date:   Fri Oct 26 12:09:58 2018 -0700
>    
>        Merge tag 'devicetree-for-4.20' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
>
>
> And that shows you the two commits that were merged 0ef7791e2bfb and
> d061864b89c3. If you look at them you see:
>
>    $ git log -1 --oneline 0ef7791e2bfb
>    0ef7791e2bfb Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal
>     
>    $ git log -1 --oneline d061864b89c3
>    d061864b89c3 ARM: dt: relicense two DT binding IRQ headers
>
> You can see that the first one is the previous commit on Linus' branch,
> ie. an unrelated merge. The 2nd commit is the commit that was on top of
> robh's tree, ie. that's the start of the interesting commits for us.
>
> You can also get to that 2nd commit using b27186abb37b^2.
>
> If you look at what came in via Rob's branch with:
>
>    $ git log --oneline d061864b89c3
>    or
>    $ git log --oneline b27186abb37b^2
>
> You see there's quite a few commits, and in particular there's another
> merge:
>
>    389d0a8a7af8 Merge branch 'dt/cpu-type-rework' into dt/next
>
> If we log the 2nd parent of that, we see:
>
>   $ git log --oneline 389d0a8a7af8^2
>   4c29e5934f6c microblaze: get cpu node with of_get_cpu_node
>   a691240e36e3 fbdev: fsl-diu: get cpu node with of_get_cpu_node
>   651d44f9679c of: use for_each_of_cpu_node iterator
>   a9a455e854cd iommu: fsl_pamu: use for_each_of_cpu_node iterator
>   37dc218bed44 edac: cpc925: use for_each_of_cpu_node iterator
>   76ec23b127cd clk: mvebu: use for_each_of_cpu_node iterator
>   7de8f4aa2f35 x86: DT: use for_each_of_cpu_node iterator
>   8cabf5bc1049 SH: use for_each_of_cpu_node iterator
>   38959a091e4a powerpc: 8xx: get cpu node with of_get_cpu_node
>   84dbc69a2ff3 powerpc: 4xx: get cpu node with of_get_cpu_node
>   a94fe366340a powerpc: use for_each_of_cpu_node iterator
>   5e5abae858b5 openrisc: use for_each_of_cpu_node iterator
>   1f0fe1f67cef nios2: get cpu node with of_get_cpu_node
>   5a931a3c80b5 c6x: use for_each_of_cpu_node iterator
>   de76e70a8d4e arm64: use for_each_of_cpu_node iterator
>   5af5d40c4015 ARM: shmobile: use for_each_of_cpu_node iterator
>   07d44f1f82b7 ARM: topology: remove unneeded check for /cpus node
>   d4866f751edf ARM: use for_each_of_cpu_node iterator
>   6487c15f1cc9 of: Support matching cpu nodes with no 'reg' property
>   f1f207e43b8a of: Add cpu node iterator for_each_of_cpu_node()
>   f6707fd6241e of: make PowerMac cache node search conditional on CONFIG_PPC_PMAC
>   6d0a70a284be vsprintf: print OF node name using full_name
>   a613b26a5013 of: Convert to using %pOFn instead of device_node.name
>   6901378c799d of/unittest: add printf tests for node name
>   b610e2ff4622 of/unittest: remove use of node name pointer in overlay high level test
>   57361846b52b (tag: v4.19-rc2) Linux 4.19-rc2
>
>
> So if we think the suspect commit is in there, we would confirm that by
> checking out v4.19-rc2 and testing it works. And then checkout out
> 4c29e5934f6c and testing that it's broken.
>
> Assuming the former worked and the latter was broken, we do:
>
>   $ git bisect good v4.19-rc2
>   $ git bisect bad 4c29e5934f6c
>
> And then just follow the prompts.
>
> One thing to watch out for is hitting an unrelated bug, that can
> sometimes derail your bisection.
>
> In this case the bug we're looking for is that CPU 1 isn't onlined
> properly. But if the system doesn't boot entirely for example then you
> shouldn't mark the commit as bad, instead it's better to skip it. Then
> git will choose a different commit for you to test.
>
> Anyway hope that helps.
>
> cheers
>
>> On 29 October 2018 at 6:00PM, Christian Zigotzky wrote:
>>> Hello,
>>>
>>> I figured out that the problem is in the OF source code of the commit:
>>> Merge tag devicetree-for-4.20. [1]
>>>
>>> I reverted the following OF files and SMP works!
>>>
>>> drivers/of/base.c
>>> drivers/of/device.c
>>> drivers/of/of_mdio.c
>>> drivers/of/of_numa.c
>>> drivers/of/of_private.h
>>> drivers/of/overlay.c
>>> drivers/of/platform.c
>>> drivers/of/unittest-data/overlay_15.dts
>>> drivers/of/unittest-data/tests-overlay.dtsi
>>> drivers/of/unittest.c
>>> include/linux/of.h
>>>
>>> Cheers,
>>> Christian
>>>
>>> [1]
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b27186abb37b7bd19e0ca434f4f425c807dbd708
>>>
>>>
>>> On 29 October 2018 at 10:56AM, Christian Zigotzky wrote:
>>>> Hello,
>>>>
>>>> I have figured out that the commit 'devicetree-for-4.20' [1] is
>>>> responsible for the SMP problem. I was able to revert this commit
>>>> with 'git revert b27186abb37b7bd19e0ca434f4f425c807dbd708 -m 1' today.
>>>>
>>>> [master ec81438] Revert "Merge tag 'devicetree-for-4.20' of
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux"
>>>> 138 files changed, 931 insertions(+), 1538 deletions(-)
>>>> rename Documentation/devicetree/bindings/arm/{atmel-sysregs.txt =>
>>>> atmel-at91.txt} (67%)
>>>> delete mode 100644
>>>> Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.txt
>>>> delete mode 100644
>>>> Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-scfg.txt
>>>> rename Documentation/devicetree/bindings/arm/{zte,sysctrl.txt =>
>>>> zte.txt} (62%)
>>>> delete mode 100644 Documentation/devicetree/bindings/misc/lwn-bk4.txt
>>>> create mode 100644 arch/c6x/boot/dts/linked_dtb.S
>>>> delete mode 100644 arch/nios2/boot/dts/Makefile
>>>> create mode 100644 arch/nios2/boot/linked_dtb.S
>>>> delete mode 100644 arch/powerpc/boot/dts/Makefile
>>>> delete mode 100644 arch/powerpc/boot/dts/fsl/Makefile
>>>> delete mode 100644 scripts/dtc/yamltree.c
>>>>
>>>> It solves the SMP problem! SMP works again on my P5020 board and on
>>>> virtual e5500 QEMU machines.
>>>>
>>>> QEMU command: ./qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048
>>>> -kernel /home/christian/Downloads/uImage-4.20-alpha5 -drive
>>>> format=raw,file=/home/christian/Dokumente/ubuntu_MATE_16.04.3_LTS_PowerPC_QEMU/ubuntu_MATE_16.04_PowerPC.img,index=0,if=virtio
>>>> -nic user,model=e1000 -append "rw root=/dev/vda3" -device virtio-vga
>>>> -device virtio-mouse-pci -device virtio-keyboard-pci -soundhw es1370
>>>> -smp 4
>>>>
>>>> Screenshot:
>>>> https://plus.google.com/u/0/photos/photo/115515624056477014971/6617705776207990082
>>>>
>>>> Do we need a new dtb file or is it a bug?
>>>>
>>>> Thanks,
>>>> Christian
>>>>
>>>> [1]
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b27186abb37b7bd19e0ca434f4f425c807dbd708
>>>>
>>>>
>>>> On 28 October 2018 at 5:35PM, Christian Zigotzky wrote:
>>>>> Hello,
>>>>>
>>>>> SMP doesn't work anymore with the latest Git kernel (28/10/18
>>>>> 11:12AM GMT) on my P5020 board and on virtual e5500 QEMU machines.
>>>>>
>>>>> Board with P5020 dual core CPU:
>>>>>
>>>>> [    0.000000] -----------------------------------------------------
>>>>> [    0.000000] phys_mem_size     = 0x200000000
>>>>> [    0.000000] dcache_bsize      = 0x40
>>>>> [    0.000000] icache_bsize      = 0x40
>>>>> [    0.000000] cpu_features      = 0x00000003008003b4
>>>>> [    0.000000]   possible        = 0x00000003009003b4
>>>>> [    0.000000]   always          = 0x00000003008003b4
>>>>> [    0.000000] cpu_user_features = 0xcc008000 0x08000000
>>>>> [    0.000000] mmu_features      = 0x000a0010
>>>>> [    0.000000] firmware_features = 0x0000000000000000
>>>>> [    0.000000] -----------------------------------------------------
>>>>> [    0.000000] CoreNet Generic board
>>>>>
>>>>>      ...
>>>>>
>>>>> [    0.002161] smp: Bringing up secondary CPUs ...
>>>>> [    0.002339] No cpu-release-addr for cpu 1
>>>>> [    0.002347] smp: failed starting cpu 1 (rc -2)
>>>>> [    0.002401] smp: Brought up 1 node, 1 CPU
>>>>>
>>>>> Virtual e5500 quad core QEMU machine:
>>>>>
>>>>> [    0.026394] smp: Bringing up secondary CPUs ...
>>>>> [    0.027831] No cpu-release-addr for cpu 1
>>>>> [    0.027989] smp: failed starting cpu 1 (rc -2)
>>>>> [    0.030143] No cpu-release-addr for cpu 2
>>>>> [    0.030304] smp: failed starting cpu 2 (rc -2)
>>>>> [    0.032400] No cpu-release-addr for cpu 3
>>>>> [    0.032533] smp: failed starting cpu 3 (rc -2)
>>>>> [    0.033117] smp: Brought up 1 node, 1 CPU
>>>>>
>>>>> QEMU command: ./qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048
>>>>> -kernel
>>>>> /home/christian/Downloads/vmlinux-4.20-alpha4-AmigaOne_X1000_X5000/X5000_and_QEMU_e5500/uImage-4.20
>>>>> -drive
>>>>> format=raw,file=/home/christian/Downloads/MATE_PowerPC_Remix_2017_0.9.img,index=0,if=virtio
>>>>> -nic user,model=e1000 -append "rw root=/dev/vda" -device virtio-vga
>>>>> -device virtio-mouse-pci -device virtio-keyboard-pci -usb -soundhw
>>>>> es1370 -smp 4
>>>>>
>>>>> .config:
>>>>>
>>>>> ...
>>>>> CONFIG_SMP=y
>>>>> CONFIG_NR_CPUS=4
>>>>> ...
>>>>>
>>>>> Please test the latest Git kernel on your NXP P50XX boards.
>>>>>
>>>>> Thanks,
>>>>> Christian
>>>>>
>>>>
>>>

