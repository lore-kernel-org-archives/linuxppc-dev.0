Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEFB606A331
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 08:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ta9ohRgJ;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ta9ohRgJ;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ta9ohRgJ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPcCz6wm7z2y2h;
	Wed, 11 Nov 2026 19:30:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794385839;
	cv=none; b=A8MnrHUPjQSEA2WRdLSgEBOHis1kjzsKOstIJU1oHJFe+T7bqrxv/aaarn5P9aDNSgmVMbMxgSINo6oPqYumJ1l274Kt0BYB7F/Ar9rd/vzNZfGThQ+yRhw1Awby/YcxjilktMLdXKfj9PXC5ZsaEgx4xt/rvtfeWJt5GCRBc0z8+EK071QoRYBje4fuxPS9TrkAFtmzLOrRgZ4dpFgb/zHVzScLZXy6vlN81EnGA247u6gTmmkecTbBqAQ6rBtxJD4XaIPx925xc2YhhGSfHErb/RmAZYa5O6qFjtW5LkLiKuPmRmZ48CMn7eugK3og+yK6uU1CFzb3D1GVyg2Zag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794385839; c=relaxed/relaxed;
	bh=mpfsiWos8F/vl9UH8UsPq3EZ0RisGA+Dhf9KlrFQ204=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZVdi5HlPv5V98oyOeb21e8X7KChH1TqvV44NbnNvNwHqiR4l5qUjdpHIOcvmT9soSWaOf6iz6moqqHqnP+ozSce9pI5YhK7eTu/UBSwTmZMq7C7s8n/UrLGARyYSkMH8QPAiAb6SaACB3qHYqUilVooY3hupsSEkoxL1p3b76lqX0+6g5fWnafDVywOmAWb9mydo/b/tMPGASUOZV4RojONSdKTTFsNHiVaFyFM9hIws/bJvp5go6qdAGyeZewIIZCrlneW10qYMqLNpKgC5iFV0BmYPTgyDDdgOYwZ2PR588iJOVz+izhtimsI0D7b7LNmd+z4ARTIPwGN7DSfoHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ta9ohRgJ; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ta9ohRgJ; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ta9ohRgJ; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ta9ohRgJ;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ta9ohRgJ;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ta9ohRgJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPcCy0kyjz2xKQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 19:30:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794385833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mpfsiWos8F/vl9UH8UsPq3EZ0RisGA+Dhf9KlrFQ204=;
	b=Ta9ohRgJTa3g8zg+MOkNRM6p380ZaXf7a1MZHKT+SL1m4PbmiS7xGUUXEdFNvxPnY+cpMv
	8ciw8jVgEdjFQBW8l3aH0GqgVR3A0TqfXTB0mc7swf7YRiBlL7s0Zaeie7+6mtQL/oX4Wu
	X1zaj56v9fx7dYn9Y6+ZFkW//5iVGCI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794385833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mpfsiWos8F/vl9UH8UsPq3EZ0RisGA+Dhf9KlrFQ204=;
	b=Ta9ohRgJTa3g8zg+MOkNRM6p380ZaXf7a1MZHKT+SL1m4PbmiS7xGUUXEdFNvxPnY+cpMv
	8ciw8jVgEdjFQBW8l3aH0GqgVR3A0TqfXTB0mc7swf7YRiBlL7s0Zaeie7+6mtQL/oX4Wu
	X1zaj56v9fx7dYn9Y6+ZFkW//5iVGCI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794385833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mpfsiWos8F/vl9UH8UsPq3EZ0RisGA+Dhf9KlrFQ204=;
	b=Ta9ohRgJTa3g8zg+MOkNRM6p380ZaXf7a1MZHKT+SL1m4PbmiS7xGUUXEdFNvxPnY+cpMv
	8ciw8jVgEdjFQBW8l3aH0GqgVR3A0TqfXTB0mc7swf7YRiBlL7s0Zaeie7+6mtQL/oX4Wu
	X1zaj56v9fx7dYn9Y6+ZFkW//5iVGCI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-bgXIAbduMt-1PiQlG4l-tA-1; Wed, 11 Nov 2026 03:30:31 -0500
X-MC-Unique: bgXIAbduMt-1PiQlG4l-tA-1
X-Mimecast-MFC-AGG-ID: bgXIAbduMt-1PiQlG4l-tA_1794385830
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4ad3d35e899so23757755e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 00:30:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794385830; x=1794990630;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mpfsiWos8F/vl9UH8UsPq3EZ0RisGA+Dhf9KlrFQ204=;
        b=0QDc7PFJZoSTqqasgwCaACx6JPJplPTZOP9SMZy7ko5v6Zhk5aHkYF7ub0xuc+vNKy
         32rRcpqZg6PWAoHmGS6+A6oEAq+QQzykhkM8xgnPQD9KWU97drzk6HuLtwj2KzuEhGjE
         li4UTJBnPEyyvMW5gEBTDTvtYDwu3peiTY8FU0wfUDehRysRxpVlck+56/eEwdDkdA30
         qZRsR9qbpNOmBdRYSR20+itQeSmKSN+I2wkIJvPjKr64Ec7ZwoZj52jIh+vM4S5M+Osh
         JwR94oa5TQ0t3fDVpo6e2K91781xsVIC3d1dZ34fW+GEu3nc4qU11qohhbWivik3uUZP
         AyAg==
X-Gm-Message-State: APuU4Z+boHa4W40+XVylmGXBei2nURCXh8AqNYqiK35jKaT+ob7lRupT
	H/9tvUXdQRu1210TUSUQbRm5eJFfB9SP8tw+LTh+RA9Vp46ssQvdgLU6cYk6eqnjC7w7i3VYMNF
	ekwubZFmTnsmGx0Pv02GK4FA7a/7sGNINcrivfl6clCBqTSU495ohzqLc2mGeFv4JX2Y=
X-Gm-Gg: AYBFou1ilpFB552qGBvIuqj+LB0mcz+geYMjNfd2pmEkQlYm2GysCihVsf6t9YVoUHn
	fmRZPn4ESpmzsPQaq+JzayxXTPZ/Gp1MWSr1rMWpombgkJoMMXckVPudIqjlb+ZhFBhQTHnWNNc
	8XWOI2JoyVVYQML1w01ebKXqOImViRGXG1jksQyFtEPCeEajR04ND2+nEQ84cF3p5xrcig1auY3
	nWrYAaj5ga6gsAVBonwXPoOVdCH5QBhDDY6V/wQqt6f1c5ShVsynpEFTZH0g7o6sMuen9mF5pZm
	1GzRtoBFcgNA0YuWTwU+u9fjPAs+MCMroM4QIz66+NhdhKxKVlbQF5r5R+z62SR5HwZpjb9UiUy
	JsdSqbR0EecTo+So2gyYZrkpl16+hKUqZLKTFH4XpNKCP
X-Received: by 2002:a05:600c:3554:b0:4a5:e6fd:65e5 with SMTP id 5b1f17b1804b1-4ba0937ded6mr26339985e9.31.1794385829959;
        Wed, 11 Nov 2026 00:30:29 -0800 (PST)
X-Received: by 2002:a05:600c:3554:b0:4a5:e6fd:65e5 with SMTP id 5b1f17b1804b1-4ba0937ded6mr26339535e9.31.1794385829582;
        Wed, 11 Nov 2026 00:30:29 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0951f237sm26744945e9.4.2026.11.11.00.30.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 00:30:28 -0800 (PST)
Message-ID: <620ad58f-50ed-4b0b-9d13-b4df34276448@redhat.com>
Date: Wed, 11 Nov 2026 09:30:26 +0100
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc: Link with -z notext
To: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261110154415.46220-1-amachhiw@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20261110154415.46220-1-amachhiw@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3M6uCcNsMg0lb1FjwUGKTKaBBESJFPvCehRQTpZHo5A_1794385830
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 10.11.26 um 16:44 schrieb Amit Machhiwal:
> Building the powerpc tests with GNU ld 2.46.1 fails when linking the
> test binaries:
> 
>    /usr/bin/ld.bfd: error: read-only segment has dynamic relocations
> 
> The tests are linked with -pie and relocate themselves at boot (see
> relocate() in powerpc/reloc64.c, called from powerpc/cstart64.S).
> Newer GNU ld rejects relocations in read-only segments by default.  The
> Makefile already checks after linking that only R_PPC64_RELATIVE
> relocations are present.
> 
> Fix this by adding `-z notext` to the powerpc linker flags, as was done
> for arm64 in commit 5d67db4e1860 ("arm64: Link with -z notext").
> 
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>   powerpc/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/powerpc/Makefile b/powerpc/Makefile
> index 41e752b070bc..35fe58835726 100644
> --- a/powerpc/Makefile
> +++ b/powerpc/Makefile
> @@ -78,7 +78,7 @@ include $(SRCDIR)/scripts/asm-offsets.mak
>   
>   FLATLIBS = $(libcflat) $(LIBFDT_archive)
>   %.elf: CFLAGS += $(arch_CFLAGS)
> -%.elf: LDFLAGS += $(arch_LDFLAGS) -pie -n
> +%.elf: LDFLAGS += $(arch_LDFLAGS) -pie -n -z notext
>   %.elf: %.o $(FLATLIBS) $(SRCDIR)/powerpc/flat.lds $(cstart.o) $(reloc.o) %.aux.o
>   	$(LD) $(LDFLAGS) -o $@ \
>   		-T $(SRCDIR)/powerpc/flat.lds --build-id=none \
Another thought: Why are we only using -pie for the LDFLAGS, but we rather 
seem to compile with -fno-pic in the CFLAGS? That looks weird ... I guess 
the -fno-pic is required for certain targets (s390x and the non-EFI builds 
of the other targets?), but maybe we should only add it only where it is 
required and compile the targets that have relocation code with -fpie in the 
CFLAGS instead?

  Thomas


