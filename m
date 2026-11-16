Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684E6606A31C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 03:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=swnCX/VS
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSYM73Bb0z2xnn;
	Mon, 16 Nov 2026 14:32:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794799923;
	cv=none; b=HOmsIZhtkjfszmuGua1czxvzj7jrTHeXYOGkM9tyTJ+uO7xtVCAJK7F1wUAygNdtfBOhraadKdlsYnQhn2jLhCxgYa0oXDB/2WHyysOn8p/wVubwhcDfxXNBUFyetHQLQVP5eGFp47ud5UfhAZjmTA/M00wVNwb1GgxSPBmn1K+BqRxx5uXEzKiHboLTWkGyX7ODoJWvopo0W4SgQxrnOxx/wblZdSpCFmWp2IPFttPWlPCP4qvKUcMAaiFIWOtlkrO7Kpq68EuQdqGqGUJbQuQVVOYYYIJQdGg0xtlfmZcw5hsUCdqVF3SuACfCtBTYPLO/TOrG2Jc+vfoK97zxwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794799923; c=relaxed/relaxed;
	bh=QbnteX2l0Jb6TmLxEnzbnWrqpp3+eF3+v/z+RV2T9cc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=P2x8yh0KR/PrqmJW+b1sd1SMK3yDx0EzKXhT7kFAV9MJAsaGAtai7AwHLpLpXkPGl9N5Evg9zL63ConWsCd5h4gotyqlnnST1Szhb7qrywBvUjtkIAOVBN0lmVXt5hRoxTU2x4CsUZPsSqSkdEpbQD3VFmGF52+2ofyi12nsZXre2DahYVhF+30F11eVdn4hvjJkTSGApzwvCBRf0mLpUe9vrsY0RUk0AFA1iXbLwnqHAfkkXQAbAp2Ib/kkdIAWJWFiFIsDv990yQnHOWOzK49MS8WE1zdMlAvE3ES3ogNkj+ADjNAc9ZzUpXMQ/ely3dq/dGbhBzFuek3c6I8hIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=swnCX/VS; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=swnCX/VS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122f.google.com (mail-dl1-x122f.google.com [IPv6:2607:f8b0:4864:20::122f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSYM56gXKz2xly
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 14:32:01 +1100 (AEDT)
Received: by mail-dl1-x122f.google.com with SMTP id a92af1059eb24-1b24f4b15c4so919187c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Nov 2026 19:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794799919; x=1795404719; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QbnteX2l0Jb6TmLxEnzbnWrqpp3+eF3+v/z+RV2T9cc=;
        b=swnCX/VShszr4QWjIjrwTVd/A0M3mIYA2N2OY6io37dbuTf/4TA+vobIwvI54g6I7a
         GvUXcKpQDBQg/SiLc7ZCDLHHIdOtwvaJa6OC9xULJ2AVeHl3isBS4YtEtt9iKZZ8Uvji
         9MnbogPRi8AmizvnlaF27uOghMCFox1dAf8+u17A0CtK5u6Meuq8d4OzNXpEo3Hr1Cly
         ui7PmqtenqdRPIueXycj3dULX67irDwPOx/v49xRvAzHkrwn0F8DBphQEK9yR65TJPIl
         DqlbXKuPgd3R+4MwUI8zOOhCk5phfIY3ctNSYNSeecZUS4u/BDBU4zoQfOygyW7Sj+hx
         2BLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794799919; x=1795404719;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QbnteX2l0Jb6TmLxEnzbnWrqpp3+eF3+v/z+RV2T9cc=;
        b=cA6UfpQGJzXmPA2X+Zy0iuXV/pUdzodVRmZZq1EgYR+6w16OJgHugJBwfYmxPwDmqR
         ywe68LZiiSVR7cDz0FgwjchP/j/ICqbHgHA2FifU6LmglcjRBuN5awPhCgP0CFoiAATf
         1MQ1rcqZKKSzv0NyAMPovz1wEPgX7gu/RVaNyQiwswngBD7eJQtJInffcYrydK0W17zA
         NuXHZCrjHTJQakt3yNXPEumHGl8dZxc8HcCI88saTmplpIJr+fGIlUq/+uraS+ZVGk+4
         Bcvb+/Be18bC256Dz1GeC/yV83+J4mgQS3vycy28WOmYZ0nGHhIYHDDPU6Qy8C4y1ZW/
         DS2A==
X-Forwarded-Encrypted: i=1; AL+hErHSPvPcHWQk1XpXM2CSRojss9UPCsUOPKVskeYmei6wvYJXA2jPGLJ2lo2gG7Ttlr5dd9mzMA2nz6e+J7g=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+KJY19+Oy/Oeh63GD+BtlEydOxKaynCrKm5I1CLlIx60jlhX76
	9YhJXbauoJ/RBXtSKZnzRBaa42jUKRZcPtnQToZ6Q0fVDnbaq6GIU6qd
X-Gm-Gg: AYBFou2ZOxTwaK8P0RuWHQwyBp82W7UxCk2hjwOHgKJ1uwFgSd1g5K4FqcjWwGbVZDu
	e0ZiHFZ+2XKby5UYrgBHE+qibufEeSqdseMEwXtE9QNNh3AhcugZxaZtMLdRa0kflIpptkqZMEM
	EskbQzCU6deRkPa39ADrjm3+ijtqXam1IJPgrMYWdbklGWqn9BoJcNNjPIQl2+TacNy1e5hTePr
	AMNGe7UceVrRydrjKRALTJL/D9MHuXt02fM3OHXFATqp+sxAcWilDsHbsSTHVyUWdOS4pCM5iux
	2PRX4cO7tfEcs4EfRkF6b6uKzr166AQqJsPDpZinVyHZgb3Bp/iy22cN64ZmEVLK3FeCAp8WA9g
	M4lz8iTvSvPLjdoTamQ3uEip3iGwlDvDqQ8iEL3Z3t1ik8udnhqOlbeFuRJBs+/EulWTZAUF1Sf
	fCImp1ClCo3q0R1HMfD9WZeMfFFragaUyRmDrr6FPihpoXNk/2C7aHB1z8kexjG++5h0qjyPIcd
	GJR/t8IBC6VZ1858EnMJvjXEZ+6zWJt/dvti6DyhOJJOBXDIwiMbOK4fdy8ghwk46M3amDftUsb
	e/SPOXWxW2l74ELYL+ORi0PlE4GBZ3DaHlN2oU0zO+nHIhq6
X-Received: by 2002:a05:701b:4294:10b0:1b3:b3d5:566f with SMTP id a92af1059eb24-1b5030990dbmr8883780c88.11.1794799918907;
        Sun, 15 Nov 2026 19:31:58 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50319e381sm27456340c88.12.2026.11.15.19.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 19:31:58 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Nathan Chancellor <nathan@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] powerpc/xmon: Avoid unsequenced accesses to tsk in show_task()
In-Reply-To: <20261115-xmon-wunsequenced-v1-1-42ae3fe45bf4@kernel.org>
Date: Mon, 16 Nov 2026 08:54:13 +0530
Message-ID: <1p8l8nmq.ritesh.list@gmail.com>
References: <20261115-xmon-wunsequenced-v1-1-42ae3fe45bf4@kernel.org>
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
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

Nathan Chancellor <nathan@kernel.org> writes:

> After a recent improvement in clang to warn on unsequenced accesses to
> volatile variables [1], an instance appears in show_task(), which can
> break the build with CONFIG_PPC_WERROR=y / CONFIG_WERROR=y / W=e:
>
>   arch/powerpc/xmon/xmon.c:3262:3: error: unsequenced accesses to volatile qualified 'tsk' [-Werror,-Wunsequenced]
>    3261 |         printf("%16px %16lx %16px %6d %6d %c %2d %s\n", tsk,
>         |                                                         ~~~
>    3262 |                 tsk->thread.ksp, tsk->thread.regs,
>         |                 ^
>
> Per C11 5.1.2.3.2, accessing a volatile object is a side effect. Per C11
> 6.5.2, unsequenced side effects on the same scalar object are undefined
> behavior. Per C11 6.5.2.2.10/12, the evaluation of arguments in a
> function call is indeterminately sequenced, meaning any side effects in
> the arguments are unsequenced.
>
> tsk was made volatile in commit a2305e3de819 ("powerpc: mark local
> variables around longjmp as volatile") to ensure its value in
> show_tasks() was properly restored after returning from a potential
> longjmp(). Aside from that, the value is not being modified through
> other means, so rename the volatile parameter and add a local variable
> named tsk to hold its value throughout show_task(), clearing up the
> warning.

Yes. Reading vol_tsk into tsk (local variable) in show_task() function,
doesn't cause any functional change and also fixes the unsequenced
volatile accesses as you described.

>
> Cc: stable@vger.kernel.org
> Fixes: a2305e3de819 ("powerpc: mark local variables around longjmp as volatile")
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2199
> Link: https://github.com/llvm/llvm-project/commit/955715460eaf9188c241c74750637fc82dfcc423 [1]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/powerpc/xmon/xmon.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

So, LGTM. Feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


