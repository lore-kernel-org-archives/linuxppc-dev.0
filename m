Return-Path: <SRS0=/Qvz=43=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504DAC10F27
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2020 11:07:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B76E32468F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2020 11:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="DFPUeF3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B76E32468F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (unknown [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48cC3Q6kZ6zDqSt
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2020 22:07:14 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48cC0S0XS7zDqMK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2020 22:04:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=DFPUeF3q; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 48cC0M5QPwz9sQx;
 Tue, 10 Mar 2020 22:04:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1583838279;
 bh=9olihnyJ9M44PKnq28KcPbYYogv3DH93xRCS2PT0tFk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=DFPUeF3q1+xx/iAP21Mb6aBdyFZ0VQFHfaselndP8UP4Mk7+vfhbG/8it1/tdvmg6
 8/cCkdrJdLVPMcIyUQk0p6qKS8z5/9Mo/IvYlJyDWRxa5O1DyFnRv0f9GKic7PyMKE
 QxLNv9XlpzH4m0qr11rEMBNssOUL3j1qzsPRoahcKf33Re5kXXEztTg+eysqEU8+iL
 jxiBUCNlJw3tm9ML60UvzJaENGzfssLqpQNMxES5vcvPSvLzSgUZhVxU2b25n/SfUS
 62k4GyaCra5SFQYixKIbELcWkgdvkAr8Ai3UlntXSlOIvY6GNOTJbwWMLlu1743LQH
 fcuodpshZ9CgA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Wolfram Sang <wsa@the-dreams.de>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] macintosh: windfarm: fix MODINFO regression
In-Reply-To: <20200303125046.5157-1-wsa@the-dreams.de>
References: <20200303125046.5157-1-wsa@the-dreams.de>
Date: Tue, 10 Mar 2020 22:04:25 +1100
Message-ID: <87zhcoii86.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Erhard Furtner <erhard_f@mailbox.org>, Wolfram Sang <wsa@the-dreams.de>,
 Mathieu Malaterre <malat@debian.org>, debian-powerpc@lists.debian.org,
 linux-i2c@vger.kernel.org,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Wolfram Sang <wsa@the-dreams.de> writes:

> Commit af503716ac14 made sure OF devices get an OF style modalias with
> I2C events. It assumed all in-tree users were converted, yet it missed
> some Macintosh drivers.
>
> Add an OF module device table for all windfarm drivers to make them
> automatically load again.
>
> Fixes: af503716ac14 ("i2c: core: report OF style module alias for devices registered via OF")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=199471
> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
> Tested-by: Erhard Furtner <erhard_f@mailbox.org>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>
> This should also help with this: https://lists.debian.org/debian-powerpc/2020/01/msg00062.html
> Some more testing would be appreciated because lm75 also has some code
> changes I can't test myself obviusly.
>
> By grepping, I found some more potential candidates (using a "MAC,"
> prefix but not defining a OF MODULE DEVICE TABLE). Does someone know
> about bugreports filed for those? I don't want to change them for no
> reason:
>
> drivers/macintosh/ams/ams-i2c.c
> drivers/macintosh/therm_adt746x.c
> sound/aoa/codecs/onyx.c
> sound/aoa/codecs/tas.c
> sound/ppc/keywest.c
>
> Happy hacking,
>
>    Wolfram
>
>  drivers/macintosh/windfarm_ad7417_sensor.c  |  7 +++++++
>  drivers/macintosh/windfarm_fcu_controls.c   |  7 +++++++
>  drivers/macintosh/windfarm_lm75_sensor.c    | 16 +++++++++++++++-
>  drivers/macintosh/windfarm_lm87_sensor.c    |  7 +++++++
>  drivers/macintosh/windfarm_max6690_sensor.c |  7 +++++++
>  drivers/macintosh/windfarm_smu_sat.c        |  7 +++++++
>  6 files changed, 50 insertions(+), 1 deletion(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

