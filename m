Return-Path: <linuxppc-dev+bounces-17906-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FB8F417E5
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Mar 2026 14:30:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fTztd4q63z309P;
	Tue, 10 Mar 2026 01:30:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::736"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773066601;
	cv=none; b=Yn/q+tSX4uFUq12sqUYiDbHFzozTpbabhn0bX0pBMhA4HZ0ZNCJo+zq/CkTaQLBpLAJI2W65eNxuJTC+05ePe9idIRLdTm9OOg9+wHc9qiMZLzICCicfGL2NhM5I2BdqapVSQ6sYDoVoS9F5HGxqu0UoMJEf/oeu7VSmnsGMcIU4SX1uk+fyy87bLlISIZiql2e1tX/QFOoQY8ZcA9QSAEIMUYnFiBs0RTh6rVmoGgMBTOcNB7NtJtg6flyh7kzvXiVhlTaaReybIR3NTzpeaSa/G8FhU3t8oVWTztIW5DA7O3SCkRk7dk5vchN2I3rKRnECF3EdCdZbEXiAw1Z4qA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773066601; c=relaxed/relaxed;
	bh=0bCgFz4UpYVbBeKSYmRS1UHS00xtZH8a/t+DzU0dS+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fd91CHQgskBJ9eFRzr0ua4DXNS6XawKkLErynPSa2BL0tCg5+WXma3pMUlQfNEPn+40hR+YFU4Ml6h+qFjvUUHMJwHVhzDKc/bMqAOZOK3PeISTppMLAds5tLTYBrrfDXS/J86ihC686Rgf5MGYx0pyPyuS9WUMKzTRhT2C9G56dCGpNJmiXgLZ7qIXySKF+trCUajIqAa04vn1D3WdpEgdhFTaGDNy61S8rrm5N7w6D8R7hl+MPX1Z8AoPuKK8sapHwX/qKBRHgbH3g6uAw+Du/P5HNwKQVE6XEMbWGcVSbD1HlePrL5SUimSQZZhTD89zxS/RKGKrfg9w8T9mn2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Ov0EHpUR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::736; helo=mail-qk1-x736.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Ov0EHpUR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::736; helo=mail-qk1-x736.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fTztb5zZFz2ySb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 01:29:59 +1100 (AEDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-8cd847b4b23so132432785a.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Mar 2026 07:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773066596; x=1773671396; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0bCgFz4UpYVbBeKSYmRS1UHS00xtZH8a/t+DzU0dS+U=;
        b=Ov0EHpURpht8NCSBk9Xz1ECA19x6LYMc3T35Em6tsIkqOL3oo389Q2ZxqJ+pGxwvTB
         mIxgxIWKYJe94U5D59Kga0QJAhCGZFVdmU3N72j7kFN0XrXyKjpZm4iayZS+JxdSBj7A
         X/APmYOb0/4j9j3ronv5J1oPy0Lu2o9CrNNeHn2Wbp/7L3FyS9p63wnOA0tnSQoTGdP9
         V+3V8bH1v7rcNwLgwMzISdwonACY0bdXNPCJZoxZAX5fAvE1vTZj7kweeYPvfIrRT33p
         E5ugrgleyJIjUDWwHlzCw7sL6PtGfgMOoVwytgay51zicC3GuuxRf2ZInggxFyggZhnW
         IZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066596; x=1773671396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bCgFz4UpYVbBeKSYmRS1UHS00xtZH8a/t+DzU0dS+U=;
        b=g0Cb9UWhvf5DobQ4R4uoXG8M+xepcrJJ8t5EdZCqqZgR0pnoevxvzsHJytKfd8j2xs
         /DNiZwPzsCB9nLII21u8NbK8dTcuwX9wIWNmYtCsuET5JQpk6kSWPz5oTwmma+49UmLy
         7qE7RFQLmYTwY3kKsCGRdfZ5AwxcoOB4UA3OA3zyRboguvztxUuhSiZNMuXX3C1pr/1f
         zgjMBJlrFFheA2wRZBaT3KFlTBwNcBcp4BVwqyPwI7EV/ac85ITsneEt7c1s4gfxN4Qk
         TDUCKnp+0lAeUWmPKDGMe9D8CH2mVF91c7C+3y3GRPfiuowIYZ1uPck1zz6EBljJxxLd
         09ng==
X-Forwarded-Encrypted: i=1; AJvYcCWI22/tmr0lyCtYWhiPxK9JdCu3D3Q3w+Qzau7qUsvKHiuSIXxlLC5oiGPYsP3LgE4FW4twQYcFNa9EvFw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyJF4u7HIfS0laZbmlkj7gSMVRfiVNST+tr+d1xGgERvn6DCNU7
	9PZiGCf4xQDorSU7MxLlNl7mYOtlZIRvyydR/0hecMWrOOLcmVC6Ohml8pTcd4IQXVI=
X-Gm-Gg: ATEYQzxRGzV0YHAoF8smr45aieCI3UzaYp+frJaePkqWidfpex7TdoAzCcDqov7wpGd
	dvQVmQ6gxV6TXi7Sxs9QeSU/ydrPOUL1ftIOuAg1Flz+wb0w3A0dk3bjFbs9ZuNJPf51cgB8nDm
	y690hWI321sGmpAH4GF8pvll86Y6VKrFB1JU2TvJ0QoBbU4H5usGTa05ZjPmRX93jyYYOUUFcgM
	UPuN8rf8qmoFhVTI0DjKMGUFlFfMTIzq3SnKe0vIyB58rd4HPQHRdCIuCx+KC08GvD+e1HqEcNt
	6XFAoAKeP7SZuk2gm/gTpfq4rcRQW6ra+F7HdOfi7AYJfFOZFoFH2yGntXpgQ1iDrU5KLb1CPTj
	eht+Y5kWZW2s0PKJLm8bcLAXFt7vQFWKKOXrMX2jumie+BJCeY+5iuRVi6Ew9qyY2T/4LG3D2A+
	pYZMuEJuxsOmbXkAXjstqHEkhHkmCcPDQ5S95DBPjsoGfDzfDmIhqZywnwj6dCKRgqmwYI4kdUI
	U1gwrXJ
X-Received: by 2002:a05:620a:4809:b0:8ca:305b:749b with SMTP id af79cd13be357-8cd6d4d5456mr1426307785a.60.1773066595964;
        Mon, 09 Mar 2026 07:29:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd8d4cad48sm148711185a.33.2026.03.09.07.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:29:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vzbcI-0000000GTxY-2R0b;
	Mon, 09 Mar 2026 11:29:54 -0300
Date: Mon, 9 Mar 2026 11:29:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	"linux-mm @ kvack . org" <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>, Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Leon Romanovsky <leon@kernel.org>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-sgx@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v1 16/16] mm/memory: support VM_MIXEDMAP in
 zap_special_vma_range()
Message-ID: <20260309142954.GM1687929@ziepe.ca>
References: <20260227200848.114019-1-david@kernel.org>
 <20260227200848.114019-17-david@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227200848.114019-17-david@kernel.org>

On Fri, Feb 27, 2026 at 09:08:47PM +0100, David Hildenbrand (Arm) wrote:
> There is demand for also zapping page table entries by drivers in
> VM_MIXEDMAP VMAs[1].
> 
> Nothing really speaks against supporting VM_MIXEDMAP for driver use. We
> just don't want arbitrary drivers to zap in ordinary (non-special) VMAs.
> 
> [1] https://lore.kernel.org/r/aYSKyr7StGpGKNqW@google.com

Are we sure about this?

This whole function seems like a hack to support drivers that are not
using an address_space.

I say that as one of the five driver authors who have made this
mistake.

The locking to safely use this function is really hard to do properly,
IDK if binder can shift to use address_space ??

Jason

