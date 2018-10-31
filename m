Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1761C0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 13:27:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B6B12054F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 13:27:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6B12054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42lTfX5s7TzF310
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 00:27:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lTVh5vL1zDrRP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 00:21:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42lTVh2TM0z9s3T;
 Thu,  1 Nov 2018 00:20:59 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christian Zigotzky <chzigotzky@xenosoft.de>, linuxppc-dev@lists.ozlabs.org
Subject: Re: NXP P50XX/e5500: SMP doesn't work anymore with the latest Git
 kernel
In-Reply-To: <ac15715d-5335-da80-6d1c-1d558fb3cebd@xenosoft.de>
References: <6bcb4b23-bb78-d1a5-7fd0-5f892115d302@xenosoft.de>
 <99266ac6-640c-b2a9-eef3-4e89ee1e0ad5@xenosoft.de>
 <f6ca1728-d312-1267-d9d7-18d2369f1bf7@xenosoft.de>
 <ac15715d-5335-da80-6d1c-1d558fb3cebd@xenosoft.de>
Date: Thu, 01 Nov 2018 00:20:57 +1100
Message-ID: <87o9bafe12.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Christian Zigotzky <chzigotzky@xenosoft.de> writes:

> Little progress ...
>
> I reverted the following two OF files of the commit 'Merge tag=20
> devicetree-for-4.20' and SMP works! The problematic code is somewhere in=
=20
> these two files.
>
> a/include/linux/of.h
> a/drivers/of/base.c

Hi Christian,

Trying to debug things by reverting like this can work, but it's quite
error prone and is usually only used *after* a bisect has identified the
suspect code, or if a bisect can't work for some reason.

I know you said you'd had trouble bisecting in the past, but this one
should be a good one to practice on.

You already identified that the merge of the devicetree changes was the
problem, ie.=20

  b27186abb37b Merge tag 'devicetree-for-4.20' of git://git.kernel.org/pub/=
scm/linux/kernel/git/robh/linux


So you do:
  $ git show b27186abb37b=20
  commit b27186abb37b7bd19e0ca434f4f425c807dbd708
  Merge: 0ef7791e2bfb d061864b89c3
  Author: Linus Torvalds <torvalds@linux-foundation.org>
  Date:   Fri Oct 26 12:09:58 2018 -0700
=20=20
      Merge tag 'devicetree-for-4.20' of git://git.kernel.org/pub/scm/linux=
/kernel/git/robh/linux


And that shows you the two commits that were merged 0ef7791e2bfb and
d061864b89c3. If you look at them you see:

  $ git log -1 --oneline 0ef7791e2bfb
  0ef7791e2bfb Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/evalenti/linux-soc-thermal
=20=20=20
  $ git log -1 --oneline d061864b89c3
  d061864b89c3 ARM: dt: relicense two DT binding IRQ headers

You can see that the first one is the previous commit on Linus' branch,
ie. an unrelated merge. The 2nd commit is the commit that was on top of
robh's tree, ie. that's the start of the interesting commits for us.

You can also get to that 2nd commit using b27186abb37b^2.

If you look at what came in via Rob's branch with:

  $ git log --oneline d061864b89c3
  or
  $ git log --oneline b27186abb37b^2

You see there's quite a few commits, and in particular there's another
merge:

  389d0a8a7af8 Merge branch 'dt/cpu-type-rework' into dt/next

If we log the 2nd parent of that, we see:

 $ git log --oneline 389d0a8a7af8^2
 4c29e5934f6c microblaze: get cpu node with of_get_cpu_node
 a691240e36e3 fbdev: fsl-diu: get cpu node with of_get_cpu_node
 651d44f9679c of: use for_each_of_cpu_node iterator
 a9a455e854cd iommu: fsl_pamu: use for_each_of_cpu_node iterator
 37dc218bed44 edac: cpc925: use for_each_of_cpu_node iterator
 76ec23b127cd clk: mvebu: use for_each_of_cpu_node iterator
 7de8f4aa2f35 x86: DT: use for_each_of_cpu_node iterator
 8cabf5bc1049 SH: use for_each_of_cpu_node iterator
 38959a091e4a powerpc: 8xx: get cpu node with of_get_cpu_node
 84dbc69a2ff3 powerpc: 4xx: get cpu node with of_get_cpu_node
 a94fe366340a powerpc: use for_each_of_cpu_node iterator
 5e5abae858b5 openrisc: use for_each_of_cpu_node iterator
 1f0fe1f67cef nios2: get cpu node with of_get_cpu_node
 5a931a3c80b5 c6x: use for_each_of_cpu_node iterator
 de76e70a8d4e arm64: use for_each_of_cpu_node iterator
 5af5d40c4015 ARM: shmobile: use for_each_of_cpu_node iterator
 07d44f1f82b7 ARM: topology: remove unneeded check for /cpus node
 d4866f751edf ARM: use for_each_of_cpu_node iterator
 6487c15f1cc9 of: Support matching cpu nodes with no 'reg' property
 f1f207e43b8a of: Add cpu node iterator for_each_of_cpu_node()
 f6707fd6241e of: make PowerMac cache node search conditional on CONFIG_PPC=
_PMAC
 6d0a70a284be vsprintf: print OF node name using full_name
 a613b26a5013 of: Convert to using %pOFn instead of device_node.name
 6901378c799d of/unittest: add printf tests for node name
 b610e2ff4622 of/unittest: remove use of node name pointer in overlay high =
level test
 57361846b52b (tag: v4.19-rc2) Linux 4.19-rc2


So if we think the suspect commit is in there, we would confirm that by
checking out v4.19-rc2 and testing it works. And then checkout out
4c29e5934f6c and testing that it's broken.

Assuming the former worked and the latter was broken, we do:

 $ git bisect good v4.19-rc2
 $ git bisect bad 4c29e5934f6c=20

And then just follow the prompts.

One thing to watch out for is hitting an unrelated bug, that can
sometimes derail your bisection.

In this case the bug we're looking for is that CPU 1 isn't onlined
properly. But if the system doesn't boot entirely for example then you
shouldn't mark the commit as bad, instead it's better to skip it. Then
git will choose a different commit for you to test.

Anyway hope that helps.

cheers

> On 29 October 2018 at 6:00PM, Christian Zigotzky wrote:
>> Hello,
>>
>> I figured out that the problem is in the OF source code of the commit:=20
>> Merge tag devicetree-for-4.20. [1]
>>
>> I reverted the following OF files and SMP works!
>>
>> drivers/of/base.c
>> drivers/of/device.c
>> drivers/of/of_mdio.c
>> drivers/of/of_numa.c
>> drivers/of/of_private.h
>> drivers/of/overlay.c
>> drivers/of/platform.c
>> drivers/of/unittest-data/overlay_15.dts
>> drivers/of/unittest-data/tests-overlay.dtsi
>> drivers/of/unittest.c
>> include/linux/of.h
>>
>> Cheers,
>> Christian
>>
>> [1]=20
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3Db27186abb37b7bd19e0ca434f4f425c807dbd708
>>
>>
>> On 29 October 2018 at 10:56AM, Christian Zigotzky wrote:
>>> Hello,
>>>
>>> I have figured out that the commit 'devicetree-for-4.20' [1] is=20
>>> responsible for the SMP problem. I was able to revert this commit=20
>>> with 'git revert b27186abb37b7bd19e0ca434f4f425c807dbd708 -m 1' today.
>>>
>>> [master ec81438] Revert "Merge tag 'devicetree-for-4.20' of=20
>>> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux"
>>> 138 files changed, 931 insertions(+), 1538 deletions(-)
>>> rename Documentation/devicetree/bindings/arm/{atmel-sysregs.txt =3D>=20
>>> atmel-at91.txt} (67%)
>>> delete mode 100644=20
>>> Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.txt
>>> delete mode 100644=20
>>> Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-scfg.txt
>>> rename Documentation/devicetree/bindings/arm/{zte,sysctrl.txt =3D>=20
>>> zte.txt} (62%)
>>> delete mode 100644 Documentation/devicetree/bindings/misc/lwn-bk4.txt
>>> create mode 100644 arch/c6x/boot/dts/linked_dtb.S
>>> delete mode 100644 arch/nios2/boot/dts/Makefile
>>> create mode 100644 arch/nios2/boot/linked_dtb.S
>>> delete mode 100644 arch/powerpc/boot/dts/Makefile
>>> delete mode 100644 arch/powerpc/boot/dts/fsl/Makefile
>>> delete mode 100644 scripts/dtc/yamltree.c
>>>
>>> It solves the SMP problem! SMP works again on my P5020 board and on=20
>>> virtual e5500 QEMU machines.
>>>
>>> QEMU command: ./qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048=20
>>> -kernel /home/christian/Downloads/uImage-4.20-alpha5 -drive=20
>>> format=3Draw,file=3D/home/christian/Dokumente/ubuntu_MATE_16.04.3_LTS_P=
owerPC_QEMU/ubuntu_MATE_16.04_PowerPC.img,index=3D0,if=3Dvirtio=20
>>> -nic user,model=3De1000 -append "rw root=3D/dev/vda3" -device virtio-vg=
a=20
>>> -device virtio-mouse-pci -device virtio-keyboard-pci -soundhw es1370=20
>>> -smp 4
>>>
>>> Screenshot:=20
>>> https://plus.google.com/u/0/photos/photo/115515624056477014971/66177057=
76207990082
>>>
>>> Do we need a new dtb file or is it a bug?
>>>
>>> Thanks,
>>> Christian
>>>
>>> [1]=20
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Db27186abb37b7bd19e0ca434f4f425c807dbd708
>>>
>>>
>>> On 28 October 2018 at 5:35PM, Christian Zigotzky wrote:
>>>> Hello,
>>>>
>>>> SMP doesn't work anymore with the latest Git kernel (28/10/18=20
>>>> 11:12AM GMT) on my P5020 board and on virtual e5500 QEMU machines.
>>>>
>>>> Board with P5020 dual core CPU:
>>>>
>>>> [=C2=A0=C2=A0=C2=A0 0.000000] ----------------------------------------=
-------------
>>>> [=C2=A0=C2=A0=C2=A0 0.000000] phys_mem_size=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D 0x200000000
>>>> [=C2=A0=C2=A0=C2=A0 0.000000] dcache_bsize=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D 0x40
>>>> [=C2=A0=C2=A0=C2=A0 0.000000] icache_bsize=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D 0x40
>>>> [=C2=A0=C2=A0=C2=A0 0.000000] cpu_features=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D 0x00000003008003b4
>>>> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 possible=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0x00000003009003b4
>>>> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 always=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0x00000003008003b4
>>>> [=C2=A0=C2=A0=C2=A0 0.000000] cpu_user_features =3D 0xcc008000 0x08000=
000
>>>> [=C2=A0=C2=A0=C2=A0 0.000000] mmu_features=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D 0x000a0010
>>>> [=C2=A0=C2=A0=C2=A0 0.000000] firmware_features =3D 0x0000000000000000
>>>> [=C2=A0=C2=A0=C2=A0 0.000000] ----------------------------------------=
-------------
>>>> [=C2=A0=C2=A0=C2=A0 0.000000] CoreNet Generic board
>>>>
>>>> =C2=A0=C2=A0=C2=A0 ...
>>>>
>>>> [=C2=A0=C2=A0=C2=A0 0.002161] smp: Bringing up secondary CPUs ...
>>>> [=C2=A0=C2=A0=C2=A0 0.002339] No cpu-release-addr for cpu 1
>>>> [=C2=A0=C2=A0=C2=A0 0.002347] smp: failed starting cpu 1 (rc -2)
>>>> [=C2=A0=C2=A0=C2=A0 0.002401] smp: Brought up 1 node, 1 CPU
>>>>
>>>> Virtual e5500 quad core QEMU machine:
>>>>
>>>> [=C2=A0=C2=A0=C2=A0 0.026394] smp: Bringing up secondary CPUs ...
>>>> [=C2=A0=C2=A0=C2=A0 0.027831] No cpu-release-addr for cpu 1
>>>> [=C2=A0=C2=A0=C2=A0 0.027989] smp: failed starting cpu 1 (rc -2)
>>>> [=C2=A0=C2=A0=C2=A0 0.030143] No cpu-release-addr for cpu 2
>>>> [=C2=A0=C2=A0=C2=A0 0.030304] smp: failed starting cpu 2 (rc -2)
>>>> [=C2=A0=C2=A0=C2=A0 0.032400] No cpu-release-addr for cpu 3
>>>> [=C2=A0=C2=A0=C2=A0 0.032533] smp: failed starting cpu 3 (rc -2)
>>>> [=C2=A0=C2=A0=C2=A0 0.033117] smp: Brought up 1 node, 1 CPU
>>>>
>>>> QEMU command: ./qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048=20
>>>> -kernel=20
>>>> /home/christian/Downloads/vmlinux-4.20-alpha4-AmigaOne_X1000_X5000/X50=
00_and_QEMU_e5500/uImage-4.20=20
>>>> -drive=20
>>>> format=3Draw,file=3D/home/christian/Downloads/MATE_PowerPC_Remix_2017_=
0.9.img,index=3D0,if=3Dvirtio=20
>>>> -nic user,model=3De1000 -append "rw root=3D/dev/vda" -device virtio-vg=
a=20
>>>> -device virtio-mouse-pci -device virtio-keyboard-pci -usb -soundhw=20
>>>> es1370 -smp 4
>>>>
>>>> .config:
>>>>
>>>> ...
>>>> CONFIG_SMP=3Dy
>>>> CONFIG_NR_CPUS=3D4
>>>> ...
>>>>
>>>> Please test the latest Git kernel on your NXP P50XX boards.
>>>>
>>>> Thanks,
>>>> Christian
>>>>
>>>
>>>
>>
>>
