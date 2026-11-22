Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3134606A31A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Nov 2026 21:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXie8At5
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXjbC6qbRz2ySD;
	Mon, 23 Nov 2026 08:56:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795384615;
	cv=none; b=cKIczszJPyL8AiXzX4p37fGRZCe/TeOfOOt99Tc9DQSOgxYjDDoA3QICOplzcoFGQYvzJkrO6tm9uXQ42nzC9Q7ue6AOj7CE+ose9nXllyzUXC3xrxg/iKP7JB/Dt9Qaiii7fuQF3DUOq4u4gtoFbaQ2k5pl9yiP2K0Yiblc2PBDSGrWT+miwvpXLfIT1oXuh0zjwSJUNdzSxGtNHTNRkREyIWN6GomrxG80M+6RsibfRqhbKaWHvjOhNZT8+3qKTXncW5U9nPjKvKjOwiG22k+nGt7OBirQyJKyjZf9jTuk/XevBIZxfQ26V3nloorg2SiRYdujYJeCfjIuuHylKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795384615; c=relaxed/relaxed;
	bh=bwqVDHaqqXUJecFoI8gfarhhx3uMgHGFcxRh37PQR30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oP07C8hvCYfbs9g401HysAvAx9ApmO3ySNDnXpXH2ZxEI/20t/SKqiYH8Kw5eNwxDa6xPkE2UG7P6nzpUVXjU+CvCdLUnnvDN+tnExZxSayrbuQyW4AdvwkVG74gx6SRsrrURi8Omf5vIN2jQL0TYcAvS9Ru6GYrzjDSJX2jGSE/6aLewBrfyKTgkqbariQFe0JklmvTniY6uJ4k/1rVOH3KYqbT4k5T7M+CrQrj5cKHd2Dyr0d0F67lqT/3G7Q8fgkr3hRor6HHAgAhEi+7EufqT/4Sgl4bXxVFFNaFC4Ohlh25OrT0rGCbRQGjQKnXYRFzBSL3sY+HjpGSBbeqDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXie8At5; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXie8At5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXjbB5xmKz2yS6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 08:56:54 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1FC5D4249A;
	Sun, 22 Nov 2026 21:56:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085171F000CF;
	Sun, 22 Nov 2026 21:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795384611;
	bh=bwqVDHaqqXUJecFoI8gfarhhx3uMgHGFcxRh37PQR30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BXie8At5QFQ5VGJ5Wgxa+Ryfj2HbGOJ0KDHW1aolgsw2YtdZGPnu8WYcSmeFf9iTy
	 5wiX3oWysPjoCke2hcQZDizPm34+kAe7FMjSaSZ9srwusVIqRO580db6LxZDAFaZ0+
	 3aDEW76QVsDdxoBaJCF/eDmBo7SUv8nl1byepex6XqNbxhpJHXHoKY2hbT2kLTC95N
	 7JnRNOt0TIdCgaQhdXGjEOlBwvV7HGnUumRRGA3StMRgzFJT0plPL8HRWUST+VQqvd
	 X4RjTcvHCj0K1oKGcN/z3PbXWOEFtUMKW6QRQ4AjrpymszI4/3zzB9pQMRd26c47gs
	 kxUaKiE3hZ+vA==
From: Danilo Krummrich <dakr@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Srish Srinivasan <ssrish@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Nayna Jain <nayna@linux.ibm.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Alexander Aring <aahringo@redhat.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	driver-core@lists.linux.dev,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org,
	linux-s390@vger.kernel.org,
	gfs2@lists.linux.dev,
	xen-devel@lists.xenproject.org,
	linux-mtd@lists.infradead.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/9] Add __must_init and require explicit kobj_type::release
Date: Sun, 22 Nov 2026 22:56:39 +0100
Message-ID: <20261122215639.1178566-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119192520.1983406-1-irogers@google.com>
References: <20261119192520.1983406-1-irogers@google.com>
X-Patch-Reply: applied
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 19 Nov 2026 11:25:11 -0800, Ian Rogers wrote:
> [PATCH v4 0/9] Add __must_init and require explicit kobj_type::release

Applied, thanks!

  Branch: driver-core-testing
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/9] Compiler Attributes: Add __must_init macro
      commit: b8a53320a885
[2/9] powerpc/secvar: Add missing kobject release callback to secvar_ktype
      commit: 4d5d4dd2a2e2
[3/9] sh: sq: Add missing kobject release callback to ktype_percpu_entry
      commit: d19384f2f3c7
[4/9] cpufreq: governor: Initialize kobj_type release callback statically
      commit: 009365942c15
[5/9] dlm: Wait for kobject release before freeing dlm_ls
      commit: 48ae948f4285
[6/9] xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type
      commit: ecaf88d385c1
[7/9] ubifs: sysfs: Use kset_create_and_add() for ubifs_kset
      commit: 25d952902dee
[8/9] drm/amdkfd: Free queue in procfs_queue_type kobject release callback
      commit: 6d4ff4a020cf
[9/9] kobject: Require explicit initialization of struct kobj_type::release
      commit: 45eeed1f8094

The patches will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patches are in the driver-core-testing branch and will be promoted to
driver-core-next after validation.

