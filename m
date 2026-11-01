Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE63606A325
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Nov 2026 15:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z7lKIecn
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jHdz71dSZz2xnQ;
	Mon, 02 Nov 2026 02:28:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793546931;
	cv=none; b=g/IZtKQPH2KxJ7qcpCJ4wo68MzKDba/3SYn8ZoVmWAyokt/TT7hYK6PVepZZzGwCCHNLJtNuoO4KfNgnCJeU9P1+ca3dMzqcjHqNsgb1N8sfXWOSmHWv/v9mPMuzSii0KCn3SGjypAo0XUPtaciMFBw9wIp52sbkTEiDJBnHsKC3llFMnpOOYQ58pXCtDvrkwZSW+6h/ccqfnBpgbxDJnK5lmfBO+zJ5yF4c1rNFIt8Iy2m9+C/o6WdYc/j0e3kpzYgrEtREglFF2K3BrGlecv/avHTlBECqTDGhIY6AgNI71p+7x9XUM2ez7sFpQT6PSQ1QZtcfXID6W4ume8wo4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793546931; c=relaxed/relaxed;
	bh=Wo5qks5C3zcSg6+J9xriS5NqBQe487mSK7feaSBUdzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hjVBiQWLY6Ym97axqOKq3Lnfn5S5QOS1zsnF/PjRaD3pmQ3I5XJ2RJIGKX3wY2x5D8vvIT0Z2GOGNWCK6EuhE4uDxWk9uD6kr+xNluJ70EqfkvE5CGHZEdTGqrsTpPkntwwpuFmd2gTOEAag5ai4ISf1+6vIcIXD6g4vK+9GyUxhVgh2TgArd7sJknIvZg+dSxY/B3ic4ald8P7i1ceH8zZS6L96QvNGiRyQblNP8jJR4A/08T4WyUye8WlhtqrsZ6wTdb9Ma0y/mPsINYeMpQ1XlMjY428HNYgHjTpvvW8yRCABPEd1Z0iVVHKpVA3wx5NX3HFqiDB9WjHE253AlQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z7lKIecn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z7lKIecn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com [IPv6:2607:f8b0:4864:20::1329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jHdz63qX4z2y7M
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 02:28:50 +1100 (AEDT)
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so3212122eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Nov 2026 07:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793546929; x=1794151729; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wo5qks5C3zcSg6+J9xriS5NqBQe487mSK7feaSBUdzU=;
        b=Z7lKIecnN6FqU/Mb+/KsZw1x/CNA/xXXepUJ59mg55RyzDrJ4ghmEYlHV/i31S463w
         NtaVUvpSwXWE33IQUlaGOMkvf6PDD5jGhgeuBOzCMEl6HG1hAS04v90NgXxqjkf1oICa
         4VXk9tJFKbX9vY92y3CYzrISBSxphU/dUwIles0vHmAMy+BsOwH3I6VOKtnxPKHyEHuL
         cP6un9xzDiNxv2X7tNUeCt6QOg+KiYL0TnVURRopmIrCGIysfBeX0y/gynJ92Wo7YXlb
         1sBq5couPVTF6+ycBTXGaOZzNCsd3ZgDF848uuvu2faI9zJOhkNS+EsQVrNpx3/H1gIc
         JeLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793546929; x=1794151729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wo5qks5C3zcSg6+J9xriS5NqBQe487mSK7feaSBUdzU=;
        b=PsUyuGL+dIIEugww4BcnNLhrhHycXITMmdhxVSlHVT/OIhCmlYIw7sRlGwEdn0XMID
         0mBPQDK+usxXOML2egsvaAVgtKQyvPJDUHxh+MtQvxjRY6ugBj390Q08PNO7iN8BQnZS
         t4AS7wXx2n0fwi9uRUN0p4x5H63Cu47tw3stxPf4NIJw/sQeFavzjdqFDK09jpobmT7R
         u9TuXgNse2xFXcUU6WuP7zOVYXxXbDGZXp9zhg7RddbbvWsLonda29YybyFHrty8qS/L
         BUfdeRADjV2SL2BF4r1PvyQC07UdVAskcassfV46+3wvohJkwrgBop48c81ervDmOIkQ
         IbYA==
X-Gm-Message-State: AFq9FYID0MT0iqeuDEIUFofshsKFSX2aPFeHyjvpkPno20crQUiSLwI4
	C11pTnXP5x/OF0SNzdqa4KddeCn5XzLTflML1fFYyzn3Y+RMz4010fPJoO5vDQ==
X-Gm-Gg: AYBFou1AOLrXpXqLlmtBDMyonNhrxzF3bnv9fi8O6yVXuXg/IY1nYsPKaW/FAjRqkqU
	+UJ0ZQilJJtVTX21+T9d80MajkeA9ywSkuJnqptMNRdmjOwj0x06hTC935phw62M35pb5MrpcyY
	wL/SNLVUUjITf4jfpxq+W8p7giO7/AlCSJaegPXFMiDvVLAL/8mQnpUcxylzk7qDglDR4LA2GEX
	a47pkc0e/dEdB1QGzh2d25+9tpOaBsM8QzDfj3rWPo+OEL2DYp3KcS29KNHZMGBQXNVL9cU65Jq
	Ej3on2idd89Hwiju2gIX3V/uuKcGu8fri+aB6y3DI0uOCEttEeKjPqmDrfyLM91kQIQ+Sfgp9Eu
	K4orG687tJQO0b32Yj+q1lu8+LVLXiwniWWkiFklJJVl2mfn18VoAbG2sCi9wnr7VSJDTfqjAKY
	ZxYYa8GwcwL7zKctk4X7yWbjL0e8K4VRVzlE8fJVRMvGITzT+qTS9anSyqRrsra95yOG0sBtSFF
	UHJC1UDdp0CnhyOaoakYpFXHcdFclNsXBLVKkANUHZ+52jwqF20ADjWM4Vm/FTCsOh4wH5gkyZj
	wZMHvK6NR4FBdc63e8sQmORBf0lSoTgOMA==
X-Received: by 2002:a05:7022:5f15:b0:1af:d691:1b4f with SMTP id a92af1059eb24-1afd6911cf7mr4708978c88.42.1793546928542;
        Sun, 01 Nov 2026 07:28:48 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm24862665c88.8.2026.11.01.07.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 07:28:47 -0800 (PST)
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
Subject: [PATCHv3 6/7] KVM: PPC: Book3S HV: Fix error handling during vcore create
Date: Sun,  1 Nov 2026 20:58:11 +0530
Message-Id: <20f3d8cc8d5dc36872873cec4c8cb48a68e46354.1793546707.git.ritesh.list@gmail.com>
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

kvmppc_vcore_create() can fail and return NULL, this patch fixes the
error handling when this happens.

vcore and online_vcores count should only be updated when vcore was
actually created, otherwise it's state gets messed up for the VM run.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 22283d46e8fe..e39491dfb975 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3090,10 +3090,12 @@ static int kvmppc_core_vcpu_create_hv(struct kvm_vcpu *vcpu)
 			err = -ENOMEM;
 			vcore = kvmppc_vcore_create(kvm,
 					id & ~(kvm->arch.smt_mode - 1));
-			mutex_lock(&kvm->arch.mmu_setup_lock);
-			kvm->arch.vcores[core] = vcore;
-			kvm->arch.online_vcores++;
-			mutex_unlock(&kvm->arch.mmu_setup_lock);
+			if (vcore) {
+				mutex_lock(&kvm->arch.mmu_setup_lock);
+				kvm->arch.vcores[core] = vcore;
+				kvm->arch.online_vcores++;
+				mutex_unlock(&kvm->arch.mmu_setup_lock);
+			}
 		}
 	}
 
-- 
2.39.5


