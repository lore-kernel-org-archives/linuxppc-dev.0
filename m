Return-Path: <linuxppc-dev+bounces-18054-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1887106286D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 12:04:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fW8Yj4hcpz3cFG;
	Wed, 11 Mar 2026 23:04:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f2a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773230665;
	cv=none; b=C4GOc2RMFJ6ktUpttWXnVi4/KPgM1Cp/TaUDl1GGc/+0QpImqeQmyLxejqxflmdeFdiuCywF5JVTyi+Dowdts4R3cAKfNL6mQXJsJd/2aky6ESZv06j9gmvTbLIImY1IXVqwsq2Pl2wXvNjyvvAmy5Jjjludgw7rhdE5vOIfiYHcOQu6IO3NhWnariEddOXE055M7rFHplrbxaVtctEfmzwjZWyyXKMyB/kfmDgEjTgytPgFZ0Ek6/sQA8gLkFxU363CL4ZV+reG0mz6jOwxYgQJNcsvH/0tepl1R9+3TSYuSOgd3b/zaXXdnqtCAs26yu9VRzwHHwidGz0hjfT2kw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773230665; c=relaxed/relaxed;
	bh=s5EMe7bYHKODG/rm1X+QIPDr4bQTLFjKqTjmSxuIYLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4BQ5rIwFrVLT2XieXuZENZp7EmUSgCvDqsLbDx9iY/7YcQ9rZJ8UidpKcbmNjCCrDpNvUN/Towzm9QFaYqeet/rP++MglENyUC6AAYAxvT9/3H44eGDBkuuZ1PmXo8caYZ/cW3y7fSigVM1ZaDnTsjobHG2DpAKLNPVY/S3ULT2D0/BINtte4Ry3wYE0OmMPSZpf5YbWwyYMtS5tjKfieXUAOP2BJ913R8zkBFYiA575S8DugZx0daAZJ8ik5sgamxUBWePKVvb5OlhBveCehYV2fR6nNeJTZclasyDABjmOHFRcWfwWuOSBczsZ6Zwr6ClW5KrIJBppEU161ZzaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=I3EkCtFN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f2a; helo=mail-qv1-xf2a.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=I3EkCtFN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::f2a; helo=mail-qv1-xf2a.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fW8Yg6BNZz3cF6
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 23:04:22 +1100 (AEDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-89a6ac6f389so5815046d6.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 05:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773230661; x=1773835461; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s5EMe7bYHKODG/rm1X+QIPDr4bQTLFjKqTjmSxuIYLA=;
        b=I3EkCtFNG4y1F12XTmEvooKLNdyxOH8ZKk/+B4vju0NLS97zEdDtM+llnOf0GCykFO
         3MU2GDQNED4stIHrU6FWySsaoqrgwIp68oI9hG5MxnVUgGDxWHsuiOTD4PMPOvBXnUGT
         0B800y3Hj+siVi8AYGnBJWbajPpIsae56UBFLGNJfCgo16js+XLOKJXvbXkmvA8xtM3p
         ZIleNDJkX0FO9/6iP5gYNqeBOO3hfXbqP5vp9Dal64lBp+4NCourWRv0YbQjfsK89s6Z
         JZ+Jt7pO6F/4ZkPklCreLb/79bBVR5neIMPIw6xxUYav7dDf/xFO6GOoBQjGtdZoCfhX
         VynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773230661; x=1773835461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5EMe7bYHKODG/rm1X+QIPDr4bQTLFjKqTjmSxuIYLA=;
        b=ffWmNSzz9YOpKKt9HjbNFLJXcgsSXmZl0mgI+9NJtdoD4V0FGQmn6S3tJuySWqdFB8
         RxvWkx1+iXNBemix9Lnbus6TUdIMgKnLdnOEKHpgHVJwVQI+CkUMwRJJ5gaCGRps3LQ7
         oHp5X95VM038WA0ACcM2OVbj4Y0zW1f/WiyT8Kggr+ZNJ3EICk124y48XdkVCzAE7PxN
         VszixgUS2ew7HOxm87kxEo3gdhQHpfWZ7zA29RbwKF/arAKOxhY/0WzhuHlSS8i8c15+
         2WcuTCg7qighJ3wcFODTX/6ERxpzedke0X19nfmkp/ScbUsCKG1dtPCKb6e1vz82ZrQh
         kvWg==
X-Forwarded-Encrypted: i=1; AJvYcCWB07Q1eBCi4e0QyRedBiqNl61FI/sxpGrL03NqSGr9tgqa6x/D6bhacU+o4BcngaCWAY+3JiYlr1tYOgs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yze1izkbh9ClcHXTB8a8i7UU2vBryuJI/YHX0yGnwYNcr2jfFcD
	eqdvXAe0W+/FekyB8aF8o+IoeU87XBsS8vPgRHeqmsvfcAdKcDwBFrxA+fE8t1NA4dI=
X-Gm-Gg: ATEYQzzy62ogxYx1pyIg32YdlbWkviDC3cx9mAul6fJ2eRfGXGPZ0iqFN9mcCfzYH0Q
	/n6G8ichi0aYduilqmvmbUS1WtlS2+VZXB6WiPc0MmPws7bH0jTw9RUMdOfSf3HVsR79eNfalJ2
	mDY6Ac7IgMoUjONV7uBnQUn4Ot5hPcEd9F37cLx9I7R4WymdK8did1kTgGhxC1JbI/uItLMm7U2
	OduBHNsMGunhtaso4V5mNZFyuSGdK4KEboqdCl3l2KxmqcV1BIjnuLil3Jy5OFJP29+gFobP6Ek
	JAwQA76qgDMQYhFbhOddhwAD6ALcFsrUjIafuFxldUXctKkdrNy+oVVFDnZeGoX1Wq5CfFvYuyo
	GmK1aCnc8gnJpBqQWMsGTTt2D9nbUg5wC4Y7k1ABPiBufuuhU03IXndPcD9uCLzU4l0RRM9fpXG
	NFi7xS0YMu2R/g/WSY8PdlBiYCO7iI5lPH1u98MwSubwItGzYaaXi3Ab8Q8j8w9vfPcRVCGaaCG
	VNPA6gT60PnxqnX/WI=
X-Received: by 2002:a05:6214:f2d:b0:899:fd8c:55c6 with SMTP id 6a1803df08f44-89a66a5858dmr29432376d6.23.1773230660563;
        Wed, 11 Mar 2026 05:04:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65d17023sm12745086d6.49.2026.03.11.05.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 05:04:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w0IIU-000000069iv-3jx0;
	Wed, 11 Mar 2026 09:04:18 -0300
Date: Wed, 11 Mar 2026 09:04:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alice Ryhl <aliceryhl@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	linux-kernel@vger.kernel.org,
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
Message-ID: <20260311120418.GU1687929@ziepe.ca>
References: <20260227200848.114019-1-david@kernel.org>
 <20260227200848.114019-17-david@kernel.org>
 <20260309142954.GM1687929@ziepe.ca>
 <61df6369-333c-430a-bd18-c5b1acae68ea@kernel.org>
 <abE4JYo223OxWCBQ@google.com>
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
In-Reply-To: <abE4JYo223OxWCBQ@google.com>

On Wed, Mar 11, 2026 at 09:38:45AM +0000, Alice Ryhl wrote:
> It doesn't really make sense to have multiple binder VMAs. What happens
> with Rust Binder is that process A is receiving transactions and has the
> VMA mapped once.

IIRC the problem is the kernel doesn't guarentee singleton VMAs,
userspace can always clone them with fork or something. Did binder
solve this somehow?

Since you can't assume there is only one VMA the locking becomes a
mess to cover all the cases where userspace can trigger a VMA clone.

address space deals with this internally.

Thus, zap_special_vma_range() is extremely hard to use.

Jason

