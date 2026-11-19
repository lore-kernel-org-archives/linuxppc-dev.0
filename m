Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D062606A332
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qXd8/Xdq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVfCs1hP7z2xSF;
	Fri, 20 Nov 2026 00:18:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1231"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795094281;
	cv=none; b=Ryoj3S2IcorT7mO96SR0q3T+M3YkGRqpAwyPVqNGVvmAxLbcS5SN4yUCY69KwI/77GvI0TYGrlnh54VDLWZlP0pMxC19fedqcSedk6TtX9kQkFTchVlRJHSuL+Rh1AZeVPXB9RILZ7AnDnMLUEErY69rMkkSE/BZJqaVNYux0TG5vOPMuk6M3zEDlwrznDWytB6VvF9atcx2urg7E+aNFuZHIWh0MCbDdRPWZZeSRJFndBbJ+ujUJXOsYsYevYcid1kECUIDtEfMY+g/sRT6muNb95bqFgkxS36XB0Ji+lNH9hfiIYANVkPF25865tWn+SDXStCSFGJpjQqRupxMSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795094281; c=relaxed/relaxed;
	bh=EsZieg1xL+aNFbR1XdLcxFqbOuxCp1pBWzL6LYOVGPI=;
	h=From:To:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=DgIdbnmBh1kwLhGc3z9MzAI/NMkVkhpnMkyDCnaZW1LZW0pC2KuwU633Uy21Cjg14LmLp0FShq/zh6psgfLnEWYcGS8pkDs2HkhJrFo1pQgVmNEnoDP9QvaPaP9Iqw1/X/eFHVyBB+/PTboyRkO8Olv3d+jFlNQoyK4lBBf8D+dHHcCj1ryGpxr842ZOVEdwQ/rX7++6J5H39TJxrGGwDWBXrHkCk+1n3JLRo0o9sevkAdAOrXCUSqxjdKFHDhgzu5fIuG4xZ4jemLTIlD1cwACqRQuPJQxEjgku5NDmYn0ZuKvBClwBkrDvQDwDZgDzxlIWTSS9lin/R+IpzA6URg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qXd8/Xdq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1231; helo=mail-dl1-x1231.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qXd8/Xdq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1231; helo=mail-dl1-x1231.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1231.google.com (mail-dl1-x1231.google.com [IPv6:2607:f8b0:4864:20::1231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVfCq5Fxbz2xQK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 00:17:58 +1100 (AEDT)
Received: by mail-dl1-x1231.google.com with SMTP id a92af1059eb24-15ea896ddc8so3681236c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 05:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795094276; x=1795699076; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EsZieg1xL+aNFbR1XdLcxFqbOuxCp1pBWzL6LYOVGPI=;
        b=qXd8/Xdq6hhsh6iIuFF6otiJtB2W36YTrp6kyOCcHpI1vhesxgFddx182L6JNEE4gD
         iFER1gIAy10RGoOC5o9D3YqDcfaTZyeUbybFU8j/rTrpW9tjSfC8d6+yIZrWe3EsuJzw
         tuT637mYOrnnJI/E5A2zNoMwpgTv5MZhzn9c9vyqgtivIZGpqnMI/89agX2F167+MAGt
         oJVycHlcxqxR+mIOVcZn84z2hZBI9VrAShRZO3MoSOJDxEre5jmYM+sLxzOhdLnaecBw
         6pju7b93Vab+lifDRKgNS6+uGsy6h3W7yTwBJU3QVDCobp0f/Liy6Am+uZ0/XHuuONMI
         3fWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795094276; x=1795699076;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EsZieg1xL+aNFbR1XdLcxFqbOuxCp1pBWzL6LYOVGPI=;
        b=IivW+MQkdQ3Pq/iIES39NfSzqCMuhTiT05NaDBiL8+6cRQ8rcC4FmGuIe5hlYRLWDm
         41DohB6/trr5ZbTqpB54fXGIdkWoD/1Ym3CHrC6uGjWBV272ovmnjgLIPdDvjtyCarA2
         bdxWWxuJQ1QqFzUFZAebem6Vz2qANBF84rNGIZTaCG0pf6wjE6yxB58IbKOI5ZgcaQun
         6Goh8DeZa8E5M0nWtx9EPr37S68vAkVCU5lxfUNup2IWWdD9aaU/5I5xzE98vDsh3+rG
         HckAGD5U5v68WLzkod86gPzr9PAF+YJ/jd2repJ6ivH8hZtOU5+9AF5fpsUQeM6sisq7
         fkyQ==
X-Forwarded-Encrypted: i=1; AL+hErFjHY/LbX2/edK8LghSGD/wHgAN+fq+FCOlZOzKbGgu1USSZ1157AozdyTK2dC/p1QTa13Xy+ENiiK+PCA=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z++3BD8rrI7ScGqhlzR14faajfVXJ5H2t0hvWO3FQMnOZDCqr7f
	A0xmmdxfiMvuAjpgBX82RbYyRn3VFLqyOhCF35uguKZTZXN2lWmp91ldJmCtvQ==
X-Gm-Gg: AYBFou3cdR5lHp16VxmNPA19hkgL7NTPY5Dnk7bB1wIy83fLfGFt4d8KvVIjZLXp75b
	FpjcmITCP8/5Afr4bHU/lu6B39AUR+OgQmHTqwKKP/pIqMlJzsQRS8NJpDjsK5cNoXrWpfHttBh
	uWKZ2fVpc18p9jjgn+1URD0p7EaGeyM0EAfN9F4CjkxI58SfGComySDhOa0LZn4ZzyokcTQ+7H0
	mol3st1YD8d/ofiRrRBQa0/XwE+zj0/cWCSzOBxz4vEimklhFnCLv6+7rsL5DN3wFVoxn+69ML3
	8CYOJA5N64DVKJTz41o3zBMa4pwFm4Wt4PrVRRog2MqRuSjewWExNdPY6d8lyJmSAKppdz7rh4h
	086OfbhzyOhty7QFfwunzKIkr5MJNwreFBJQqAUmpiKDQe6UKbxDp2ORnNTuK9fZjte7NELQ14n
	WlZ1W6RZ2AkaozKaz/lh99uYdsCSWagunkvibXBaayLBfAsaaRCsQsyca/mYGuk+QWMEi1t0u/P
	f+73w4WLh+7hll/OYN+4Mrv+imS/3/mYeA2XDS0yzYX/5Auc7EDDivqgaFkvSmmq9KSmNlm0DJ8
	JnXYf16VwpoFsPwdZsRoudArR/A=
X-Received: by 2002:a05:7022:7e0b:b0:1a7:7160:ffc8 with SMTP id a92af1059eb24-1b543cf2a06mr5386778c88.10.1795094276119;
        Thu, 19 Nov 2026 05:17:56 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5447f468asm14497400c88.12.2026.11.19.05.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:17:55 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Dan =?utf-8?Q?Hor=C3=A1k?= <dan@danny.cz>, linuxppc-dev@lists.ozlabs.org
Subject: Re: WARNING: mm/slub.c:5459 at ___kmalloc_large_node in 7.4-rc3
In-Reply-To: <20261119132833.cf48ab8d95a8be3b900332e2@danny.cz>
Date: Thu, 19 Nov 2026 18:46:21 +0530
Message-ID: <7bi9kllm.ritesh.list@gmail.com>
References: <20261119132833.cf48ab8d95a8be3b900332e2@danny.cz>
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
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Dan Horák <dan@danny.cz> writes:

> Hi,
>
> I am seeing "WARNING: mm/slub.c:5459 at ___kmalloc_large_node" when
> booting 7.4-rc3 on my Power9 based Talos system. The warning wasn't
> present in 7.4-rc1. Is it something known or should I try bisecting?
>
> lis 19 08:02:43 talos.danny.cz kernel: WARNING: mm/slub.c:5459 at ___kmalloc_large_node+0x1a4/0x200, CPU#60: swapper/60/1

I think this patch should fix it.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=126b47221b7b98d83c118781ce724c0515d86d9c

Could you give it a try?

-ritesh

