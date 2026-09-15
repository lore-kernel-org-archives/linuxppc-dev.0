Return-Path: <linuxppc-dev+bounces-27319-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1C8C88E53
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 10:50:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkf1L52Wcz2y8m;
	Tue, 15 Sep 2026 20:50:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4860:4864:20::36"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789459460;
	cv=none; b=lZJpm94xSk2ay7eKDuXpjGbKy6Fowd+aEO8kXXFG3YM6vSz9wG3l7QwzZhDa17HYc4h9e/7DhBlL8HKb35xAQ8pfuJVzNqXHVrqWH9715I4Q1RhfLnDoSTJkvWkfpQcXmyA7x91eH+uOPnvrWsFpGt+4RDsuBuSB42FqbkhUum9/Iz1bJJStcKJ+orVefa3DN/kMAt98sW3N4ZIa5vKt5uv66gkbccJ5t9hpQutzbSwgbIDU5EUA8TvzqF+9Lw9VQg+W5FnxkyWHdNsdUn+Fgf0rGHjYQt6hzYmXpBZvxS2kaosK+5MlLvYo4hvWrntQT+b+UtVDTf793F9OZyCOqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789459460; c=relaxed/relaxed;
	bh=skIHTRCMg076kDWG2pdx8YKlOQsvXC/Hd109poRNzB4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=kFCZ6Wzq1EDZjr3pyPS3tcawRDj/mkiMTJY3EDWpr7J+LRf4azL9a0lmAccWCufPe85xUtvdL/JEAIi9EDRDix8n3NhivRFffdt7Ek2c3uCDRMEmQL9kmNNuDi0Ph8NCe/VFtnUcf/aXR0GIuZu1z2j2i/eDeDcqfv9Zhe6yxDzlNoGfxtqcuWbeok3O/1Jz24tWmEbH/1alexh7MqNNzXN96ocVfWGeYkyVVVS6EmUNQ+Efj3qjoJavUqz41x7JBYBJ9S6CHIs2vJktG2AwLo7zYpeV92FQMPsVZDIQCriryBcRVvJ96AZyT3dZ2CkdGhebe9fo0o9EWWM9dTcbug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oMOOpdT5; dkim-atps=neutral; spf=pass (client-ip=2001:4860:4864:20::36; helo=mail-oa1-x36.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oMOOpdT5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2001:4860:4864:20::36; helo=mail-oa1-x36.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkZKv3Gm4z2xSg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 18:04:18 +1000 (AEST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-4827cc09eefso974897fac.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 01:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789459451; x=1790064251; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=skIHTRCMg076kDWG2pdx8YKlOQsvXC/Hd109poRNzB4=;
        b=oMOOpdT5yb8pmb0ZebttYj6AePsktIPYQfMECburkjCyDjt0PewRgvtMcidOwCghih
         6bWxjNjLe94jC0cdRWPJosJIncUL6YN4wtlIdnP1Yw/xOCkAIRctSTSbjMbvH8hh0F9p
         uxKLmhSOTSLwOJaQ80x/3+dRwdZv2ryl7JpeVCeVVx7KQ7SVO7402o0PKjbRigiYo2El
         KxnLutgFcfu5ZsNzZyGYKbsOetQfomYA6HaPkPe7zwZzlSg6AMmblU7n5QQ9+DeLrWTL
         pPx1Qm/eHfqknbWmxfGqpLt0jC8LtUVbps1xiEyvqnYZ41Fky8SILFrnNnseO0uMGUA+
         l7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789459451; x=1790064251;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=skIHTRCMg076kDWG2pdx8YKlOQsvXC/Hd109poRNzB4=;
        b=eRZPPDHbbTXoP9BToYCldVukd3oE3Cet2noXhV4R6D8fm2IHyLmQMm2GN0OoHwT/49
         KRg1LPUYyupBzEKMvGCSYE37w0OnKNRxo5DVLpeBdKiWEt9m4+AYDCYdg9bCmO9eZAGt
         ylpB69dIuZjAA+OfjUYWzWP6wm2nziuMIaQfqgsl0m2MPb063XB2dtglLEdmRK59k7AX
         3OnnSmf5Yqi8hrHCEPmHjurFxf03sXr9Zblon/aUTcz4dW2CgD8hpC1JIUEFBhdZzlQz
         5JPo3C05TnC2XTEuNNWIE3kzc/hwHtq64SXgyfLXS0Xo2/+IfqAThJqd8EkqkzIfYuMK
         bqYA==
X-Forwarded-Encrypted: i=1; AKwUvBw3geiy9BnAMCPI2RQru4hghhniT6T89+bzX/ye4MOebTbWHzwXeIlc4228Ppx/dOULuFCzgfncJUMOksc=@lists.ozlabs.org
X-Gm-Message-State: AFuF++naMQKpRKT5TB4KJu6kB+V8zLGkzwMwpyR8u5RJ3yNRUjROZwLJ
	JDXuQA0C/XuQzcr8tWJXfePml3a5elVyIbkyxg8QGdFEhzPHjHUe7bXC
X-Gm-Gg: AYBFou0Vtsk8WDmdlOLmymCrnm103a0EnTHvNOUywphm8+n+I4RqMuOzZaB+tenWbjE
	jWPnILgLcl+iAxE2YqPFuackBEmO2AFp6+zcsNK9xi7Gz4w/FmRfcoNkjlXo5ksrC09JlsuQgyA
	AtXtNQJi7i8dVamMIhPwUP8MR4bFYZSeKYXUI9TVZtl1aVotx+KM/vq1ZxpeKBx+zayKCLbVkNn
	b/9USlRVtfGbADMmm03nKus/eJeZHmm1/xIX1PxRNC0a7KDQOwbbZCLarV4bnlcC3iuZHzp8GDe
	DgPSqPGLoDBHGFF/KiLCP1WMtUipSXxqxotrcDAmmVr69Y0XPg7FmcDN02mgZVwHNDcbLTjElud
	u42LKIl10mHNjGvl87w/zUA22keXEbHWeIhiH7eIg/G3jM3MtUwde0WzbQaVY3Bv24C6VMChrAR
	8wdWYFjVYL8nFdXzVaI1nTVnJ0pLOTSLnSxCE9l6UwdsqrB6EGs3ZdnAVAHpfWfsIkWODJwByFQ
	hJlpA88F05FuNSnmM/SWybJWFOBadFm7qFCN6jXfGa2zF1+F/9be4M=
X-Received: by 2002:a05:6820:1628:b0:6b8:ef7d:e181 with SMTP id 006d021491bc7-6c544daaf8cmr3999047eaf.54.1789459451326;
        Tue, 15 Sep 2026 01:04:11 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b97994sm57642954c88.12.2026.09.15.01.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 01:04:10 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Chris Chiu <chris.chiu@canonical.com>, maddy@linux.ibm.com, shuah@kernel.org
Cc: sshegde@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Chiu <chris.chiu@canonical.com>
Subject: Re: [PATCH] selftests/powerpc: Fix exec_prot test failure on Hash MMU
In-Reply-To: <wlsnyvt2.ritesh.list@gmail.com>
Date: Tue, 15 Sep 2026 13:32:02 +0530
Message-ID: <v787ymbp.ritesh.list@gmail.com>
References: <20260909050919.3344699-1-chris.chiu@canonical.com> <wlsnyvt2.ritesh.list@gmail.com>
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

Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:

> So, I think what we need here is:
>
> diff --git a/tools/testing/selftests/powerpc/mm/exec_prot.c b/tools/testing/selftests/powerpc/mm/exec_prot.c
> index db75b2225de1..51ac2f9c14a6 100644
> --- a/tools/testing/selftests/powerpc/mm/exec_prot.c
> +++ b/tools/testing/selftests/powerpc/mm/exec_prot.c
> @@ -167,13 +167,17 @@ static int test(void)
>          * Read an instruction word from the address when the page
>          * is execute only. This should generate an access fault.
>          */
> -       fault_code = -1;
> -       remaining_faults = 1;
> -       printf("Testing read on --x, should fault...");
> -       FAIL_IF(mprotect(insns, pgsize, PROT_EXEC) != 0);
> -       i = *fault_addr;
> -       FAIL_IF(remaining_faults != 0 || !is_fault_expected(fault_code));
> -       printf("ok!\n");
> +       if (pkeys_supported) {
One quick correction - I think this should be
            if (!hash_mmu || pkeys_supported)

> +               fault_code = -1;
> +               remaining_faults = 1;
> +               printf("Testing read on --x, should fault...");
> +               FAIL_IF(mprotect(insns, pgsize, PROT_EXEC) != 0);
> +               i = *fault_addr;
> +               FAIL_IF(remaining_faults != 0 || !is_fault_expected(fault_code));
> +               printf("ok!\n");
> +       } else {
> +               printf("Testing read on --x, skipped on Hash MMU without pkeys\n");
> +       }
>
>

-ritesh

