Return-Path: <linuxppc-dev+bounces-22696-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AB1CD98CF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 10:11:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfjSg4dvkz3byk;
	Tue, 16 Jun 2026 20:11:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781604691;
	cv=none; b=kPrGDJgcj+pWs67ZEdyFFGx3al+lKezl+LzBiSK9XRSG5AK8iG2Q6TrpfnnfiIL23a4/VLVGizV5wFpgRJwMkMRVrNNPtW5I8FbSEPMcJXN0tszLtHjF8lSLtGjaUZb1kiwB/NFGGRO0uKcxawp807bubNhsXvWDpJBAmo95tv0m7j9zxrBTgsZR3rQnvbwEIALmjIXPfbNYgqFhRZ4jTCva4f6W1YlKjvU833bCZ9bUEtno+eNPv8zEfBWD14DiybgdGwz7/kQL3ypp7Z2zDCauHO2feJuDJyIB3Sc39r6Tuk2G62k/cT4miM1Z9/e8EqZ6Kjin0qn0MhD/iH2Itw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781604691; c=relaxed/relaxed;
	bh=EjK9bOT4HxhDpI2JWZDdTH2Qo6aFDccf6h//ov0/4Kk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=C3ZS4zPmbInqRnLSjYDOj3z/Uo/BGISrlYm8QR7WZrcvP/5/pADJg1z4OobfTuDFR6kF81sf29dTeKZ1KZIoH88WkF+ear5wLumvg6k2NVJnkWhBtYXTh4hDyIiFeWggso3r9G3uJ2qsRVBIXcD9ZXGNHUwJPdhysy1QCcrA3s3QGwCXqi6qHdODhkmVHlBRMcuxNGMCvGNcxR2TVn7srYV8UBEPafvzQ6P7+BrLLFKUqVDlNhhPptFPBlT4qApoIIkFwUNHOVNwrzVfBU+G8BYt+t8Z9YhfLt5rFhbpeb6Ctw3dOm12R4l9HwkP78ndstp0Lclo8Hcjukn3Zw5T4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EVZFcNbi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EVZFcNbi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfjSg0Gljz3bt2
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 20:11:30 +1000 (AEST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2c40397e746so26018275ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 03:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781604689; x=1782209489; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EjK9bOT4HxhDpI2JWZDdTH2Qo6aFDccf6h//ov0/4Kk=;
        b=EVZFcNbiKQmtPs/UhZvRm6C1pn9ydKTKTuALoIVAqp93TY46ipzt/kJQ/DDa1Wt7tI
         TSbmzQE6KaKWEEpS49UoaBKkyguMRMav1hcaUbuDXUEjGEi0DvLdf2QE3MmaMD/WkMI5
         ACJigPtE/X8nM34F6SIdr6FMMclvi0cwF6uL4sqcCnIqZdBhKjGCYt7JPy1DPoSUP9t2
         OFitqkzW6TKTn2CW0NyHCinxcMHjkI0HqUklNKt7Gvc6N8qWQM2iot7rg89P8SeKNp8I
         8WeXUa0hzmDtIVV0ktTj7qZ/8rJ4gsIqefWRTAjtooFr8ii7HYvS2yKYxItbbR1XCJHn
         pYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781604689; x=1782209489;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EjK9bOT4HxhDpI2JWZDdTH2Qo6aFDccf6h//ov0/4Kk=;
        b=ogJoHa9j9P0y75Egx+4QvFA3a68uWrgQmkaQjnZDXcfZkSjwgTjO9XPtEVTNl44Uru
         oqeemMaNsV4A2y5nUAmuKQcxM2vdTr6YbvvkUORP87MQxBGOWFBjdPR0I3XHzz16NrvF
         6apImsewTHDlh6TEqbXXP0CoIGpsMljWA1cU6GOjDInjIlQYmIZFSjoivsRDFpkY2RCQ
         GNGxg02HTASZ4SNv0dBA8WYrhGo8vAk+zvQ1kOtkEQR46BfKpxEZuzXx805uonJ/feIs
         8sLSb3JsngZk/8WrQAC8bDuuf9R5V3tEUbxtx9NnbN591vKtwm7uP3LVRuz/w0Vn9JK7
         9HKQ==
X-Forwarded-Encrypted: i=1; AFNElJ+XKH3pd66VOJk6TaKNEU2qVfFe2dlF+bA9pi3cAQ5LgQmmaXXYKncnTNQ9+joSLEn8Xz63HaO+O+Ap/T8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyVNIESk37ev+2sc1lS2jN3x/YB2U6MYyTg+WuCyMUeWWhuBX84
	Efy6jKxMF/C3F/ZqwBBTlmf9tag8+GsKk/HCWPGyyw6OcyNn/scm4U3D
X-Gm-Gg: Acq92OFycn2/k1ZbmQ87OHx5Q43pIKQiCLY53Pn/wCcjlhHwU3B0/LgnjchyQlVyPy1
	HGVfE2Pcd4yakUrkA3kSjtS+ia3RFOnMx+MepDUqkIG0763Bq8Tw+ohJVTQtLM1GMtnRw4THcrM
	ox0Mse6+LRrUcQSKdyLi5f3vKko+m6q0kdWx6HesYK9+p0aaQdbuwTIHlpnhc5HOt0v3XD1EtId
	ELUmnrpBPUB0KdzdqcHpO/K7hVILcdtkbALY6joLvYcUrXBzU7vHzRLJ+WkDjqYbXa1wWHsPNnB
	b2m31KXbKlnJRXRLQXuFArlsKH7exo6+e2qKEbcNucyfYr4xJnJldZ+20f9gS4Jqq6PLMWvXZ7K
	Mem6qUcntU8QM+LqI83AVTsuiCog35kkjem97f3qjhi00o/b3Ndv4Y2UeGeEEKSWv2cwU2mlwCV
	UtXRY0F8jIxKcEATr2Mfp1fVnYwQ==
X-Received: by 2002:a17:902:ef0b:b0:2c0:f807:9bf3 with SMTP id d9443c01a7336-2c69a142023mr30873995ad.10.1781604688658;
        Tue, 16 Jun 2026 03:11:28 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c432c8ce89sm128713805ad.57.2026.06.16.03.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:11:26 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Sean Christopherson <seanjc@google.com>, Amit Machhiwal <amachhiw@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v5] powerpc/pseries/Kconfig: Enable CONFIG_VPA_PMU to be used with KVM
In-Reply-To: <20260615091120.84169-1-gautam@linux.ibm.com>
Date: Tue, 16 Jun 2026 15:39:39 +0530
Message-ID: <bjdaeqzg.ritesh.list@gmail.com>
References: <20260615091120.84169-1-gautam@linux.ibm.com>
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

Gautam Menghani <gautam@linux.ibm.com> writes:

> Currently, CONFIG_VPA_PMU is not enabled by default, and consequently
> cannot be used for KVM guests at all, unless explicitly enabled on
> host kernel.
>
> Mark CONFIG_VPA_PMU as "default m" to ensure it is available when KVM is
> being used.
>
> Cc: stable@vger.kernel.org # v6.13+
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
> v4 -> v5:
> 1. Drop the fixes tag (Ritesh)

Thanks. LGTM, feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


