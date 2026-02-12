Return-Path: <linuxppc-dev+bounces-16821-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D40E9E31B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Feb 2026 02:25:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fBK0F3Fcyz2xcB;
	Thu, 12 Feb 2026 13:25:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770863133;
	cv=none; b=AiGouJJwE/Zq7gEmEh9CqPq/xIzgBkjzNbR55ZiWc+xAJqwisJMya8fAmNRGanGzMN9EhHcvywAFOQv94P/v5ZgLAtLIJ3V17U6bn9jt48yNqR1XeqEWf3P62kLMTcWEbTZ//RZaeUM5HymOCne7R41bngc0G1zY+P7i6/h1flZuQcVatydk3cf1awKaivyUHifgWUvFI5bAn/7ER0tRxUzMs2Y6XtRWOzgAPBBg+KD4AKTgms08nynTpbeU+x7wMhmGRiI3cz2OF8t2aIiupiVzl05YfyAdeL0mvUl59m3F+P0ImOSfvtasSFtGfFCBA9wgYld7VxAGD0hhMYlSSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770863133; c=relaxed/relaxed;
	bh=BW+Mgpaq6SwF9hkVhCNywA9aCMpLFaTHrW15uFZTbFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Di6SjkA7+gA6Kbmwfdxhd7su26mz44e2RvgtE1ZKIhXl1VQUmxWCNPtDUE+k84SzM//GE0Vd/fXZRR7mayVaTIl1wQcv3AmKn83nPiVqmu20JQ8vOull/WWqyMdcGI6C0zeeXg6RBowFLjcjj+yTVoDfRCpnyqduRfqlAXreZylGccfzC3OV4duy4piAEeVvocKZZK460l11uUaMTcS4BgywhcjNi7F97NCtfJptIiYqLGwzWW4w+WHYJ1gkkdak95LJcvJ1JnoMOUTtaU1utrIIwboFhyPW346EGvjyK+B4eC3Yihdogckj1IONYn9Cu8jPukXpBJYTtXNK1o/EtQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K5DoyXpP; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YbagbSki; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=coxu@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K5DoyXpP;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YbagbSki;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=coxu@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fBK0C4VxNz2xHX
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Feb 2026 13:25:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770863125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BW+Mgpaq6SwF9hkVhCNywA9aCMpLFaTHrW15uFZTbFY=;
	b=K5DoyXpPysvfVRTPxJtxGLMC8QdvDKiI1awH0JfD+qpxgQI4WUKX04/Y/GpIAP8y+gfu9Z
	6eax6tD1013cF+NsClhFI9taXsZJzAGD0dBLW3Ad3Z3Cxn2sG4oB4NMTVDia5xpLG0dGei
	a/cUcNCrQeNYIcYCLDHkaQd6AvSXjmM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770863126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BW+Mgpaq6SwF9hkVhCNywA9aCMpLFaTHrW15uFZTbFY=;
	b=YbagbSkij7DQjUfPD0OwhK8/1jEqzzlSsMTPz9pDOkZlLdUBQWyAr5fwQMoVfAeTpzHfZa
	UR4Z4B/PotE6HfTpBKMp2vXmd6Jw20aPWf3S6NDPW5vhbUWUZzDHhllhAyAEbBRiCqVMOT
	m5Szj+W5m9aGEJzn7FcvIu8E1+8zKIY=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-_gf4EhBeOdqc4bPmSl7bfQ-1; Wed, 11 Feb 2026 21:25:23 -0500
X-MC-Unique: _gf4EhBeOdqc4bPmSl7bfQ-1
X-Mimecast-MFC-AGG-ID: _gf4EhBeOdqc4bPmSl7bfQ_1770863122
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8249cbbf769so577916b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2026 18:25:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770863122; x=1771467922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BW+Mgpaq6SwF9hkVhCNywA9aCMpLFaTHrW15uFZTbFY=;
        b=GaObWa5GpPox3GRwRvzkWP/+B8nD0WW+RWsDYr5+5xsk9Qz8rguN0q/LVrB68fh+Sy
         QcLsVbi5YIJRcT1wkU8+TblpxYNZfYx8DtD7JIznwoa+Wf7eq6f9+O0wLRofEN8CSGUR
         OjMO38Ij+iArtewZIojDNNS8Q/CCRnf8DeHhHrupJaYVuYDxyFPC9in+PUBPlOdrruYQ
         K2Je6pIagN9D26LkV8A+U1RS94nMARUfuvMtv893KpNuqIqkVR5p3HLIuBLKXXsPcGAv
         YsxTAo1z529k/i1BXzxHjcC62/ZiRHZSXydjP3wfk6qABXoo1Cu+0TQ1BTcX4ztDFSMg
         ZnWw==
X-Forwarded-Encrypted: i=1; AJvYcCV5xQfNbnNCblhn9syhrg9xNeKBxE/nTcSsGJOHKgwkjouMa8B+PpQLl+Qse1bwad8CAPSww9OjeaEK6bk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyFi1uYbUKIrp2j9mXkcrGPrZ2Lo0d8po/MZzaGLwmMUF0LM7pW
	WQNGPEe1V9+va7fli8xokmMqantOuXN7MkaUHNVVdEKDiBb5D6ridEhryT90+BpXdZX7IOqM8JQ
	Ky+13gqalrt+wt+xNyvuZSmX3uBlO99CJC9a8e72vbg1yY3iQ/Wz4SVhZq6y1Y0I1X1GtMYwg4C
	itzRAL
X-Gm-Gg: AZuq6aJxr7i4BBujiC3hS4a8Gy0KaoRQ9sMDNRA1UIiwRugnmyERZmKmt/anC8Z4oNX
	6GQCKx6rwQZpiGTnOzrLxj7ZXaQ4Y/wKKAMVya82LHBto1jyGTNmgZ3ZTaxvukW8IfhoE3M2ekU
	q03msJy3VH0LnVyxTg/PlrxTRw/+V5SdHLh4DFkIbc/lLP22kXhpQlSm1sF4GxchJ8zsVzx3Za4
	MDZsU+fiiZL284EkNchV7e01ZxEwvduBlOut6CXJyjePHVGl2kDXrOf5Sr3fLiWLpXYsdQ1dUQU
	0FmY2gp2KPP4XXb0udG5b/rp8EM0zWLWF859nK5wyG8EfkCt1Pf3v/ABZda8iHXihtRo3E5npSi
	gZVPOR4mYNluV
X-Received: by 2002:a05:6a00:1d84:b0:824:9451:c1ee with SMTP id d2e1a72fcca58-824b3068659mr493713b3a.55.1770863121969;
        Wed, 11 Feb 2026 18:25:21 -0800 (PST)
X-Received: by 2002:a05:6a00:1d84:b0:824:9451:c1ee with SMTP id d2e1a72fcca58-824b3068659mr493667b3a.55.1770863121385;
        Wed, 11 Feb 2026 18:25:21 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8249e8198a6sm3984873b3a.50.2026.02.11.18.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 18:25:20 -0800 (PST)
Date: Thu, 12 Feb 2026 10:22:10 +0800
From: Coiby Xu <coxu@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, oe-kbuild-all@lists.linux.dev, 
	Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>, Baoquan he <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Kairui Song <ryncsn@gmail.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Linux Memory Management List <linux-mm@kvack.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
	Thomas Staudt <tstaudt@de.ibm.com>, Sourabh Jain <sourabhjain@linux.ibm.com>, 
	Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] arm64,ppc64le/kdump: pass dm-crypt keys to kdump
 kernel
Message-ID: <aY05DpHN6QL8xQQ4@Rk>
References: <20260211082401.2407853-3-coxu@redhat.com>
 <202602120648.RgQALnnI-lkp@intel.com>
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
In-Reply-To: <202602120648.RgQALnnI-lkp@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0G05kbX87RYBR92Vgc9gD1n7ritpLxmKqpVqgVA7ryU_1770863122
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Feb 12, 2026 at 06:35:52AM +0800, kernel test robot wrote:
>Hi Coiby,
>
>kernel test robot noticed the following build errors:
>
>[auto build test ERROR on 2619c62b7ef2f463bcbbb34af122689c09855c23]
>
>url:    https://github.com/intel-lab-lkp/linux/commits/Coiby-Xu/crash_dump-dm-crypt-Don-t-print-in-arch-specific-code/20260211-162729
>base:   2619c62b7ef2f463bcbbb34af122689c09855c23
>patch link:    https://lore.kernel.org/r/20260211082401.2407853-3-coxu%40redhat.com
>patch subject: [PATCH v4 2/2] arm64,ppc64le/kdump: pass dm-crypt keys to kdump kernel
>config: powerpc64-randconfig-r111-20260212 (https://download.01.org/0day-ci/archive/20260212/202602120648.RgQALnnI-lkp@intel.com/config)
>compiler: powerpc64-linux-gcc (GCC) 11.5.0
>reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260212/202602120648.RgQALnnI-lkp@intel.com/reproduce)
>
>If you fix the issue in a separate patch/commit (i.e. not just a new version of
>the same patch/commit), kindly add following tags
>| Reported-by: kernel test robot <lkp@intel.com>
>| Closes: https://lore.kernel.org/oe-kbuild-all/202602120648.RgQALnnI-lkp@intel.com/
>
>All errors (new ones prefixed by >>):
>
>   arch/powerpc/kexec/elf_64.c: In function 'elf64_load':
>>> arch/powerpc/kexec/elf_64.c:82:23: error: implicit declaration of function 'crash_load_dm_crypt_keys' [-Werror=implicit-function-declaration]
>      82 |                 ret = crash_load_dm_crypt_keys(image);
>         |                       ^~~~~~~~~~~~~~~~~~~~~~~~
>   cc1: some warnings being treated as errors

Thanks for reporting this issue. I'll fix this issue in new patch set.

-- 
Best regards,
Coiby


