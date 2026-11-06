Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8B5606A32F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 04:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=h2NarzBu
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLRJb3WBhz2xH7;
	Fri, 06 Nov 2026 15:38:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::c2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793939919;
	cv=none; b=gcSxOYnCGniKUow4/EumdIFrfFevu5bG8IMajHFANIH5AtlEXVpLqPE94Dt85gdFH0ZusereLWnuMu14L3l94jEX1L//YGUk+TJ5uoL1UutP+r4OD7MNDDAoEBgFI5hYtbsPvDPFAk2LZTkORMHOOGzWRWZe28/OLbU7hHDPqHu//QjD5HE3kMbztPhcIYsPOCzg0c+pMux9WIvLK7Htwb3YxkCTGRp/tIuqzuzC+Fz8MKWVhROfXUgNKl95vhZopELP/trDN0FgW9Ogn+z2FzC3ygz3C/eVR8cmItilnvQHoADbyDKink+3Fm2Uts5JOb08nujTOfSQhPXZ84h94Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793939919; c=relaxed/relaxed;
	bh=/Yx3i1zeQ5pe4eBI/JzCvDsEdxLLepzecCOmB7O2Y5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UYV4D0IWznOcs83iV9EXkIlBfo/56XAId8CA0ToEEfuyyclFPWbPToqLSbrLrfb1B2M7wTfOwao2KB32TRSwptE76hzNvlZG4AqggchR4VmrxN9UbZ2cT5FOnNe7z67m9Akz7GoTeADzQXdBGSgMKYoD+52enNi8Zi7RDH7Xh/qqZcVnCAIoYmkKwRWlw8xonXShPb+FlmRQzSeod0cJIerYtf5AaKjkSKo41Y1xW/4LPSdiFfbywzG9OchKzKblOA3KmVq49FNm6kTyV4EsoLH3fd0YlzodfotiQ5vEcq7ztoS/7Ft5werlytKiN+7cj7c/ViL68W7HsAbDuAAQIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=h2NarzBu; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::c2; helo=mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=h2NarzBu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::c2; helo=mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-194.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLRJX3X00z2xDD
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 15:38:34 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=/Yx3i1zeQ5pe4eBI/JzCvDsEdxLLepzecCOmB7O2Y5Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793939893; v=1; x=1794544693;
 b=h2NarzBu5wSfv3HGLjDaliK2QJozxMk1T8AWSAyQrfXgHTDTPCv+ZGuVrnREakda/ZEx8QA1
 8oHdr4LZFwNJAxqLIVYaUXa8CPvRrYRT1iKnDBFCbx5htEVpTCoeBhb92BY4AQ1xCcuyadvcBnR
 1nSZlm5DlYnhXsdFYvkrWORw=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 9188c1b74d12ac2b;
	Fri, 06 Nov 2026 04:38:13 +0000
X-Mizu-Trace-ID: 9188c1b74d12ac2b
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: songmuchun@bytedance.com
Cc: david@kernel.org,
	maddy@linux.ibm.com,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	lance.yang@linux.dev,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	osalvador@suse.de,
	qi.zheng@linux.dev,
	muchun.song@linux.dev,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	loongarch@lists.linux.dev,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 1/5] powerpc/mm: make vmemmap_populate_compound_pages() static
Date: Fri,  6 Nov 2026 12:38:07 +0800
Message-ID: <20261106043807.32969-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261105061217.13302-2-songmuchun@bytedance.com>
References: <20261105061217.13302-2-songmuchun@bytedance.com>
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Thu, Nov 05, 2026 at 02:12:13PM +0800, Muchun Song wrote:
>vmemmap_populate_compound_pages() is no longer used outside
>radix_pgtable.c.
>
>Make it static and drop the unused dev_pagemap argument from
>its only remaining caller to simplify the code.
>
>Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>Acked-by: Qi Zheng <qi.zheng@linux.dev>
>---

Feel free to add:

Reviewed-by: Lance Yang <lance.yang@linux.dev>

