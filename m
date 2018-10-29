Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0659C0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 20:15:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81C9320824
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 20:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="fuz71amn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C9320824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kQnL0S7wzF0Vv
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 07:15:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="fuz71amn";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p00-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5300::8; helo=mo6-p00-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="fuz71amn"; 
 dkim-atps=neutral
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42kQkd5lVnzDqYd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 07:12:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1540843955;
 s=strato-dkim-0002; d=xenosoft.de;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=8/Uuj4xxD++KlX7WuVJKZQoLW0nuVYEro1CZgKpjvMs=;
 b=fuz71amnLkfTggPq/AS/vwzPGFBbShGBpSOFMcm5TgrvAccueBtxbiGHcQAtuCxrJr
 ISRVwJ2NRHZfdG38t9ygpn97wYJRpKkWsTVAVPixk4m8TKghhldHuJ4NUEYNTXoHC2MQ
 8r8V+1saXnkZT11obegCcW421zBpEGPkJK1YUH5pgbcHQ4P//P6jG2QsMWNrzFrwH1rC
 y76NITn9ZxEY5KMJ4xIc87a9bzItAZWgvkA2UO53LD0HthWrPyb36U4wv8SG7E6iTpgK
 E0zWJpY3UL9azhQFaM1AOSuJIE5QgTk0q+fx1Y6ga9bCDBE/BEsGxt/qz+cLbahhWdy3
 1osg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6Kxrf+5Dj7x4Ql+BpvNtdS8exnpilKtYAeuiUTgS/puSSfJ71GJcSA=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:b1c3:9b3e:b4dc:b0df]
 by smtp.strato.de (RZmta 44.3 AUTH) with ESMTPSA id Z0624cu9TKCY9Am
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Mon, 29 Oct 2018 21:12:34 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: NXP P50XX/e5500: SMP doesn't work anymore with the latest Git
 kernel
From: Christian Zigotzky <chzigotzky@xenosoft.de>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <20181029191321.Horde.fxo4MJUhTstCq8zaw1lK7Q3@messagerie.si.c-s.fr>
Date: Mon, 29 Oct 2018 21:12:33 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <77061E9A-AFC9-437A-AB42-F47266FD9721@xenosoft.de>
References: <6bcb4b23-bb78-d1a5-7fd0-5f892115d302@xenosoft.de>
 <99266ac6-640c-b2a9-eef3-4e89ee1e0ad5@xenosoft.de>
 <f6ca1728-d312-1267-d9d7-18d2369f1bf7@xenosoft.de>
 <20181029191321.Horde.fxo4MJUhTstCq8zaw1lK7Q3@messagerie.si.c-s.fr>
To: LEROY Christophe <christophe.leroy@c-s.fr>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello Christophe,

Bisecting isn=E2=80=99t necessary because the problem is in the following fi=
les.

drivers/of/base.c
drivers/of/device.c
drivers/of/of_mdio.c
drivers/of/of_numa.c
drivers/of/of_private.h
drivers/of/overlay.c
drivers/of/platform.c
drivers/of/unittest-data/overlay_15.dts
drivers/of/unittest-data/tests-overlay.dtsi
drivers/of/unittest.c
include/linux/of.h

I removed the OF modifications from the merge commit 'devicetree-for-4.20' a=
nd SMP works again.

Cheers,
Christian

Sent from my iPhone

> On 29. Oct 2018, at 19:13, LEROY Christophe <christophe.leroy@c-s.fr> wrot=
e:
>=20
> Christian Zigotzky <chzigotzky@xenosoft.de> a =C3=A9crit :
>=20
>> Hello,
>>=20
>> I figured out that the problem is in the OF source code of the commit: Me=
rge tag devicetree-for-4.20. [1]
>=20
> That's a merge commit. Can you bisect the branch and identify the faulting=
 commit ?
>=20
> Christophe
>=20
>>=20
>> I reverted the following OF files and SMP works!
>>=20
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
>>=20
>> Cheers,
>> Christian
>>=20
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Db27186abb37b7bd19e0ca434f4f425c807dbd708
>>=20
>>=20
>>> On 29 October 2018 at 10:56AM, Christian Zigotzky wrote:
>>> Hello,
>>>=20
>>> I have figured out that the commit 'devicetree-for-4.20' [1] is responsi=
ble for the SMP problem. I was able to revert this commit with 'git revert b=
27186abb37b7bd19e0ca434f4f425c807dbd708 -m 1' today.
>>>=20
>>> [master ec81438] Revert "Merge tag 'devicetree-for-4.20' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/robh/linux"
>>> 138 files changed, 931 insertions(+), 1538 deletions(-)
>>> rename Documentation/devicetree/bindings/arm/{atmel-sysregs.txt =3D> atm=
el-at91.txt} (67%)
>>> delete mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,l=
ayerscape-dcfg.txt
>>> delete mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,l=
ayerscape-scfg.txt
>>> rename Documentation/devicetree/bindings/arm/{zte,sysctrl.txt =3D> zte.t=
xt} (62%)
>>> delete mode 100644 Documentation/devicetree/bindings/misc/lwn-bk4.txt
>>> create mode 100644 arch/c6x/boot/dts/linked_dtb.S
>>> delete mode 100644 arch/nios2/boot/dts/Makefile
>>> create mode 100644 arch/nios2/boot/linked_dtb.S
>>> delete mode 100644 arch/powerpc/boot/dts/Makefile
>>> delete mode 100644 arch/powerpc/boot/dts/fsl/Makefile
>>> delete mode 100644 scripts/dtc/yamltree.c
>>>=20
>>> It solves the SMP problem! SMP works again on my P5020 board and on virt=
ual e5500 QEMU machines.
>>>=20
>>> QEMU command: ./qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048 -kernel /=
home/christian/Downloads/uImage-4.20-alpha5 -drive format=3Draw,file=3D/home=
/christian/Dokumente/ubuntu_MATE_16.04.3_LTS_PowerPC_QEMU/ubuntu_MATE_16.04_=
PowerPC.img,index=3D0,if=3Dvirtio -nic user,model=3De1000 -append "rw root=3D=
/dev/vda3" -device virtio-vga -device virtio-mouse-pci -device virtio-keyboa=
rd-pci -soundhw es1370 -smp 4
>>>=20
>>> Screenshot: https://plus.google.com/u/0/photos/photo/1155156240564770149=
71/6617705776207990082
>>>=20
>>> Do we need a new dtb file or is it a bug?
>>>=20
>>> Thanks,
>>> Christian
>>>=20
>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c=
ommit/?id=3Db27186abb37b7bd19e0ca434f4f425c807dbd708
>>>=20
>>>=20
>>>> On 28 October 2018 at 5:35PM, Christian Zigotzky wrote:
>>>> Hello,
>>>>=20
>>>> SMP doesn't work anymore with the latest Git kernel (28/10/18 11:12AM G=
MT) on my P5020 board and on virtual e5500 QEMU machines.
>>>>=20
>>>> Board with P5020 dual core CPU:
>>>>=20
>>>> [    0.000000] -----------------------------------------------------
>>>> [    0.000000] phys_mem_size     =3D 0x200000000
>>>> [    0.000000] dcache_bsize      =3D 0x40
>>>> [    0.000000] icache_bsize      =3D 0x40
>>>> [    0.000000] cpu_features      =3D 0x00000003008003b4
>>>> [    0.000000]   possible        =3D 0x00000003009003b4
>>>> [    0.000000]   always          =3D 0x00000003008003b4
>>>> [    0.000000] cpu_user_features =3D 0xcc008000 0x08000000
>>>> [    0.000000] mmu_features      =3D 0x000a0010
>>>> [    0.000000] firmware_features =3D 0x0000000000000000
>>>> [    0.000000] -----------------------------------------------------
>>>> [    0.000000] CoreNet Generic board
>>>>=20
>>>>     ...
>>>>=20
>>>> [    0.002161] smp: Bringing up secondary CPUs ...
>>>> [    0.002339] No cpu-release-addr for cpu 1
>>>> [    0.002347] smp: failed starting cpu 1 (rc -2)
>>>> [    0.002401] smp: Brought up 1 node, 1 CPU
>>>>=20
>>>> Virtual e5500 quad core QEMU machine:
>>>>=20
>>>> [    0.026394] smp: Bringing up secondary CPUs ...
>>>> [    0.027831] No cpu-release-addr for cpu 1
>>>> [    0.027989] smp: failed starting cpu 1 (rc -2)
>>>> [    0.030143] No cpu-release-addr for cpu 2
>>>> [    0.030304] smp: failed starting cpu 2 (rc -2)
>>>> [    0.032400] No cpu-release-addr for cpu 3
>>>> [    0.032533] smp: failed starting cpu 3 (rc -2)
>>>> [    0.033117] smp: Brought up 1 node, 1 CPU
>>>>=20
>>>> QEMU command: ./qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048 -kernel=
 /home/christian/Downloads/vmlinux-4.20-alpha4-AmigaOne_X1000_X5000/X5000_an=
d_QEMU_e5500/uImage-4.20 -drive format=3Draw,file=3D/home/christian/Download=
s/MATE_PowerPC_Remix_2017_0.9.img,index=3D0,if=3Dvirtio -nic user,model=3De1=
000 -append "rw root=3D/dev/vda" -device virtio-vga -device virtio-mouse-pci=
 -device virtio-keyboard-pci -usb -soundhw es1370 -smp 4
>>>>=20
>>>> .config:
>>>>=20
>>>> ...
>>>> CONFIG_SMP=3Dy
>>>> CONFIG_NR_CPUS=3D4
>>>> ...
>>>>=20
>>>> Please test the latest Git kernel on your NXP P50XX boards.
>>>>=20
>>>> Thanks,
>>>> Christian
>>>>=20
>>>=20
>>>=20
>=20
>=20
