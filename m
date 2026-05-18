Return-Path: <linuxppc-dev+bounces-21047-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F3E0CD343F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 05:21:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJmPd6FJbz3cGR;
	Mon, 18 May 2026 15:21:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779081701;
	cv=none; b=UdYY7Gz09RWCWJcN7wykj3Mp3mNd6webCrqw9Fv34HwFCl50VGiyl+yU1tlVcBW7Ay4OuanYbjJFtKqkAiUffPu37iW4FBzEnLGNN7r3/7q16MdM1chfKdc67kfef0CX+GjumPFKPiKMyEZiUHSwQsQ5E5cAkf77+s75mEHDk4rLPeT0RoveIBktimZXnZLSCs8YHUHIXgURrBbcXmNHIjtPgGz09e1LYSje78Iwh9NMls6HEzOXEChGUMJuODXMTezWhwmO3EsBUygePTxiuwRAXP9SfgllwxLWsT03A80JYmZY84JbO7f82vq8oad8A7cGJiSc/7uTjvRpwGl2NA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779081701; c=relaxed/relaxed;
	bh=f+52qFTDqoU49AtpaOwzhNlBojPkERzEz4f3SUwOzlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+RUl+XVxc3AZhswW9p8L9qjh9ZShinE9AiT3tlZdzkxoiNi920AIzmXggpO501UiY/d1Q2oGO2sbfdo1s8sxWVebeXqppNF7RvNJOWBmKx/HBCUdvTk0O2ux/1k6nMl2LFRVx7gaHNYktSdia211AsRcy1H5UFnUkwhH/ZfFRKTjLcInUIUADnOy32l4DHg7OGcEFHcn55yBq8Tpgbzem07xSvdPPZQWQcE8FAZWhuYtHEiMLPNkLe051hRUYi2SPbDPJnQVGpvfjXE9/V47lzVZljCz/EIkCf/+qaQLOPaOWUA/W5GGSiehMySUANZWWl95oE2jeL3ZgkVXUXUtQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2jbzeTqI; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+a5a5d3dd39d7e5270008+8303+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2jbzeTqI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+a5a5d3dd39d7e5270008+8303+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJmPd1CVlz3cBx
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 15:21:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=f+52qFTDqoU49AtpaOwzhNlBojPkERzEz4f3SUwOzlA=; b=2jbzeTqImxVT9d7yS4fHKW69lo
	/5Of1/5x7sNkzs6PLx5qP+LsCiHhj23U0Hw43V3hAjTovZdzROWCdk6UCFSf+lisJmjOZqslmbg2J
	ys5Ovr9L+uZrqOAPJ2Ww6rea1ybwfhCMohtT++WlIIYavIDwakANRtoW5OUFb/33ONfnpyMWtUTcC
	uaLwV7/S8DJcwPgZqVm8KL3Z0R4s4Ytv0p/5/E2UOqOQ3QjQwrHRkwSUXCE9sq9kICuJ5w7kD4kJE
	tlPEIdwI6tw282PrzVNyPE38M8JOFKbYuZaCVFOsLEt0pfQBlTGjqCngeKVaxhYbeyhXIDOI7l4AL
	oIUg18ZA==;
Received: from [2001:4bb8:2d1:6fdb:d67d:128c:34ba:85b8] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOqPo-0000000EHOH-1ZZ0;
	Mon, 18 May 2026 05:21:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dan Williams <dan.j.williams@intel.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fnnas.com>,
	Li Nan <linan122@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-raid@vger.kernel.org
Subject: [PATCH 12/18] raid6: use static_call for raid6_recov_2data and raid6_recov_datap
Date: Mon, 18 May 2026 07:17:55 +0200
Message-ID: <20260518051804.462141-13-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518051804.462141-1-hch@lst.de>
References: <20260518051804.462141-1-hch@lst.de>
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
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Avoid expensive indirect calls for the recovery routines as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Ard Biesheuvel <ardb@kernel.org> # kunit only on arm64
---
 lib/raid/raid6/algos.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/raid/raid6/algos.c b/lib/raid/raid6/algos.c
index ff99202cad46..43e3309b5306 100644
--- a/lib/raid/raid6/algos.c
+++ b/lib/raid/raid6/algos.c
@@ -26,6 +26,8 @@ static const struct raid6_recov_calls *raid6_recov_algo;
 /* Selected algorithm */
 DEFINE_STATIC_CALL_NULL(raid6_gen_syndrome_impl, *raid6_intx1.gen_syndrome);
 DEFINE_STATIC_CALL_NULL(raid6_xor_syndrome_impl, *raid6_intx1.xor_syndrome);
+DEFINE_STATIC_CALL_NULL(raid6_recov_2data_impl, *raid6_recov_intx1.data2);
+DEFINE_STATIC_CALL_NULL(raid6_recov_datap_impl, *raid6_recov_intx1.datap);
 
 /**
  * raid6_gen_syndrome - generate RAID6 P/Q parity
@@ -126,7 +128,7 @@ void raid6_recov_2data(int disks, size_t bytes, int faila, int failb,
 	WARN_ON_ONCE(bytes > PAGE_SIZE);
 	WARN_ON_ONCE(failb <= faila);
 
-	raid6_recov_algo->data2(disks, bytes, faila, failb, ptrs);
+	static_call(raid6_recov_2data_impl)(disks, bytes, faila, failb, ptrs);
 }
 EXPORT_SYMBOL_GPL(raid6_recov_2data);
 
@@ -151,7 +153,7 @@ void raid6_recov_datap(int disks, size_t bytes, int faila, void **ptrs)
 	WARN_ON_ONCE(bytes & 511);
 	WARN_ON_ONCE(bytes > PAGE_SIZE);
 
-	raid6_recov_algo->datap(disks, bytes, faila, ptrs);
+	static_call(raid6_recov_datap_impl)(disks, bytes, faila, ptrs);
 }
 EXPORT_SYMBOL_GPL(raid6_recov_datap);
 
@@ -329,6 +331,8 @@ static int __init raid6_init(void)
 	 */
 	if (!raid6_recov_algo)
 		raid6_recov_algo = &raid6_recov_intx1;
+	static_call_update(raid6_recov_2data_impl, raid6_recov_algo->data2);
+	static_call_update(raid6_recov_datap_impl, raid6_recov_algo->datap);
 	pr_info("raid6: using %s recovery algorithm\n", raid6_recov_algo->name);
 
 	return raid6_select_algo();
-- 
2.53.0


