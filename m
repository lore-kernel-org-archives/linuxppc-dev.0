Return-Path: <linuxppc-dev+bounces-28976-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB71CA5FED
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2026 21:45:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzqYv0Mssz2yjN;
	Wed, 07 Oct 2026 08:45:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1233" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791312144;
	cv=pass; b=RGJtufsbg5xjd9VH0C86EvIlsURiBpeubxvY3BaTmiLCO05xhg088mrUI5ZxPVkCxy0sydJ4dPu38YKSjCqOb5/j+cbyRX6RfJ2d60ZSuYtRtwzN42qeOd28fn+8eU3pLMliOkua5VUVgKmJC0WSh6cb+hO/ZI5JhNF2VdKIU5YWW64t/6L4RrtNZbNRVK4BhLOZEud41D//VQCJRRouwnS0msnzUNjQNfokLstnFVVLIK36vTdvSFK6aw+Cnx8rdBQ9gFLthJF9Lj+tG+bbl4RLTPQAtn0X0lbF07IXiyUjTXII5u4Pq6HYxiq0ySF9IJh9KY2/vvbd+4jb4vjwqQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791312144; c=relaxed/relaxed;
	bh=PXeSyA61cP/YG1W7o5p7MScoynhww5ruZfkO1uzVkSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HOMk9JuBwx15TjGH6hEhnCcMjhXP1bXP3dF8aCaykoznV+0l8YJERJFmW4bKcVIxxhTGIbQYoYCLDUoP4JXs8vnUQAGCkYpkf0s89t9blwnWeW5MZJyIAwgfM1LC9gEMfQhRp4FC6lbbpC97DL+1TuH/5M9johLxi7o5NTTYjSFNgjHNOptcrawTkATeZY1V5G9uOmbwWcCNf0LgYniy7e/2NozFZjuFZfRTxfMCmBV7Lqcfpwon1cgfcBo6rMz2ht3Dis2GG0C7EAAfZza6DN2KtVi3KVs4avDfrz9VBA4ooEkKMqW2we5szUDPClmAlWSc02VJhC5KyQqfsWxzYg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ai7kOTaS; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1233; helo=mail-dl1-x1233.google.com; envelope-from=jrhilke@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ai7kOTaS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::1233; helo=mail-dl1-x1233.google.com; envelope-from=jrhilke@google.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1233.google.com (mail-dl1-x1233.google.com [IPv6:2607:f8b0:4864:20::1233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzlVS2M9Cz30St
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Oct 2026 05:42:24 +1100 (AEDT)
Received: by mail-dl1-x1233.google.com with SMTP id a92af1059eb24-150ef97e790so2132c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 11:42:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791312142; cv=none;
        d=google.com; s=arc-20260327;
        b=rd0CeforOOxTcJlsJ2YI0N2K34x3Y9YmOS2IojPFr0eGfRT1AXkgf1cb7+gDwBOsh4
         wWE5MBsW0q3vj5C9fuXTIks7GMRvCT8bvp/NiD8L1yhbep9cKd5Jie0Z2S9YZQEs27Ud
         1SHOxB48vM5I07R4DGXJOP1WVORABLHWLLgkIR8EHqTEwFSLWDiTyTlZi5iieQUYHQ62
         Ed89AOfz4668D3jaw0ftK271XnGC4imlWiT9TMyfi9Nj+zVP67CFFjISb+JykZ7m/8Cv
         qnvGvPF8CHNGZSSADGKbjBRh2vyN1p9/SLBlYFmSV86HT1P/STNSSiDMWypBsQWsJe+A
         a2vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PXeSyA61cP/YG1W7o5p7MScoynhww5ruZfkO1uzVkSM=;
        fh=D1z9zIsBhfkb758u20Cr2fFqmwHgrvoqiRGnNScjaZo=;
        b=RssB9JAjOEFIH0Hhy+S/B12nhmYCcWtXMyWUgeJZPQuCfZKhnrhvB8W8uk633zglOy
         Y2F07fMs2OW+iPxQmbCL2FuaQPzF5yhCoxItLDIGQB3OoMU51ukmF4JkyWr9kMZjWOEz
         wcVkWopZGzxqop8+3PoYoGNEc/zloe+iw4tfgQqTMLLYssAlM/Jd2gg/I4Iw+/bLnLJS
         kzSe8M1gYugKpX3FqPPvhaQ5548G+7QVkGoKj7BfSMhe/U3zDP4bdnO6/kietlVt1kZ5
         HkwiDct2EgfPfa7j79N+euPxZWWb8WHeyz4r5+JXC59mK0quCbPXfUA8sVJFwhIf3j3X
         NBAQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791312142; x=1791916942; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PXeSyA61cP/YG1W7o5p7MScoynhww5ruZfkO1uzVkSM=;
        b=ai7kOTaSPfeBjcSjwdcFf7dn13TVicaQzjhjFTXVmeMfu2lhyebx5Fi4WYYSCOpjbn
         Aw9rx+H/AkXYh9kpFVn52eOJWCIrPQAcaT+A4I8bzhNgXyffKRoeHHeuTeY+X5UTMMy2
         JiOc4WUZZ7NQt5i/uPw6/2+BfDHwra/oD3z5FTly4Rx43D8g6uIay1J3hRQp2jZ1J/NI
         B3Q/Mjy/q4z6a1I/s+1RO7EpvjlZQh7HPeUGoZ+NRbwFUehaIgwHx/RjcOjVLhh9kvEI
         ji9jCERV5bHD313rpxonHs9LBBAqA9TD5QGlL8HHHiJpgPMV4WBkeG1mNIZslpi90Y2b
         JjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791312142; x=1791916942;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PXeSyA61cP/YG1W7o5p7MScoynhww5ruZfkO1uzVkSM=;
        b=WxRd39e1lHKlRrqG815VYfMSv3nTyUMsi/YM2JLiyw8343QlfcHkObxtDh8pOo9hGO
         9pDePmLTjczfO9SZDb4QKBeoqIvfccAjvrbK2+x0KuuHqQS7NHLrwDvbET2DtrJgY0re
         e+oXWSpZS3Tv5Y4lIGGtcVo9xhvty+JXWSZP9O32pgQXTKam70W9XoSvAiYOTk4At5lC
         8TkXpvxrexBLV33nvDlzTbEGxFBiCjIy4RB84oePj3tfZNSawK2xJm0pVU9+424yqlQv
         LsCFY9V26v+RC9Wm6oggBOVN4WOovV8IjfLnAJRnXUVrvH4YZG3vrF1YD0c1Gybi+Py5
         QUmw==
X-Forwarded-Encrypted: i=1; AKwUvBxsdqG+RO19Us/ofUNdYqzD32KUrt60oEy/qIcCi1htZ4J1JUFAWKjvcnpfqJ20zGb1pn9+pokPhgGgwHc=@lists.ozlabs.org
X-Gm-Message-State: AFuF++n8JEs2JMQUR1ps/EYLfNUDDn8jYY0VdGIMhkJzKTW9F9C7dIO2
	SM5CLgfLLUr+D1z9zHFKdI47JVZ/O/Zy0PznJc2uj1O0/vbodrHTKKUl8yVSUOOTXjzPDaI5zz3
	Po5GKpHapPQydPPIUJ2DgAyYMch0NonotwEdRY7k=
X-Gm-Gg: AYBFou1WelLp+ZFYfgXqgDtc6tBn5QlY+1k8RjfruPh3SVx10yhJzR/gQmTAHH5wvfS
	KGgty/ub14FwzEtbX9VSt8GjSexq8xCMPrmpUSqqX3oPIG2/y9q0LICXTxd+7S0OJ3nrqoY4URb
	gdblkCajJKkHFpJ3Usv52nHdl9O5p/XOxWG+gaNjEZ3IbjpUtIb/4onFAsL5gy6qwfpVMskT5No
	pYsaUSgn+1okMXNlkWGy7P1dPJMANHof210AExJ/nxX7Wrkp/S1nycZSByXHFQNexD+keOltnLF
	IVFPLs5nsEQSFUMa/fUoAwgAhvFUJH5s1DWyxWwQRJglk0Qizg9yO36fwtoqcXv0H8RKUsuy2b4
	vr4ItUzOTTeUeGd3Le+t0UKlhhtBtEehNkHq0Xg==
X-Received: by 2002:a05:701b:2518:b0:14e:e4bf:7974 with SMTP id
 a92af1059eb24-15d7ab090dbmr488934c88.4.1791312136400; Tue, 06 Oct 2026
 11:42:16 -0700 (PDT)
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
References: <20260924173501.856380-1-dmatlack@google.com> <20260924173501.856380-14-dmatlack@google.com>
In-Reply-To: <20260924173501.856380-14-dmatlack@google.com>
From: Josh Hilke <jrhilke@google.com>
Date: Tue, 6 Oct 2026 11:42:04 -0700
X-Gm-Features: AclHuK9yzmvKK8dZq9avpOj6F6GskJ-F_IbrwE7g9TDd8JjXbHVrXV8aJ-JhauA
Message-ID: <CAAdrzjs1JkKJwcim7czNHAoq-u+AEGqgynNzmnbxq6Xk3LJCfg@mail.gmail.com>
Subject: Re: [PATCH 13/15] PCI/VC: Save VC state in the saved capability store
To: David Matlack <dmatlack@google.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Lukas Wunner <lukas@wunner.de>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 24, 2026 at 10:34 AM David Matlack <dmatlack@google.com> wrote:
>
> -     pci_allocate_vc_save_buffers(dev);
> +     pci_vc_reserve_saved_caps(dev);
>  }

Nit: after this patch pci_allocate_cap_save_buffers() no
longer allocates anything, so the rename to pci_reserve_saved_caps()
could move here from patch 15.

- Josh Hilke

