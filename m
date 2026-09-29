Return-Path: <linuxppc-dev+bounces-28507-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1193CA5FB1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 15:59:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvNCc1t40z30WJ;
	Wed, 30 Sep 2026 01:59:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790697564;
	cv=none; b=FMse0F6lcPBeUa8PblMpMMr89tSnHgrx0raKVXYWtuLUPw646U+wSzWg6dwxBYQOzaW1IB8J3hNKMkHQNUKALR9tAmokINQeQdh1W0HrTG+8Gv9WlvNunC7jJnBD73D+U8TSOlATSRAZ6C0wwNtADkFwWSwdRN/nDReYVLD2U+DNlqxJTv2GZ3GPFVyjF7QHYrOQ6tAnAeQuqZXTo4tlLe+zpZ042p1xpem6YZ6aZpg19OtZXQHv0+3sXzDNzJEPFqardm24zK7M1FfV7LYJtFbyRV/QXfbsffZBBdLihYTbZUC8+gX447z/LJANml9iwtwNgGOmX0X66u652xsuqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790697564; c=relaxed/relaxed;
	bh=3j1GsvDFG4oGBkWvUsNYUZ4jWPGCGdM9fhJMq32ExyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGK5rvLfNqJBpCebJHMeUkiRCFxJmhi8klHj7UKSqmvRm2zgMFSN2q4ChL4sgp9HNadox2nfg+5PVcykn8p7G58mKiMfaJUMR4MPVgNXyCJXPA/iu9s7jWE0HshgL6RGbGKr4zeyOy68ZyYzR3SNAUlJsYrIGcyjCLYrIbjECGFzqsFEB5H9IahWs52av7ef9du9GNHVX0sTrh/Fw+AM9caqymozEUCZb5aMDkEr6K7W18rUzMBSp6zOGJvCPmJfVcbJ3+rMgWsCahimgFckfGc+SfMI2+DZjQEpZp/S4BlIMalDB7/LInNZTt4x4NzaetMwptyMUC4DgcQswDSAHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gourry.net; dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=DB/WWCvq; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com; envelope-from=gourry@gourry.net; receiver=lists.ozlabs.org) smtp.mailfrom=gourry.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=DB/WWCvq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gourry.net (client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com; envelope-from=gourry@gourry.net; receiver=lists.ozlabs.org)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com [IPv6:2a00:1450:4864:31::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvNCZ6MW9z30WF
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 01:59:22 +1000 (AEST)
Received: by mail-wm2-x10.google.com with SMTP id 5b1f17b1804b1-4a003bd18e5so13447785e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 08:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790697560; x=1791302360; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3j1GsvDFG4oGBkWvUsNYUZ4jWPGCGdM9fhJMq32ExyQ=;
        b=DB/WWCvqfd6+BPRPu3A102oI6ENvSn8KBfmUeV5baA13MDk2ESukJ3UqwtfsPpCs1L
         /CtyJF6/UY6xjuIEtHVaJdXBeM0wPCk9i+Zz1nlme2QbHIzizkRmBFcWaHd77Bfj2AaW
         LaFlcaz+niY9HcUC2+5iJzhsUjk3HGUHivR9/K3DZ9SKgw8WAxo0OhBWEV3LwXgqPfUp
         Hg4q/lPiPR8SXj7KWOkXW2o+bHhorFne3toQTo26et1/MOTAefMQxHEUAqEXZofJT4+g
         /p9orEcK0g6WdEmtYluHcFZx1F6hnbSg2TD+3ifkjPFekozY0mHblfwEfGKdV8j6Kjn5
         gmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790697560; x=1791302360;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3j1GsvDFG4oGBkWvUsNYUZ4jWPGCGdM9fhJMq32ExyQ=;
        b=S0oAtWk89N8IWw1QB+cidd7WiQ1TFm6hzv7er7xtkqm1kxldJiDj2OHoo/Ukzwox/r
         udgCKSdtaEvFSEA33eSnykP87v9boohwm1RDp45eXUXMj6h7NPpDK2wlLUNX8DZTPLd5
         l/jFW35sRxyZoNSzR8Ft8ry/TsHlifsE0PW0N5BY3++zVk8ENDz43QSMLHDnUbRiBAV6
         Bd+U80113boG8jOivDkhPGTLNIdEP9fbXAPta4Ffychkn6T3560m6EBOfsiAYOTmZ5ck
         BWx5298UzJ0lyG3K3MaFcwlybTPg+R9R6RbzJGEkAOvVqyUkeprYMRqeKrHgXIXEXj5p
         2bGQ==
X-Forwarded-Encrypted: i=1; AKwUvBxvNBKkWgQHp22dAOGG4jTbKn0Km8P0WhO6ErJXRihm98DZjt9wNHIdkSRI9m8wVKXv5itz5eSlko9dgUs=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mk3hCf5nj+lf2zPEHikZknfYoAk4aIz8x7zUQduW+uN5RxEEQc
	dffPMR1ZttpcAKeSPQkCYvN9WbGAz3ZpC6BP/LwlvkcwW7zmtZORfbhEB49p+Aicxl0=
X-Gm-Gg: AYBFou3tDV4usrvEYkaf/dWHBQhCTfJsuQYk+KihyadTU8ejg6aedp1TO8kZ+eMKIZE
	LnATg75GJ9bYWrQNU9OpVN9DvAjLN8yS1/WdUg/4kG57mJ+7u0PETI/ahx0Q6o0H4PzqvsaIvmX
	lJVngNWZT9QfOFiDNR5d/Fi20zEJJA9EUid76Ev5ZAaTl/Fe3qUE9377wwbCnw/4C8aEo0Mw8nM
	hfoYsucs7oi8127U57KLwtburuIMXo/xmd8/qCWigrBCeOzFoPWDNng/bB/SzJ7gk1bmVCblj+R
	3eXD7P41+UJs9QEC0yaw8zT4+2RmiPZgBk4W7na4gVDjgq6hZFPlCzyJwjd6WEF4gJqXdINfDHU
	n9LpqzarORGSeTfmgzwyGDZRcD6CUe5aiV+fGCJxdvClbxNF/ZK3mwna6fSuMPVpAQMIpK3hK/N
	A+LmQ6P6Hs7fiLvlHhjWDEigxeKCJbMpPhiwsmP8K3i1i1pyHku592Ikw/uCDGJ65n5g==
X-Received: by 2002:a05:600c:46d4:b0:49f:ec98:f030 with SMTP id 5b1f17b1804b1-49ff06f839dmr227620145e9.33.1790697559827;
        Tue, 29 Sep 2026 08:59:19 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c092:500::5:5c0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a013c6f295sm7062155e9.0.2026.09.29.08.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 08:59:19 -0700 (PDT)
Date: Tue, 29 Sep 2026 11:59:17 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-rdma@vger.kernel.org, selinux@vger.kernel.org, linux-sound@vger.kernel.org, 
	bpf@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, fuse-devel@lists.linux.dev
Subject: Re: [PATCH v3 07/40] mm/vma: tidy up map kernel pages enum values
Message-ID: <arvgNTUgcO0nPh-V@gourry-fedora-PF4VCD3F>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-7-4583d8a23bca@kernel.org>
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
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-7-4583d8a23bca@kernel.org>

On Thu, Sep 17, 2026 at 05:22:16PM +0100, Lorenzo Stoakes (ARM) wrote:
> MMAP_MAP_KERNEL_PAGES is a mouthful, discard the MAP_ as that's implied by
> MMAP.
> 
> Also while we're here delete useless comments for mmap actions whose names
> clearly indicate what they are for.
> 
> Also update the userland VMA tests to reflect this change.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

