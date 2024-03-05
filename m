Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A48C48BF6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2024 00:40:01 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=L5LihVMM;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TpcCh52Mpz3btZ
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2024 11:40:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=L5LihVMM;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TpcBv3bHQz30YR
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Mar 2024 11:39:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1709599159;
	bh=O0yyXFEBHAkyNtI5CjiaTsfcPSXS8959gJlNgVluFYY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=L5LihVMMitiNLxNXu2uwdvAv5G9pLC5oUdBu+pvYJDZ313YT8SyKPN20bPRxW4GVj
	 /utTJNIIqFYG2T9xXeKGzbECdqAlQXpV2INu3W3M9K2sEDjHtJCC1xTQxcw4aDTaUn
	 LeLem1wU+SnumutF4cSN6xEfhO8L2iISNF0BZGTmWmYublljLePl9zrN0qM0U1nZQY
	 3zjHR+/kCU+tdM61C06/119pJz9yBVmYSF9NBTYGjOuNdoKnV/LeRDgn1n1Zd5ym6S
	 p4UmssY0/676QfbmJFkFp9KgmxO9w5mXW8AsUMO1oGPCthyKjrjzBikVQdMtXrFtK4
	 E/5H0SV/AJJQw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TpcBt73J0z4wcv;
	Tue,  5 Mar 2024 11:39:18 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jani Nikula <jani.nikula@intel.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: include linux/backlight.h from asm/backlight.h
In-Reply-To: <87bk7u5n9h.fsf@intel.com>
References: <CA+G9fYsAk5TbqqxFC2W4oHLGA0CbTHMxbeq8QayFXTU75YiueA@mail.gmail.com>
 <20240304095512.742348-1-jani.nikula@intel.com> <87bk7u5n9h.fsf@intel.com>
Date: Tue, 05 Mar 2024 11:39:18 +1100
Message-ID: <87cys9pl55.fsf@mail.lhotse>
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
Cc: linux-fbdev@vger.kernel.org, Naresh Kamboju <naresh.kamboju@linaro.org>, linux-kernel@vger.kernel.org, lkft-triage@lists.linaro.org, dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Jani Nikula <jani.nikula@intel.com> writes:
> On Mon, 04 Mar 2024, Jani Nikula <jani.nikula@intel.com> wrote:
>> Removal of the backlight include from fb.h uncovered an implicit
>> dependency in powerpc asm/backlight.h. Add the explicit include.
>>
>> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>> Closes: https://lore.kernel.org/r/CA+G9fYsAk5TbqqxFC2W4oHLGA0CbTHMxbeq8QayFXTU75YiueA@mail.gmail.com
>> Fixes: 11b4eedfc87d ("fbdev: Do not include <linux/backlight.h> in header")
>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: Helge Deller <deller@gmx.de>
>> Cc: linux-fbdev@vger.kernel.org
>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>>
>> ---
>>
>> Not even compile tested!
>
> Naresh, please try this patch!
>
> Michael, if this is fine by you, ack to merge via the drm subsystem
> along with the regressing commit?

I prefer Thomas' patch, but I'm fine with either to go in via drm.

cheers
