Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA65606A33D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2026 08:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ddCy9JWi
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j84pY5pkwz2yps;
	Tue, 20 Oct 2026 19:10:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792483813;
	cv=none; b=Mr4feoN7z8ITcetIJ/HroXbujdWRQeNVMlzeShw3NNUeRmOWSrYmCU0rtRihwN3w7Pb2MDOhk3H0HXaNzGR8LH3CA3OFcFZyHhUJzF4/j24y7xt+tzuT0yH0t0iSTohv/HqnZlg1rxPqDD0jQ/TeyusjaE+uDF1ZfBPIDoaRaHKpEr8ZSghSiJq35hdd7aPtzOh9+AIrw4Jvf4bZZq/KgAE/LFz4zV15FF5WRGCvcBN1qz4rOc56C3T0lW7jYtQPz2HN6Wn1ivj0FQFOSmJ0qWXfS44aFCh7Oo5CbOrnvewWbzh/BYjewu+ktJlrmE2Gau92dsEsqt1PDXlpisyhzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792483813; c=relaxed/relaxed;
	bh=IL/ezpdN5w+pYR3PWaXa2V0Ctgdyc4AXOvpXb4+oGbM=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=YTs+fkmHi3V4NsKI7TlRZxIImoEt2nU6kDDriNpXvjK8gCtRUSLjExU12wqO3dUAljjh9/wPU8J8+Zl8XGpxnDYQ1iHUd41pDGI2mxtQBw04wRsRPhNl6pNQoQ3pEXVLf9qg1rNWdfCM9SZEN1liIkdlpkmQVSCKcu/FGFo1lLlIa1E0iBHnCrFWMxaZY3mMkFB7K126BaIx+tTfO97soYeArIsmRE1Hv+4cqtoiQk1jwL059CnYZeHXjq/4mnD+yjaSZv8npg78tTaiF89bQsGI7vknHkYr6kbB9+ll8BeyVAuRKYHvImID4G2/AHbevVJ+A5cPgry/seHxD1Mt3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ddCy9JWi; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ddCy9JWi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j84pX71pvz2ylj
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2026 19:10:12 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 753FF43B1A;
	Tue, 20 Oct 2026 08:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDA21F000C4;
	Tue, 20 Oct 2026 08:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792483811;
	bh=IL/ezpdN5w+pYR3PWaXa2V0Ctgdyc4AXOvpXb4+oGbM=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=ddCy9JWitnHDZO/lVYfOdqe6FqQZqK/Lrwor35sehBH4ernYh/kO3cjbIvzXzvQ+6
	 0t4DbnO6piOaO+yoKOwQnqFlMfHmUtpaktKYDBFT1wwrjS/2kp2ucfMslbKxvU8n04
	 VjwGhSDPDtnrlR2XfSco7VLRf+gK/8QeWu5EwzJzGgttxu7KMxwbxtk07n/uvd2UX/
	 gLSJcKQfIhNBZR8KZujEh6612ZeaQ6mdoQ53uDpB0wSajWSAtsss0dTwuomHZHK6ZS
	 hIQ77WUcqI09pFilPtMe5u2GgZYSGsi3W6zNJ1FXoD3cZFSAVwQwbswoezVhhSbTV0
	 HaGKGBQM22Anw==
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
Subject: Re: [PATCH v6 01/14] kexec: Fix CMA segment address translation
 with non-zero text_offset
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
In-Reply-To: <20260921090450.807575-2-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <20260921090450.807575-2-ruanjinjie@huawei.com>
Date: Tue, 20 Oct 2026 11:09:39 +0300
Message-Id: <179248377975.302547.13172455257147735569.b4-review@b4>
X-Mailer: b4 0.16.1-dev
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> kimage_load_cma_segment() and kimage_map_segment() both translate
> a CMA segment using page_address(cma), which returns the CMA base
> address. This ignores segment->mem.
> 
> On arm64, image_load() adds text_offset to segment->mem before the
> segment is loaded:
> 
> 	kernel_segment->mem += text_offset;
> 	kernel_segment->memsz -= text_offset;
> 	image->start = kernel_segment->mem;

That's true, but since commit 751c263bb74f ("arm64: remove TEXT_OFFSET
randomization") TEXT_OFFSET is always zero. This is upstream from v5.8,
so no LTS kernels has non-zero TEST_OFFSET.

Maybe we should rather start deprecating .text_offset in arm64?

-- 
Sincerely yours,
Mike.


