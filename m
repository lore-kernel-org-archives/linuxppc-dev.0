Return-Path: <linuxppc-dev+bounces-26086-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1BBC61DBD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Aug 2026 07:18:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVGG85jGdz2y32;
	Wed, 26 Aug 2026 17:18:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=81.169.146.220 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787728704;
	cv=pass; b=Mk65bAfrVgMxiiuM9OFk3/JiGRpQlppnr9q0x7BBfskv+JGqUuAx6B+aCW3/fZOYF0Iiv4spR27MEVtWJcyQq+2H7Lv6UeHwPwKiz5nLO4MWUiVQqnwgBzlEQJJuRcbYVL1DeDvJ+qmoBA4umoBgqQmOXZgCt2vxA/eDnYmY54xzDcZVQhHS3+Uum+W+mPy3huvQI4zuw+wQtZMdbRr/9qThHpRmaheuUaJXyLjbj9waYhlGqYLguOZkPAXlErlTUfigWa6+yI7jyiNM0Fx5Vvv4aW1SluATCohNEYyLwhjD1RjNsLekV+MtGJ0llTiHJ5FfdkLAwLpRuvFj5ilskQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787728704; c=relaxed/relaxed;
	bh=+Kq2RsohRbnLlL1fIC+hGIycAbUIkalQ+/Z78X5c0ew=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=gc1UdI62hWFvDL6YcFH+4RBthFiHUlaCGZbZKaDBN/jEM5iz68hKjcQH6n9s6/++mdqgPqMJm9AjDJuGAWxk+e4hgaIXLMUnCoHnbJTz3Zk8/p4DFt5cixduL2+Kx+3XfxMRGVLFnKfp/DC0lO1qKBmq5Wza/Rcf9zKmJz0YZBTa3DXt0yb3nphF1OZtHcdpvmw+d8JebT+RUqjqIKt0V+8ju2pEBftV79jISNiQnp0SWOsN47l22KM162L7n1IKDT0UPiPldDxOYYeeK9y6DYkT5WjTax2D5kAGy7Y4PEFM0J+kVN6w6HlNMZgfjXGYY0PH3QdJwF8SLgyj093+wg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=BhMpx/KI; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=qjid3Wyy; dkim-atps=neutral; spf=pass (client-ip=81.169.146.220; helo=mo4-p00-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p00-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=BhMpx/KI;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=qjid3Wyy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p00-ob.smtp.rzone.de (client-ip=81.169.146.220; helo=mo4-p00-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVGG12p6Nz2xGw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2026 17:18:13 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1787728672; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=PjEtvZ+WGgW7qU+JqGwK6cTzjfiPA0fXaKHjIwnVNtH+3IGvQj5c0UVRE+7P1FrAs9
    jD1zopqIAZssAWwWYzdT6RK9gAyBlWrHlEhdkcBrD1g28Aow+gpWRLMGn0ugZTnjziHy
    AHb7rg4X21UXml2Z4RGBrxPs9zBYVEv79dUKc2Mce3Q5kjdLE49bplzeAjhEa7DAbeRO
    h6yQlpblZAIHItmQ/opYKDYuChkwYrUpEZEbGqgBjYzH0/fHa4tnOBL7jh2d7ZSdkh5l
    hNz5TrVVOtl9gfcIdlBiisQ604MTTREauN3ADLtkTGeju6LTKC+yVJ97gU7fXA6siqxD
    pDvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1787728672;
    s=strato-dkim-0002; d=strato.com;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=+Kq2RsohRbnLlL1fIC+hGIycAbUIkalQ+/Z78X5c0ew=;
    b=E3DsjgBn5JaawB/W+QP4uDEVFRK9E55hKexx6EYDjMz31HJa1jGdcoCrjoxQ+uptmq
    qNnSSUSp6ccYWsFZ9vPWxVQCc+JuJH6ezCQkQF/aaVf45k1Fyh1T8AKXkyPqcEk7v/32
    vueqTJ9Z66nw9grf2HHh3NP+S6ojfnJRd79+KFINjpW+eK5kGvid9QP3QhH/mx75gHA3
    TWllodV/SYiquksMucW+GrwUdMOtsRUbStlYFEXW33vEmTK/PQ3a+dBaZVuzJSIZ6RAX
    m5rFbHMxPBisuPgnb1zqJIGJH8U2wdGRPq5aIzdzWPm/2o0XeV3ox5FU/ApX2sd3E9xX
    +i9w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787728672;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=+Kq2RsohRbnLlL1fIC+hGIycAbUIkalQ+/Z78X5c0ew=;
    b=BhMpx/KIgx8CiMJqy4fmDmtaIKY42vdlkmV/VgqFkdlma2XI7n0AYMTT6fzhCsoQSi
    HqZuK2wNwxT6OO1TuvCBfh+zihUHirpvWaCwgF6keNkWRtBgWB8bGnEPyX5/+KGTsl6G
    zxPxdO/flkVExgiITHO/HPzeUeWYAtmXAEwPSGhNvIwoWDWx6PM7Cxr0pl6OheXxNhbC
    14awMmTK8yra8HmhGTiaSr4sdFrduaKWHZ1gEha69vwFjmpbFRj+wFZ09VGhdjYj6u3I
    K9BfB3cLK/cfrwJDNOLwAD4JveumpVfR5t4xxYzsIl9+UuxYH/tkY4F5kPDRRoclsGCe
    v1dA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787728672;
    s=strato-dkim-0003; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=+Kq2RsohRbnLlL1fIC+hGIycAbUIkalQ+/Z78X5c0ew=;
    b=qjid3WyygEdaNwHSGuFp9D9mPe4FTeINW75SYZKcD1N/n41pnQSkKKvdP+IrkCcOw0
    YC6R26uAA+hiXQ4JfRAA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5jhs3mQAn9OTkNOrN3EgwCWK5/AC49UK5N/"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id ee2bee27Q7HpPtq
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 26 Aug 2026 09:17:51 +0200 (CEST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Christian Zigotzky <chzigotzky@xenosoft.de>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: drm/mgag200: Fix big-endian support
Date: Wed, 26 Aug 2026 09:17:40 +0200
Message-Id: <22C49569-6B51-4FEC-B689-ACD28A41D1DA@xenosoft.de>
References: <4ACA9FCA-683C-44D0-B31F-CE70C40070BB@xenosoft.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Trevor Dickinson <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
 mad skateman <madskateman@gmail.com>,
 Christian Zigotzky <info@xenosoft.de>
In-Reply-To: <4ACA9FCA-683C-44D0-B31F-CE70C40070BB@xenosoft.de>
To: rene@exactco.de, Thomas Zimmermann <tzimmermann@suse.de>
X-Mailer: iPhone Mail (23G83)

Hi All,

Any hints because of this issue?

Further information: https://forum.hyperion-entertainment.com/viewtopic.php?=
t=3D5201

Thanks,
Christian


On 02 August 2026 at 08:07 pm, Christian Zigotzky <chzigotzky@xenosoft.de> w=
rote:

=EF=BB=BFHello Ren=C3=A9,

Many thanks for your patch. [1]

I have bought the PCI graphics card Matrox G200 G2+/QUADP-PL/7 32MB with 4x D=
VI. It is an AGP card connected via PCI.

We use the new DRM driver MGAG200 since the kernel 7.2.0-rc4 and the old DRM=
 legacy driver for Matrox g200/g400 graphics cards since the stable long-ter=
m kernel 5.10.260.

I tested it with the RC5 of kernel 7.2 in my PowerPC machine (e5500) today. U=
nfortunately, the DRM driver mgag200 can't read the PCI ROM. Maybe only an x=
86 ROM?

xrandr detects the ports but reports that they are not connected, even thoug=
h the cables are plugged in.

I also tested it with the stable long-term kernel 5.10.261 with the old lega=
cy DRM drivers for Matrox graphics cards.
I installed the Xorg MGA server xf86-video-mga-2.0.0_3 for the old legacy DR=
M driver but unfortunately I get only a black screen.

Is it possible to use this card with PPC Linux?

More information:

lspci -vvv

0001:05:00.0 VGA compatible controller: Matrox Electronics Systems Ltd. MGA G=
200 AGP (rev 03) (prog-if 00 [VGA controller])
   Subsystem: Matrox Electronics Systems Ltd. G200 Multi-Monitor
   Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing- SERR- FastB2B- DisINTx-
   Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-
   Latency: 128 (4000ns min, 8000ns max), Cache Line Size: 32 bytes
   Interrupt: pin A routed to IRQ 18
   Region 0: Memory at c20000000 (32-bit, prefetchable) [size=3D16M]
   Region 1: Memory at c21000000 (32-bit, non-prefetchable) [size=3D16K]
   Region 2: Memory at c21800000 (32-bit, non-prefetchable) [size=3D8M]
   Expansion ROM at c21010000 [disabled] [size=3D64K]
   Capabilities: [dc] Power Management version 1
       Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
       Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
   Capabilities: [f0] AGP version 1.0
       Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64- HTrans- 6=
4bit- FW- AGP3- Rate=3Dx1,x2
       Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit- FW- Rate=3D=
<none>
   Kernel driver in use: mgag200

0001:05:04.0 Display controller: Matrox Electronics Systems Ltd. MGA G200 AG=
P (rev 03)
   Subsystem: Matrox Electronics Systems Ltd. G200 Multi-Monitor
   Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing- SERR- FastB2B- DisINTx-
   Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-
   Latency: 128 (4000ns min, 8000ns max), Cache Line Size: 32 bytes
   Interrupt: pin A routed to IRQ 18
   Region 0: Memory at c22000000 (32-bit, prefetchable) [size=3D16M]
   Region 1: Memory at c23000000 (32-bit, non-prefetchable) [size=3D16K]
   Region 2: Memory at c23800000 (32-bit, non-prefetchable) [size=3D8M]
   Expansion ROM at c21020000 [disabled] [size=3D64K]
   Capabilities: [dc] Power Management version 1
       Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
       Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
   Capabilities: [f0] AGP version 1.0
       Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64- HTrans- 6=
4bit- FW- AGP3- Rate=3Dx1,x2
       Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit- FW- Rate=3D=
<none>
   Kernel driver in use: mgag200

0001:05:08.0 Display controller: Matrox Electronics Systems Ltd. MGA G200 AG=
P (rev 03)
   Subsystem: Matrox Electronics Systems Ltd. G200 Multi-Monitor
   Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing- SERR- FastB2B- DisINTx-
   Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-
   Latency: 128 (4000ns min, 8000ns max), Cache Line Size: 32 bytes
   Interrupt: pin A routed to IRQ 18
   Region 0: Memory at c24000000 (32-bit, prefetchable) [size=3D16M]
   Region 1: Memory at c25000000 (32-bit, non-prefetchable) [size=3D16K]
   Region 2: Memory at c25800000 (32-bit, non-prefetchable) [size=3D8M]
   Expansion ROM at c21030000 [disabled] [size=3D64K]
   Capabilities: [dc] Power Management version 1
       Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
       Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
   Capabilities: [f0] AGP version 1.0
       Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64- HTrans- 6=
4bit- FW- AGP3- Rate=3Dx1,x2
       Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit- FW- Rate=3D=
<none>
   Kernel driver in use: mgag200

0001:05:0c.0 Display controller: Matrox Electronics Systems Ltd. MGA G200 AG=
P (rev 03)
   Subsystem: Matrox Electronics Systems Ltd. G200 Multi-Monitor
   Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing- SERR- FastB2B- DisINTx-
   Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-
   Latency: 128 (4000ns min, 8000ns max), Cache Line Size: 32 bytes
   Interrupt: pin A routed to IRQ 18
   Region 0: Memory at c26000000 (32-bit, prefetchable) [size=3D16M]
   Region 1: Memory at c27000000 (32-bit, non-prefetchable) [size=3D16K]
   Region 2: Memory at c27800000 (32-bit, non-prefetchable) [size=3D8M]
   Expansion ROM at c21040000 [disabled] [size=3D64K]
   Capabilities: [dc] Power Management version 1
       Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
       Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
   Capabilities: [f0] AGP version 1.0
       Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64- HTrans- 6=
4bit- FW- AGP3- Rate=3Dx1,x2
       Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit- FW- Rate=3D=
<none>
   Kernel driver in use: mgag200


dmesg | grep -i mga

[    2.302206] [drm] Initialized mgag200 1.0.0 for 0001:05:00.0 on minor 1
[    2.303761] mgag200 0001:05:00.0: [drm] Cannot find any crtc or sizes
[    2.304697] mgag200 0001:05:04.0: Invalid PCI ROM header signature: expec=
ting 0xaa55, got 0xffff
[    2.305792] [drm] Initialized mgag200 1.0.0 for 0001:05:04.0 on minor 2
[    2.308281] mgag200 0001:05:04.0: [drm] Cannot find any crtc or sizes
[    2.308802] mgag200 0001:05:08.0: Invalid PCI ROM header signature: expec=
ting 0xaa55, got 0xffff
[    2.309319] [drm] Initialized mgag200 1.0.0 for 0001:05:08.0 on minor 3
[    2.309785] mgag200 0001:05:00.0: [drm] Cannot find any crtc or sizes
[    2.310900] mgag200 0001:05:08.0: [drm] Cannot find any crtc or sizes
[    2.311895] mgag200 0001:05:0c.0: Invalid PCI ROM header signature: expec=
ting 0xaa55, got 0xffff
[    2.312633] [drm] Initialized mgag200 1.0.0 for 0001:05:0c.0 on minor 4
[    2.312844] mgag200 0001:05:04.0: [drm] Cannot find any crtc or sizes
[    2.315512] mgag200 0001:05:0c.0: [drm] Cannot find any crtc or sizes
[    2.317178] mgag200 0001:05:08.0: [drm] Cannot find any crtc or sizes
[    2.323318] mgag200 0001:05:0c.0: [drm] Cannot find any crtc or sizes

xrandr

=E2=80=A6

VGA-4-4 disconnected (normal left inverted right x axis y axis)
VGA-3-3 disconnected (normal left inverted right x axis y axis)
VGA-2-2 disconnected (normal left inverted right x axis y axis)
VGA-1-1 disconnected (normal left inverted right x axis y axis)

=E2=80=A6

lspci -nnk | grep VGA

0001:05:00.0 VGA compatible controller [0300]: Matrox Electronics Systems Lt=
d. MGA G200 AGP [102b:0521] (rev 03)

Thanks,
Christian

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/drivers/gpu/drm/mgag200/mgag200_mode.c?id=3D6cb31fba137d45e682ce455b8ea364=
f44d5d4f98=


