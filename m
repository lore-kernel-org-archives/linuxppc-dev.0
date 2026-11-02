Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADA2606A324
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 22:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rmbuVq/o
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJRKP01jdz3c01;
	Tue, 03 Nov 2026 09:32:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793658744;
	cv=none; b=iYprklTTF31vIXqWzMiJlzAlNUn76yCS4ZE4UiFsl5t253dNRy2FG5eDXAZrCQANWNGeVRo6hUy4ENiKvVa/N1/HlhXFXDeI/1Rbj/Z3qaQ1NzuiHGPf6xmupz+Stg3L5srDjJuDAX1YYvEzu2llrczRApE8PTb8sK50aJxgix1Df0wzUJy9WDpbCB+l7lHzz/hx4EAHCYNhfnH+o1U5p3ng803kffSMAH0D+5T+RTMvP0H7pqFRWVwej7cfJ21QQYXroFS997CnnZDGzn2h2BJZ70+y+oXAUjoTCXC4lRDVhou5Bi+5Rwfn0q5VvzwA26RUEZkVXA8Z37aKNG8TZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793658744; c=relaxed/relaxed;
	bh=PouyaftKJjg/z7eygis5HQO9z4kpbGhMVfLqb3UDoCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DxdWf/kxWVZo4KubPuqRuh5CUTedT7ljUtnS+0CQ12peBo8CBVWmalQLImu455w0UHxJPEzBLZ/Q0DAU8GPA9xzR6DEAxDRKD6c2Xq4YxCVK01CmV1Q/sBq3Cb9KyUPp6X/FA9QUDP6LycXyfj1TAnDsAI5Th2eY3peHea3XJDeo2UTtCT+FqAMWThaND9fjBsvAJsWbPwvORrRM5XCnNBwIMhsLATaswFlFEw3sAG0W6YBXakf2l+t6iKvuzB3WjE+BWeGF6fJt5VRXQ/pc06C/vGKEMS0ObB8ewgMQOSRbEQbZZDwZcd0HVWyq6e4juXaBHCqfD5t9tj8cHjw3NA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rmbuVq/o; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=pepe.schlehofer@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rmbuVq/o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=pepe.schlehofer@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJRKM2vB9z30Tp
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 09:32:23 +1100 (AEDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so31128025e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 14:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793658740; x=1794263540; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PouyaftKJjg/z7eygis5HQO9z4kpbGhMVfLqb3UDoCQ=;
        b=rmbuVq/oVGlE6ctEPPLcc0dF9i8mnyOWzCM3WmUc3LycOYFhwxMS/Ghpd1dKEQLNHP
         Va1CXTCcKoTpJ8a9CCAW5XkNiq/lpEOmMsI6bC4KQBdmnIHYjOqvvccORqabMgHnCneo
         AjXBLiTp7LU2oGdutYw6x99+OiIPegdsX4BaUipU45xdysOH93hlJ7SuKpzt6WfeMfcq
         W3UIyYiFQcI3XCo/8VRuY1kKbrDvwTPtdar7tGYAaSKzi8RBRdZUlFd2vRi3ZimKPTBu
         OTDCO9L3OYetSZVpURzoTwhRmjJ1iox+XyI16gOWa8/bZZEXbI71VHaUnaHiuuXd9oK2
         izRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793658740; x=1794263540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PouyaftKJjg/z7eygis5HQO9z4kpbGhMVfLqb3UDoCQ=;
        b=hCGgdHyzgBqzSmofMovgjTjigU9yl1yhoDN7clvIGvH1KaDPCEZ6X/oRydP4TXsDUB
         7NDI1uEdX9AXk3xOB2E2JIUVxj1MZKHFtUlI6tGtwjvjPJ6SVMiF0HNG5S+lfBlk5Yoa
         9oRW+TF6ZaXa0moxhc1ST9nB1dKo6rc573Cs0usmtkERkM2GJXL3V7Eu6BWRy0bZZX/t
         XrsJ/8LJZvN20LtQornDjtjEApRVCJ8ITrTIUEBgHAi7YyDS4J7NFb2PEik87i+YoPAY
         2Du3BxwDkQQhaw/VaEHWDGNyAlV67eWaNVVy/cWavzgV1Rjca8NNtcxlY+wGS173ux5m
         6LAQ==
X-Gm-Message-State: AFq9FYJ0IIJLXv+CdiSmA2QaQ62g/OvGKV2DFjFzbvbNpYWd9v11uE/o
	pnRh3NslTc5MvFsA6bgTLp1oulZIWYlTBwGZxj9DaK+3YH/O8MgHmeyb
X-Gm-Gg: AYBFou2m3kZ2CHKRghiNCkSJsrl8rRzFqelhuEn2yT3Twu1ga9U4JXWxsnzeaf2OVvR
	YFrjPkqZQdsDfBvmvPb7hDq8BUpKZH9TOFxwWUVM7HQUdoRZ4xkfif/EHHx9bApEPUM/Co5jYCE
	ZtK02bLrjVqBHpPzxfEd6Gy69CLQLWRJlaw02icYW2kMC+8XOIx0dZPUkkmDUDXUqc+xZkI76GL
	OgXrXWgutbJzGnPtCgHOJ3YAFu6G4IxfJbnPcG+cBecsGSL6eI3krylMHr5wHjlMwwMBqBJsnQr
	F4bUMvkyyWOjTxRXcpPg9ZqudQz6Pc+sPj9NLLUsKhAJrdEbA3R3hlFl5kJV4DA7/1dgMyhQy+6
	04FfyQn7NotqKhA/v/JWqykmExk8cmdDFwO8vSuWIZS+pS7RslsZGPfxX95EGHbIQcHqC7wER2k
	8PjZjLjl1taz4BSErFDkipAW0YahqRZZ/AIk2BRlmWRoebPSL+Z1LiR19EXppslLOCxjE5EvuOD
	BJcPP8T3C/lY809XqyXZLVLxMliZE2TSZVFWAsJhnPPUg3KI6enunSABIFdhFqyDBClxgmDiGAh
	KvI5Ng5ddFBqT+IZQseOBhys53cef4aNROJr53CmY9MGGtMLkwjxh/todRzQjnct1BEdNpMNN0l
	08S25ExgTaJYEY6YoVbN4/gruAaLH7YTSOWljsFOw9GVWG2HYOFm7UuLmHrGiMpqVvWL32f/FpS
	XC8LrX8VccyS0glbHsVFqs/pLwXFlagGHSZ2s8Lwq0QJL4TEVhkIw=
X-Received: by 2002:a05:600c:138c:b0:4a1:acaa:9d4c with SMTP id 5b1f17b1804b1-4ac18c740c5mr248869715e9.25.1793658739610;
        Mon, 02 Nov 2026 14:32:19 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a00-1028-8388-a84e-10a7-164b-0039-11b7.ipv6.o2.cz. [2a00:1028:8388:a84e:10a7:164b:39:11b7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a82cebc1sm22127715e9.1.2026.11.02.14.32.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 14:32:19 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>
Subject: Re: [BUG] powerpc/code-patching: IPI with interrupts disabled on e500 SMP
Date: Mon,  2 Nov 2026 23:32:17 +0100
Message-ID: <20261102223218.11883-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <33tm72zl.ritesh.list@gmail.com>
References: <33tm72zl.ritesh.list@gmail.com>
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ritesh,

Thanks, your diff fixes the issue on the Turris 1.1.

Test results:

- 6.18.55, CONFIG_JUMP_LABEL=y: Without your diff, the board hangs
  during boot module loading in 5/5 boots and is reset by the
  watchdog. With maxcpus=1, it boots. With your diff, it boots
  successfully in 10/10 attempts, with no warnings or oopses.
- 6.18.55, CONFIG_JUMP_LABEL=n: With your diff, 10/10 successful boots.
- 7.3-rc1, CONFIG_PROVE_LOCKING=y: With your diff and jump labels both
  enabled and disabled, 3/3 successful boots in each configuration.
  The smp.c:917 warning from my report is gone, and lockdep reports
  no issues.

Feel free to add:

Tested-by: Josef Schlehofer <pepe.schlehofer@gmail.com>

Josef

