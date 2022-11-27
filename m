Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50829C4332F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Nov 2022 23:00:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NL3wg4d9Wz3cDM
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Nov 2022 10:00:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=exVzIoRS;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NL3vb5k6fz2xrL
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2022 09:59:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=exVzIoRS;
	dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4NL3vV0x13z4xG6;
	Mon, 28 Nov 2022 09:59:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1669589974;
	bh=n9irktu+jevq7fMe56RmXT6JJ5LT3gsl+oqzr4gohXg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=exVzIoRS3oDlkfs92eXqQcJvt61j+Obqhy6yazv9im5S0aGjM1SC2Qqq95SKRFHqr
	 XU8khHre4kB9xsMJMSk8H6WprPmyaGFVZnSHfwd3CUV9xzDKCJKfyf1Jd+iZCorlnN
	 9+PBLxobPnUTuImVNCDC8RlLqOTeY0vbFl+M9X0SJaJf61YhoIkhmJrcOMgrCS6GXp
	 P6UBkEWHmWDWTYlL1kW5MYfQRCHIqeu47iTHtWB4kuVVuiPt4mFdKvWt4fbpFhIqCy
	 ElVR6LaeJDSgFGTxKXo03VI6VvhaVZ9YSm8P2iP7okBZwrZppKKhghSD2zcGqWqtD9
	 T3rwnaO0pv35w==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, Christophe
 Leroy
 <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 2/3] powerpc/book3e: remove #include
 <generated/utsrelease.h>
In-Reply-To: <8f8b12fd-2e25-49e4-a1fa-247f08f56454@t-8ch.de>
References: <20221126051002.123199-1-linux@weissschuh.net>
 <20221126051002.123199-2-linux@weissschuh.net>
 <03859890-bf90-4ad0-1926-4b8cb8dbfa57@csgroup.eu>
 <8f8b12fd-2e25-49e4-a1fa-247f08f56454@t-8ch.de>
Date: Mon, 28 Nov 2022 09:59:31 +1100
Message-ID: <87r0xoatrg.fsf@mpe.ellerman.id.au>
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
Cc: linux-arch <linux-arch@vger.kernel.org>, Russ Weight <russell.h.weight@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Masahiro Yamada <masahiroy@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Thomas Wei=C3=9Fschuh <linux@weissschuh.net> writes:
> On 2022-11-26 07:36+0000, Christophe Leroy wrote:
>> Le 26/11/2022 =C3=A0 06:10, Thomas Wei=C3=9Fschuh a =C3=A9crit=C2=A0:
>>> Commit 7ad4bd887d27 ("powerpc/book3e: get rid of #include <generated/co=
mpile.h>")
>>> removed the usage of the define UTS_VERSION but forgot to drop the
>>> include.
>>=20
>> What about:
>> arch/powerpc/platforms/52xx/efika.c
>> arch/powerpc/platforms/amigaone/setup.c
>> arch/powerpc/platforms/chrp/setup.c
>> arch/powerpc/platforms/powermac/bootx_init.c
>>=20
>> I believe you can do a lot more than what you did in your series.
>
> The commit messages are wrong.
> They should have said UTS_RELEASE instead of UTS_VERSION.
>
> Could the maintainers fix this up when applying?
> I also changed it locally so it will be fixed for v2.

I'll take this patch, but not the others.

cheers
