Return-Path: <linuxppc-dev+bounces-16992-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A1FC55ABE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Feb 2026 13:16:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fHW3B5QYNz30GV;
	Sat, 21 Feb 2026 00:16:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=130.133.4.66
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771593366;
	cv=none; b=J9l6evolRhDh12ezimInBKX4ViYEvmGCTPFE/YT24+0ct14oTSoJRtvT1F5cYu2h1zir3p20lrE4JZ4sFqXCk5ZluslvVNmQSmgrqjVwwzU+4pZHIvEfKmtLDFOpXlLqJ3saYEEqCBpIMFIFgxyTDQVJr+yQVnxfJ4Na9g4CMdAsxCpU9QInojZ2K1BTx5XLzv62ElAqr8XQHdCXI03YnkiNdSEEeWG5eEr9Y52sm1sgE39A7P210oA0dVaKDUOX5Rwb/i/6ES1NTK6Kw4AnpAkpXgTzHz1oT8Cfg5j4/wKnpHNUqlaAF+Zqs9IREwm/0bpdVdW6F7Qylm7fw3ieMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771593366; c=relaxed/relaxed;
	bh=mOkNCk6azFD4Se56SNgIay6/ojZdDJ39xzBXTJXthIE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dq6idY4SQ+11ha9AmcC+auSty7RQ1/KkptyDpnZIT+KoWnWAg3zebtofjpRS+B244rN2ZvxnJBRNE+LPcTz6ENMCv3d+fKMBelOqDIWa+Kyjt8yBmZbpgI+hmd9tUDFOgIrpEOR+wxtwsFp1QNqKC/k5yIbMg9qzQM2765T7B0fczAF+s+tip55ED3E6e/kAdCHtCufrAhpGPNjO/aWfU8xT3VFoBhu0y31V+t2Jxur6CFXvDSOUmQLfUactm8cFURgA4iA7m+mt1CnKzopDLRJxtTa6rWW9UgFqc7siUO9neMHMug0M5X4HMcLrBsIpzj6tjOqjCrRREEj/cj8zUA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; dkim=pass (2048-bit key; unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=lyEnyuQk; dkim-atps=neutral; spf=pass (client-ip=130.133.4.66; helo=outpost1.zedat.fu-berlin.de; envelope-from=glaubitz@zedat.fu-berlin.de; receiver=lists.ozlabs.org) smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=lyEnyuQk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=zedat.fu-berlin.de (client-ip=130.133.4.66; helo=outpost1.zedat.fu-berlin.de; envelope-from=glaubitz@zedat.fu-berlin.de; receiver=lists.ozlabs.org)
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fHW354vNnz2xSX
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Feb 2026 00:15:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=mOkNCk6azFD4Se56SNgIay6/ojZdDJ39xzBXTJXthIE=; t=1771593361;
	x=1772198161; b=lyEnyuQk1BEjbMkbwG4vtQ3E+VSQowr7bT14756JzCjGikCW5nHzNtln1ALNb
	l3AJFaAhgtlYD/vZmZxzEssJ0qPGVlo+7gkbrqcJQSGIa7DMcsm9d0IcjhKfHItBCemI5qZ/7RiO9
	3KGsneixmrBoej2E9kEZAMzVFzGh9EiA03useNUn6BjKK2PmXYJ95KTYqN5sL7t6xiBvo2vPU6xA1
	k1qFzUiKlxdVo7oVrqT8T3UPJA6WviTBykxI+eM6uPDbu/Ts2EclomIElg0IwstFgil+cW864GDXb
	gsRuIiSvuvUFDM/NtC+NO2LzKGjIEGHMfF1gNjRAHtVqYtdH4w==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vtQMI-00000000Zex-35F1; Fri, 20 Feb 2026 14:15:50 +0100
Received: from p5dc55f29.dip0.t-ipconnect.de ([93.197.95.41] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vtQMI-00000002ANB-1yr4; Fri, 20 Feb 2026 14:15:50 +0100
Message-ID: <8aa6c538d4a49084f6464772f8dd1bd2b642c54b.camel@physik.fu-berlin.de>
Subject: Re: [PATCHv2 0/2] pci: fix msi_addr_mask on powerpc and sparc
 systems
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Vivian Wang <wangruikang@iscas.ac.cn>, Nilay Shroff
 <nilay@linux.ibm.com>, 	linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, 	sparclinux@vger.kernel.org
Cc: tglx@kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, 	chleroy@kernel.org, gjoyce@ibm.com, helgaas@kernel.org,
 davem@davemloft.net, 	andreas@gaisler.com
Date: Fri, 20 Feb 2026 14:15:49 +0100
In-Reply-To: <782eaaf6-f7e2-4c15-b4a2-52e7697dbd95@iscas.ac.cn>
References: <20260220070239.1693303-1-nilay@linux.ibm.com>
	 <782eaaf6-f7e2-4c15-b4a2-52e7697dbd95@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
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
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 93.197.95.41
X-ZEDAT-Hint: PO

Hi,

On Fri, 2026-02-20 at 18:14 +0800, Vivian Wang wrote:
> Hi Nilay,
>=20
> On 2/20/26 15:02, Nilay Shroff wrote:
>=20
> > Hi,
> >=20
> > Recent changes [1] which replaced pci_dev::no_64bit_msi with pci_dev::
> > msi_addr_mask inadvertently missed to initialize the pci_dev::msi_addr_=
mask
> > to the DMA_BIT_MASK(64) on powerpc platform. Due to this, later the=20
> > validation the programmed MSI address against the msi_addr_mask fails.
> > This causes pci device probe method failures on powerpc platform. We al=
so
> > realized that similar issue could potentially happen on sparc system as
> > well. So this series initializes pci_dev::msi_addr_mask to DMA_BIT_MASK=
(64)
> > when pci_dev is instantiated for both powerpc and sparc platforms.
> >=20
> > The first patch in the series fixes this on powerpc platform. The secon=
d
> > patch fixes this issue on sparc platform. Please note that as I don't h=
ave
> > access to the sparc platform, this patch was only compile tested on the
> > sparc system. Anyone from the community is welcome to test it who has
> > access to the sparc machine.
> >=20
> > [1] https://lore.kernel.org/all/20260129-pci-msi-addr-mask-v4-0-70da998=
f2750@iscas.ac.cn/
> >=20
> > Changes since v1:
> >   - Initialize the pci_dev:msi_addr_mask on sparc platform (Vivian Wang=
)
> >   - Some minor cosmetic fixes (Bjorn Helgaas)
> >=20
> > Nilay Shroff (2):
> >   powerpc/pci: Initialize msi_addr_mask for OF-created PCI devices
> >   sparc/pci: Initialize msi_addr_mask for OF-created PCI devices
> >=20
> >  arch/powerpc/kernel/pci_of_scan.c | 7 +++++++
> >  arch/sparc/kernel/pci.c           | 7 +++++++
> >  2 files changed, 14 insertions(+)
>=20
> This series is:
>=20
> Reviewed-by: Vivian Wang <wangruikang@iscas.ac.cn>
>=20
> With the caveat that I have neither powerpc nor sparc machines to test,
> so it really is only reviewed.

Then please make sure that the changes have been tested on actual hardware.
We've seen some regressions with changes on SPARC that went in without test=
ing.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

