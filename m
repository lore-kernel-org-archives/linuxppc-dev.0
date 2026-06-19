Return-Path: <linuxppc-dev+bounces-22787-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DDACD98E6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 06:18:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghS8N4479z3bpP;
	Fri, 19 Jun 2026 16:18:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::435"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781849908;
	cv=none; b=TMF7XUsL/62NqAKwlFPm+BT8KCJP+aA5Z2BwGsNGHIUgYkPe7b2cshLgaFlFDXpmtVzuwqdEqchGJtdeLyok4nwPCTH2iy5EjdungacKjUcDKNa2nC4r3gDZw1n/FSnFHRt2ZbCy0K5fs/u+XnfDkUFVDmwdEXYJPVgMEjRsK2UcrMBKf3/+dus4Q23M7vRRiLVO2Jc98fuEc30OiAP9l6kQmNRKD4Jr2wIU6g6vv5yp2rXeSfKjoY9DTI/+xDu7H5O3SWp3EnpKmCPiq1p1DiU8ig1UNCBLRUVr5eKkohTiIt3JrVKmFDpjRmFW8JTKrvFsveGLU3S7P+voP+RoUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781849908; c=relaxed/relaxed;
	bh=EHfg3PbWG4R9I3I+J+lPr6BGFQqbCUCgzzGk8YcR7j0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=JzX3SZVQ3r+nkOr1T309YpYHJdZVD1AGIxsl/qzuAA6Uupa4Shb9Tllms70GU1+OLnMX3Zx1Q7X33PFw5mwy6IKOQI0JhSfh4o7P//ygNA1d1LR+z+Sk0WfDo0Cmxqg9ZCunmpb4Jbvlmm9Mm0yKRZRKMADCt8BmGgYYnTBpia51vAgrRJUi+CrCQ1RSwk8DWTtSu9qlTeWEq7YddFZTPHjHOFpS3FNUW1vCBW4w1LK/pUd1w13p0JuQIrD7pqeWTutNZrfem1Zc6Z5O1ngbdMH7a0uQJiEtmvIPmV1oYQk4noV46Q11jRShG0F75hdUt0SqCxie+6AKgDzcVw0PhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Gvj4eSh7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Gvj4eSh7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghS8M2000z2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 16:18:26 +1000 (AEST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-8452a597afcso1049616b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2026 23:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781849904; x=1782454704; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EHfg3PbWG4R9I3I+J+lPr6BGFQqbCUCgzzGk8YcR7j0=;
        b=Gvj4eSh7dE0RNcKyJ/4DEEMeWhV0isVeNnWl6wPcQ1oKA4N8iQCvJz+jTrkUdav/ck
         HS/HVkzX8BsnFwd3xS5OmJc9xNWnbscPPEkCNSo5QOWzwE/z/zZLYGkhxczHTbtsOTgC
         jpmj3afeBJCrUQuD8x0wt/eC39dFaDy+l54rG9wkpFSuU2+CqELNmLXrja/x2Dat5I7N
         FwDyxHmcyYrDX3YOJNuQiU9cdJ1r10ADZOcaCdvLvcfEjf7k2jpDOrh20NP2rYDrUuvv
         /9dSl0i2p9mLzDqteHrxhqyseNGhnpswWF1kYGWTD1u4dS4MsTFMBR2kGbRztVGTcmvn
         i5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781849904; x=1782454704;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EHfg3PbWG4R9I3I+J+lPr6BGFQqbCUCgzzGk8YcR7j0=;
        b=EKuvii6MKDjUOytIpJEhj2clb0UGUdKstEBchlukqnX6Broeia3PwdoJhRZV09KbIE
         MzHzfANRG2MjhgWcULGY8N9J7dTmhisJR0b0EuU+UStv55U0XpaP1n+y8irlY69ak6Go
         UboYvsNaATJniQI/UEMyDDoRkUp2XnbeaPfSmzh4hFkawynWuWNe9HM7WuYmBTu93Qgt
         ZUC6csDr4LTGqN2f78DRAAzIj6+O5HwNfqhRUi2cyIIskjoxnfTGXNmbqnW/pIgxxejq
         c+UfVn8h2wxYElNuEEnapef5SqnG+f/zDYjAma1ZERk8Ih7EheWRzJQoUls48Fhc2rV6
         T3hA==
X-Forwarded-Encrypted: i=1; AFNElJ/3EcgB25W/qlQCmxTiTx9wfMwKXdWhtKXPySCP+oTstXZMdTYAKVTdkfWvPPTIc5P+5GUYtIy3d4PY00k=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxbxHHa6eIMCDZSStNwJ4w2vXgWoKu1cTR0l/A7DvRre8vQryum
	PYErfsk549mt2aNWN/WF99cmUJ5UGTrH32sk4DSDU/0v/6dxXFo78LRm
X-Gm-Gg: AfdE7cnRYlXOWxe3SHbVKACS1UmZ3OkqPToPBS4DPs+2gLzGQoa11Sp++XTz5yHRbab
	XTnBq6kG2q3D61dEDJAvPklgepaLKM4fQ/gmAEcTEfZtKtMjs4s/48X/qDkcAmRXrNB8n0GoswI
	iCfVHk9LdY11fz1tkvd8CKe7IZZlzIB1zvB3BoWb2mqRhO4SuSJ2cAyMKEeartgPnxKAkcQqPpW
	r8QWa1cJnGbMxXwq+8HuCF6l/FLGgTaLtKnQmiqGxxRLo7w0noDTDJD4s5UrHlk1bgLxnXigMTd
	hfOb4rPvEkS55HO+UphFOM1OQin6Nd7yRN8KB49JVLZcynmdYqRNQ67BscfKSNQ/Cju9aqFUrwM
	CVQHnEyDaEXHuip0T1L18pEOMddTBablQJGD2gS3CcUCjvcn/J8kGkZNVji8RMTBdJUpuoZLawm
	zSnxyDpry6pf0xGFQ=
X-Received: by 2002:a05:6a00:3e22:b0:842:4f20:5402 with SMTP id d2e1a72fcca58-84550877548mr2333344b3a.21.1781849903509;
        Thu, 18 Jun 2026 23:18:23 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8455364d2cesm1153731b3a.6.2026.06.18.23.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 23:18:22 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Aboorva Devarajan <aboorvad@linux.ibm.com>, Christophe Leroy <chleroy@kernel.org>, linux-kernel@vger.kernel.org, Sourabh Jain <sourabhjain@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: [PATCH v3 0/3] powerpc: fix preempt_count imbalances in perf and kexec paths
In-Reply-To: <20260605082912.305100-1-aboorvad@linux.ibm.com>
Date: Fri, 19 Jun 2026 11:45:59 +0530
Message-ID: <5x3fxdgg.ritesh.list@gmail.com>
References: <20260605082912.305100-1-aboorvad@linux.ibm.com>
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

Aboorva Devarajan <aboorvad@linux.ibm.com> writes:

> Hi all,
>
> This patch series fixes some minor preempt_count bookkeeping issues in
> arch/powerpc/ found during a preemption leak audit prompted by the
> lazy/full preemption model changes. These are get_cpu/put_cpu and
> get_cpu_var/put_cpu_var pairing errors that leave preempt_count
> incorrectly elevated or underflowed.
>

All 3 patches looks good. Aren't these candidates for stable tree?
Then why not add Cc: tag too?

For all 3 -
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

