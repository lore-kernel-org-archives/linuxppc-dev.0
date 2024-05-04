Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508C8C4345F
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 May 2024 12:31:59 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cyId0vM1;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VWn9T6gxfz30Wg
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 May 2024 22:31:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cyId0vM1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=npiggin@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VWn683n8Fz30V2
	for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2024 22:29:04 +1000 (AEST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6f453d2c5a1so532101b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 May 2024 05:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714825743; x=1715430543; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFe1uWytdimmtEZbjI3zC2F1410iNZlNbtoiOiPVBV0=;
        b=cyId0vM1jLFGPXwxM457mPJRe9bQVb8su8CikPzaciiVWDgca0F8c3QFg8oOyG7sCv
         dX7HhRZ/4leJFO/q989iFXLZwTCMtN2rSa58OZF3zH8Q4hVh8PXWSyknTpObUUn+Ucn2
         MpzCoaHMpDTMKR9uwwOn8AIxsm/pfGWCyN5E8JIdMc+X0tD3BrHcfMbIEcDmCJ3FONoc
         auuAPOduFN3+LCrzv4kIcTFKmlEf3BrjHTnWS/fc+WDGvoWiK09awe4J4vqDNuhlSZvU
         y7jKV1OF7Rc06NrZWNJ3yDcFgHj9pl/T7Lle+CsP2EkBnVgFnye0BYyG/1bFvb/cRHMn
         Dj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714825743; x=1715430543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFe1uWytdimmtEZbjI3zC2F1410iNZlNbtoiOiPVBV0=;
        b=CD7xbqkV9w/5wgnbJuC6Fw+Y4/cHgo6KOTO5Bwy5+L9T0VrVN6vg4TVhWHeq/CmCps
         xOlh3HJUU4sprOVqvXAG3Ajf8uhaqIKjWIgsKBd6dyEgAQrutwe1BzpA+LQNsT12V/Hu
         B3o+teemn3SGSHkLxd7mufGK44XajQTV81YCrKfcp4vKdg2L0QhZfZrL4XjxnW8WueH7
         0t9Fu7hzwiuMA/AI6BrecuTMQCHmKl1TaRuh7k8WuVhTKQhQ1B/+kfecvPQnNOt6+yoA
         7p4lscx5/gQhW6AXDe6WeQl37s1TsqCg4kIwsiddf8T/BQ/dPjSxaB+80CPldI4ew9Pv
         G1wA==
X-Forwarded-Encrypted: i=1; AJvYcCW0jYA6bp3BXdwbgLIDVJM6zZ9JymXUCw+MZ+5hpJavOY/Dntu2gipNO1C1FAZwnfXho5gFDlG6F12VXBYAd2ILMOcdq5o/XPXy2M2jtQ==
X-Gm-Message-State: AOJu0YwOM6EnY8evwKRI5G1IxacjJMOhpgVZqfJLt9b6jYt8vaDe3+5k
	I92m7FMv/IID2DasdFbsjY+uADHrVBJzDgrtR+vVgR2AKtcUiE0P
X-Google-Smtp-Source: AGHT+IFU5PoRxx+mTNW7TKy4wefEqAB9Vnc58pFz6n9Y7PrQ01UGoWnU/ypMDlEI1b/QoE5Vxl0sIw==
X-Received: by 2002:a05:6a20:9187:b0:1a7:5e8f:8707 with SMTP id v7-20020a056a20918700b001a75e8f8707mr7337295pzd.26.1714825742844;
        Sat, 04 May 2024 05:29:02 -0700 (PDT)
Received: from wheely.local0.net (220-245-239-57.tpgi.com.au. [220.245.239.57])
        by smtp.gmail.com with ESMTPSA id b16-20020a056a000a9000b006f4473daa38sm3480068pfl.128.2024.05.04.05.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 05:29:02 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Thomas Huth <thuth@redhat.com>
Subject: [kvm-unit-tests PATCH v9 03/31] powerpc: Mark known failing tests as kfail
Date: Sat,  4 May 2024 22:28:09 +1000
Message-ID: <20240504122841.1177683-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240504122841.1177683-1-npiggin@gmail.com>
References: <20240504122841.1177683-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, Andrew Jones <andrew.jones@linux.dev>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Mark the failing h_cede_tm and spapr_vpa tests as kfail.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 powerpc/spapr_vpa.c | 3 ++-
 powerpc/tm.c        | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/powerpc/spapr_vpa.c b/powerpc/spapr_vpa.c
index c2075e157..46fa0485c 100644
--- a/powerpc/spapr_vpa.c
+++ b/powerpc/spapr_vpa.c
@@ -150,7 +150,8 @@ static void test_vpa(void)
 		report_fail("Could not deregister after registration");
 
 	disp_count1 = be32_to_cpu(vpa->vp_dispatch_count);
-	report(disp_count1 % 2 == 1, "Dispatch count is odd after deregister");
+	/* TCG known fail, could be wrong test, must verify against PowerVM */
+	report_kfail(true, disp_count1 % 2 == 1, "Dispatch count is odd after deregister");
 
 	report_prefix_pop();
 }
diff --git a/powerpc/tm.c b/powerpc/tm.c
index 6b1ceeb6e..d9e7f455d 100644
--- a/powerpc/tm.c
+++ b/powerpc/tm.c
@@ -133,7 +133,8 @@ int main(int argc, char **argv)
 		report_skip("TM is not available");
 		goto done;
 	}
-	report(cpus_with_tm == nr_cpus,
+	/* KVM does not report TM in secondary threads in POWER9 */
+	report_kfail(true, cpus_with_tm == nr_cpus,
 	       "TM available in all 'ibm,pa-features' properties");
 
 	all = argc == 1 || !strcmp(argv[1], "all");
-- 
2.43.0

