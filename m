Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F96606A323
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Nov 2026 07:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AHiuNst6
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jS24824WGz2xGr;
	Sun, 15 Nov 2026 18:02:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794726136;
	cv=none; b=b4bDTRsXv8RpY+25GBg5WaUpnIrB4vjcDBT/+uHXflES1r+BHRBOe9O5sRteCRShnIlbfcDw4gGo0vuqQ4SH7GQrhTo66V2s8d/WjiamvNiIu4wNETLjjCoSoW5h0eMzO9vc+FqxPJmEizjd5zkRxKkE/q1+iaL0RUj+EZoOur03298jFwKn9RoQuP54tYwjhlEbllGRYCklCIwPYtDUhpjLVD55GUieyYymJGPNmZVYz5riNaAlsmBYconA5ohN14gnmtepGPDWUqdIiqPjhjGrzvGdYxBulfbLKKmAdnALgZffouX/+OtBvhegsmIYQl0cBJaUc27rM6azVgKeeg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794726136; c=relaxed/relaxed;
	bh=WlvaTcb4vTukTns5YClT9/RRVqSRloX/GzQ0iNm2R4A=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=Ox0lq+PVDGmzLkbiVLe7RpES3XMXafqf98CtkHARTb+57MWgD1+Q7orJ8RDFQ0kFzmK3rTRv7/BefJbKSdLoAtuccRK+UBzpCAox22rWGkYD2DaSB4sVmKVikt6DjTN7loQBPEXFjCC/GTzKUV7lQDyeYFXh/SmPD6SqxbeoVh+m2xnc2Yka3VXSD8+/NGq6poPNLKGuhRXNwNEH5vmbeUGCjVOmmSDbcLJkFOkxVEnZUpZzWYKIfWsh3ZvmIuL2zt2CYbFuVhfts77i8ln3oRUleAIS28weKynSjEEDiLeLZNbvFXU5+6skJkKB2RevSFiCn2McduE3szpta6+T9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AHiuNst6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AHiuNst6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com [IPv6:2607:f8b0:4864:20::1329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jS2470R6Rz2xGF
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Nov 2026 18:02:14 +1100 (AEDT)
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1370654eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 23:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794726131; x=1795330931; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WlvaTcb4vTukTns5YClT9/RRVqSRloX/GzQ0iNm2R4A=;
        b=AHiuNst6qDUkIt7s0FH6YbuoM/4+fsfUszqJFxUXTPIHkbSJQdxIbtnXDswNefm4UG
         aqq711BkC+KGNxK17I/uQPdAe9pLtNMjrMuv7DweMiiTvqZvil3Rj2FVXu8xPPtzax9P
         mAaX1g0beRT1Um+nl6H6xE92Uee9D6cLG4UYdH7nzDlYhvEXXQfyWroCD5mcvJD+D+KQ
         KIporTIM+XEumGa5OzwCa8ieh+SXSOKp3YHFEue/VY+QgM7EQG97bo78PWdCvNIK5frf
         Mn6n34bZc2ktPnCWke91OIxi+IjsFTKfI8fgPUDuXrlvTTM2NNvlA7c6ffmFwsfY3Gpm
         XpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794726131; x=1795330931;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WlvaTcb4vTukTns5YClT9/RRVqSRloX/GzQ0iNm2R4A=;
        b=pulhKv65wZjEwRElOd12YozP4l83gwT5vPLyVWKaQNNt88cijKHsLma2hO9gDB2NRX
         gTxy1hqbCev4Ntj6Xg/+IedV8o/S16fKFeCZLD9OcSF26hior40oHs1a7gwEMeEB7zjh
         MHEX9Rw5PWvlPFEIG/5xzkn8IBQ0dTWq4mlWwP5AucHYlLgRn+3AnRx0aCqENrYSO2bG
         zKKmHDnyZfDuxkDMkxrUsXmsQP0K8HNSG1rhWOnWBeFigmjHcJ+C3k3E1erJQ5eyc5Bf
         qskEZzUwsRTd8UixA58QdMAkJIDZYvnqU17RxR+pNBWR0COyjC+BZixHmR4g77PPFC25
         Q/Ww==
X-Forwarded-Encrypted: i=1; AL+hErFl1JwP16TB6+ricKuf7dKesm/TkfTemYLpZ3FmSSCNurB2iCe49pb/Qwe1WtjiOtd7+YwVtf8PD+lh8ak=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+sRHnPVqYEp4W1SVue5EdoEaZMSXClRsXheK61t/K7TDB2tq4T
	f02LXu2LcsLqsFPCW5xzQ0JDpEVlqPIdUlHNcpGZ9BWAYBeGodblqXkB
X-Gm-Gg: AYBFou1gZEeaTQZGwWSwwXCWbYuOu/hARafvVsRgzrmDX61VArXADE7QvQ2/0Gkn1B6
	vhB8pp1mhDYgX+Hm2C1aCxnZZkMOjZAfSTjU4g+U7RRNCNeF3FRQQ6+3WWjKUABXBJ8XV3mPI05
	hwA3txCIp/2fSfooQQMU7MKO1x9PYFQlOJLD/HW7oi8ys4v8qgBHaEC9p7BQIPthmiN4ikmqm4v
	0iOi+n5PXSB5J1nQ8SpgvXV1LwT6OfGc7Tkp+CVHxDF+lWFbPaE2/RaagwR34/ROekL1PZxPQhU
	ZjJW2DWyAPb/QJL/cqu9kRql5ogzaDJtMaCn+ab2zHdRqg/ADZDAOHghiCFx+9L45jyhlXwAzee
	0yMQUUHlakayKEc0Yv54ZtBfNqFgVyVZbfTzxc+yq7ufB6WlWeCbxApCLWdVV6v40SksRz+VKts
	NY/fh/YdIse+NHAgI9WgNhizJpM+icu1aNtH0Uf0P53u7vk/FOw4OfIA0GfCDT/gCiZjOPhx5PM
	XoF9CVdLaDYrY54In4gIXzNwJ1By20P6oOmr2DYsck3YLULsj21LF6Ykim2VBZmBldxUGgdbrWs
	VAcjhacUdGM+wKki81J1MymY6ZA=
X-Received: by 2002:a05:693c:88c3:10b0:36e:4aaf:6c7b with SMTP id 5a478bee46e88-3796740c786mr6920484eec.39.1794726131042;
        Sat, 14 Nov 2026 23:02:11 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563e6b6dsm40284667eec.21.2026.11.14.23.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 23:02:09 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Alejandro Colomar <alx@kernel.org>, linuxppc-dev@lists.ozlabs.org
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org,
 alx+linux-hardening@kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>, Michael Neuling
 <mikey@neuling.org>, Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
 Michael Ellerman <mpe@ellerman.id.au>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH v1] powerpc: Fix off-by-one bug
In-Reply-To: <1f7d29cebba5823400ad0bc5d95610f05f55e2d0.1794686962.git.alx@kernel.org>
Date: Sun, 15 Nov 2026 11:17:37 +0530
Message-ID: <5wxy8x3a.ritesh.list@gmail.com>
References: <1f7d29cebba5823400ad0bc5d95610f05f55e2d0.1794686962.git.alx@kernel.org>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Alejandro Colomar <alx@kernel.org> writes:

> From the surrounding similar calls, the intention seems obvious: this
> seems intended to check for a prefix.
>

Could be, however the existing code is not functionally wrong either.

I agree it would have been nicer if all three were consistent. However,
x86 handles the same parameters with exact matches, so if anything "auto"
is the one doing the right thing here :)

But making "on"/"off" exact matches on powerpc now could change
behaviour for someone passing e.g. "offline" today, so I'd rather leave
those alone too.

> However, I do not understand this code, so take my reading with a grain
> of salt.
>
> Fixes: a048a07d7f453 ("powerpc/64s: Add support for a store forwarding barrier at kernel entry/exit")

IMHO, I don't think this patch fixes anything functional. So, I don't
think it will be correct to call this as: "Fix off-by-one bug" or 
add fixes tag to it.
And so, I would suggest, we leave leave today's code as is, based on the
previous reasoning.

> Signed-off-by: Alejandro Colomar <alx@kernel.org>
> ---
>
> I found this while looking into replacing this code with calls to
> strprefix().
>

For your conversion, I think, we should keep today's behaviour as is.
Maybe streq() for "auto" and strprefix() for "on" and "off", which means
there is is nothing to change or fix.

-ritesh


