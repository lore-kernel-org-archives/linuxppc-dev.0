Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14C8606A324
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Nov 2026 15:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gDHsH2mB
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jHdzC6x9bz2xRm;
	Mon, 02 Nov 2026 02:28:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793546935;
	cv=none; b=Nwo7kKHnrXkHpHZ0npECoRyGOUrcbe8YcFAD01fH5+8ZJXgj1Mbpg35GnlrddUUZndsJ/h2c2fLwdYaarHtlXyeNFGQbz9kNObyckX6uNWbXE98E843Iz3tCb+x6+PtOtt7GPhxaUqIKPTN5pg04yrz4k24MCtwFScRupHqK7BnInlboOfMa2mp88SLQoMJR2kgUZZoZomj7ReqhsLu3WvbTgYFnlAW0Nzkyk4oiRZ1ifS2PE8L27zz3gdGLE/RfgpWA3h658PfFcP1VWTriXYZVOcOpE41go5bjntPPGA+/yeXXEyNvd/n80PsGk6l/EqScKGDoqgGdakohcNVqXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793546935; c=relaxed/relaxed;
	bh=8U+w5fTrGO1h6dmc4Lc7LqvLyaXO5MtfIamT3kiNq3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mpZMgpZbthxdCQ5vvzqJlSaP16P/ntiOH2ADHnKxUTMUDVjm6zxNo8pYfuRWgDd52ggC9Su0zjBP74c8HiIF3OGGTOvinzgGNqg3Sqn9dU6Vmzs6Sj/R1XCne6Tu9sqj+VhyudtX38dNLa2I1uE0e/X4K8roarwvyrVk0BsjquNmbJRJxrn0bYNqxu7g9otOxbe8ErkPV89qiZ7WUdXGYoECZdnM+FmZrXTp/wyWic2nXjdUcKwc90R4u8DVjmfRNWZ1HxxVdOk/t7RXfHfvbh4o6GV8J7xrrJPvOkn4tQz5oKkqCU2axXLIhzVQ2pJ0ONO1Ozdt3iJ4r8kOebohzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gDHsH2mB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gDHsH2mB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132e.google.com (mail-dy1-x132e.google.com [IPv6:2607:f8b0:4864:20::132e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jHdzC1wDlz2xyj
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 02:28:55 +1100 (AEDT)
Received: by mail-dy1-x132e.google.com with SMTP id 5a478bee46e88-36a2551d7b5so4227766eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Nov 2026 07:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793546933; x=1794151733; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8U+w5fTrGO1h6dmc4Lc7LqvLyaXO5MtfIamT3kiNq3A=;
        b=gDHsH2mBuGPLw6Cik3z/7SAUm7nfBTEhr922Km0wVfclkbeSJIhtckLtp1/vYTk5X5
         IaBzTk58qdp12XXdyl2dS7hkYygPVh2RP58zMIU6yNZzUUuO1VCKizio42KlkcTgOIcl
         7ScjtGZv5Zax7UJEXmorQk3IwYps4kElHDbPm0lD/5YCUIVTSAUuEL+IbEKMQxOdAF8O
         k3tZUO/AKipuSMQAaypQ3Az7cYFvxmVeCs1Qd1Uj7Rd3y8G8Zo5uNaGEBa7V46PqFk9M
         joyTYQS+RYcxIEVAyO4pABXXM6E6bmo+cEpQ6+KKtzJchstvPCsKVy6NNKLlttgmoClv
         q6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793546933; x=1794151733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8U+w5fTrGO1h6dmc4Lc7LqvLyaXO5MtfIamT3kiNq3A=;
        b=MNfjBOI/fGS2hW88ex7qMtTg82wpc9dhTY6x3yEk98rjkh4iFHpuWMAcfxHIUS7gWN
         hNh1xZQ+ESO//YzKYpQsiKbmAY7WBxcqVm+mOtrCVLwyHvSz/ADl6VpdHtwiUObP2wtc
         Y9jA10v6woguY9sNB9SLOeIxWooWeO9/yjcvnPwErCB8TFBtHPbucUfLihtsYjqeLYcR
         Z8ypdEZXWT5xuwAmhUJdvVD3YUgaXQhHFc8JfowgmxIrhvauo/sdnxrSmpsutlWQOJKd
         WMyKGpjHY73d0c3PkFmnY5Lbiuc7ZaURjFFRv/qJm/wiadMMaMYaQXPpd3WqEb014bdu
         zGrQ==
X-Gm-Message-State: AFq9FYLhnF3kaK8R4LEqw5cI0QQYUthNjbGMlMkuQ7cC9v0FXy0UZnLS
	EmowIi54PG96fOTrBl7hgEUCI0T968kOCLecNH/mTMoMFjLqX8PEwt+ptTHw5g==
X-Gm-Gg: AYBFou2eUYg/A+5P+uYBdlUqX+OKAPM7bElrBMq/m3QjVbyJMnz77ITCbXh81sK2klY
	NL5HDW3SdbsJI8fQk+F2c/l1oNoFYQvExKI6QfOjU5B6GBSVODNvZLd6vxfwe8jbmhDN9s7yY/C
	kZniwO0Q2WtfO+Nfu/ceoHKK++GgIL5tGXDm23/+BsO1B00WxHHKKi8M9+k977Kz3oB/Gz8KS53
	yWEEW/UwBTfisTwxHxqAiAAd5TEjUyjsdtNF6c9hBjutLikb6IOpIS36e5G3D4osyuavieZV+rq
	6u8+HpkfsMoNp8t6JizGkSax4kCZDDUeK5pdHm80jcqjjKZWpNiTo+eF09++GGuoJlfQrQAuxri
	rrnBsnosPPoijI2xwn54IvAZ4dM9OH6BfspaDo1S4ZepW2m0biZpOAROg+BgHqtcYDm4aYlHXL1
	4D4FPy8ReRTBjk5j8oewBXTc284HQHrs3lK92JYyjtCgZX1k86yewhDR4KsA5CKXCDZVV7u9M36
	v96AKtcSklclgaggshteLc9Ow7PVpje/8M++81ef83i2GnlqtzcnKc3aUpxL1sSp+z5sNplVAqa
	ggonIqEbYSNch+pdtBcA8GcpZ0AnDc4tIojfd0Wril5ODj+/FAn7H8k=
X-Received: by 2002:a05:7022:258f:b0:19e:78fe:9d67 with SMTP id a92af1059eb24-1ac5a680801mr14363449c88.9.1793546933035;
        Sun, 01 Nov 2026 07:28:53 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm24862665c88.8.2026.11.01.07.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 07:28:52 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	kvm@vger.kernel.org,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv3 7/7] KVM: PPC: Book3s: nestedv2: Free the guest state buffers if vcpu create fails
Date: Sun,  1 Nov 2026 20:58:12 +0530
Message-Id: <082c338c69773a73a48cd4e0d0885ee0f6ef5326.1793546707.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1793546707.git.ritesh.list@gmail.com>
References: <cover.1793546707.git.ritesh.list@gmail.com>
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On a nestedv2 host, kvmppc_core_vcpu_create_hv() first creates the vCPU
in the L0 with kvmhv_nestedv2_vcpu_create(), which also allocates the
guest state messages and the run input/output buffers. Only after that
it picks a vcore for the vCPU - which can actually fail.

This patch therefore takes care of freeing the GSM abd GSB for nestedv2
if an error occurs later as part of the cleanup routine.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index e39491dfb975..8de753e302c4 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3099,8 +3099,11 @@ static int kvmppc_core_vcpu_create_hv(struct kvm_vcpu *vcpu)
 		}
 	}
 
-	if (!vcore)
+	if (!vcore) {
+		if (kvmhv_is_nestedv2())
+			kvmhv_nestedv2_vcpu_free(vcpu, &vcpu->arch.nestedv2_io);
 		return err;
+	}
 
 	spin_lock(&vcore->lock);
 	++vcore->num_threads;
-- 
2.39.5


