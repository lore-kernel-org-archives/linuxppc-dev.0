Return-Path: <linuxppc-dev+bounces-20736-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BA4CD4851
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 05:25:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gF4mQ6Py3z2yVP;
	Tue, 12 May 2026 15:25:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778563510;
	cv=none; b=brZzx+QEnEV+aXlB9vSh3DzIucp4XuNHDQwt4oCMDeRfXBdEqXm/5MKVbtzb7NQ1LtG8pBhBeQ2MUWaYhRMiuxNbL2cvf79d7nbqYqeYnvhDf8mI1Lw35EM4lxbJEJKisaDpOzJjiSiazP9XnChYxWLw5vCIl8jYx1AhJRHGI4t0OO56AhG058cCo4F6fNYGTD3IwN8YuywcfdoUcZPhcCxHl5SSLY6RfJmxT8srk5UTY0fSjWwt+MCeGl7Fwg212Xw9zkzUb6eLs8RZwqczgJdbgoEUNiiFebKH2MaqcmL4joYguK4TJGELTGVzXis+J3Io40euVHTmABMVRfLa9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778563510; c=relaxed/relaxed;
	bh=v4XDa+C/o91FMWjaSNhcRxXMdj1CYKY/YPjwb23rTsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PC7alcnLkKoaCgF8IEosbG3j1S789+Ktx42s2rjTm5optqa5VOaWnvsZuhCtPQQrk40dZpJwF4xolmHLM6568kU/UtlEEz+QsO9/YiHp8HljUgNWA6pWOKcaxvIAKDTqrIyewqO7+2uqaR6NCw14aAQin4L7AXQ5gPzxT0XvJKQkFNG+4bEIuZ1rdamEYSUsyg6O3K1GuWpeUeq+TE6T9Y0anGMPXQe0BqDIPa1NU5fl2TP1hIcMvmGWTcJl1lbnevTVblmGaB4RzhCkLiC4s+btG6tWgc1COxXdElT55czmvZI7v2bMXwyw65ItMzzwZd3nmsWypfQxuG5gxgeJaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=nj+eSR6Y; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+9f3c1ea353498f61ccd0+8297+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=nj+eSR6Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+9f3c1ea353498f61ccd0+8297+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gF4mQ1ttdz2yVL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 15:25:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=v4XDa+C/o91FMWjaSNhcRxXMdj1CYKY/YPjwb23rTsE=; b=nj+eSR6Yjql/J4+NOLB1SIR9wA
	yiTsn5udcxuDswc8RbV0Nz37ZuPaslxNhIKY9akbDGEQQjGYsUCE+Vxzhneju2Evin+QBZeiYTCxR
	8+/bkPa388JJH9xVoLVtf8cDY6tAsnGW0VnCVXqYjP37KlzIRcMq+WHpabYljLU9+zyOpcc9oiXgh
	60fqvpn8xmYuAPfWRPlcfGlL2VPXrJt1VVSukKXADFk6a8izV3T8mvjQw/u7+onJwJVS2250slP3l
	vh/jPtKP1HFqwZvJWzOpwjEp6s628KldCifTx4R9yIU2X5c7CllE5xxW7J265m0ZxofOuRSFTyMeJ
	sExTVitg==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMfbz-0000000FcGb-2ne1;
	Tue, 12 May 2026 05:24:56 +0000
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
Subject: [PATCH 12/19] raid6: use static_call for raid6_recov_2data and raid6_recov_datap
Date: Tue, 12 May 2026 07:20:52 +0200
Message-ID: <20260512052230.2947683-13-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512052230.2947683-1-hch@lst.de>
References: <20260512052230.2947683-1-hch@lst.de>
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
---
 lib/raid/raid6/algos.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/raid/raid6/algos.c b/lib/raid/raid6/algos.c
index 65b75236ecf8..d333318e3301 100644
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
 
@@ -324,6 +326,8 @@ static int __init raid6_init(void)
 	 */
 	if (!raid6_recov_algo)
 		raid6_recov_algo = &raid6_recov_intx1;
+	static_call_update(raid6_recov_2data_impl, raid6_recov_algo->data2);
+	static_call_update(raid6_recov_datap_impl, raid6_recov_algo->datap);
 	pr_info("raid6: using %s recovery algorithm\n", raid6_recov_algo->name);
 
 #ifdef MODULE
-- 
2.53.0


