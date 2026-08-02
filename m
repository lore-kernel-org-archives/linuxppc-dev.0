Return-Path: <linuxppc-dev+bounces-25208-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C31C55162
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Aug 2026 18:06:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hCnnS5y4fz2yhP;
	Mon, 03 Aug 2026 04:06:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=81.169.146.217 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785694012;
	cv=pass; b=T8JugmEF5xEiBzZqy47Gm2cUXMutPFUvifJYjuOIQj1MK2/C0dYTORETxX54ZMZjevyW/dbuaK0ihxQjqID1LPciXPiUVPsUmzqCHaU45t7SGfJvYGNOX50PTWQr9YOeNnH4DJ0aLaN8ltxbGCP4UZHvbJEHesV820sKMYAPL6VjvTCgAQ4sn7x6HYGmakCS7UOWaLYbQVC68JQ5QwcquOy6TvboGXWt647689/T1dfCgQXUW38V3PvsXEBgbae01eez/eXBXtAN8jS2rgzVOIVz/L7f24I8au0U6TvDRlvpxo+L1AbiKWC0IhtzjEdmZR+Y8s4yR1/c8fRDcd7CCQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785694012; c=relaxed/relaxed;
	bh=x6WG5r4BH/0ur53Z7RLHV8SurE73WV0dWZwEQmtc/Oc=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=mnIdNSKY/Fie3vZVzivXff0kItcEZuz5xrG8hIhMOoVcdJ2c1cjsA//7SLfcvaf2HHH+mqaNb4zJmupEhGkGlg1y1mcRbSG1Ys5jkzexk0/fxua20bzR/SdgEnFOYHriT3+YAuEOFcrDJcmrlxOD0ArWl4nI3D8ltHXS19bsE6yOdKX0R7p2nXvcce/ynW6mdXd9bUTN+mi85vExcirGmVAjrmaYK413ur2emETsk0RCDO85Fmjzqb8GmCKtXa2ysw9rgzSPJlZwP9Ut1/G42IdBgH4e/WSKzCwlujf8gCx53v/RO1x5nbpOq39lH82i2f7z8vt7qTdmC4alOi++Iw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=EJfaSKn/; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=/GtBonpj; dkim-atps=neutral; spf=pass (client-ip=81.169.146.217; helo=mo4-p00-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p00-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=EJfaSKn/;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=/GtBonpj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p00-ob.smtp.rzone.de (client-ip=81.169.146.217; helo=mo4-p00-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hCnnL2STkz2ygp
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 04:06:42 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1785693992; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XgGYjvCiz8wkJL4Nq3dho+wb+j+UCpoerw3EHqInjwcyWjanM3s3Rq/oyckvBMSFTP
    mzcM3VXQ1JLmy8E00Il48hYHu3DLyXBj90Q/gxpZjjKmlVgy2AQy2ma/ysaYKWnptIhp
    DcHw23rDyzHHZiUb0M2bDOuMmFdWv8woANSD7FbWQBmK3lrKbkxyv7immqKEOiyrrwla
    GWvXPyqEjJ1enYYy1MGENv1jEHKMJ6XhG7A9isQEVacnyHF+aaZKrHPqLOxudLaNl3+O
    oYaoPJYGY4llsdCxP1/+J6eb9vkTw7gXJRRZF/FFcxsw6cLHMbaJL3i73lXADYlmQEgj
    wBiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1785693992;
    s=strato-dkim-0002; d=strato.com;
    h=To:Cc:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=x6WG5r4BH/0ur53Z7RLHV8SurE73WV0dWZwEQmtc/Oc=;
    b=lNBuo5C1yaN59kP6g/PtGQROtTnOgXcf0DB8LGCoEyAzjGpmDsDko9qwQIkHgaVSST
    1FGoYEyBJ9Yn4+gswEd4fzdgASix73GRjW73m9aKATdeNvio6EOuP5HbjNXM0whErgOP
    nXZpEjB2LjBvzQiVdbFxm8TJYP35ep2mRUSAAaKSO20zaI76oZ7VxwdIapNgW4bGXKzQ
    bnMaSZuHk1QDDu6gHs1dDSKDsps5MKD58o1L6vdwWw6Tugz2mjWLHuMoktWr1lOkHJJt
    hynl4PEfFrs+ErpU15ZWsJ3cTtmyjCPJBPzqWFGe5WaQlo4hpTzE71JdIUJV068i7+VH
    dUvw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1785693992;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:Cc:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=x6WG5r4BH/0ur53Z7RLHV8SurE73WV0dWZwEQmtc/Oc=;
    b=EJfaSKn/FNguc0JgV3qQPClgO3Z/eK0vUf7Pvyt5ssc+tHdUZaecJJQRP5SL3Xu+lY
    nBxZRgcMXEXR8SOCHX67fRDv93KYIemTOMUF/7UxGRB6WpXM6PSsKcYqbJBYDuYbPvMJ
    Rd/HarlnIW4hyB4A9zyOJxj0C/5PhuQrIVAMlRE4X6C6K+i/5D/sLM892Nse7oXNEF3G
    NFurONK4f/du4gnz7A3xpJAYPo8QmfSP9cfl2C+CKia9DeK2LDlsqlGrr8uyIAWhzeem
    CnR0tsiuxaGiSWZT6qLmdzkb2O/pOAwXtOlaNtmRZQrmN2A1L4EHotcnhmB455QCMJiF
    VK4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1785693992;
    s=strato-dkim-0003; d=xenosoft.de;
    h=To:Cc:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=x6WG5r4BH/0ur53Z7RLHV8SurE73WV0dWZwEQmtc/Oc=;
    b=/GtBonpjE5bGt97sIlVH/nvcnOvDvGjFwRWMJTxixBusnvF6tRR437swPxOh0jrLMY
    xixuu3AiKASgGwywBwBg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5ngs37FDC/dXI4qqvqBTuDzQbx64PGDpzLHRQ=="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.5.6 AUTH)
    with ESMTPSA id eed0ee272I6VvL1
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 2 Aug 2026 20:06:31 +0200 (CEST)
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
Date: Sun, 2 Aug 2026 20:06:21 +0200
Subject: drm/mgag200: Fix big-endian support
Message-Id: <4ACA9FCA-683C-44D0-B31F-CE70C40070BB@xenosoft.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Trevor Dickinson <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
 mad skateman <madskateman@gmail.com>,
 Christian Zigotzky <info@xenosoft.de>
To: rene@exactco.de, Thomas Zimmermann <tzimmermann@suse.de>
X-Mailer: iPhone Mail (23F84)

Hello Ren=C3=A9,

Many thanks for your patch. [1]

I have bought the PCI graphics card Matrox G200 G2+/QUADP-PL/7 32MB with 4x D=
VI. It is an AGP card connected via PCI.=20

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
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <=
TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 128 (4000ns min, 8000ns max), Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at c20000000 (32-bit, prefetchable) [size=3D16M]
	Region 1: Memory at c21000000 (32-bit, non-prefetchable) [size=3D16=
K]
	Region 2: Memory at c21800000 (32-bit, non-prefetchable) [size=3D8M=
]
	Expansion ROM at c21010000 [disabled] [size=3D64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2=
-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [f0] AGP version 1.0
		Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64-=
 HTrans- 64bit- FW- AGP3- Rate=3Dx1,x2
		Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit- =
FW- Rate=3D<none>
	Kernel driver in use: mgag200

0001:05:04.0 Display controller: Matrox Electronics Systems Ltd. MGA G200 AG=
P (rev 03)
	Subsystem: Matrox Electronics Systems Ltd. G200 Multi-Monitor
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <=
TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 128 (4000ns min, 8000ns max), Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at c22000000 (32-bit, prefetchable) [size=3D16M]
	Region 1: Memory at c23000000 (32-bit, non-prefetchable) [size=3D16=
K]
	Region 2: Memory at c23800000 (32-bit, non-prefetchable) [size=3D8M=
]
	Expansion ROM at c21020000 [disabled] [size=3D64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2=
-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [f0] AGP version 1.0
		Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64-=
 HTrans- 64bit- FW- AGP3- Rate=3Dx1,x2
		Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit- =
FW- Rate=3D<none>
	Kernel driver in use: mgag200

0001:05:08.0 Display controller: Matrox Electronics Systems Ltd. MGA G200 AG=
P (rev 03)
	Subsystem: Matrox Electronics Systems Ltd. G200 Multi-Monitor
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <=
TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 128 (4000ns min, 8000ns max), Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at c24000000 (32-bit, prefetchable) [size=3D16M]
	Region 1: Memory at c25000000 (32-bit, non-prefetchable) [size=3D16=
K]
	Region 2: Memory at c25800000 (32-bit, non-prefetchable) [size=3D8M=
]
	Expansion ROM at c21030000 [disabled] [size=3D64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2=
-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [f0] AGP version 1.0
		Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64-=
 HTrans- 64bit- FW- AGP3- Rate=3Dx1,x2
		Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit- =
FW- Rate=3D<none>
	Kernel driver in use: mgag200

0001:05:0c.0 Display controller: Matrox Electronics Systems Ltd. MGA G200 AG=
P (rev 03)
	Subsystem: Matrox Electronics Systems Ltd. G200 Multi-Monitor
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <=
TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 128 (4000ns min, 8000ns max), Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at c26000000 (32-bit, prefetchable) [size=3D16M]
	Region 1: Memory at c27000000 (32-bit, non-prefetchable) [size=3D16=
K]
	Region 2: Memory at c27800000 (32-bit, non-prefetchable) [size=3D8M=
]
	Expansion ROM at c21040000 [disabled] [size=3D64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2=
-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [f0] AGP version 1.0
		Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64-=
 HTrans- 64bit- FW- AGP3- Rate=3Dx1,x2
		Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit- =
FW- Rate=3D<none>
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


