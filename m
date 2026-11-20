Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503CB606A337
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 04:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fn5EB6po
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jW1t11DfYz2yDm;
	Fri, 20 Nov 2026 15:03:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795147433;
	cv=none; b=cMumYqUiAeYhyHqD4veY2KeRSatol68cub0amW12gYvAaFqg43U11QxWKe48JZH1UeyujWGaEnZSmnAgPX9pPTlLtVRtPTOoXbExxhZP/VwdWMNjNLZ/vsJ2hnhZFPmb1DpRpPN3QK2js/pI/MxOvpjs1/lnv6O26znyPCTx9qjHQDgoXd/gVWJukYQcHmbQYm5AMFNIitU6cov9hmoMJGXYruzF7ud72PzIym7wtNC2hRI0y8yKa2uJbVOcPhpuPuML3obtU1QDJAPgp83b1CYqiP1vOB0L5S8pEpRiXQBt72pDr3NB/L0v89TEiVEhN2lQn3XiMlQFpiatTCRizw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795147433; c=relaxed/relaxed;
	bh=zePSK3NYQ9Uq2qwAbmJwQ8LjQR2v+Q7ZVPo8eNiOxkM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WzOTj43UDm+TcgIlR2vUQUPhPecABiv5uAWUULGdmr5jNiumLxGcxNDSMIKYkDLjFROUzBobPqwl1qUBabMNx5g/izy9fYpWbGF09osvEuw2fOfXIRLaLlz4AmPTC52OzulhizCNadBva41bKu73fulHdHaleLwld49taE+yEDIf5dA+zGdKcKA7HRNoCqTyF5Us1g5gC2wD80fEjFh4oaYxkuqyYtkLxXIYGZB/W517DseE4/Dcms4U1S607o2TGZWw2s8uFeKwluAw5rzgi1ISybhJty59TW5UXihol9N+8Ip3OkpqclIJkFzIjFkl2nGfoxal+aM1WF1EV86gVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fn5EB6po; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fn5EB6po;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132e.google.com (mail-dy1-x132e.google.com [IPv6:2607:f8b0:4864:20::132e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jW1t03Zzbz2xHX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 15:03:52 +1100 (AEDT)
Received: by mail-dy1-x132e.google.com with SMTP id 5a478bee46e88-382f4710a17so725187eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 20:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795147431; x=1795752231; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zePSK3NYQ9Uq2qwAbmJwQ8LjQR2v+Q7ZVPo8eNiOxkM=;
        b=fn5EB6po8ik+EPUoHxT/cHT8Pf/ISa5cavENnNLSfN42d6eXAvxUtW3y31KmlIlsmT
         JL0yZeF4+2BjUxdlVRnh5ij+w3NkLmkG8eFlRZ4jhrhNLjAV8R8CFk8ovSSGLG45PJ08
         8mTFEU2hUbZyZEV842/73JhOypoFby7brzC3vYrDS671tsWcTHDUWpIK3kwmDZvaQ+du
         YXbkLbNedYCU1VGjrAlGTnl95A/saQvkSIMUSiqASkegZ0Y9o45xvB8kpbBrUAh2G+9p
         fJpmVw8cLcCHr7rt2j6gpvkmYj3/z6oJeoPrCA6Edv0v5v++SAhgWDXqCgVLM/evSwGA
         bEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795147431; x=1795752231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zePSK3NYQ9Uq2qwAbmJwQ8LjQR2v+Q7ZVPo8eNiOxkM=;
        b=YQCCLTtvGSoC0c+qo5OeQifkjU9TOWbwb5/zv2ihFRGos7IGAjUARbxhuzql4hTrk3
         oRNRg5p4/eZs4vjhrjH8FWFGyKq6fi9XbS3KIcWhT28X1dDIvRufvpqon28nDUVNdKhu
         5fy48SKYIvq1I4P6nC7QeD+BOqY9rKmawUT9OVJe/i3gEsbu/cCaprjyh3N7y1ZFKkly
         KvREaMvWP8ryBOz2m1eIJDiHmSPy559eV/u0Ftday4HunqYcGfuXMo86jtPUD8qtXBeZ
         soKCGTucmlSHllNgzsdHxLVCPY6XB3s7lZljUsVPjB1PhPera6uZdePfWR7v80CnxmSE
         FAhA==
X-Gm-Message-State: APuU4Z8t/PZ2YRu8ty33lxr1FEXptpSA0rlVV4DyhcMLNqIHmUcUt5ew
	/3Wp4ZK5NiOWp/DRVqDNTNrT1y9THhfxs4lfwNko7+0v1sUafl09AZ0Lm9aV/Q==
X-Gm-Gg: AZFdTZdvQQWsKXi/4BToZKs66B2stpLYaR+yyiVRvmmgtwVQEqtI+HOtJ93wpC60szN
	+5CWpYttZFba/1EYOsOQ0NyENI0QoIrTf6MJcEnQC8Fn1sMnjs4pi/F20zxGZdXPqjAuYgJoL/k
	mwW244dvWPlZBOaKVcsKCZicMW8rqO/Br3Ukj4hu4DF+xsumi0I1qvHsgD3qtbcM44zmoyo68oV
	NzwohmyOIPGShzyGxXZAE6vHksilPXEAyqR2Z8D5nPrzi0JkzxgOaRXOiRjENYPVHMSg+AmOXFR
	XErgjrdfTIiATIwHskVt3+YpBgKpqglbxZI2jujISkoEQehCncGvpeCVFAeCS6PIWkhqLTNt2k/
	SNruRf5BpNAY52qxNjvkqawhtwf26Cl/wHx0ovpxH/ptx6RS6PS78E3ZkDDOfTjd4E3Ml3s5LV1
	2dp+uffE9zjNPqWo8BcIXkN/6glQIs8ciByjJgKX/M9o5fhJtFF4EFcvvW/UpqqBtlmhqvhYDd+
	9K7lJjH/xgK44Q/fA6TOPnu3XUcbshLNMR4OsIqBH9GnOr+BGvjUrj4+9kq63x+O3SoXrESSc7i
	gRyauDhh7iTB6+jl/5A17BvLEKONzLdpIA==
X-Received: by 2002:a05:7300:ac82:b0:385:4b9:18f2 with SMTP id 5a478bee46e88-3857093f077mr2141216eec.21.1795147430620;
        Thu, 19 Nov 2026 20:03:50 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm3246104eec.6.2026.11.19.20.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 20:03:49 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv3 05/19] powerpc/mm/book3s64: Annotate the subpage-protection PTE lock
Date: Fri, 20 Nov 2026 09:33:04 +0530
Message-Id: <2f7b796319697323ba44241bef7d5a979213b79d.1795147055.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795147055.git.ritesh.list@gmail.com>
References: <cover.1795147055.git.ritesh.list@gmail.com>
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

Clang's context analysis reports:
  subpage_prot.c:83:2: error: releasing spinlock 'ptl' that was not held [-Werror,-Wthread-safety-analysis]

pte_offset_map_lock() holds ptl when it returns a PTE and
pte_unmap_unlock() drops it. However since the lock is taken inside the
helper, which is not annotated, so the unlock in hpte_flush_range()
looks unheld.

This patch fixes it in hpte_flush_range() by adding the needed
annotation here. IMO, should ideally be added to pte_offset_map_lock(),
once that happens (since it might need larger enablement), we can remove
it from here.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/book3s64/subpage_prot.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/mm/book3s64/subpage_prot.c b/arch/powerpc/mm/book3s64/subpage_prot.c
index 37d47282c368..d641c35c408d 100644
--- a/arch/powerpc/mm/book3s64/subpage_prot.c
+++ b/arch/powerpc/mm/book3s64/subpage_prot.c
@@ -73,6 +73,8 @@ static void hpte_flush_range(struct mm_struct *mm, unsigned long addr,
 	pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
 	if (!pte)
 		return;
+	/* pte_offset_map_lock on success returns with ptl lock held */
+	__acquire(ptl);
 	lazy_mmu_mode_enable();
 	for (; npages > 0; --npages) {
 		pte_update(mm, addr, pte, 0, 0, 0);
-- 
2.39.5


