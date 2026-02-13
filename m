Return-Path: <linuxppc-dev+bounces-16859-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECD3EF48C4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Feb 2026 03:10:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fBxxY2F5Qz2yL8;
	Fri, 13 Feb 2026 14:10:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770952225;
	cv=none; b=jjq/tbA/176Bf3pis8DgMMsbcuRWe0n3N4M17JAapGpxAW8wpoWfyTHW2/LfrRJuf3vd/lC97kLBU9nM0WHBRnWa4gdhpstBmxop+jidsjz3ObIcdv6U5GDQ/YjmwKHDGNRgAb36Z8ZLEvW6QLeW42Jjiotfvj0tbYjiBT3yZgCsaeNHyxbN1XIcg6SU1SEz2OGpQGzs2AGf4cI4sm0csxRt0yg9tuCRmDRA/gvrsPJfO+MtIrriwiyNDaztGDHufnSqIshp48EV2ldJJOyDlp5qpw57NabMLGOdztAE8uFaak29EErc2XNImqQpPIdGeJ9/D57PbvpFteuHB02upw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770952225; c=relaxed/relaxed;
	bh=P78RENVYqtBrXiPd84cUvPiHnkgGJOrq+jEIxq84kb8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OeHtrDqIAwQLx9ZruT2eJ7Hy1GhQGcAK5OnULaLC3YvAIhDxgxuEJeu+R8MPVQe59nuyuiQhlrYLTpYEAVn1M9tAb0Z+9nbij4QdceeXFjKKmEGlgUZxgIHENPU9Hx6Ip1NQ9zL2Lq7XvfK1Oxnt4DAiiy0lMG9uNU/uv9aIiuOCleXzWl12kFnWFxbGke78o7p9X6F11dcLtHe9vaLD4HZ4rZVQji4Ti8tz6hModbQPDc9eRjtPQpnSvkQpikvk2pP2oZ4ersOpl3iV8jnonW6fxBZ1Is9vb3wi0rBdxLeFRvMYKB2HKy8DsU+RXIsOjKGI/YHHcIZ4cwTfwcDOUA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UqncZvbj; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=pjw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UqncZvbj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=pjw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fBxxX2mN0z2xlx
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2026 14:10:24 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 71CDE44481;
	Fri, 13 Feb 2026 03:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C7CC2BC87;
	Fri, 13 Feb 2026 03:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770952221;
	bh=DlVfwlabE/UrECF6UV6WXsGt9/oBuJ/GsD7QC77Cks8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=UqncZvbj0SmNgh6HQ/8D5uoY1GFs2E42UQc+n7sxEIeVzpQSz2IMx9zVWyz7j4P7+
	 tfOiJuyBxCrBsc2bAheTKpm+HdgmlfqnLuZA8ABBgI8BB4Lb7+u/ibAQCcDmZLMtyq
	 Dq96qaThsOFsKMLtIO2NcWVBj+w9FzkKz/VUtZt1faNqiV0NkWWQW2B8WwY9y04Gcd
	 aYQgjkp6ysc/U+JYrKXXYSXRfOItiv0ulvtW6qVQy79wnnzFOinDd0RjM46o52YLFs
	 e8YKvqJaZE43RDWwzJya1N+H3cjiEt8a6WCf6LJlnzNFusrJSTRdUBupc/JwHn7iy/
	 2DRGVckeUTNTA==
Date: Thu, 12 Feb 2026 20:10:16 -0700 (MST)
From: Paul Walmsley <pjw@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
cc: corbet@lwn.net, skhan@linuxfoundation.org, catalin.marinas@arm.com, 
    will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name, 
    maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
    chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com, 
    aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, 
    bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
    akpm@linux-foundation.org, bhe@redhat.com, vgoyal@redhat.com, 
    dyoung@redhat.com, rdunlap@infradead.org, kees@kernel.org, 
    elver@google.com, paulmck@kernel.org, arnd@arndb.de, fvdl@google.com, 
    thuth@redhat.com, ardb@kernel.org, leitao@debian.org, rppt@kernel.org, 
    osandov@fb.com, cfsworks@gmail.com, sourabhjain@linux.ibm.com, 
    ryan.roberts@arm.com, tangyouling@kylinos.cn, eajames@linux.ibm.com, 
    hbathini@linux.ibm.com, ritesh.list@gmail.com, songshuaishuai@tinylab.org, 
    bjorn@rivosinc.com, samuel.holland@sifive.com, kevin.brodsky@arm.com, 
    junhui.liu@pigmoral.tech, vishal.moola@gmail.com, dwmw@amazon.co.uk, 
    pbonzini@redhat.com, kai.huang@intel.com, ubizjak@gmail.com, 
    coxu@redhat.com, fuqiang.wang@easystack.cn, liaoyuanhong@vivo.com, 
    brgerst@gmail.com, jbohac@suse.cz, x86@kernel.org, 
    linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
    linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
    kexec@lists.infradead.org
Subject: Re: [PATCH v5 4/4] riscv: kexec: Add support for crashkernel CMA
 reservation
In-Reply-To: <20260212101001.343158-5-ruanjinjie@huawei.com>
Message-ID: <97c57b38-2970-bdd7-2303-6de9a5c14d14@kernel.org>
References: <20260212101001.343158-1-ruanjinjie@huawei.com> <20260212101001.343158-5-ruanjinjie@huawei.com>
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
Content-Type: text/plain; charset=US-ASCII

On Thu, 12 Feb 2026, Jinjie Ruan wrote:

> Commit 35c18f2933c5 ("Add a new optional ",cma" suffix to the
> crashkernel= command line option") and commit ab475510e042 ("kdump:
> implement reserve_crashkernel_cma") added CMA support for kdump
> crashkernel reservation. This allows the kernel to dynamically allocate
> contiguous memory for crash dumping when needed, rather than permanently
> reserving a fixed region at boot time.
> 
> So extend crashkernel CMA reservation support to riscv. The following
> changes are made to enable CMA reservation:
> 
> - Parse and obtain the CMA reservation size along with other crashkernel
>   parameters.
> - Call reserve_crashkernel_cma() to allocate the CMA region for kdump.
> - Include the CMA-reserved ranges for kdump kernel to use.
> - Exclude the CMA-reserved ranges from the crash kernel memory to
>   prevent them from being exported through /proc/vmcore, which is already
>   done in the crash core.
> 
> Update kernel-parameters.txt to document CMA support for crashkernel on
> riscv architecture.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Looks reasonable.  If the plan is to have the kdump maintainers merge 
this, then:

Acked-by: Paul Walmsley <pjw@kernel.org> # arch/riscv


- Paul

