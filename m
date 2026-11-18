Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14267606A335
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CiM54+Mt
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jV8Pq14pqz2xSl;
	Thu, 19 Nov 2026 04:54:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::e0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795024495;
	cv=none; b=b4MO45c4VFByrjvKtFv6tVqgVz/JjeIhh3OhgYSzqrXSOVtu4U7vIn4OaoXPRbHRaRRjtagNn9qwScQSXuhWQIY3FrDmxv/Y9o1aSfhjAAzs/URlm/oqKXJJKNbwLvQmy2Y3XH+VKSdSA+rTCcvmmjYRFuN6Sg2rfhUvrDnunTDiB20CsobmgDNd8hjhOBPw6kknsN4FYftvuZkKZvD9G/6tKmscUOnNDyPrC9hpBMGL3Fl7u/SuUWa5trsyyR4GmQkaLY1UwteuvFHfU1sYkxsxGBgnJu1+5ztZkKabV5gqqHPUzIlfbn/oI4KY5oA8T/r8T/P8Qo9lsR46oj5+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795024495; c=relaxed/relaxed;
	bh=mIvlMhQp2XPMKkyqstwBRddoJIhsg5ZvouNFjygJYDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FF1eQB6/W7weJtcxV8zY0+/s9Ej7d0fEc6V3riL1UE/b+EdUUhsdeDyMXPQtvngp+75DOA5m/6RbUQl0FC/88e5ep4o0N/9DNzqCK82YICc3/jmcI1SdXEYoNK4exo9fylteOC8IKlVifB/u/LwHBHTjEwl8V2DxdbiUKq74CN02bmm2li4b3SUiMi/D3Xf8dEnYxNnKoEMMAWnOF11cry+w6WeDz8qISu7ZI6ctPldMQNml1BLJ9fLdZAMhhY23R/wD340YCWcUVH8/663IOQIkrAYmXiuPSbze8meN6P1rGLQPwAOY78/CWENYWb8/ZeIQhUTwiTGvfzOcDm5t2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CiM54+Mt; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::e0; helo=mta0.migadu.com; envelope-from=andrew.jones@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CiM54+Mt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::e0; helo=mta0.migadu.com; envelope-from=andrew.jones@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 79 seconds by postgrey-1.37 at boromir; Thu, 19 Nov 2026 04:54:49 AEDT
Received: from mta0.migadu.com (out-224.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jV8Pj4rFBz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 04:54:49 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=+m7k99GokHGG2Xt0WNDUpUu/POJp/u8hXMkzLb7HkPI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795024471; v=1; x=1795629271;
 b=CiM54+Mt0jogmPAr1PfGS/6DOqHQSeJRgnmjJsQNo87+XR6M3rfDHJGM+uGzafQa+Ichujdp
 erm5OTO+vkXBzCfF4ysrg0IUOAyEHGIA9eNsdotHU1DXObBmMkRsiNSLn5thflUH/XQyffD84LG
 d3WmOKHHwZAbV9xOB8p0G9zE=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 55e39e18abac30ad;
	Wed, 18 Nov 2026 17:53:05 +0000
X-Mizu-Trace-ID: 55e39e18abac30ad
X-Migadu-Flow: FLOW_OUT
Date: Wed, 18 Nov 2026 18:52:30 +0100
From: Andrew Jones <andrew.jones@linux.dev>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Laurent Vivier <lvivier@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Nico =?utf-8?B?QsO2aHI=?= <nrb@linux.ibm.com>, 
	Chinmay Rath <rathc@linux.ibm.com>, kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH] Move position-independant code flags into
 the target specific Makefiles
Message-ID: <av3l0ZC64ouIp4KN@orel>
References: <20261113120101.145183-1-thuth@redhat.com>
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
In-Reply-To: <20261113120101.145183-1-thuth@redhat.com>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 01:01:01PM +0100, Thomas Huth wrote:
> The settings for position-independant code are currently quite a mess:
> It depends on the target whether we need the flags or rather should even
> disable PIC / PIE, but currently the settings are spread between the
> main Makefile (-fno-pic is the default, unless CONFIG_EFI has been set)
> and the target specific Makefiles.
> This leads to some weird situations where we have -fno-pic in the CFLAGS,
> but link with -pie in the LDFLAGS since we still want to get a relocation
> table, but then again need to add a "-z notext" to the linker flags to
> avoid warnings about relocation entries in the text segment.
> Let's face it: Always adding -fno-pic / -no-pie in the main Makefile is
> a bad idea. Move the settings to the target specific Makefiles instead
> where we know what we really want, and then we can finally drop the
> "-z notext" settings, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Makefile            | 6 +-----
>  arm/Makefile.arm    | 2 ++
>  arm/Makefile.arm64  | 3 +--
>  powerpc/Makefile    | 5 ++++-
>  riscv/Makefile      | 1 +
>  s390x/Makefile      | 3 +++
>  x86/Makefile.common | 5 +++++
>  7 files changed, 17 insertions(+), 8 deletions(-)
>

Acked-by: Andrew Jones <andrew.jones@linux.dev>

