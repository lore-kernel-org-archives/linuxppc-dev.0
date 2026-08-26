Return-Path: <linuxppc-dev+bounces-26117-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D319BC5DF97
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Aug 2026 15:07:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVSgW4Cc8z2y32;
	Thu, 27 Aug 2026 01:07:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=85.215.255.21 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787756855;
	cv=pass; b=IlF+S5gaJsLxqsQeloTSIonkEIkMajTz/+5E44DZENsn40LbYv9IrFjITkJqKBxgjAPgEDA/cIqDTQ44HuJH6NgMWNsEuwHEFwLxQ0rPfKMViBZgzmfbr5qzM2/tMQSIZFq5jiF9eqkhmwaDbRbkAZBoKgcv9oGaDFQrfdQrzb9Ein4Lb65TXAnshz2Ksl3OIgvCiaxVW5innlOjcEpy8tepf7TVMoni3DWYuPkA+yJolCH+WxZ6dYWZuR0Jfiik/wdr53q6IMQAI/1gb+D5vFdiUpA8ZzSZZHiDA9l/uu5xG0AO43dSfodWnVkE/JzSn+hF/pOziV5jczJw6B5zSA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787756855; c=relaxed/relaxed;
	bh=Hjhp8QZkf1qJ5QQbYRUC95C0cpNGrQZe5EY41Fjimww=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fM58Z5GwQaIADnJZrAJiXy44VXwBjJQ6s6XYhYLz0xr2K8FC9rsL6Nnn89QOX+mPaxNM3nAeUQQ3jviZhEffcHe49RzkzVd7OAtrdlkdMYIhAKaoyeNV0o96iVxdQxftHI5XmZsOkFwQaqWo+hLqD09YwNeSQmfsZ4THn7LuJpDcvcXs1YLKBkiC4f4oOw5uWY0wmHgW/dWa3Miput4MKVlF7O+/jF3ps4b+wj7fjsZGrhK1Pige2BAcO/fWUUn/LpYXR3n5eIUlKlWBlZFuBCZsNBFXJw/UalsORRCV4nWd0uDDiL9fMyez2pkSDFr0nfxPhaQvaukJkNqawjuSPg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=MU8YK7lr; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=fttUFSBA; dkim-atps=neutral; spf=pass (client-ip=85.215.255.21; helo=mo4-p00-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p00-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=MU8YK7lr;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=fttUFSBA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p00-ob.smtp.rzone.de (client-ip=85.215.255.21; helo=mo4-p00-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVSgP1DLVz2xGw
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2026 01:07:25 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1787756836; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=m2jR6jNPVu35V1OVThYzVnaNBsjMLmC3U9BPJ8j2tVmb9yWSIqrun7ptwvEugxopmy
    sPi+05ZfBCSe7em9dfHhB7VwWDgVKSigwHExbvTyng+zD/g/3JmJVUADFMuTdDoAknLP
    AzZvdubgeuOrnD+I3qBeVP2GnyxqltdzxYBh4ZqkugxOjlo3RiXQW0x5ozvc0scSteul
    N0JBiyjsGOFPMR0DIExlQgkfDprvA7pKUPu7r5/lFdr3J+Y09710FCeF905Kv2i6CIWC
    AWiy/4JUfc3ln3fnZDrzNmM0pcHEZYBFv7LcKQdUaWNpiohax8QY1l92SCz+3gA1hj7N
    VCKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1787756836;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Hjhp8QZkf1qJ5QQbYRUC95C0cpNGrQZe5EY41Fjimww=;
    b=IoSIvxOewkjbdMZpYQ+zotkeW8vLJdG2Gs6aN0yjWsUl3Zy28Oa6zLb9AVL37FKTFO
    0Zt181QNHSDQHFHn4PfFFaWYF1zQZI2mzTdW7LzOYGANV+Sdn9v/oDCcqDuxtzfH8dAH
    pzAdPOM1CUcPHgHD7u39wGPRFB8LSrz3bNaGVkqDicgobZA+FQvAX5vGvhESpq7hd2gW
    mg6EiYrFDEi/viifh3znaeq+vhYizfqdnpGuYNwTZICcaeXhX9jiyMNPx5+k2ZPIQjR2
    kg+Z+PL+qSNFqCWox6u/8YdZIpMrUsq9i2nnCh+HhTqYjNRuTi9k7ZEm+clgwLtWukNN
    FrgQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787756836;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Hjhp8QZkf1qJ5QQbYRUC95C0cpNGrQZe5EY41Fjimww=;
    b=MU8YK7lrIr9spO39P8iUm3TzIzlB6MdfQDJN44E2Yfg9fDcEFpPY+Qff++nryZNB4G
    KN95bOXNGtQpGxm95mYW4EaVpSlz75NzreznsxOALlv08MufwS4Jy41GXYNaHswgwutt
    GOPVW16pcPPwGwur85whpRWqZVeneNxmoMtrlMeyF8WxG2btOZYTu1yY+QoagcKguazt
    XOT08zziqpQo5/GIfWO0zfZ8bISMACWdMRF0pm7uu/PKL8EjcnhmYYL6PcYMDKzVyGiK
    6Qa5o2U1zI17ESaDGCFJDFZ7RWFhS0UFqQb4sAsiTxhy6ezFW8DpAKx3r8ZEb390fUdB
    OI1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787756836;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Hjhp8QZkf1qJ5QQbYRUC95C0cpNGrQZe5EY41Fjimww=;
    b=fttUFSBAn5yBEpweceQCwJkhYTZU2fumt8qaQyTnlgOZDZRsPol8KFvnXwzswCJ5zR
    riOY1EiCXdY8rYtb3EDw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIi+m7xzg"
Received: from void-ppc.a-eon.tld
    by smtp.strato.de (RZmta 55.6.2 DYNA|AUTH)
    with ESMTPSA id ee2bee27QF7FSFU
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 26 Aug 2026 17:07:15 +0200 (CEST)
Subject: Re: drm/mgag200: Fix big-endian support
To: Thomas Zimmermann <tzimmermann@suse.de>, rene@exactco.de
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Trevor Dickinson <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
 mad skateman <madskateman@gmail.com>, Christian Zigotzky <info@xenosoft.de>
References: <4ACA9FCA-683C-44D0-B31F-CE70C40070BB@xenosoft.de>
 <6c265d1e-c301-4095-83e2-0e669222469a@suse.de>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Organization: A-EON Open Source
Message-ID: <0ac66673-034b-4fa0-089d-788ca7fde899@xenosoft.de>
Date: Wed, 26 Aug 2026 17:07:14 +0200
X-Mailer: BrassMonkey/34.3.2.1
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
MIME-Version: 1.0
In-Reply-To: <6c265d1e-c301-4095-83e2-0e669222469a@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/08/26 11:06, Thomas Zimmermann wrote:
 > Hi
 >
 > Am 02.08.26 um 20:06 schrieb Christian Zigotzky:
 >> Hello René,
 >>
 >> Many thanks for your patch. [1]
 >>
 >> I have bought the PCI graphics card Matrox G200 G2+/QUADP-PL/7 32MB 
with 4x DVI. It is an AGP card connected via PCI.
 >>
 >> We use the new DRM driver MGAG200 since the kernel 7.2.0-rc4 and the 
old DRM legacy driver for Matrox g200/g400 graphics cards since the 
stable long-term kernel 5.10.260.
 >>
 >> I tested it with the RC5 of kernel 7.2 in my PowerPC machine (e5500) 
today. Unfortunately, the DRM driver mgag200 can't read the PCI ROM. 
Maybe only an x86 ROM?
 >>
 >> xrandr detects the ports but reports that they are not connected, 
even though the cables are plugged in.
 >>
 >> I also tested it with the stable long-term kernel 5.10.261 with the 
old legacy DRM drivers for Matrox graphics cards.
 >> I installed the Xorg MGA server xf86-video-mga-2.0.0_3 for the old 
legacy DRM driver but unfortunately I get only a black screen.
 >>
 >> Is it possible to use this card with PPC Linux?
 >
 > Attached is the patch I promised.  Please apply it and test it on 
your machine. Does it make the card work?
 >
 > Best regards
 > Thomas

Hello Thomas,

Thank you for your patch. Unfortunately the card doesn't work with the 
patched kernel.

dmesg | grep -i mga

[    2.307195] [drm] Initialized mgag200 1.0.0 for 0001:05:00.0 on minor 1
[    2.308649] mgag200 0001:05:00.0: [drm] Cannot find any crtc or sizes
[    2.309551] mgag200 0001:05:04.0: Invalid PCI ROM header signature: 
expecting 0xaa55, got 0xffff
[    2.310305] [drm] Initialized mgag200 1.0.0 for 0001:05:04.0 on minor 2
[    2.312660] mgag200 0001:05:04.0: [drm] Cannot find any crtc or sizes
[    2.313177] mgag200 0001:05:00.0: [drm] Cannot find any crtc or sizes
[    2.313640] mgag200 0001:05:08.0: Invalid PCI ROM header signature: 
expecting 0xaa55, got 0xffff
[    2.314357] [drm] Initialized mgag200 1.0.0 for 0001:05:08.0 on minor 3
[    2.317630] mgag200 0001:05:08.0: [drm] Cannot find any crtc or sizes
[    2.318185] mgag200 0001:05:0c.0: Invalid PCI ROM header signature: 
expecting 0xaa55, got 0xffff
[    2.318840] mgag200 0001:05:04.0: [drm] Cannot find any crtc or sizes
[    2.319345] [drm] Initialized mgag200 1.0.0 for 0001:05:0c.0 on minor 4
[    2.321014] mgag200 0001:05:0c.0: [drm] Cannot find any crtc or sizes
[    2.322400] mgag200 0001:05:08.0: [drm] Cannot find any crtc or sizes
[    2.327215] mgag200 0001:05:0c.0: [drm] Cannot find any crtc or sizes

lspci -vvv

0001:05:00.0 VGA compatible controller: Matrox Electronics Systems Ltd. 
MGA G200 AGP (rev 03) (prog-if 00 [VGA controller])
     Subsystem: Matrox Electronics Systems Ltd. G200 Multi-Monitor
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 128 (4000ns min, 8000ns max), Cache Line Size: 32 bytes
     Interrupt: pin A routed to IRQ 18
     Region 0: Memory at c20000000 (32-bit, prefetchable) [size=16M]
     Region 1: Memory at c21000000 (32-bit, non-prefetchable) [size=16K]
     Region 2: Memory at c21800000 (32-bit, non-prefetchable) [size=8M]
     Expansion ROM at c21010000 [disabled] [size=64K]
     Capabilities: [dc] Power Management version 1
         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [f0] AGP version 1.0
         Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW- AGP3- Rate=x1,x2
         Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>
     Kernel driver in use: mgag200

0001:05:04.0 Display controller: Matrox Electronics Systems Ltd. MGA 
G200 AGP (rev 03)
     Subsystem: Matrox Electronics Systems Ltd. G200 Multi-Monitor
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 128 (4000ns min, 8000ns max), Cache Line Size: 32 bytes
     Interrupt: pin A routed to IRQ 18
     Region 0: Memory at c22000000 (32-bit, prefetchable) [size=16M]
     Region 1: Memory at c23000000 (32-bit, non-prefetchable) [size=16K]
     Region 2: Memory at c23800000 (32-bit, non-prefetchable) [size=8M]
     Expansion ROM at c21020000 [disabled] [size=64K]
     Capabilities: [dc] Power Management version 1
         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [f0] AGP version 1.0
         Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW- AGP3- Rate=x1,x2
         Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>
     Kernel driver in use: mgag200

0001:05:08.0 Display controller: Matrox Electronics Systems Ltd. MGA 
G200 AGP (rev 03)
     Subsystem: Matrox Electronics Systems Ltd. G200 Multi-Monitor
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 128 (4000ns min, 8000ns max), Cache Line Size: 32 bytes
     Interrupt: pin A routed to IRQ 18
     Region 0: Memory at c24000000 (32-bit, prefetchable) [size=16M]
     Region 1: Memory at c25000000 (32-bit, non-prefetchable) [size=16K]
     Region 2: Memory at c25800000 (32-bit, non-prefetchable) [size=8M]
     Expansion ROM at c21030000 [disabled] [size=64K]
     Capabilities: [dc] Power Management version 1
         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [f0] AGP version 1.0
         Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW- AGP3- Rate=x1,x2
         Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>
     Kernel driver in use: mgag200

0001:05:0c.0 Display controller: Matrox Electronics Systems Ltd. MGA 
G200 AGP (rev 03)
     Subsystem: Matrox Electronics Systems Ltd. G200 Multi-Monitor
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 128 (4000ns min, 8000ns max), Cache Line Size: 32 bytes
     Interrupt: pin A routed to IRQ 18
     Region 0: Memory at c26000000 (32-bit, prefetchable) [size=16M]
     Region 1: Memory at c27000000 (32-bit, non-prefetchable) [size=16K]
     Region 2: Memory at c27800000 (32-bit, non-prefetchable) [size=8M]
     Expansion ROM at c21040000 [disabled] [size=64K]
     Capabilities: [dc] Power Management version 1
         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [f0] AGP version 1.0
         Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW- AGP3- Rate=x1,x2
         Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>
     Kernel driver in use: mgag200

xrandr

VGA-4-4 disconnected (normal left inverted right x axis y axis)
VGA-3-3 disconnected (normal left inverted right x axis y axis)
VGA-2-2 disconnected (normal left inverted right x axis y axis)
VGA-1-1 disconnected (normal left inverted right x axis y axis)

lspci -nnk | grep VGA

0001:05:00.0 VGA compatible controller [0300]: Matrox Electronics 
Systems Ltd. MGA G200 AGP [102b:0521] (rev 03)

Thanks,
Christian

-- 
Sent with BrassMonkey 34.3.2.1 
(https://github.com/chzigotzky/Web-Browsers-and-Suites-for-Linux-PPC/releases/tag/BrassMonkey_34.3.2.1)

