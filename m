Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E6D606A320
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Nov 2026 02:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mXCoi4dq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXDD469kgz2xnn;
	Sun, 22 Nov 2026 13:53:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1234"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795316020;
	cv=none; b=Vgcby1Z6KVpCnZnQ8251uWp8mxIfTy66H0JR8qGJlX9U+DEoBDOZHn7NeLDped4yR19OCfO+MTAsEOM1xGSxHAO7zWnOF60ZQz/oO/tQOLZvK+1UtdhIyXXa9FhEO+g3mJ0/BB9al9rRlC7mVGuZ3jvXMry6/AxiVlJ0df4yCX2zSNhuzB68y1Szb1lo+f7Z8x6fioGyoqWIw8jl0Tul7Dn5ZOmIOQ3skifwEFn2JXUVgjaNBXhBIueeo5OvnkZeYFQ1vn+E8ggCgxprouX+zAWEhx5NEB3gT+sZE7PfvulqG9TddV6G3HieqA7vIU7OSTDkPM+Y+OI7nK59tl11GA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795316020; c=relaxed/relaxed;
	bh=W/MPU0ws9cN6OmylOQcaVZtBQz8QcJlnEdU8znZTTXA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=TfiQ/6l4FMjwhO2g1og47piYz2LCDZpJVsoNKLXEUMP6x3cbqQpX6LMo7+Ms1r9OPDbiItzoRfkC43lissK322d6JU3U292CC7QC6qaGfFd3xJAFm3qSpCVO028CzmI5TcKZi+AHyyEeI6Y+C1zODx/tGNnW0uzQKz01c6AyJe/em0p5vSsdB4hk5RpOwov6I7MdOW+rOmAGVnoGNlL4NFvqXBJDvn3Ig6bPMtMbRosTbT+GeFzAubveBjUrsqM9dhrHgbmETx3UUcKQOrMKA80R8Kr1uozOuljONhfOKgsYEV+Gx44Wu4NFoKzaNX1ztUD4OEI28Z2H39dlxTnT7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mXCoi4dq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1234; helo=mail-dl1-x1234.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mXCoi4dq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1234; helo=mail-dl1-x1234.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1234.google.com (mail-dl1-x1234.google.com [IPv6:2607:f8b0:4864:20::1234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXDD3564yz2xgv
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Nov 2026 13:53:38 +1100 (AEDT)
Received: by mail-dl1-x1234.google.com with SMTP id a92af1059eb24-1a2761c69fbso4546907c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2026 18:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795316016; x=1795920816; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=W/MPU0ws9cN6OmylOQcaVZtBQz8QcJlnEdU8znZTTXA=;
        b=mXCoi4dqOIBtprWvLy+OYGl08QGiErba+CHK+1K4QjFISSzZh1h9yd1VGzxJAktVym
         o/PVFwg/8B+lq28wqzBaRhIMAuEZJamxUS0G5v/oLxUAEYyKSabbniZ780Sygs+CJpaj
         S37Y9vI1q1LLN5iejfpP6/nZwdn8JvqqiQrmLSsCO88L9a9B80Bk03ALGZ9IQe2hgZ9Z
         qZYVWjXv/Zuues1QZboO+xaatxHoebcWx9Rl6verEFxE2X7uz8sEyFObfOsIRs8rB7/5
         +9EslcziJ/u9u8ivyF7UhD9xHXRVZeu5jdQRKL76jk3fflu+OeI/AOw4k48HE72+BNHv
         6HxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795316016; x=1795920816;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W/MPU0ws9cN6OmylOQcaVZtBQz8QcJlnEdU8znZTTXA=;
        b=Qy/6dAtwZYQYTOa9usv+VRWd9KB/JwOOtnybhD2RAqfLIEXcxpCKrV95Kq3sCZPMo3
         NPgfleorADqPbpoeAWRlgivQ/0rD8ZDxOIgoh5lyCR64iU9fJ7nzwAUlSqV8/GnlbzDU
         YA7M2WjqmWD+GWfGp8sdmqvC4YtsgbGNc54ap5Hbie90H7BmMbRRYidwnj2Jiv0B5Cul
         uzCIwNgf+iN+8V/xjGvISPnW+fkjj2Q08bh+zP8lSklTLGJiaMTdxU1v3+YyAxrDQOtS
         jhXR/rUipueDtGTFxywzuyjfLBw6714qAcBybvEO5L1Dki4Tn25r2g0BySxlOI2xVFcR
         WILQ==
X-Forwarded-Encrypted: i=1; AL+hErHHyAooVFwXbiXjNws43x0PaYsyzlZIifbnplQxMgN6qgS09ogXFxVWCG5nDDMatVhRjS+U2IrynEZANPk=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9UDZCAuW0iXLm39tdPXiupjWGQxyV3bC2JAcqJSXzK+EKEqrXP
	sgR379KhhOoYf8/DeiPWxPNlS4mWJFizjyRtwQA8z1ynG0Zpnji6/i4I
X-Gm-Gg: AZFdTZeh76gNa0SjM5Jmo49JeszSLEjbdCtO7Guuyp7gDSilE5VzTdoq+7nBlAUttvz
	Pduv5fk8BjD6KbOAHOuvMlZ26y/zU+DUIK8+anv3j4oD6gXP+av19OWR6bFMOCA7oRyy7tl/D3I
	xDcMNVPBqGaaj29k+4+aax0M2CLIsYFtl3z+rwGTVHWYIHwn4B3XUSwo0BzmYNW/cbPyJB5DFK6
	Az8jAjlCsrPDPKkpgjGIPiOPE4YJO7tPT5kSsg9dijg4c7qbfy1QzRLHgCuk029uwPddxFbILWw
	fPWEQkczac2K2kB4qZzph/5oXnSdCPBGjQEKWkKy9bKh7VWQW0Yp7nC7lVsSoNwPZyAOF3D1adS
	mgSA+AzcwQn7uUIVdgG26FiWRT1bCB1RYJIBxOvV1SMKnqtgLy7m7r1WLTiovVeoep2P2jTXiit
	KkgpHQr/gXriCyBSzi+H1d6FoxVcmcy5a4DyppAwvoEwEjZ3PN84SxlxVvp0z9qYIELxGH4F/w4
	24NGSfOiM/vyzvI1jACMnM+FHlRbgMeRO1tA4r4F+VzPVkbdTTurkp85JRTDHZglfjGMQt8oCcv
	RllBQfWjNrF6ik1Nkx4wPUWbiBqT
X-Received: by 2002:a05:7022:4099:b0:1b2:3e9b:3dcd with SMTP id a92af1059eb24-1b5568b2e59mr7776194c88.10.1795316016104;
        Sat, 21 Nov 2026 18:53:36 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556840494sm18082231c88.12.2026.11.21.18.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 18:53:35 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Jyoti Gupta <jyoti@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, npiggin@gmail.com, chleroy@kernel.org, sshegde@linux.ibm.com, oss@buserror.net, Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH v3] powerpc: Fix missing of_node_put() calls
In-Reply-To: <20261120110648.333973-1-jyoti@linux.ibm.com>
Date: Sun, 22 Nov 2026 08:21:58 +0530
Message-ID: <y0alk27l.ritesh.list@gmail.com>
References: <20261120110648.333973-1-jyoti@linux.ibm.com>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
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

Jyoti Gupta <jyoti@linux.ibm.com> writes:

> Several PowerPC code paths acquire device tree node references but fail
> to drop them on error paths, early exits.
>
> Add the missing of_node_put() calls across PowerPC platform to ensure
> proper device node reference counting.
>
> These changes prevent device node reference leaks and improve overall
> resource management in PowerPC code.
>
> Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Signed-off-by: Jyoti Gupta <jyoti@linux.ibm.com>
> ---

> v2 -> v3:
>  - powermac/pci.c: Dropped __maybe_unused from the ht declaration in
>    pmac_pci_init(), as ht is now used on both PPC32 and PPC64.
>  - kexec/file_load_64.c: Use "goto out" for the -EOVERFLOW case in
>    add_usable_mem_property() so the common of_node_put() cleanup is used,
>    instead of adding a separate of_node_put() before the return.
>  - Link to v2 - https://lore.kernel.org/all/20261119075827.45823-1-jyoti@linux.ibm.com/
>

Thanks for addressing these review comments.

The patch now LGTM. Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>



