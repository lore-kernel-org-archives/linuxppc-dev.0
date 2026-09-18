Return-Path: <linuxppc-dev+bounces-27720-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E76CC982D9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 10:25:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmTKT6RZbz2ygK;
	Fri, 18 Sep 2026 20:25:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789727133;
	cv=none; b=KWe8yIMojj9sQCSLXnDUgwVs5qKrId9kG/42GkXeUqZFr5BD8lvu0jQUo5QHYEpf0sJEaRDIWU8njDCXVNruy7fzNnWtiyG8NjuqBc7Or6J3EjH/OF7Q15748iWBcDN3Q77wLvz7qQRBTT1aJ4AhYWkbT/4Kgg4/fyYCLS0LExFx7/00W/fsLAVbsq3HJ32QrdMd+BbUFij9LiV35bVAUMb8esp/mYygpnCOJffPs2cGu+F3vhBYijzlGTFWk4wRZhI+1Upthq8dIRBKCzSvljRWVKKuPwUJhh5YXOqKday5Fwa5RWwujFfHlbE+4bwcEppWWjuEETPKDqhimX7O7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789727133; c=relaxed/relaxed;
	bh=XCX7OD0MFSj63jeBdnj32V2m69meKqvW8/7zSh3AOsY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ib8sEV0SQwfoeguFJQPsS9Mzv2sDRWfhD1pFkchBZIFysGhjvaTF2q5rO/Zk3RDfeZHPbWmCalnS7VUWhDFu67Mw0GLteg0DG/dicrhZXvIhZdCg8HRyw4gfKOjZlONhskaDuyRvsR1RXOY9VPbgiUHASZh5P27H1c0PsIoyJUVo8h2yYkH74oHjgZ8mjqzEjC9bGmcg9N+umgDL3KCbY7cyN/3AChzE9NPu5JnoawgLzW7tZgych5ixZaPgI8ycAfwkMgxvO4O1dw9M/rqRuhF+oqKiAcnyvY2gq/ByTsQqXAbaawse7h4fjhj73xEvdyIu+XsGPkI78cTf7+7VkQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=fail (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bgn07gul reason="signature verification failed"; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bgn07gul;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmTKT00kFz2yHD
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 20:25:32 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0B11B41418;
	Fri, 18 Sep 2026 10:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170481F000FF;
	Fri, 18 Sep 2026 10:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789727130;
	bh=XCX7OD0MFSj63jeBdnj32V2m69meKqvW8/7zSh3AOsY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bgn07gul2XbQMTEsRc4NB0SooXCoVClfKj7xYlHbS0pB2k+p9hs37drFAnbcjmF6s
	 4uQTP4i4RTHhMXyDNCKCVqtp09Vt4jf/2sZpt6hXCITDDYmNLKHl/7GEuioB10pBbq
	 KgC8pFhunF4pZVF52aAyqYLmVje7onyZnDtkoMo7M+n8lrWgnW2qD56PzJwaioLm4S
	 fHUW0/h/VQS1YQuMks/Kfw+mvY5dmMgMBMzsknhX/LGDPMoVKKagSg7iLX1wTh+7zx
	 SfTRxREogXbxKWtWO3h7HjVP9J++VI67o4Pb8NZxEUTXLM29u8MBaqpCcwe6O9eeSz
	 2AjhZSXEB/PNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 14/17] elf: Introduce elf64_phdr_size() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinjie Ruan" <ruanjinjie@huawei.com>, lizhengyu3@huawei.com, dave.hansen@linux.intel.com, mark.rutland@arm.com, bgwin@google.com, npiggin@gmail.com, mingo@redhat.com, mclapinski@google.com, thuth@redhat.com, ruirui.yang@linux.dev, sourabhjain@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, catalin.marinas@arm.com, dakr@kernel.org, linux-kernel@vger.kernel.org, vishal.l.verma@intel.com, pasha.tatashin@soleen.com, robh@kernel.org, sshegde@linux.ibm.com, chao.gao@intel.com, rppt@kernel.org, seanjc@google.com, chleroy@kernel.org, liukexin@kylinos.cn, linux-mm@kvack.org, takahiro.akashi@linaro.org, piliu@redhat.com, akpm@linux-foundation.org, pratyush@kernel.org, ruanjinjie@huawei.com, kees@kernel.org, hpa@zytor.com, rafael@kernel.org, ritesh.list@gmail.com, blum@kernel.org, linux-arm-kernel@lists.infradead.org, coxu@redhat.com, maddy@linux.ibm.com, eric.devolder@oracle.com, palmer@rivosinc.com, tglx@kernel.org, adityag@linux.ibm.com, kas@kernel.org, chenhuacai@kernel.org, yeoreum.yun@
 arm.com, maqianga@uniontech.com, gshan@redhat.com, guodongtai@kylinos.cn, gregkh@linuxfoundation.org, x86@kernel.org, zhangtianyang@loongson.cn, jbouron@amazon.com, bp@alien8.de, tangyouling@kylinos.cn, loongarch@lists.linux.dev, james.morse@arm.com, ardb@kernel.org, mpe@ellerman.id.au, leitao@debian.org, will@kernel.org, baoquan.he@linux.dev, hbathini@linux.ibm.com, me@linux.beauty, graf@amazon.com, linux-fsdevel@vger.kernel.org, kernel@xen0n.name, driver-core@lists.linux.dev
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-15-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-15-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:25:26 +0000
Message-Id: <20260918102527.170481F000FF@smtp.kernel.org>
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

> Add a common helper to compute the total size of an ELF64 header
> (Ehdr + program headers) from the number of program headers.
> Replace open-coded calculations in powerpc, x86, vmcore,
> and crash_core.
>=20
> On ppc64, struct elfhdr maps to elf64_hdr, so the powerpc change
> is a pure cleanup.
>=20
> No functional change intended.
>=20
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Dave Young <ruirui.yang@linux.dev>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D14


