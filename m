Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F4D606A32D
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Nov 2026 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xmnmTa2x
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jHdz26XNCz3bcr;
	Mon, 02 Nov 2026 02:28:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793546926;
	cv=none; b=I6gEuQx/pgLZuxa7ZtTlc24Jsr9VlGq5VDmHXLoiWa5knHz+h23sDE8zkmCG4/RLyIKYjgBhlGxz0Azfr3fOcpmpv8Q30kTrOLzLFiBhN5HA7ceZ5PU3CJY3wvGFABXUbPqmtDrgkD95q37DR9s87SpeCTYox0dQBnym4oGFY3PyOnjFMOGIWgLYocJtvL7nvVjQm9Chc5qJWnCnCBZo7Rri3GhnGIqy7U6IxTWa2xAO215nynBtLlwEXPpynP4ySYheL7bGksmKqdmgZgAYlraJjsqXxVjxGzJq/zIWErA/c65JVRpwdu1W25muY7tFihqeNtqnzGG6LSW7sLehCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793546926; c=relaxed/relaxed;
	bh=qduAH+VDk53vSkstbY9xaGv+g9KfxKxHxkbXDOSNrm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RG2pB1zFc6HpsGZ16GB48LTNAqGP/Kvmz5LlahpsXMiGobcAq6mbBhQVCEX8TEmFYcwattRcgPWWnpZ/wvCAnQX6jOiWNWV/a1xgTv22g3oXc+JmKKlXgG7G+t2FDGFLa75e9ypidBnpCYOhhrkdIdeV1R2vucuVXwTdhbUHeczS+DwvwxIp2zAQod6SzUJu1OGWLFiX9P9143DX3N5eXQIvVyMRooOpRMDb8PAxSIpb3YLuAT2XCFF+C8kOnubIY4AmYbVAngOUbS/vWTIea4d3lzu5rqqPkQXw4OFQY1wt8iQv7tC5QTchupjWnWcjCWL+z/HJ7r6MQ7mRjvS+HQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xmnmTa2x; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122c; helo=mail-dl1-x122c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xmnmTa2x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122c; helo=mail-dl1-x122c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122c.google.com (mail-dl1-x122c.google.com [IPv6:2607:f8b0:4864:20::122c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jHdz21pnyz2yST
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 02:28:46 +1100 (AEDT)
Received: by mail-dl1-x122c.google.com with SMTP id a92af1059eb24-1a2761c69fbso2953145c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Nov 2026 07:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793546924; x=1794151724; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qduAH+VDk53vSkstbY9xaGv+g9KfxKxHxkbXDOSNrm4=;
        b=xmnmTa2x0l5KKn38QkXkr1Jv5TM1j1H8DsolQ/jlzNn1UMnuPUvVMagYTuLh26xsFe
         WWO+HBBY1xD460GeP+v0kLfbI1guqq2XqfP1217ouLckyrRR5/g+VgAwZp2p8TI55UAv
         tMyqNQNv7XrcVwYcNVwzNlAuMbUDHLdqdvL06UlncAKxLffwi1V68zZuA1L3vKoYtYVw
         XpSyWHxJWhBUhpJo5vSi/P503sFTzmnoBw5NanRbsq120yq/WqF1fphtWq9INKVZjxMv
         KgkGWmG8hJpjj472KYqwoFY9YhO3F09fEn6cWVV5h8rTb6tIrNywtP0q2HTBuYRdMKQF
         pFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793546924; x=1794151724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qduAH+VDk53vSkstbY9xaGv+g9KfxKxHxkbXDOSNrm4=;
        b=URVWZpV2j4Dlgc3OVNiE+/j8XUu6m/2bby+BykKMrVDJBKyckiuoJ9PaoVrkGJ5UDu
         wTW4B8pvRB8bSS95HLj2DkTI/8WCVEA2OfxYU0Mx4H9bolJ9jcIDy1Bu8vkpDom401UW
         DnifZrqgZzbKXCWbddNvwIchAG9jLT7LquqygRbgtcVZOiJMqNUHvWQd99jAq4GVHnEM
         8rDzasK/GH2OnD/kn8KwN1ICmqdrZzQ5SWXBU37IVdYgfv5tdXCYLqqkZ6kd1cg+Jo8+
         9OOMIsLKiOy53OB7JmEsYDeMskHfd4CsISvwLoQfO28CYEnXVZbTSjrOmriwoP0Piin9
         Pfkg==
X-Gm-Message-State: AFq9FYJTxKVSAkcFfb7KDBb1/kN7If2vKdew9wwzu3akLmfN0y6f1fvH
	ziHXmP7vVk1vlAiCp9YzjHncfvrXEBKE5v9cpFLax7Nu57czYTMak2u2uKoXmg==
X-Gm-Gg: AYBFou2ZdmQQZN6zs6KA/Ug9wrRFtz080JfdAmyxWFNdVcGVYuXaafOBS2fMMuuxSZI
	N/ab5Tgba/BpWnAC1bnjHGrL/LajkuqVrhylUI8LeqYkHw2TEGhDI+FctCDjbYSH7CvtZKqbzYG
	q5eX+xB7c7lAYKwhwnYSREWWEiha8/Osxvxyy6YRgv17W48JwYSYej22fL7aBZu6C8XuKpd/fux
	xO4HTGlLjN0Qigh9IDrruNqqHEmHTB5ChB6Q4OMAUEFr79T06uwPS9XaDIi3ZochD0NKekf7TAt
	dJ8hWrgCA5blWhtfKmJidCkEXSc2gRQciFr2MfflbcMqg+3q2wb1uF7SzJSaOM4b3rrFouru+dg
	vNxhyWGG9tbrEWwSZSpK3qM8i6ebMx/rv36zHXuT50ROw+qbYAwrId4JM+XYXqB13w7JD1M+s7I
	tGMgpwUlNZFeGCZ9kreynnKSgF3kiy0nMsbhESJX/wwTHC/qKobAAoAukZWKdWX/MFbHBCfHypx
	XR8tTd7KjJ7vZSZb7jNCxjXw5IaoG8jXCOmeNoZLy8E0K2+zOFSEbcww2TJb7FA+Yw8vQpnjiN8
	rIVQgaIUBrWbhlD8HHjHbLSf+D8BI5Ku8g==
X-Received: by 2002:a05:701b:4784:b0:165:4b88:abc2 with SMTP id a92af1059eb24-1ac5b5ee632mr14506105c88.26.1793546923991;
        Sun, 01 Nov 2026 07:28:43 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm24862665c88.8.2026.11.01.07.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 07:28:43 -0800 (PST)
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
Subject: [PATCHv3 5/7] KVM: PPC: Book3S HV nestedv2: reject vCPU ids beyond the PAPR limit
Date: Sun,  1 Nov 2026 20:58:10 +0530
Message-Id: <3b233fa135d54d3ffb569d7febdc1cb8e0ed406a.1793546707.git.ritesh.list@gmail.com>
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

The previous patch caps KVM_CAP_MAX_VCPU_ID at 2048 on nestedv2 but
nothing actually enforces it. The generic KVM_CREATE_VCPU path only
checks the id against KVM_MAX_VCPU_IDS, which is 8 * NR_CPUS on HV.
That means a VMM that ignores the capability can still pass a larger id.
That id goes all the way down to H_GUEST_CREATE_VCPU, where the L0
rejects it and prints, ...

        KVM: Create Guest vcpu hcall failed, rc=-56

...for every such attempt before failing the ioctl with -EINVAL anyway.

Check the id in kvm_arch_vcpu_precreate() instead so it fails early with
the same -EINVAL. Note that PowerNV and nestedv1 are not affected.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kvm/powerpc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index cf620b6534de..5f9cfc34bec2 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -778,6 +778,9 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 
 int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
 {
+	if (kvmhv_is_nestedv2() && id >= KVM_MAX_VCPU_IDS_NESTEDv2)
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.39.5


