Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAB160A2601
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Nov 2026 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H9qXyalm
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jHd2n5dXDz2yST;
	Mon, 02 Nov 2026 01:46:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1332"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793544417;
	cv=none; b=ikK5t7mP3G3OvSk+I9iXf0oCFWkDOLVVDFMoe9ZT9MDFoM4UlJ/x6r2wJMIHy7rBnhjm6hgN4Vu1zCcGpGtcML26o0Ui9+Ph4BVgKYG+ExQfQsLQQS42KGCWTLeTF3M5fZveLlC2TO5xES3dCqLBeEcTF3/6y/HVMhsk70nilDjF8kEV6MLKonLR0cqyZ4unDywMUey624IxxvNzZ0tW2VyAuAOWlZjdK6qUP4Vw4WQ78JUeBf2KfNq3Xv58XIKB0YoG+iXWFrSGjzyawn16ixWDu3UYDAy4rjTUoIIoZoyY7rXk3pLZR+vWYuk6LF7+vI+9cjW1sor8UNfF+Khp1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793544417; c=relaxed/relaxed;
	bh=Wi5Uu//3wa8/Ft7s/aMc5zpRyu0NlDyq71TEbyp4LVU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lsmh1CDY5SwIE2oury42KPYYg+eJSsdF11s3U4eDiWKPBXJO5u8IpHevMTEbuIBHOrCIwJ1/yY5kzAfT+V2O7AJcJnePPP5YKr+0TQtjJC9z0a026rFeA8yNHQjQOqyU5v+zAVyS1eF7GeYw+aZEgRSXY69brbf2IFnCc5I2ZK82KjEFw8QuTLC37SNDZIxziW4A93mOWJ0aRTkr/JgmaPCtzS3CwVNuaZ+/HYub7mCqgv4cWTxt5DcRp28twWorkE09DWhXpeLYxFyVlvgRDB3k86efOic/OrCL1r+uD1JDuF3n+3RG/bABxG2DvwO6OmPAPC6GaQegOvkXqNeADg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H9qXyalm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H9qXyalm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com [IPv6:2607:f8b0:4864:20::1332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jHd2l68y7z2y7M
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 01:46:55 +1100 (AEDT)
Received: by mail-dy1-x1332.google.com with SMTP id 5a478bee46e88-36a315ed211so2690620eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Nov 2026 06:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793544407; x=1794149207; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wi5Uu//3wa8/Ft7s/aMc5zpRyu0NlDyq71TEbyp4LVU=;
        b=H9qXyalm1y1xQJLR2qGkIdhN0hdDmg8yT3YUyLd7/xNWUffzwbJYwmx78FsFrlde0+
         scCPt2+Jujj3mw/IhSUw768dVM6dy2dxJIfcwZm5GUFfjWKSmEjnEcNHGfN0oepwr2YK
         nkPlKSv1yPF1C2I5C70rsT49B3/qpMSB6lXnpGwLUnu34ZgVxQlbfo5hc0dKYOMlt/ds
         BmNVIlNFwV/GPqZXBtdI7eyYODpfDn1LB8opOY0iOihxt7w+pAdWYY3eQu1alMyICi5n
         LS3IWHhiCRNOKY/Uv5TPRlE1gzXkBLVaZIx2yArwBjn7hl/O3rYMN6qkx9elB/gq2wTC
         jnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793544407; x=1794149207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wi5Uu//3wa8/Ft7s/aMc5zpRyu0NlDyq71TEbyp4LVU=;
        b=nx4Nn/ciI2EKr3FUXfN80itSAwx4Ut2aJpxo6EYHkFezp2w1Nk37ZNGiscJfuHTW9l
         Igaa88q+tbDjptXW6YJqcl/5dwnTNYHBLE9mSX4247ADihJ1jmv1uONxUvpX8P6LwZ7V
         0fT2EmsgyUs3t9Cv8Gl6+VVZ/LR6DGIK6S8ZWlnIJsTL0Y5ZDl+9j3KbzB3TF2BfAm3P
         kxjeit6cfO4QhX5lIEfv+d51uB4m9FXTp8HRIdqfs2+gMQRHxsDwFI4e+7jyBewYb9oj
         lDHK5WAOw4TpanNKp8dh6kjWAg5wPg0MQZSOzfu5IVF7RzHT5KJT8fPYm2rUfqlpSKYn
         +Jsw==
X-Gm-Message-State: APuU4Z+xkGqdWNq0ocOBOJmRzZr0+jDPTtnRQGzYWxsMIV4sits/NTcA
	nHNbBYDFzh4skegGFLkY4I5xpHat5Bm/WQUHKWt3goxaLZU2dOH0riHrmrErpw==
X-Gm-Gg: AYBFou3G5zvmqoFchEtWnbs3dIoLRhoM6m3RHFnWsM5/saHnBTGc6PXveP+zQ8W25Tp
	UKrkfoIbIr3BM1DO/KtD+2WtXeG+M9OvJEIYOdONeIw2njyWOYzKknRvn8IdCwTRmvRzdadQDh7
	zFdBRLCilup//AntvQUnt60FfVRDNccmHZtieAiGMMHyIdjCnixpigOuySKh8e1S9Q4enZU5inT
	oK5bVH8L8A18XOqLMu1KvUvj98EM09OH2nIP/bgOycqZtKSDHiThhD+rAZjsCXCGd7OIBR9jMpC
	l3S/3C3awgRMBPcAb1M1tywQ0hHB0Dt9hlPdh22o7XgZDICwPh24mGfJbpkv9ATqKPo/Pm8JiTG
	tVJWN6M1kZzURV8wn/0tumjOLuIBMpk42Irrr2hFpFXha893n7UWayIZl9R21pCSYCvKA9Pe7nb
	+XHwP9A20YUlYZmXDRh4xeiBpUhA2vHciCjRHbIfcx8VI9IK2YRfgUnvA0eC5gWFiVFW6CPJQ84
	kkfiXh15M22RCHNxDKeeaLzPa9p5Nw0pAZnE94h5OBJk4LCXvK0H3EDO19Kcd4InR1x8d2VS+51
	/22oZFj7mWfPAZUBd3fVmoW/EhcrwKShrg==
X-Received: by 2002:a05:7300:3b05:b0:369:e8a8:b9cf with SMTP id 5a478bee46e88-36a3002ea8cmr21134686eec.11.1793544407273;
        Sun, 01 Nov 2026 06:46:47 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm32747545eec.25.2026.11.01.06.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 06:46:46 -0800 (PST)
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
Subject: [PATCHv2 0/7] KVM: PPC: Misc fixes and nestedv2 vCPU limit fixes
Date: Sun,  1 Nov 2026 20:16:25 +0530
Message-Id: <cover.1793543627.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RFC -> v2:
=========
- Addressed sashiko review comments
  - added patch-3 to address similar __ffs(0) problem on booke
  - fixed build issues in patch-4
  - added patch-5 to reject vcpu ids beyond the PAPR limit
- Few more patches were added. Few of them were reported by Sashiko and few
  others were caught while doing vcpu create path code walkthrough

Most of these issues were identified while adding kvm powerpc selftests
infrastructure support [1] (which is now merged upstream). Patch-1 and Patch-2
were identified while running the selftests on Qemu+TCG+powernv+BE, while
Patch-4 can also be reproduced on a real pseries LPAR with nestedv2
capabilities.

[1]: https://lore.kernel.org/linuxppc-dev/179211526968.809012.4905747914183363587.b4-ty@b4/
[RFC]: https://lore.kernel.org/linuxppc-dev/cover.1789099725.git.ritesh.list@gmail.com/


Ritesh Harjani (IBM) (7):
  KVM: PPC: Book3S HV: Read EX_DSISR as a 32-bit field on guest exit
  KVM: PPC: Book3S: Don't call __ffs() on an empty pending_exceptions bitmap
  KVM: PPC: BookE: Don't call __ffs() on an empty pending_exceptions bitmap
  KVM: PPC: Book3S HV nestedv2: cap max vcpus to PAPR limit
  KVM: PPC: Book3S HV nestedv2: reject vCPU ids beyond the PAPR limit
  KVM: PPC: Book3S HV: Fix error handling during vcore create
  KVM: PPC: Book3s: nestedv2: Free the guest state buffers if vcpu create fails

 arch/powerpc/include/asm/kvm_host.h   |  1 +
 arch/powerpc/kvm/book3s.c             |  2 +-
 arch/powerpc/kvm/book3s_hv.c          | 15 ++++++++++-----
 arch/powerpc/kvm/book3s_hv_p9_entry.c | 13 +++++++++++--
 arch/powerpc/kvm/booke.c              |  2 +-
 arch/powerpc/kvm/powerpc.c            |  9 +++++++++
 6 files changed, 33 insertions(+), 9 deletions(-)

--
2.39.5


