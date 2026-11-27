Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB37606A324
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2026 03:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rtg4ePns
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jbJDx54J7z2xqh;
	Fri, 27 Nov 2026 14:05:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795748705;
	cv=none; b=EBrsU9jCY/C4QylmhU5zpWOEf2/wlBVY/k1l295PGIs0uFeTU6N3d2Sh0ZxOsbUlxoZOOZFf5h9ox9SFqMSt//eAdF/IiwkEQ8AY8sAIOsuBoYCL39uocdeji2uSeZzjC32Qd5FmF3EmD0Rwm+pfuFyQTFUQn2vkfWxWoTU6LEGF1k7XEiqb6v5vCZY6H2eYPfQz5Wg82I6MxM8kEyISj79zojHxl0/n/0cFNSqEyzcF4oO3GOE4/h4Gw3VSUs9DUn7Zs3ewHFxUn9tTb1g9BSY4AncUNtAmgasH5kFLfLy9gnjyMAcCUXcW7GtEBGfO+zyFvUB2IBknFyT7GS4JMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795748705; c=relaxed/relaxed;
	bh=Y3LzlUWMVTYisJA8jH1p8f5OrfQXMWAfxOlYz+VWDx4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=miek9HRvNnaewI6E7x2W1EYnCkFhtLQdhRh2sWE7GR4VoOHSp4O8ta3yufbYlmtjS1vbeINjyT6/fu4LhhW2QsByY9XTG+VjYaFNjCfRInh8DE0YGAT/YDX7zyNihhdOBawDIK+SWQ5pKHeN1n+3yCAAWn0L0/YC2jmEdHYUnxvQeNqTc/vOziy2mfJiw6gtYoIMd96fx90+OvCqBCMH975sBpnHqKyqZNdUJqgZ9K3i+aMygiYn0k4DGcR7nQW/uS0fh34dbxmAeapmsrzDkZky1LJgjXesN7116+HUTIGmcUvRRYJBsc8BShKVRfdwxvx5KFOQQtlK9d3qtCcSzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rtg4ePns; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rtg4ePns;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132e.google.com (mail-dy1-x132e.google.com [IPv6:2607:f8b0:4864:20::132e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jbJDv238pz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 14:05:02 +1100 (AEDT)
Received: by mail-dy1-x132e.google.com with SMTP id 5a478bee46e88-33fb4680717so3849630eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 19:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795748700; x=1796353500; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Y3LzlUWMVTYisJA8jH1p8f5OrfQXMWAfxOlYz+VWDx4=;
        b=Rtg4ePnsQcpiF3UX8TGKhBgqLRgEHx+Dhb140zXjyI1I4fgzeY0VLZcLq23IaRJ3Ue
         AaMeIlRvSjJSfe3WdbbZYXaGQum/VicSy1rdfIUgrKXe2vx4+Bbyv2/58lIo1PyCx9di
         A2uyuffoLi2+SPIVeb9a4MASg6Zasi3ieTiHsD/rraQg59ENOpisA91Lz12UMRADH5Uq
         U3pAt7/AlLp3e5IS+OkpQ0s7rbCV7sMECXmmzwd3q1krdix8bMVCShRQ55Ltbi/qzqWj
         69AaIY1pvtfDu4tMHoBrI4QanoaWpF6A9PArRnSp+WMALZDIhedofExV8MhBQse7OMOW
         nBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795748700; x=1796353500;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y3LzlUWMVTYisJA8jH1p8f5OrfQXMWAfxOlYz+VWDx4=;
        b=RmapoGXC7xLzJDPfry5wHtgVqZRAOpszIqr+5vvJW2elrLnMRyPid2iEFvQYHAEDh4
         ZN4GaPVFFvjGU2MpZCDXNfUTz1NJfABxGcpBWCyy2QLUQ8LO/PqQsyg4XWNMOiTok+9p
         EOQDV9gm3fHTiiSn0Q0mL3W7X6mY2xtwtUZIUwUOZqWVfz53/36xiMAWrEcw1Nx1ndGc
         bL3HyKecwVJ9pq41WryGtpMiU2Qr/G8ZaCZGxwRDOOxkvyVDDKVn1EdelGZT4V7EW7SK
         X2U+yg+pbcDCgLsrFR5bRQN/DYPuinvOLZVNvLYOh+DQ4tRSwmmPcFB/iuuBWAn71UbS
         q6CA==
X-Forwarded-Encrypted: i=1; AL+hErG4u4Hpzt8GF1SGiTO6jXQEh9pjImQYd3GYvzw7c2nMxtUqcnGTJSPmVxjTVJwmenZsLQu7gcj3PmQABAo=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/GHRcAHpCm1fv2FIFJYcJrC1GyIigq7yzMbII9/u9i0HwTPYX2
	b9irEZR103/qWnu9W5XE0QgNeBpbI2Qtj5G8c450YXrPnsbG3hdPmB1jnXoyvg==
X-Gm-Gg: AZFdTZeWA1vjlUxYKCmz77iIUUB01pCLX77Ex1qC6hWTqsbwgSPMk+AmC7B1N+gZgdI
	xr21vLOZsV0cWwO1G7lJnOq1ihKGAW2G/klxVsIn4MG98+P4cqLEijdhCLv/3uulwf5aDG6/DRJ
	eSZxwgwcDIYU1LkqgU4x/ZRhSWnFZos0W9Muh55xTwLng7MT8a5vplzCSaRVzV7cJZ1qWqIU9qS
	Y/ItTwxAUuZ3XC6n6uHb+fL6iCu97IeiLTaTMBUbMc17qKxn1qvfdS3GvsBJqvo1jVFUgkMfpPn
	SCpWkzNJpw3Xbcw0A5RdKVABcw3C1rgCIQTzkk7so7Ue7DV4G50bqRrYBs4pvOMSVlEBrnfxToy
	+vVNHTHxW439R13XhbWwewdvjA7UpIDiV9HZgxjTAk/NZP9Pmz2OuDYraklYhulz9EbpNom6lZO
	iex2KY2DRk6LXp0nZIwCrG2nTzguIfhVtq623ZYzicEaL/+nqwQ3UDZWHEk8YIw1olX/kYV0z8J
	AK5+S2QLsZScpXUvT0nJjU9IyhpTVHwk6DTL0u4JzAdV594SvsZhta28WupCOez09AfNN25RH3f
	Lt+IeO+mh8HdDD40VxLnMntI7T0=
X-Received: by 2002:a05:693c:65c3:b0:386:e9bb:d9d3 with SMTP id 5a478bee46e88-386e9bbda7dmr1642098eec.28.1795748700271;
        Thu, 26 Nov 2026 19:05:00 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567daaf70sm69435384eec.28.2026.11.26.19.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 19:04:59 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Thorsten Blum <blum@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, Yury Norov <ynorov@nvidia.com>
Cc: Thorsten Blum <blum@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/64s/hash: Remove redundant 0x prefixes in htab_initialize()
In-Reply-To: <20261122184854.24251-2-blum@kernel.org>
Date: Fri, 27 Nov 2026 08:34:26 +0530
Message-ID: <h5h3j7ph.ritesh.list@gmail.com>
References: <20261122184854.24251-2-blum@kernel.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
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

Thorsten Blum <blum@kernel.org> writes:

> The %pa format specifier already includes the 0x prefix. Remove the
> redundant prefixes to avoid printing 0x0x.
>
> Fixes: 178dd2ee2b72 ("powerpc/64s/hash: Fix phys_addr_t printf format in htab_initialize()")
> Signed-off-by: Thorsten Blum <blum@kernel.org>
> ---
>  arch/powerpc/mm/book3s64/hash_utils.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)


LGTM. Feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

