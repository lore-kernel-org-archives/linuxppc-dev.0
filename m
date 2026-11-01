Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DD8606A325
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Nov 2026 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yQu6uf/S
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jHd3H40Nhz2yqs;
	Mon, 02 Nov 2026 01:47:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793544443;
	cv=none; b=H63I6gmCyl1TBiLAotV5RLK2a4GbQn5lvu1nEGNlRHHw2UzRNCqQ1XqUE0QBmgsFk/EnrpPK1X2fqMq4wdArjQnNOekM33/BueXdlKpplb6AjQRJJone07+ZyLDrWHeyln4Mfvirc40ITZekD/q473PDN8NtFnL8ZVjqU7iEr/Yzf/6Iq4mkfbhrZkEOEGsa4gGh0WEU/TGL9uiB1JZB6gTkiSLKOGaMkRsKE15nWSoHvgjH595VgnNAy9gS5gSGY2ivzsTQi8OrmsaKm4EPVCz7tv8sLcjKGaQI2Z7E1D+VxUmzVhKbN4x+JD+UEUElkHC9W3T3Ibww2UgdpeKk/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793544443; c=relaxed/relaxed;
	bh=UGcwHzUCP4ZDgaGEqf3mJTvGTZTE+h3JfZ8GLOdbBG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fhjsIrVK0ZRKJUuhm5MY07v5yVPvyFtHIRYnsqGJ6ZLc64/2K+rsYQ//VtPD1yjqlngF3+C/3hARuUjsCJl/dK9Tiqlr2XgRf0UBLEJwN3Gz1pNXr1w6ruz5SKytopKCeZUYI8nFp8PRzsq9A7wS42sNuZJ5EUTXoD58tiE5N18qnL1vA6gdblogS149oGBVaaWOPnYQz2MyxJiFBKF9YgJdlCwP/OCVlLffWmy4gSsRPupeH0tIYqLqE8pHPhtqIFegy6S8vidWn+VH2NUq6HzjwlNJOGbql/K5WZRhs4ksyuunvD2eyltq2RmzWy0CYuqvRDpEFxBn9/2MZCQ7Jw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yQu6uf/S; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yQu6uf/S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1333.google.com (mail-dy1-x1333.google.com [IPv6:2607:f8b0:4864:20::1333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jHd3G6mTVz2yZf
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 01:47:22 +1100 (AEDT)
Received: by mail-dy1-x1333.google.com with SMTP id 5a478bee46e88-36a2551d7b5so4208393eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Nov 2026 06:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793544441; x=1794149241; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UGcwHzUCP4ZDgaGEqf3mJTvGTZTE+h3JfZ8GLOdbBG0=;
        b=yQu6uf/SvJ/y5uiIuE53RRnv/oG9DifFoxl/c818y0+KHx0J6I9sOyUrwir0D983U+
         eh2NwPZtK4ozsbOy4GFJjfelFh8ASlUTsDvnN13sFIdazvqW/9lfSwrTU/qO6NMhaSUs
         tTizvomSb2I2jSbn8tnA89iFSWUR0OVz5uw/8t0gOa1UnKBVgA6PzXwMm4KsQ9yjtJfn
         4w3iXLMIyUohs17TAyh4JRnHw1X2Jus61GQTWl2J5KA/epPVrxImUXBw5gKXe+6EJCAU
         93oz43gPfnjNhqFx/AuGzU5kZ3NoY4A5aQLZFJI2hvxuJzCKq7VQAJAbCiywuhIVGxdH
         Wx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793544441; x=1794149241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UGcwHzUCP4ZDgaGEqf3mJTvGTZTE+h3JfZ8GLOdbBG0=;
        b=cU43yS0B2wJbhqj/J8Hm5h9ztm2FlCg1ppRb1AQy80Lv7GLzel+3/6R3o8UnQbtsHA
         doO0qsfPii2Vpcnp7lsgY4KG288MSEX1bGwQJwN9EhPkBH6g7D4wyss1o+B9PhaXVl2k
         xqMtaEkRqvL8Oyv8uHPaK22sIJx+N7gK/vDdT+Tc6v+Ay3Av/6GjKqwgwo6RVkPXYskI
         dnkwHzbKU41o5d8vAYFaIdYtmDdizSrnh+icO6QVajkjWEyffNoKPc+jGrFsUpZjULhc
         HsiFqWrVbW6E9npS0ImGS7Z41urhay77l+jOI5EdMN1hHKHfBuOzQe7qf0SRbh1ynRgZ
         +otg==
X-Gm-Message-State: AFq9FYKIXrxXOciFzg8RuTQzJz4v5T4LQv08zXUgqrR1fp/ERSMbxCet
	gB1rCIB840GkP38Plu1ptGFpSWq7H1niC0nI8c47lfMgeDf3pvBqAymopxWiMw==
X-Gm-Gg: AYBFou2/TakkEQr5IEtnULJFofyJ0GRlR7jspwsoVOhnHb5XDemt/ynY6Q1nxk86F7i
	+QhgFVcXiepfy9Q4DdyrdOgPfL4o6sOyNdkTm2Hf3zxqmVb6L40657uIKMNBigOeh0ampu2U6vP
	Zf86g8/d0VncTsqEcXIQ7Hy4b3UJ5NbQlvXBD9RHByMAp5HiT0RTmlLmpiCzsQarU5U3FnTvsj1
	AtFn1t93UNoh8XNdqFmy5LbbTJp+bGhit3VY5cZ7UKTpKektMTWIMojasp+ynm5/w+/ChxqOlxR
	Vl+jYOul2y62xwKNwedLGGWBQxTuqT4Sz5Ofa3GwW7qm2+3F4Cx1J+apAUjdhU0XKHqHrUFujR3
	2zzZ5/6idmpODI9qJSlk2+4kFvuFxg3vb4FhEFo7XT351Er0Bxra0MIn5EVb8wfBTb2lJgPnxTD
	d9XfgaNYDS4X7+iMjcdHJIsSNfbP1SAb7Pg8khI+V5NEq6xEVxDcg/f59pHd4fx+SVUkbd3rd6y
	eDOyzUO6gqV45fkidbe4JIa8RfmF/JWAtWsAmBJCi0NR1x9G7eveWkG2rUknVRuo/OjtumID1Ik
	koxRfKi0kfRVqJ+UnAvm9FyR17YD94qB3g==
X-Received: by 2002:a05:693c:8211:b0:369:f3a3:fad6 with SMTP id 5a478bee46e88-36a42340d04mr11570265eec.4.1793544440908;
        Sun, 01 Nov 2026 06:47:20 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm32747545eec.25.2026.11.01.06.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 06:47:20 -0800 (PST)
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
Subject: [PATCHv2 7/7] KVM: PPC: Book3s: nestedv2: Free the guest state buffers if vcpu create fails
Date: Sun,  1 Nov 2026 20:16:32 +0530
Message-Id: <2c9913c7051ddc867439d2b6d2d485d3df83a31f.1793543627.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1793543627.git.ritesh.list@gmail.com>
References: <cover.1793543627.git.ritesh.list@gmail.com>
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
index 7975e5de89d0..a242abaea357 100644
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


