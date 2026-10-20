Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ECA606A32A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2026 08:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bz1GiMUt
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j84pK0sJ4z2yps;
	Tue, 20 Oct 2026 19:10:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792483801;
	cv=none; b=D6KFui24dRF9nvvaEB8XpBX7H6hcx0I3TW6Wh5IXnayhajL52Dim58gJuK0pw02Yv9NZmzV7Zr+6Y6I7jOHFBoOecXQenw3+iVUHw/O+2sQIOr6hPYP5D9uUt+q1ei+/g3TlS5iYQC7OcC0K/XZ9xocRbuowybcfoYWMRftrP7Zh6G+ir6x7tmDbGLbwrZHWN3YjLRQqbjPB/ADAgVMrJsG12nAC2nOsG368YlBKlXBxeCRxoWh3rayvVmexHi25N7GvkjsEp66byPX92CDlVPNvrLFEbp4lCL6YnZEDOqDtQ6KprXmXG+mq9xqCtAMevTmZAhrCAkrLT1GlKHpPtg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792483801; c=relaxed/relaxed;
	bh=XSsZkzzBNNe/aTV43Z32nPhmjz0NciIMlK5b8uQ8eSs=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=YYWJaKzuEG/t2GoPa/H9fxjwwsHJ+yAkbPyiG9o8stiDooZxBdAykftKc2R4bTSxVv7c/o7/cVXHHQEHRIx4ywmpaeTdJgbj45EquhOK4evCDBfPjQV5IyS+Ni91Cr2fgb+BVtNfqm+ZreQju0qTSQIhlbtzzbZ8yhLk3eiQIOJglPCTc+gFDECiQVfMaZAALud1UNKNxd0ocqFeyFcnOlURNMSt9qOJLLacznmWJewbUwHct5w6ClgT6ZiLK52fDRlCeXEOO5g4pvAUcd94SQDIp8UZTLDqQ+mHKG0ifzbJ2lsIf3kSxFfyN30fKjxcJvAc4G+4Ee1sTNsZzd1nJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bz1GiMUt; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bz1GiMUt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j84pJ1Z1hz2ylj
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2026 19:10:00 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A05F8438C0;
	Tue, 20 Oct 2026 08:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361FF1F000C4;
	Tue, 20 Oct 2026 08:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792483797;
	bh=XSsZkzzBNNe/aTV43Z32nPhmjz0NciIMlK5b8uQ8eSs=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Bz1GiMUtVdCxcnrgWdw0nUgk3XjmNZkUSWIAKL6542R8NsGR9CCPthO/llpAKQpVs
	 BMrYgVtgXR+WBclpzdm2maK+uihORxVis9YyGSohSAC9tcKWg3sWc7sNaMbPLcTF/m
	 jLqY2p8/fix+MJqukHD6KLRg0t8y8yRkCW7UOIfmhWudURS2yJ4OsYMY6iwbUTnxKx
	 OViCdgx01YkG1X8f7F8+iPsg5qvr+T4GyTzQ7EfBugtX5bw7V3bfLGdboJIhMaLgfd
	 qO1VcSV6mjmsF7exhP7uFHh7iJLKUjxZSpuOx1L0fzwUoXjoX5ANMdrJnQGjqVob3+
	 MfrluQfgmtYOQ==
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 00/14] crash: Fix several bugs
From: Mike Rapoport <rppt@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
 chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, 
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
 ritesh.list@gmail.com, sshegde@linux.ibm.com, tglx@kernel.org, 
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
 gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
 akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, 
 pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, 
 leitao@debian.org, yeoreum.yun@arm.com, sourabhjain@linux.ibm.com, 
 robh@kernel.org, coxu@redhat.com, kees@kernel.org, tangyouling@kylinos.cn, 
 liukexin@kylinos.cn, zhangtianyang@loongson.cn, guodongtai@kylinos.cn, 
 maqianga@uniontech.com, chao.gao@intel.com, kai.huang@intel.com, 
 vishal.l.verma@intel.com, seanjc@google.com, piliu@redhat.com, 
 thuth@redhat.com, jbouron@amazon.com, me@linux.beauty, 
 mclapinski@google.com, graf@amazon.com, bgwin@google.com, 
 hbathini@linux.ibm.com, eric.devolder@oracle.com, 
 takahiro.akashi@linaro.org, james.morse@arm.com, palmer@rivosinc.com, 
 x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 linuxppc-dev@lists.ozlabs.org, driver-core@lists.linux.dev, 
 kexec@lists.infradead.org
In-Reply-To: <20260921090450.807575-1-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
Date: Tue, 20 Oct 2026 11:09:39 +0300
Message-Id: <179248377975.302547.11812783408034710690.b4-review@b4>
X-Mailer: b4 0.16.1-dev
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jinjie,

Sorry for the delay, it's been really busy time for me.

> As Baoquan and Catalin suggested, this patch set fixes
> several pre-existing code issues found by Sashiko AI [1][2][3].
> 
> The major improvements and fixes included in this series are:
> - Fix several memory leaks for arm64, and similar issues on LoongArch
> - Fix out-of-bounds write on 32-bit Highmem for x86.
> - Fix TOCTOU race in crash memory range collection.

It feels like these are three independent series, maybe with slight
dependencies because they touch related code, but it's not really a
single series:

> Jinjie Ruan (14):
>   kexec: Fix CMA segment address translation with non-zero text_offset
>   kexec: Record allocated CMA pages to fix release size mismatch
>   kexec: Extract kexec_free_segment_cma() from kimage_free_cma()
>   arm64: kexec_file: Fix CMA page leaks in segment placement retry loops
>   arm64: kexec_file: Fix elf_headers memory leak in retry loop
>   LoongArch: kexec_file: Fix CMA page leaks in segment placement retry
>     loops
>   LoongArch: kexec_file: Fix elf_headers memory leak in retry loop

The very similar commits for arm64 and LoongArch imply that that we have
some code duplication that should be addressed regardless of these
fixes.

-- 
Sincerely yours,
Mike.


