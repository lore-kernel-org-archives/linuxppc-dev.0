Return-Path: <linuxppc-dev+bounces-24313-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9EFC44501
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2026 06:30:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h137G3sfDz2yRF;
	Thu, 16 Jul 2026 16:30:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::534"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784183402;
	cv=none; b=TwfZtgrMRtOw+3a8bFPJqX/zBrvPFVoTs5e6/e/9CaQpI7+kzyhTrXjlKBpoeA2AwYch9p1JwN9B/GPu42W6K3A8FilBmACplpPGcw060aMRk80A17SWic6ILzsq2zYx7H2EYWn1OzxgXlcLfAD64mvnLxOScWyGi4hiHIdyJ7c0MTz+JdnUCQFy/+Eyz7/C9doN6ov+jfDfimtuRCpOE+jLGFHf4ThDCHbBQ+Wa7KDp9RiWnAIrd5uyrrGD6KI9tC1E42MoiHz6ItTkFsbgF/At02WQuxrf2mrpbmM7WgzT3s2awckrhB2hIEuGh5Wu01L3WWWFvbsWz8A8MtCARA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784183402; c=relaxed/relaxed;
	bh=n2hc1u0Rsq2BO6lcSFliSHkUB8MwQfikqH3yIF9qcoA=;
	h=From:To:Subject:In-Reply-To:Date:Message-ID:References; b=RYBgWZ78pMcdCGjhFA9h7HqcX1z6I/GZ+ImwAJOT61IopOYlRD+Es+YnRVEhBRopFEBhVr2vNqj2ht3WDB4Ux8+51RImheWha63aKagVqt8Eaqxrlropqm8ctILCRnmNduJuNyrAkZ2qISyP7CFKwgTVlGSbf00tV1r7gFWLdBEJ4/x0EIfDV16WMnvNXtnLPRiOtpuPZn6Wr3lLeZn1pP2ctSatDDUrGUKAwR1GM19jm5RKh04qArKK763sRVyYnTzil/P5D3/fqG7QICOYe/SqheiMB50oSn3HRk8kVR7xHI5bhfrXR66g9LIEFIcuxBL49FfB+3U0sqozsVrByQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O6jQNTZm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O6jQNTZm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h137F47v1z2xQD
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2026 16:30:01 +1000 (AEST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so4603837a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 23:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784183398; x=1784788198; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n2hc1u0Rsq2BO6lcSFliSHkUB8MwQfikqH3yIF9qcoA=;
        b=O6jQNTZmqlMR1xjVbT/+RC7vZBGwS3YHQhhMBffrub/+cCT43ktAVspsMuKOXH9sxY
         2oTw9/pJOcWPIuMdO6sXUbhfiuMMilbViCjkY8bB+keztmZuD31LsmPU0WQtqJtMzMXF
         JNGabuYLhjewqAcxb9uq9yoXkLiGs0eagGGUdnHAs0DRHnaeEDjHGvCwEmc8Ce0YxSB4
         hJJ157567UKxDEovZiZMwWnIFttHpsJbv3NCm4iOYrI97Cjr3qtdTjS/NjTj9zw0s865
         exTaAayJqRlM/NmjePKcqKEXRY3HQqvvEr278Kn6PSlaThUw6PJX1cri2CWGCaA2xWU1
         Xnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784183398; x=1784788198;
        h=references:message-id:date:in-reply-to:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n2hc1u0Rsq2BO6lcSFliSHkUB8MwQfikqH3yIF9qcoA=;
        b=krdkw7262gpvXDsqJ/SxAeDa1eb09T6sISXvs3nIqIf7ntv79rm90DGttgpM2JQbrL
         ErIBffQ1/OSZ+NAqVd/3G5IHIfD1O/Ryt6IZnL/q5G5xhTcGIHFUa4u3fEjzOTMGScKx
         /QkixOP0DWIZjSYxdwnMpl2Tnmlj70H6WlEq6ewCfBHjDPlccqKT2Y4VstpQfhwQrmgL
         rbZC2mAVXrdzgwEfALl6KnnLMahDrlfBKEmank2eTvX9Or0IDxSWeMD1wMOOW1zlR9NM
         ptZk551/QA4KZDHvX6cuyUi9nSYfI+gaQman6OjwNavatMtDhhqW5pzGGQ/XMF338Mn0
         6Meg==
X-Forwarded-Encrypted: i=1; AHgh+Rpj6zDGvL6FB9ZVw/oOoxt99BXmxObNBF6NfIH2WYN8ZCbnxGcnZCV1lA886wv6nIQQw3P2sOzLPsSN+7U=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwdovOR18eeHomYiZegzHLwKGCMa9XBTazm9Dh50Zwq7oFsiLRv
	NV2QuZUbgSVMOEhl15KhrevydNekpPtt0XdFZX8BhEIkScZkUl8cYOyd
X-Gm-Gg: AfdE7cmumcRfuHwvwPadpLNC1FpOymjIRqD/P8N0kemfq/mt/m6FGYCXsPJH1aZEpC0
	VCO79BvIvdTUmUamsmwk4J165De+4ungD2zmTdNqaUltB1jfCK7A70FZ7CKL6YtE8z20mfnGz8e
	DmGcwaZ7rpOs3fjS3J5SjDCnpr28WT9dW0nkDnCMkat1bRhKQG7NXKSe3uNThgPYAIQtdxiciCi
	qyQlJpFHAY/7cnlhtd/1rJ8S7AXIDzaSraNk0mzfer1KdvMUbf8S8cRAKm5Ocx/CLWp+tYgwtM4
	NoMPcO1Z1nQH6472zMkReKM24fcxCCkdbNmd6VVYmCL9CNLtBGVXoJ1rIQALvA4RYO1RKBfVfH7
	kkQP9vtezf5eB+1NzAeJk2vg/K9MBdsUS8hweQ0ojFbj8Is6E5VpLWIlgJ3zvcZKDpFPFpZpZub
	QV
X-Received: by 2002:a05:6a20:d706:b0:3c3:4ab3:608f with SMTP id adf61e73a8af0-3c36c1eadbcmr6801577637.29.1784183398290;
        Wed, 15 Jul 2026 23:29:58 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd432e848sm8204494c88.9.2026.07.15.23.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 23:29:56 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Narayana Murty N <nnmlinux@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, shivang upadhyay <shivangu@linux.ibm.com>, sbhat@linux.ibm.com
Subject: Re: powerpc/pseries: EEH detected with xhci_hcd
In-Reply-To: <29f33de0-0861-459f-b6a0-440354fac785@linux.ibm.com>
Date: Thu, 16 Jul 2026 10:21:03 +0530
Message-ID: <cxwnv8p4.ritesh.list@gmail.com>
References: <2ad00297-eca5-4f36-ad01-138837f6fa4f@linux.ibm.com> <29f33de0-0861-459f-b6a0-440354fac785@linux.ibm.com>
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

Sourabh Jain <sourabhjain@linux.ibm.com> writes:

> This issue only occurs with the Radix MMU.
> Booting the same kernel with disable_radix=1 does not reproduce the issue.
>
> The system also has pmem.

@Sourabh,

Few requests -
1. Could you also attach the boot logs from the same system with the
   same kernel but with disable_radix=1?

2. I can't really tell on how is MMU related to this issue? But I think
   if you could share the working dmesg logs from Hash that might give
   some more info. I am suspecting what if the firmware negotiates
   different page sizes even for TCEs for Radix v/s Hash.

3. Would it be possible for you to try git bisect and identify the
   culprit commit?


Btw, to clarify I think there are two issues here:
1. EEH triggered for the USB adapter - I think you meant that with Hash
   you don't even see EEH error being triggered at all. 

2. Second problem is - EEH recovery causing this WARNING.

[   17.375534] [    T118] WARNING: arch/powerpc/kernel/eeh_pe.c:439 at eeh_pe_tree_remove+0xf8/0x2f0, CPU#10: eehd/118
<...>
[   17.375599] [    T118] CPU: 10 UID: 0 PID: 118 Comm: eehd Tainted: G            E       7.2.0-rc3upstream+ #3 PREEMPT(lazy)  f29942c1738362234fefd88de0d1ed711f1a557e
[   17.375603] [    T118] Tainted: [E]=UNSIGNED_MODULE
[   17.375604] [    T118] Hardware name: IBM,9080-HEX Power11 (architected) 0x820200 0xf000007 of:IBM,FW1120.00 (NH1120_135) hv:phyp pSeries
<...>
[   17.375650] [    T118] NIP [c00000000004a048] eeh_pe_tree_remove+0xf8/0x2f0
[   17.375654] [    T118] LR [c00000000004ba6c] eeh_pe_detach_dev+0x5c/0xa0
[   17.375658] [    T118] Call Trace:
[   17.375659] [    T118] [c00000000a357c90] [c00000000dd32800] 0xc00000000dd32800 (unreliable)
[   17.375668] [    T118] [c00000000a357d30] [c00000000004ba6c] eeh_pe_detach_dev+0x5c/0xa0
[   17.375672] [    T118] [c00000000a357d60] [c0000000000496ec] eeh_pe_traverse+0x6c/0xf0
[   17.375676] [    T118] [c00000000a357da0] [c00000000004e100] eeh_reset_device+0x1f8/0x298
[   17.375680] [    T118] [c00000000a357e50] [c00000000004ce5c] eeh_handle_normal_event+0x61c/0xa60
[   17.375685] [    T118] [c00000000a357f30] [c00000000004e298] eeh_event_handler+0xf8/0x190
[   17.375689] [    T118] [c00000000a357f90] [c00000000025dab4] kthread+0x194/0x1b0


-ritesh


