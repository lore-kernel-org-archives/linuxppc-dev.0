Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B732606A324
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Nov 2026 14:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=voCJXCaA
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jHd3W74Wpz30V0;
	Mon, 02 Nov 2026 01:47:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793544455;
	cv=none; b=WpzDiC+6tpodrGStdF0g2PftFlewTv2GqxK3CE9cu1HmWY+nO/NYV8WYfey6RDfEro/trNJiD5pucJgY6e2RzrhLPCL5a3PqeEp/ujFUXcU3LkWZmCf+dgLFk27PRALrPvv9LJ7C/SDkeRuLWzr/Sf19O7x3VB9AA5SHzjQoq00MpVcyvpJs+I5QyR+YQA4mgN3aDAuJRWYxLfpvOPTWz7/gaJqlTxJ9jrRR6MVP6wDtvxPv+Q4VwxcmiZJ1ulOmJ1vE6029Jg5BTbCFK59PzAiws2GUu2NBaBydSeWoPeQkxj+QKIKG7Ieqjen03JC6lAJElYtmWu5LaE5OZ4UNZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793544455; c=relaxed/relaxed;
	bh=dgMJjwzYlt2oKYB+mzgQnp5Q2wXRFx4jyh9x953UNf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bzjx7QXjNdunqvrhHswd4vAV+M5yg1eNjMahr2zRPOfd794iLShgEnJB2etYXyhs3VsgBckuigNInCJ4a0Gu54hzFKZNGhS9t4RVubcJgz/MXwwjej4B0IQxEVR/ml92rSSQKS7JFS4p8SPJhGxqcnCEZjeDXw7u/qwBd6XLCnSSFq+uUNtgdr/Q408Tg4i8KDi6txIqa/phfa/kpo7MOKrEJENNPThGjTykPPbJtyzR12U42M7rfvzhz7gQb9grwwyfLfN3xDLHhKvq+6mTujnciT9ZeUvss52/yZuOxslHBkcIwJgFvk6Or/XucVBv7jjp6SJhH8V5It5uj62g8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=voCJXCaA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::b; helo=mail-dy2-x0b.google.com; envelope-from=kaylovefoss@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=voCJXCaA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::b; helo=mail-dy2-x0b.google.com; envelope-from=kaylovefoss@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x0b.google.com (mail-dy2-x0b.google.com [IPv6:2607:f8b0:4864:36::b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jHd3W211bz30Tp
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 01:47:35 +1100 (AEDT)
Received: by mail-dy2-x0b.google.com with SMTP id 5a478bee46e88-36888ae05e7so810847eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Nov 2026 06:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793544453; x=1794149253; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dgMJjwzYlt2oKYB+mzgQnp5Q2wXRFx4jyh9x953UNf8=;
        b=voCJXCaAwdx2z7BkxduI46qNlXLK12edxNvE29ShYtg0nIu7jqOsVLiaMeiAYKIWpQ
         6A/322abf4RUNSNlC5okLMPbp9sMNTtD1Z8EX/MTpHZXXCaegDg0HoroMl6d2wNtdJKe
         4q1M22ljmkJBvh0NZkz1tU2ACfYSZ3DNdIziijMCTl/Q0nui78J2x8RDtfYBFqtm5uXL
         xGY2/h7OhR1kffSwLVnwEaWVIJCbCb8pNPmNGZ3mMPlkH936qj+4NNniZr+OSKIGkybN
         VdLqsHgnnVJ8khb7qJx65U9NHhYk93crn8YC6DEFcIqVkiosk4XXHETcfaF03eyJXaJX
         pHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793544453; x=1794149253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dgMJjwzYlt2oKYB+mzgQnp5Q2wXRFx4jyh9x953UNf8=;
        b=c4A5Zbvj5Zz18EFkLPMcNmZckUbAICDldYGmaaD/Qi4jgEdLGtDpIANG7ePEl+QfyB
         w+/BjObTNkyYf5myF2KKxjvB8YGDWIWQaO6d2EhejxgZ/be3FGHhUGYD48DqbVhUcLqK
         +dbS3an60foMSB5LYr5FpzylAbwlHCJfz/2L2sBvIOam+PoeusTgoV08cUHRWoVKXB9t
         CF9UOoa2uGzjOVn9Ng3wDn2Dn8JjPu/A9PbsHugJJra0Hn+un/cyy4sHSR8+Qs02Achx
         jQZjE3BXyIuq+hjRw18aPofpD/G6OUnEx3BwRfVtoEjPpnUuHoX6p20AlfcTX2PfeC4Y
         4enw==
X-Gm-Message-State: AFq9FYKwqgLUQJlZPv4MdB1snaNV11KcG6OBR1ZPh83Txev8E99bSfK4
	aXE3fuHIRY2oxzykil6PRH51cNKXR9p+fSD6YPp0KVzlKichGZhGZD9oSpqdIW+t+cvudg==
X-Gm-Gg: AYBFou2MowN9TfIuhgfUgmm4tKM7FU2roh0UXNpWnkA0dPe6LDEe73G6NaOYX+BMXSC
	gDfWH8Xjt6ChM1KDoN7cgIQhD8WXhxUu1ZJTTkb710Z+FXNRIDNn0P86M06B2icyOPVVZsz8rKw
	UmZsC1fpYPtT0mlVjrJqkg+igv8CyCZg7oqH43u8tJmcZ+eRpb9HnnGFwqj8ox5pBAlZ9nUvIXa
	aZQNBSI0cmIPzdrLhGlkiHHqdDc+xOfWv4m66scHKaZqnHOtNlIdiQV2OG4j1KscYPiimWZJF8p
	8lOpp21YwLEc8dwG+0K3NrwqmcwCuLAEZthsnUCJbQ1EdIFkZIGbsV3hmNcWIMWFJGb77KQ6Y2r
	pvWWA5qhRPrLWcpN7rDa1AtwSxHa1tNZkr+ZpIBZ/RhztgqIzETbqEeKkn0gx4iRkx8FzDOGFg2
	E5mQCA9lsrOYR5IC25ORWVbLvIvAgKoeZMdUtyX72trcKCE1mcfsFXkNe6HsS0qdbxWRwoLu8DB
	CIJA3AeJxea0SxQrBVWPbHef93JOQqSG38RZN6e/8B6+HgwzeuY//7IY9+p/JAJuzwwkxYdgleV
	NWc/qIqPuZfTTevREQqz2+Z6mwa2sFaw6yXB3ipFLw==
X-Received: by 2002:a05:693c:8353:b0:369:5583:bf4c with SMTP id 5a478bee46e88-36a424064a8mr11553738eec.28.1793544452933;
        Sun, 01 Nov 2026 06:47:32 -0800 (PST)
Received: from nixos ([27.75.108.59])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af1dfsm29440899eec.7.2026.11.01.06.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 06:47:32 -0800 (PST)
From: Bui Nguyen Nhu Quynh <kaylovefoss@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au
Subject: [QUESTION] Does PowerVM populate the rtas-sensors device-tree property?
Date: Sun,  1 Nov 2026 21:47:00 +0700
Message-ID: <20261101144716.119289-1-kaylovefoss@gmail.com>
X-Mailer: git-send-email 2.56.0
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

I am trying to determine whether PowerVM firmware populates the rtas-sensors device-tree property on the /rtas node. The kernel's ppc_rtas_sensors_show() in arch/powerpc/kernel/rtas-proc.c reads it, but I have found no producer in QEMU, SLOF, or the kernel documentation.

On any PowerVM system, the answer is one command:

    ls -l /proc/device-tree/rtas/rtas-sensors
    od -An -tx1 /proc/device-tree/rtas/rtas-sensors

If the file exists, could you report the byte output? If it does not exist, that also answers the question.

I have a QEMU patch and a local reproducer if useful, but the firmware-side answer is the only thing I cannot determine locally.

Thanks.

