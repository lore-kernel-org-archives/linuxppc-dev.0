Return-Path: <linuxppc-dev+bounces-21235-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19724CD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 11:46:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gL8rP5HMcz2xqv;
	Wed, 20 May 2026 21:46:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779277573;
	cv=none; b=H0TP+MvuRSsMmugakkkaCJ9IDXY4hRZlCZyaxKAkaXIAErWA8NLKpgQzHjutNxIBFqCp3z5Ag3BwQJdMQTveZEn4WhB0mkKYvyyZRzKsISNHQV1G9n5+uqAiW01Ddx9RzkWVdc+2E0PlOt/EQ11M/f3/RLofBiSR06fOwGRSHIyuLYk5b5G5aFsf9ETxNZ05y/vVg0nfX51aMp6Iq72lELDVPSaYLrBEEQrbOg6IswuyBsgiMI0gUrYBki0G2BMSLA2JlMrKTaxkwKnKw+OG+lVCe2rkhRLmI5kIKmLoTnSb5v4jloEcMpLZzCHp7zHLNIBRvmjGuMv73+RUOCasfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779277573; c=relaxed/relaxed;
	bh=RNZTCia8bRlSbSgz5D/BvEXx+e8tvmS3lBEOF+WnOwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=adJHsmDw7zk54YsnJWq2q4Y/Dxj4wgJBpc+itPyoIo9x09x8Yd9PeCLBaz0JzOKSWqXhlMBVRhoRALn4II9RSK3Nirzyp7DWyQkRRGV1ewoHPQnT5FNwB5lZb7JofEmzxWn2yjVYmYDmFIwncsvWyAx9CQEPI46NZqx6UwpnG82GY47FljBSDBTEe6YULLCPNr1VZ5+lzdk1Qot3ewpWEyuN3PopTPhKcUWViEalfXHuiuDbVO9nb3TsF4jHws0VYJuid0cgeBk6/bJsJZ4k3h19/msk6taQACU7/437TljFrbrYV/+ARk/VofhsKRLNMcVIzv0h8J/7hy8cJlljfg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=KrbKgJxC; dkim-atps=neutral; spf=pass (client-ip=212.227.15.18; helo=mout.gmx.net; envelope-from=deller@gmx.de; receiver=lists.ozlabs.org) smtp.mailfrom=gmx.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=KrbKgJxC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmx.de (client-ip=212.227.15.18; helo=mout.gmx.net; envelope-from=deller@gmx.de; receiver=lists.ozlabs.org)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gL8rL3gGrz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 21:46:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779277552; x=1779882352; i=deller@gmx.de;
	bh=RNZTCia8bRlSbSgz5D/BvEXx+e8tvmS3lBEOF+WnOwE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KrbKgJxCkH2Vi4EDAlGhjtWOUpqkt0dH+lAaNR2uGUEuy3VxrI3LDKIm6D0Pt7FG
	 1WEHPomJJGFQlAXYm+53aUk1Imr2OIFsn4VaaNIPyc27GdyNuuppSWVH6OvZnPB8z
	 mq/HkqqL5MrQCj1D0ibcLd+WF0gaZieyoEftyuLxXLsaRBTOKb9vkOIPLi/KYrlRS
	 2ZAD2eW5giWJqH51yIlB5PC5ZaEerE5hE9uaam+Pc6Po0y3mxBB/PGqWSDgTJd1GS
	 D2zf2Sv9czt5Ii+LOygBUR9rJuMSNi2EYdvfy0WQH5Hk6q3asxRbbq7+vGroTY8pw
	 ENWosdQUfBMMsH0d5Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxUnz-1xIIG12Klt-011VXL; Wed, 20
 May 2026 13:45:52 +0200
Message-ID: <0ec8d725-1f86-486c-a8fa-ee1c68a01985@gmx.de>
Date: Wed, 20 May 2026 13:45:48 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: console: mdacon: remove this obsolete driver
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-fbdev@vger.kernel.org,
 Linux DRI Development <dri-devel@lists.freedesktop.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Nicolas Pitre <nico@fluxnic.net>
References: <20260520033155.17378-1-enelsonmoore@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260520033155.17378-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gfI53cV7IIsiLFY311/gxZupMFCovWyFn8QlWFedzR4EoHdRxzU
 fd3FhpqqnL5hLnvs7A9JXsSS0GGY1a0PpTCHg+cRT9QMot4prVLbfqDIPQapOQ8bspQVjFb
 uq0WdoxAmexngai8kuobQsHlsp2lKE2++58Fzt4ADKClbjiBp7PG7kB7ESbtE841bsP+Ngp
 QbwIySazlAhGsM93n3U3g==
UI-OutboundReport: notjunk:1;M01:P0:wd6J/JnIWZM=;3DjiavRrerC71RWZ5FsWzOYKg7p
 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

On 5/20/26 05:31, Ethan Nelson-Moore wrote:
> The mdacon driver supports using ISA MDA or Hercules-compatible display
> adapters as a secondary text console. This was commonly used in the
> 1990s and earlier for debugging software which took over the primary
> display. It is highly unlikely anyone is doing so nowadays because
> serial consoles and much better methods of debugging exist.
>=20
> The driver is not enabled by any defconfig, nor any of the
> dozens of distro configs collected at [1]. It has been relegated to VTs
> 13-16 since commit 0b9cf3aa6b1e ("mdacon messing up default vc's - set
> default to vc13-16 again") in Linux 2.6.27 (and before Linux 2.5.53 -
> see the link in the message of the above commit). The change in 2.6.27
> was done because it was incorrectly detecting non-MDA adapters as MDA
> and taking over all VTs, rendering them unusable.
>=20
> Furthermore, vgacon supports using MDA/Hercules-compatible adapters as
> the primary text console, so any systems with only one of these
> adapters were already using vgacon and will not experience any loss in
> functionality from the removal of this driver.
>=20
> Given all of these factors, the mdacon driver is likely entirely
> unused. Remove it.

I've applied this patch to the fbdev git tree, since I also believe that
there is no use case or user left (with Linux kernels >=3D 7.0), which use=
s the mdacon.

If someone thinks we need to keep it, please speak up.

Helge


>=20
> [1] https://github.com/nyrahul/linux-kernel-configs/tree/f0bee86a135a040=
6ea427855f52702dd00d770f9
>=20
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>   .../admin-guide/kernel-parameters.txt         |   5 -
>   arch/alpha/kernel/io.c                        |   2 +-
>   arch/powerpc/include/asm/vga.h                |   4 +-
>   drivers/tty/vt/vt.c                           |   3 -
>   drivers/video/console/Kconfig                 |  15 -
>   drivers/video/console/Makefile                |   1 -
>   drivers/video/console/mdacon.c                | 566 ------------------
>   include/linux/console.h                       |   2 -
>   include/linux/vt_buffer.h                     |   2 +-
>   9 files changed, 4 insertions(+), 596 deletions(-)
>   delete mode 100644 drivers/video/console/mdacon.c

