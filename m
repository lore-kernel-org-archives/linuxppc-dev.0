Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B74606A319
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2026 08:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M4RM1DJx
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j84ps574Tz304Q;
	Tue, 20 Oct 2026 19:10:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792483829;
	cv=none; b=o18+5bfPsqe+3N7vnz+e/26DPy0vMUJFkhf8/zzY8iAV9RBEPUHZd9Z3FzvWxXplzM5T3U5wMexJnkQRQB+u/2tFp7QBN6Du2iJwjV5Yg239IBGUISzh/sOjiXlrdmPNVYUoILDC2mjzKiMReITxuAdKGI8eObwymXniTRrz2hYkCoBRTRdzB6i4+nJWsbfQKXafcnAe6MkDQJie2sk+VO4WSKNFJuWGS68mAAWC8LUPxlL82XpU99URDL+o3terkYXrFIJokgZbWzrm+F7fMztCFdErY8PzBdSvu/VUcSaXJWI133+7VmAk04o6knnCSR0mXm1rOleqQiQVj5pUqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792483829; c=relaxed/relaxed;
	bh=yBYSrHGCRn0VnGOMETmfFB9n0GdErJoxxpvBx0Cls0A=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=BEIIzXE/HtOo0gLNuWvVJfue/JwjU9IkcV5qgL3TXSQQe6sgCdrhp57UlFYQzVWZpatXgFVNDyhMTIUs35OzDTVOeMP/wln0fod4M53i4dCqirQmDP4asKmPQHaLqHBgSkw+cqEVlZgmEluOZJF66KZhZdcNg4/zynX1ObuxZ0PsL5ifLOFea2Y75iRJBrp5a+RS7082WqtJQ1iK0s2eNBURSc7QuDrNTHwqaHiAFv+Lsm2V1H9sHznpskrKJnaRjPbJF611pDDacaryu+wKPuG2Yx2ujdyjqGebKAkHqPDJ/ax420CkhINF+oYWxuzcbzZipm6+vzepvTDeQmDaUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M4RM1DJx; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M4RM1DJx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j84ps0PvDz2yrQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2026 19:10:29 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 790BB60D7E;
	Tue, 20 Oct 2026 08:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4671F000C4;
	Tue, 20 Oct 2026 08:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792483825;
	bh=yBYSrHGCRn0VnGOMETmfFB9n0GdErJoxxpvBx0Cls0A=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=M4RM1DJxucPrV9uY8fDO6NsLZA+LShmgNV4RcxcG9OSaNxMDvLJzUKksUlvNfLCLK
	 B97wnUobAdittrCZdufknf0Lq53w5WdQcPJn0X7K3DwA0KBALEVtqaN8EmGbA5eu9r
	 b1Kg6NkzyNR9hIQ4FsHdOENrCRWHrMqTUBy3AOd2oD0BbBd2ErC5rE9Se/fzTqOlMD
	 lOIGdbHvJJNmS0Lgv6BZAGQ4mBHURySJ2SB1TgNH5wAyJJpRH2n69kFyItaw948hhO
	 syFBn+u9Hq6iAJmtlRPuJw2+7EK12R/9EeP+zziXUplV6kPQ9Pxv2918smIV3WWv5j
	 TZGTZLDl1MOEA==
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
Subject: Re: [PATCH v6 02/14] kexec: Record allocated CMA pages to fix
 release size mismatch
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
In-Reply-To: <20260921090450.807575-3-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <20260921090450.807575-3-ruanjinjie@huawei.com>
Date: Tue, 20 Oct 2026 11:09:39 +0300
Message-Id: <179248377975.302547.8708639983163316788.b4-review@b4>
X-Mailer: b4 0.16.1-dev
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> The CMA pages allocated for a kexec segment are released using the
> segment's memsz to calculate the number of pages. However, some
> architecture loaders modify the segment's memsz after allocation
> (e.g. arm64 subtracts text_offset), causing the release function to
> free fewer pages than were originally allocated, leaking the remaining
> CMA pages.

Like in the previous patch, arm64 essentially subtracts zero for any
kernel newer than v5.8, so deprecating .text_offset in arm64 seems to me
a better solution.

-- 
Sincerely yours,
Mike.


