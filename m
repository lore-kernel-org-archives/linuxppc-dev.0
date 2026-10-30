Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DF7606A31D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 04:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kpR0XQDJ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jG6w75RQJz30C6;
	Fri, 30 Oct 2026 15:05:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793333159;
	cv=none; b=JSX7B3T9+H+ZcS96yQyKMS4F2v0h5ylY9pucEzVs8L0lUWpojnsaHgNegiqjBULW/tdhIh/PD87r2nPjXrSdnfGUasFCJPCZBPlQ/KQj61YQO8APklcb+7BWlEoR8lQQg0T1Jio92GUNAh0ix8GpDHJPFBeM5pzLzTdaJiNTV8i8pYke+Ed7KPNhsmju67dxJpa4N+EToEtXiKg2iy2E9MLsHe7h3qah8TeRQ9yDHtaEEyAfq63F5IrUev/CSl6zQEo1Il2QhpmD1jruMiXmI/BYSudcmFNckAASxcnTbRqLwMVa9uk1QOvqyaeoclYMQinQ/4YUm8GKV9hDOxHLpg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793333159; c=relaxed/relaxed;
	bh=9CvywPHpjrCT0zo2JhnH11M0JaZbySgNZTi9n8+NQFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImKrJOYVZwqebjVehjSx/HB6UYI8MSdTYaFW9U/x5/u6zqxtchb1pBhyL4rb3FZNhgDvkrMDMSjlT+w3C2Yz7hucLUIYoNyQ0eDEjTOTdrnbsggef4amseXtEfzKrDMdSSQ4QkmHVPAmCylX3yL4zj3qlfzB6/EbMi0X+vnj1fpsLATZhZYgpztmNRWHriggwTHW+OCDIh0FEjeBjSxnBW5u6WCQRELcAabfLAxox8QS8UCeZ/tBi/TlrVTdrgagBjkhVisgIgfZQLVSRvwycEcWJBOGj6eI/KbCwMrtlTb38Rj1QhfqD0cyD1A2h2WIklACwlTJQKw3BhMDhEk0hg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kpR0XQDJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132d; helo=mail-dy1-x132d.google.com; envelope-from=viresh.kumar@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kpR0XQDJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2607:f8b0:4864:20::132d; helo=mail-dy1-x132d.google.com; envelope-from=viresh.kumar@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132d.google.com (mail-dy1-x132d.google.com [IPv6:2607:f8b0:4864:20::132d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jG6w53W6Mz2yQH
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 15:05:55 +1100 (AEDT)
Received: by mail-dy1-x132d.google.com with SMTP id 5a478bee46e88-3514b90bb89so632144eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 21:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793333154; x=1793937954; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9CvywPHpjrCT0zo2JhnH11M0JaZbySgNZTi9n8+NQFc=;
        b=kpR0XQDJNNy80zdGGIpYiiaYzwr0O+s8eceEXTe7TCAlou5wOhksGIIRLxyTo7GYyb
         sbAc3l8YJwT18InBjMqfAtbq3T4paGg469R8OXfHLgvrTp7FQ3MFwavJby8QhAAq/cWq
         2nk0auE7h/l7SJSGb/T52QR+LMUdqf5WB0UZPfc8GpubbnA91fCCDmw0s55RbFnALm42
         tDKslUKO3cmY41hbeASP07CgpivsFOnuq3b64Yrg4h50O7YmZOPaDjjacl545ER8Wbvf
         hzm8FSBWhBllh0y5AZJu6rDEmInWye/+uP16c/4Mm6J+wW0enEp8TWYS2MvXhyTTv49Y
         SLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793333154; x=1793937954;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9CvywPHpjrCT0zo2JhnH11M0JaZbySgNZTi9n8+NQFc=;
        b=JTwteof64AqobBMa8gDRocDuz9iklHTqhxvLmKv2MAwRzkY+exzDcP9R+vshjSqkzQ
         8uWCsB/WeriVmJoha/JATeVfD8S11U77mlKWlCmfrIe9aMQvGWm+e52ddW0V7W0I6GZi
         Imkk5M7V1MZXrHu4J0vGKs1GVqBj7H6pPq5QhFKTaK1xy6oqAwFyTGVf2uV8gVzO7FzP
         nTgKfgXmZRuH/EgdB/XjmD34y25PZY6EyDTGDjr0WvoNWV8NpoIfbL0iYfChx2N1tikQ
         plFmamZhG2t4wTCrOCOitHG4AORx8SapUWYUv3CLYCxcreK4lgoRuV/HGZvEorShtbgR
         2aeA==
X-Forwarded-Encrypted: i=1; AKwUvBwsHc5pjJOqpzRjirdLCjPHv/HGSSp5gnBom0VzELIULlJfDDVPHCXTJ06fOLrjZk/jRkLZQtUZELXHLnE=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJiUaaSm4f31gD+7VnDGPpFIlhQxEyW/xo9etu2JULFF7W/rz/j
	VthiLK7TA7yFx+j1Z7aY93q7hKbjw4ceUSq7LQEZmeiTv7nNLDsg4zRhU2j5R+lOc1Y=
X-Gm-Gg: AYBFou2tHFKOF1FeetoZBYbutnJb0LfOPG+rYf740lEs6DiBRGqPecgjwUVs169MEZS
	LcZTOPOrIPAadFzk33QGLPjOHD41u/FqJWFVl46aEqw8Lw+MsH8CM4QhottLBtfitNdXM+FxQWq
	ccSbMo09Oj6iFDVK2/WAX9IQ5ENe7D2JmOURNEZ3xjd1M6zt7LG3iXAU1n4SWqP7bnQUw3uFvlD
	kgo9RBO+jh2BhhaTnP8upazKIjmx140jjZ94JnCXAYShXNZWXrQe+GtMhEssg3O8vUSrnIlSEwP
	8G335/nfbBHPCaNleeYs0hj+OVgo3Qsd0dpP9HF2zIuv3mI8ezrgmuLsR6KX9boe8flJyyJ3Rlw
	3ZbrhHxdNFJ2GNYrGrXlHmhPFifQMN7lduvTkrdxzkpE6hgxUmPDHxruAPNzNtwyJ26Zp4oV6e5
	pNVCmPs9FDqBPCFJHV2SFRMeHwtfenHqBgyPD3gqL5Mgex7gXuC+LBGWApE+2BVQLk2Z2y98CvX
	w9UGJUXPdoyRVgjDfxV9wASt/Dk4NcqojDA+VKFFbOZNRunbXAjuH0MErRwLRk9cqaMsaxR/yqU
	E+QC9fO77s/h4l2Tx8meil/Pt1dxt6o=
X-Received: by 2002:a05:7301:53cb:b0:35c:e696:2d4a with SMTP id 5a478bee46e88-36a423ea99dmr1772736eec.24.1793333153319;
        Thu, 29 Oct 2026 21:05:53 -0700 (PDT)
Received: from localhost ([122.172.82.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4291e38fsm3512579eec.15.2026.10.29.21.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 21:05:52 -0700 (PDT)
Date: Fri, 30 Oct 2026 09:35:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kees Cook <kees@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
	linux-s390@vger.kernel.org, gfs2@lists.linux.dev,
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/9] cpufreq: governor: Initialize kobj_type release
 callback statically
Message-ID: <auQXnep2xKpuNJOF@vireshk-B250M-D3H>
References: <20261027223847.652884-1-irogers@google.com>
 <20261027223847.652884-5-irogers@google.com>
 <CAJZ5v0juvZ2ZVRBkY6FxBM=NhPt9vMA3+yRugXc5u=U1jO9AXg@mail.gmail.com>
 <CAP-5=fWVZ=7-qDRODiEQzRzhpQqribv9Morj=OoAXW_6uaW2dA@mail.gmail.com>
 <CAJZ5v0i0YoOW+ueh_aZJdYVS0etuCqfrf_S0NTKzCE9_6oKxPQ@mail.gmail.com>
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
In-Reply-To: <CAJZ5v0i0YoOW+ueh_aZJdYVS0etuCqfrf_S0NTKzCE9_6oKxPQ@mail.gmail.com>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 28-10-26, 16:39, Rafael J. Wysocki (Intel) wrote:
> I'd expect the driver core to pick up the series as a whole then, so
> please feel free to add
> 
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org> # cpufreq

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

