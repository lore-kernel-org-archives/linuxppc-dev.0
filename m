Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF092606A327
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 11:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hNHhq7+f
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZHSX49lMz2yCN;
	Wed, 25 Nov 2026 22:26:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795605996;
	cv=none; b=TIW/TQ/BVZXaIi9lAVUgmU4NPwB6eZDcPEfuCd25GIU9I96nwwBaPUHh9XcYOxaiLg234BjySvKGg7vB/Cj4ky7SXj9qhMkkIP8w1Tn/EyEOwaIZvjZODoy5yIpuHYLdy4CPjXgRlaeEFYZXkYFj3lCGz4lI4C+2pGC0PetBG358yb0Fzy0BUxdK942P80B0jfUXf1qQPH/DQO1iw7sM+Q0ESo91Qr+luuSwAJBBnwgooiPvUuTgz8npaRipIh08n6WN8/GtPHVOu9QlxuKVCYRQhr/4g3aCyRZ1APrhE3LXuKzV0bz/lqKduNqUeWBvFIcwLeLszH+2iM83GdHd1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795605996; c=relaxed/relaxed;
	bh=BDad+1Q3j6dYRY0ykgld/Vjl2b9srpFqahkLGtGJZw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=haqC2IzgHIe1l6fjpLsYJNvuGRO3fp/Rl+SqPul526WMyHnJ76IuoWSkQGaFumNphIcmCVvHAbBu6ruDpiQZLYJ6u1yew06BwxIySISluo8BkFgdYFT2QBp32ocCARhHdlzHlkUK3ny3/wEf8oG1zEi7p4GDWmMeGO0JOn8GD4SXIRMQzHwNfPDLRHB+SA2U2sS1/tKWs/fGkB7RbsthegH5kNhZy4Yg/K8BNyIhtWSvYFE4zRwnACqMz16jA0/GmQu07Dv+DNXnCBW9fwxJVYt9+tzz4SVnUm1++RxrqcOEHc9MpY57g9wkqj2QlkU4LyCLfyhz5Z/8tlGxThCpsA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hNHhq7+f; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132d; helo=mail-dy1-x132d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hNHhq7+f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132d; helo=mail-dy1-x132d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132d.google.com (mail-dy1-x132d.google.com [IPv6:2607:f8b0:4864:20::132d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZHSX04N7z2xKQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 22:26:35 +1100 (AEDT)
Received: by mail-dy1-x132d.google.com with SMTP id 5a478bee46e88-385c497bf94so2470890eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 03:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795605994; x=1796210794; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BDad+1Q3j6dYRY0ykgld/Vjl2b9srpFqahkLGtGJZw0=;
        b=hNHhq7+fuVnLdonwKkWplNq7X0P7c5Q54NxRzzoEydj8YkgQtJ6FhPMPdAGu6ZJllD
         bQNZpStobPoH0jJ6XwLxXC4AhiJTsac/MwRpYDI6OQ949p5KCrmrKeVp90LcxiU6U5s0
         CHLTz4pGURddj7OYYuNekkXbS6VnYRHkpEuYnuCx/z9bT0Dnttuoa5m5GAR79BEFA06Z
         e3LYsVgGxlu3dOC2NiIrhlBT8fr+1017tnw56J6EJqCQ/jxBc1L3DFF935b8pktkBttG
         plFI5a0vWj6X7eh9zRwG0UJAX6POffMv8GuGtGCOAiWaG6Vq/ztT2DjC5088QZm5ly7Y
         Av3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795605994; x=1796210794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BDad+1Q3j6dYRY0ykgld/Vjl2b9srpFqahkLGtGJZw0=;
        b=ApneyaOt7J+C1oq4xS9+hWbzaeH03K+sYDmMKzkScNNDXXnCGTRIEOFV7VYCXs7mLY
         egZWEaCyeIOGPb1GPS0gFpySvOfLXNPwjineK0fFO9sKqWk1Vu2lwqUdZ6yEQEYTwVgj
         /eZSzgcKzCRgSAJ+uKsK3Q4s1x3GSiPDZnxK86bGgGf5WpYEDEep/BGWXDryLTGWvCPm
         UQWOoYlA4eYWbeI65gCAnP9UbzdYH34ptDCvVi1GGy4zClJ1s5eKbC+/z47LSj6yZCih
         Ok700ppZcwqniAADpf9rV8Xr6qikzJqmPDUQ9BHtC2EkYCd+8qNF+uJDGK56owhjCCwn
         Wm8w==
X-Gm-Message-State: APuU4Z/JjBC9iXQjFKpfzdfsU5s6r/kEjxzOr/IOTJ4aOY+pI4bXcJDL
	+bPbFV2VWX4sr+YxW8wYIJG7ve/BSteQLkCcGAEP9Pe8RISUPRKfzLPnkJkAmA==
X-Gm-Gg: AZFdTZdCJXXFX5j4lfizTJMIGx3Wnyppxnth5svY0lTKH0IzM5D4s3Aich+EB3UcSUn
	e57i0gJTG46CmBQOHzGm0v7ldOg/FHovXMhGq3qFIPVjEBenLwyE6Ac3Gw/LE/92oKbaLBRmJvb
	a/Yk6NyljUf5nIqlIWI14JLFk0vaTzSBDE3dZfIskbdNeTARF4utbk1T+c+gJm0rBWlzM+fnKeG
	LlCFMqbECrz4h1Fk3GgMlVvwzIDrebV8IR9i56qLtCGnobbdk0NrqKMDPcYUzGQq4mY+WAL3F/O
	0vZp7QcZcGxNnkRAR2Mhqdc96k0laUdn9vsTWtb9kKp/HvXE/N48w/eGnYWGWm1f5IRD+8GnLUt
	kkncViUBhvy6T0erkNNGL3R/63iM/0M+P1ZTcTsiHE7Bx7mShU6rKdQOk2ab8lpJuki95zj1arE
	FcH8y3adVH+lG4UGvTO1MzoT1nlMY8RTKe+asIcjEULzPBCcfrVESFV+Q+IE2g+JAH5uiXhXumb
	J5vmzieLHT+Oszq7W5A/5mPBnXu/armkCFowrOXxvjh2B0DvSGZr++SDoI5W/RrJ9lywgFRIVxs
	GZszZi0eCT1RIqg8X3y3kT2/WPa628yAXA==
X-Received: by 2002:a05:7301:700a:b0:384:988d:6ec2 with SMTP id 5a478bee46e88-3856f6524acmr19373422eec.33.1795605993905;
        Wed, 25 Nov 2026 03:26:33 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm11778380eec.17.2026.11.25.03.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 03:26:33 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCHv4 4/4] powerpc/kvm-hv-pmu: Free hostwide stats buffers if perf_pmu_register() fails
Date: Wed, 25 Nov 2026 16:56:06 +0530
Message-Id: <158060809f1d4d3708693a6cf33d40365c3af2e8.1795603946.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795603946.git.ritesh.list@gmail.com>
References: <cover.1795603946.git.ritesh.list@gmail.com>
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

kvmppc_register_pmu() calls kvmppc_init_hostwide(), which allocates
gsm_l0_stats and gsb_l0_stats. It then registers the pmu. If
perf_pmu_register() fails we return without freeing them.

Call kvmppc_cleanup_hostwide() on that error path.

Fixes: f0c9c49c5067 ("powerpc/kvm-hv-pmu: Implement GSB message-ops for hostwide counters")
Cc: stable@vger.kernel.org
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/perf/kvm-hv-pmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/kvm-hv-pmu.c b/arch/powerpc/perf/kvm-hv-pmu.c
index a58634f656e9..ec05b4855736 100644
--- a/arch/powerpc/perf/kvm-hv-pmu.c
+++ b/arch/powerpc/perf/kvm-hv-pmu.c
@@ -402,8 +402,10 @@ static int __init kvmppc_register_pmu(void)
 
 		/* Register the pmu */
 		rc = perf_pmu_register(&kvmppc_pmu, kvmppc_pmu.name, -1);
-		if (rc)
+		if (rc) {
+			kvmppc_cleanup_hostwide();
 			goto out;
+		}
 
 		pr_info("Registered kvm-hv pmu");
 	}
-- 
2.39.5


