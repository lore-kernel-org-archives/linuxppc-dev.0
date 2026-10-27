Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE20606A31A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 04:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s2qpNQs+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDH5V2kyrz2yR1;
	Tue, 27 Oct 2026 15:07:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1235"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793063867;
	cv=none; b=PEyWFsa4za7g0z9fQkoqvFbPgCexjZaTVz9yJtL9ciRK6bvg3g6JL509Z8VaIos1xSbcJ35oc14G1NPfwJioft7kgWJxPjjsL0NURUf42ZgYHPnRtUAYkk40JPSzS1ktkrNvBVnTAx2YJrMngXooQvhLurumx8QqcJff6EshDdhBOaSAvtRmhPDovTFUzT5aEWbfGCRSs3gu6wuEz48ddh/E2Lukhyb7XAf/HAeFzPuzZibEvinOcBpVbr/nlXLVGc90+zY8tB5p6qPrd+IrZ84VsntfQ9zzKl4qIxUzIZqSH5ybE7H7ISydX7/vLisaZhXex3D9eCo8SUOB0IdFyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793063867; c=relaxed/relaxed;
	bh=iiPmRn6CvRr3XqyVwuF1K5kxi2SD9m8ff5KTZX9HpcE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=YAb81YBWOig0NQNHXXWE/MR9k8AQ7AgdtpQ0WvggXqzvONVkaBOFjAlP3WwhAQ6sN6CB7k92J0XA8WgWHNmBbXudd6NGqREK85a1s6RgdQDK6+tThi/fOLJjVMaqxJQtSmZ7S/66s8YJ4vSpJ/2lt1bKgTpQPj55cRr/647Se9HFsoIVIRpjaZkEqwJg/X+IvXHlFOdSGDCysULrAD8rLiPvqiiAtgsP09jaltSCh9LIF7gm8IFxWlPTh8dhSwKnyEegDJVVP7etjGwr/CGjeBL2amfIkZq7tWvm8k8GMQr+5TS85yU2vpYMmwvxFaA8Ytz3kK4GqeKy9e+AAyVM2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s2qpNQs+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1235; helo=mail-dl1-x1235.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s2qpNQs+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1235; helo=mail-dl1-x1235.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1235.google.com (mail-dl1-x1235.google.com [IPv6:2607:f8b0:4864:20::1235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDCKQ162Cz2xjQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 12:17:45 +1100 (AEDT)
Received: by mail-dl1-x1235.google.com with SMTP id a92af1059eb24-1931ff67a29so2285934c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 18:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793063863; x=1793668663; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iiPmRn6CvRr3XqyVwuF1K5kxi2SD9m8ff5KTZX9HpcE=;
        b=s2qpNQs+oNFBCdA/Z5PaZGJQWsvsOBkNgM/p3TQvSdU5bG+Eo2B2J3dvK6H7LfSLog
         NgLRDW/T32m4ClDboOvFX5cHcWaNDB6QEBvjQ2gNZHe0GO1Z7t+OW5P38Oh8TnRgiD38
         JB4mrzjuK0KaxDwR8nieqIPbDVCrupLzot7/5G6WzhlK08y/yGJ1sgbcV6kb+g1Az+O5
         ouEwt2cqk35ToriK/Uk5HaTKlWbuPvGjNk0sBJA6FJj+ug10QbTqjZc1Bmo6vlFwEWj+
         tmptLeD36Saac6jdKAtwud+/vImB1BpK0kn0FXtYYjOaj5GJ0E2n3xg+9g0YqhmOOmWu
         ytBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793063863; x=1793668663;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iiPmRn6CvRr3XqyVwuF1K5kxi2SD9m8ff5KTZX9HpcE=;
        b=2TbyqfhW6j1j9E6JL+D3hrq5cf+tVb25L6tizktxwyAdVgBkX25IAZUBb2EEn4Fb/q
         6qivHH4gIdgaMfV4WUS/AJa+wjF4ROVAXY9hcRRtGRszpJ9b4XG5WEBZWF/YwPZen2M4
         NXQMgA96ts6yFmw8bJH3aCkHrNsTkDXpwOA5Xekdq7lDC0aG5Pa/NVmIt+6sVRkGe+zD
         +XWrrFiZZb5NCOhwVkutXNUK5/s3Taea/SSaelXtDXlLux9BDHQstpfwnAT/pX7wfDAE
         jBJHmPDjb6+D/scQJ4Vbw+MOtnlL66f5FBUnKZjlptf05jnaum8/fL8o8nQ36D/MI1a4
         rTKw==
X-Forwarded-Encrypted: i=1; AKwUvBwqKyNpU01isCqGqjLBiC4cZ+FlbLgzxwa+YJUtBxpO9crl3hhD0a0Zn2ABikuMRD5JZHe4Ucoq2J+7JLg=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIogMQPeynapERG+2y3aHrmu+M4Tt/XvccXM/vnT2MnlZHETKD3
	dUBOjcMiY3BciuAumcCT2yUcMKbGcKPB+7mhpmB7SfmuGak6JAWKHpk0
X-Gm-Gg: AYBFou1ixleix+z7WWv0GAYNwgmNjo2AwfmjDieHne5eOSHdyqp0wfQYqJpUnKwwTmq
	Ej4xfkmQABpHTWhozULxHq2DcEy/eIStU/1+oPs/9gTPaDheagWQDgRTJsYWKwDR7v+/XaSo5Gg
	bcmC46vKm5tojatTdxXWlr3Xu7GHX+an+6/1Rgx1HZwKvAZByxxR3u84dCI+bfSwTheRN2SSpKO
	qWNeShuZza7fJIULkDd71CnkF/hTMgwOHVoHq6kf0LTrQQ3as7V9XwD/EZaZXpKuE4A1aTS4TOi
	uN73UenYwAsJA0N7kDp+VHTMH6wpu2Co/9+8tywE2Mhn2YRRXl/HAJMKdUeUNS86ye0gTamOGqO
	HTP3QIIgwuAB+kiXMSaNlXpgvS3FEW6Wl4ZRl/8BdrvnjHOf/RKdVbDEi5GfO0OJbJmeazeOkcA
	cOLS8zz8gWZHbOIwK8s2QSZMZw9m66c4UeH6tTz+Vn0muSHHZHM8mDMWv8bE2gc22gcGIdlZ4NB
	vsd9oDaYrntcFSKORXDTXP5f82q9qcI0KN86SIhWcJa2aBJnJEIgw==
X-Received: by 2002:a05:7022:297:20b0:196:82a:b80f with SMTP id a92af1059eb24-199374f3409mr10733011c88.45.1793063862576;
        Mon, 26 Oct 2026 18:17:42 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8db7e73sm29204728eec.20.2026.10.26.18.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 18:17:41 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Bart Van Assche <bvanassche@acm.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, Qian Cai <cai@lca.pw>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] powerpc/iommu: Fix an RCU read lock leak in mm_iommu_is_devmem()
In-Reply-To: <56f0c45723ee53149a21ceb599010e957457afd8.1793044370.git.bvanassche@acm.org>
Date: Tue, 27 Oct 2026 06:43:59 +0530
Message-ID: <bj8g54iw.ritesh.list@gmail.com>
References: <56f0c45723ee53149a21ceb599010e957457afd8.1793044370.git.bvanassche@acm.org>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
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

Bart Van Assche <bvanassche@acm.org> writes:

> mm_iommu_is_devmem() returns true from inside its RCU read-side
> critical section without calling rcu_read_unlock(). Neither caller,
> iommu_tce_xchg_no_kill() nor tce_page_is_contained(), drops the RCU
> read lock, so every successful lookup leaks one RCU read lock. Fix this
> by calling rcu_read_unlock() before returning true. The pointer to the
> list element is not used after the RCU read lock is dropped.
>
> Fixes: b5952f8125ae ("powerpc/mm/book3s64/iommu: fix some RCU-list locks")

Thanks Bart, but this was caught as part of Clang's context analysis
work on powerpc.  It is already posted here [1]. Could you review that
instead?

[1]: https://lore.kernel.org/linuxppc-dev/04e4dafde56fe4b055fbd763dc0e119862073c6d.1790590014.git.ritesh.list@gmail.com/

-ritesh

