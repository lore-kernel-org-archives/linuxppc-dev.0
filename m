Return-Path: <linuxppc-dev+bounces-20084-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FCCAFED3EC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 15:48:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g2HSG5yFgz2yWK;
	Sat, 25 Apr 2026 01:48:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=130.133.4.66
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777045726;
	cv=none; b=Mqs0pRGErLe/aSi7WQR73i/iuhsyP5BtEus4t81yfcsJ/pzbT915xQKkIyEW/5r04KybprNGi76UR8ITQIx03WE09XLFVFL71ju62Dd37Im1D7zXQSSuiU0vZyYaPvvVd69RIxbl1iZn6oW7XggLcSjaVYJL8ZnaZcqw7PLN30V2w0fKXmW1qnZsH+kgCf0uQajvMGyfOXAfVRZWJlRTfktsAKenjWfEk8HtMjKJHazOfRLMp+FVrqu/kmAJAGLPN8RvigOO320QJsZddyB2mazruhMWWsvhvHW5ZtJpLMNYgSzUfOGlXOPKPqJdrUwfk17fbgcEa5JbrQDGmwlnqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777045726; c=relaxed/relaxed;
	bh=sR7PWVzDNl0Tt491SxI4OxCz/9aFZbKZgaCBkHzdKEE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xtp9EVkpKOBq6wuKeuCEfhcpsDrgeXoxq2sBDwg2ltIQsIfb6SOSADAWEPoB2KQ1MZjrVrkk6wcDb3NRGWBfqQrmcuDGj16J3GUDijBBkJhdS1OUEA80QlTDDx5aP3UXXmprXEMzmPOihwfsmQJ5fs3CdmmP7zy9txBhIyFmFA4GoEUrfyyEMQhUMF28OjFNHix0py6sRo5hNW6rB4gpzu6/mgfKqjyEwIRpqG01NvTHgULJ/fUvTFoklByZ0B0AQyqoIXZ8zys8eUgFW02zMwa7jfO5xuRfLREYe7RlkzntCXhLDASFDMqwHa/EZCtRuvFqtsB6wZHAJZIfuRFLKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; dkim=pass (2048-bit key; unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=P1jDrlBY; dkim-atps=neutral; spf=pass (client-ip=130.133.4.66; helo=outpost1.zedat.fu-berlin.de; envelope-from=glaubitz@zedat.fu-berlin.de; receiver=lists.ozlabs.org) smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=P1jDrlBY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=zedat.fu-berlin.de (client-ip=130.133.4.66; helo=outpost1.zedat.fu-berlin.de; envelope-from=glaubitz@zedat.fu-berlin.de; receiver=lists.ozlabs.org)
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g2HSD69lcz2yC9
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2026 01:48:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=sR7PWVzDNl0Tt491SxI4OxCz/9aFZbKZgaCBkHzdKEE=; t=1777045724;
	x=1777650524; b=P1jDrlBYB0iZr4wM0Fk2wnlkvkL2wYxCaLKkuXeO6C/ZKMwJcDh636dRowMOY
	dC93JPngUSGUs8nga0UWG4GOPe7rptEBuoBimQNODIizJbiiOVpMh7kmNoYOx2HLlDtiwyW5pI8SN
	gwW5ktBxnafxI1zdUSDT9xqxI15EEkmlg4OtNLuvhky0tTKy7rBtmwK/mWYMEEA876QiS2kxuP0VA
	nfm+RuflEMm0/spHN4UHt+srLgbr2J1gmTaKvecA2gB7fBxu+JP7GoJJpTLKJqJu80CQkBlZB790c
	eAgWdq+YDjMPQI+itDkU/FWw8FCiQXTHUeFKtqTIFCFEYx0n6Q==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wGIli-00000000k6X-3PRH; Fri, 24 Apr 2026 17:48:38 +0200
Received: from dynamic-002-242-158-062.2.242.pool.telefonica.de ([2.242.158.62] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wGIli-000000007EX-2Trq; Fri, 24 Apr 2026 17:48:38 +0200
Message-ID: <d9ad0cd6fa640f23c396778bce2aa322e40e7e88.camel@physik.fu-berlin.de>
Subject: Re: KVM-PR no longer works when compiled with new GCC compilers
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Christian Zigotzky <chzigotzky@xenosoft.de>, linuxppc-dev
	 <linuxppc-dev@lists.ozlabs.org>, kvm@vger.kernel.org, 
 "debian-powerpc@lists.debian.org"
	 <debian-powerpc@lists.debian.org>
Cc: "R.T.Dickinson" <rtd2@xtra.co.nz>, hypexed@yahoo.com.au, mad skateman
	 <madskateman@gmail.com>, Christian Zigotzky <info@xenosoft.de>
Date: Fri, 24 Apr 2026 17:48:37 +0200
In-Reply-To: <a584b7a1-fc25-a475-099a-634159b6ffe8@xenosoft.de>
References: <cfd779d6-9440-46b2-9ed5-752f1ae6b5d1@xenosoft.de>
	 <588ada6c-bcc4-e93b-1beb-4f7f859e3d5c@xenosoft.de>
	 <eee732904c2a7ccce9b496b05f988a36d8a9883e.camel@physik.fu-berlin.de>
	 <5da12382-5424-4bd9-981f-359e4dc1fa67@xenosoft.de>
	 <a584b7a1-fc25-a475-099a-634159b6ffe8@xenosoft.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 
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
X-Originating-IP: 2.242.158.62
X-ZEDAT-Hint: PO

On Fri, 2026-04-24 at 16:47 +0200, Christian Zigotzky wrote:
> I compiled it with "mtune=3Dpower4" today but without any success.
>=20
> Error messages:
>=20
> [=C2=A0 800.274759] Couldn't emulate instruction 0x00000000 (op 0 xop 0)
> [=C2=A0 800.274767] kvmppc_exit_pr_progint: emulation at 100 failed (0000=
0000)

What exactly are you running inside the KVM? 0x00000000 doesn't seem like
a valid instruction and a quick Google research reveals that this triggers
a SIGLL trap.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

