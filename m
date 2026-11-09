Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAB1606A31C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 11:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m7xB9uTE
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNSVB2KBmz2xdb;
	Mon, 09 Nov 2026 22:38:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::532"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794224338;
	cv=none; b=fiNZRv3LrJDIsw8Ee8bZgRU74VBYT1PGTSxYHNfPIpUVktrfos0MZcvokKZeb5rp7DQSQQQFW9eBQMOFnij9lQE+k+IKwDzWRWB5pgZN6q/IPwDwNcjNol7k57gXj7AY89fW+uF6XwQ1PHoxcZD69zc31JDlTMO+Lt2gJ2kE3dty++CbqKL/2vwY7W0x/B+aXe9Vmo7DPXOKAYtFx7Qo9xr6PEYFyTagyiVRC114YYgZDsks6lzcI97O155vy/bhjVg/Z6RcpZM8AghIoyCnvsY5ID55nAy3HLHp4Af8wh0utPrfOc91l0yUkmnWvwTdzQfooPFE9AlzkxseEPaSNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794224338; c=relaxed/relaxed;
	bh=WqzI2P0ubLVIWtFBMZak1suctx0ODmadmSDnzYGG298=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cubAdl8fuVBEKf0P4++Kurw0ysb9gM7vpFS3DEIS234XaYGSU/EWQv79Xva9aC0GqLMLx/OzrpFSa0KDLTr7Cm/MTN8vtTIOsgK1SfRdWpPGfAup2b2xNpKrUv7quRMtCddHB6OYb6IvrurvrHz4OWrlPEy6VKLU+SYmpXMxhsw5CU4qWUcLk8wyhH6nvgDXj6Bs3PyIHMBYpJzqTVTruoYnPvUR9CfCcDssW3zYSf0Uy66did0225ffafUuBmwlwHpqvnBDaUldNbI7IdcQ0O3h6qaoxy0YIaNGtVzFY2UuZTuAZXflYkI19rLmJjJnLnscspn05HXAgYbTwhx8Ew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m7xB9uTE; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m7xB9uTE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNSV9215dz2xSS
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 22:38:56 +1100 (AEDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-6b5669a5100so986960a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 03:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794224333; x=1794829133; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WqzI2P0ubLVIWtFBMZak1suctx0ODmadmSDnzYGG298=;
        b=m7xB9uTEjkVv7Dl3zcspU0p3k+HrPUtL9v1VNx2shvJ9cMv8ELUndiH1C2NAgnhhbU
         16KFbtLy0MCMGxqrOQOL0Z/8wo30lG1np4yrbbmOcFazDi8Rrr6W8xF8o2HRoOY9sXNh
         pvi+mggDgiKKV2L7UuGJVQcDLBUuIO2h0nPm41EbJ24cJWpQh+Neia9QWAoA9uPlqzQH
         IJVkAtAM6ncn8yiDGx9N3MHePoQXxlx3KwXy3ynCciOl86MD/Il95wb/ES2Hu/kDVNYf
         lfmOkhOzxBEiIF6XChsllMcxMkx4V4jhvc4fRaQcd4GYqm3WiUhIk3dJ45eAPympj8vJ
         oRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794224333; x=1794829133;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WqzI2P0ubLVIWtFBMZak1suctx0ODmadmSDnzYGG298=;
        b=oWLaPOv/jc807We7nkKyDWc1V1jGv1iRCi9bHWLHK9l7i6oQfET0EPyFp1aTncxtO5
         LCy3V5Ey9gDcDAFyOEFOtn3k6yQy4M8/egcU5bxreAaz+XvKtRY4G/GRgBoAaVysiZ9H
         qRztmxD+TLWx2n0QUBOhCGnHuZsEjwm6/MdjBGgWWQNemgETvRa4ba7ro97nI+pKymP+
         gyObIPi4PtSZkuoUQFUpXwMUmlFLYIdRY1eXVzpaH2On9ZspdXE1ot5coesOUzROZfPp
         eGvfgYdzuurY9h4iTy/wfn3SwPRNS6metAkZ4l2IWvzdjYTrAhQvjO7xzFRTFW1jhklp
         pa6Q==
X-Forwarded-Encrypted: i=1; AL+hErGvzRFKuearCrGX/RjLXRiFyuEs6n/DwTV95r4gkJpnxBNZmXxwRA3MVO8QE6W6ANm18Cpar+U7XOdi16o=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/Ho7FM8+3HyhB3VLRi9AnD7AhQOp71ui+F6PtyD97+DTVUKzFg
	BecSW0FZ/QY9/a3jnu9GMbn+3XwfKKLuukkL4cm8A/Zt4wh3oqe/KR7x
X-Gm-Gg: AYBFou3TlG9mqqe8U/oiv2HtYzbRYmbJdi4qxMhGAZy9/e8PJsNV6cHd1TfERn4t5Ek
	+1kWZyY94myGiyX2Jfqxn7eAJijYtKSkO6TwfnXHou0jTq4XsoLpF0WbXhBlku2DvgScs7qXgLM
	yaoWTMumu7qmBf5UelV0AzNLSGfHaALCsmI635b7i2c0JARbufOJwYtYHcRJIFSOTjq2sUKxJln
	VIOJvJtYpXBPM0dn5qOdaDb6jbl6IxO7ITAfSbX7aR5/RAY934ojeQkgHCFv25aHyyYkd472W1J
	yxHk06QLYf4iQPqf6ThtqdI1s6K7JfFj2xQJagMWkIeYcZ0+rjXQiWxv5xP4cdtf2psMNUj83hV
	bIQyioEx4OoBpiRt/DC1lPDBWsCBuNTllP/c3R65qQtpFUuR+EmG/fYAwz92JVYqPVhr7O3zOfI
	WChIWLsySEW6Bh1S+LHa00hAalX2TDC0g3iNa2LVMsNtYJeJcWaWL3z0h26/oqZs0RnXpFn6rOq
	r72pEfIl3l4mmLUPI2a2vj2YWP8250wEoftmapW6vkTxNfP4HKe95uoXB+EtIWlAkql
X-Received: by 2002:a05:6402:3604:b0:6b5:9714:dea8 with SMTP id 4fb4d7f45d1cf-6b72249b331mr2626989a12.45.1794224332902;
        Mon, 09 Nov 2026 03:38:52 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b721ea56f2sm1479837a12.8.2026.11.09.03.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 03:38:52 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Mon, 9 Nov 2026 12:38:49 +0100
To: Wen Jiang <jiangwenxiaomi@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, catalin.marinas@arm.com,
	will@kernel.org, urezki@gmail.com, linux-mm@kvack.org,
	baohua@kernel.org, dev.jain@arm.com, ryan.roberts@arm.com,
	anshuman.khandual@arm.com, david@kernel.org, rppt@kernel.org,
	leo.yan@arm.com, xueyuan.chen21@gmail.com, chleroy@kernel.org,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	ajd@linux.ibm.com, jiangwen6@xiaomi.com,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 00/10] mm/vmalloc: Speed up ioremap, vmalloc and vmap
 with contiguous memory
Message-ID: <avGwySHgt3qCmvIG@milan>
References: <20261107134953.748622-1-jiangwenxiaomi@gmail.com>
 <20261108230842.3a77b9fe2d4bfc2a04b355a5@linux-foundation.org>
 <CAHKocdGWE9OVA5pJh33U-FYnNkUqRS0pzFt=rCwXWzY9w-QXyw@mail.gmail.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHKocdGWE9OVA5pJh33U-FYnNkUqRS0pzFt=rCwXWzY9w-QXyw@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 07:07:23PM +0800, Wen Jiang wrote:
> On Mon, 9 Nov 2026 at 15:08, Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Sat,  7 Nov 2026 21:49:43 +0800 Wen Jiang <jiangwenxiaomi@gmail.com> wrote:
> >
> > > This patchset accelerates ioremap, vmalloc, and vmap when the memory is
> > > physically fully or partially contiguous.
> >
> > Thanks.  This looks pretty mature and reviewed.  I'll add it to the
> > pipeline for linux-next testing.
> >
> > Sashiko likes it.  I'm working on a different AI review setup which
> > finds different things.  Very slowly.  I'll let you know if anything
> > interesting pops out.
> >
> > Do we have sufficient ARM review?
> >
> 
> Thanks for picking this up.
> 
> On ARM review: Dev reviewed the earlier revision in detail and
> his suggestions are folded in. Leo Yan tested the large vmap() path
> on TRBE/SPE. We'd welcome more ARM review from Ryan, Catalin
> and others.
> 
It took a while but i think it is more or less ready. All patches have
been reviewed in the v12.

--
Uladzislau Rezki

