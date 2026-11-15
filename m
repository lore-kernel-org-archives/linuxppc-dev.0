Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7656606A323
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Nov 2026 03:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=val+63hI
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRxm25Ldvz2xL5;
	Sun, 15 Nov 2026 14:48:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1235"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794714482;
	cv=none; b=Od7djPSzQORJHoTYkze4twegiEQX8dhHGj5l/ZSZK/fe9X42gtsCVo+tsd2q/LApefpbwkwCt/K56vMmirDE77V+yoep0CEqOIxS6t+6oEDDCskFyJtTXJXOt6MrJUTYPz7LVNUjUQ8e9Vh7HCweRqr/63n1TDZsnZaZG2C8rmM+U7yBVyRp79Zs1i+f0gKa0IfM0Oeyk+NnDu5Dj8jy1ZICZxgbH2dNua6qSXoBDqFcbzf7PGb//EyyKztuQRH183MGljChtIXiVoz48gm3SJIf38ERWbsf75i4RpGNpYM91Ss1WpZa07k89QzQefMNJjKIgNqKIek7s3dY7Z+3bw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794714482; c=relaxed/relaxed;
	bh=LjmFqyVwuBvTU6cvsaTkZ3oz9EU+ZEVRCv7g4CuSLzE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=ZdP9fioosoxQIle86fE/xl3jl1DTZe6flLcJqOj8uWqfoiq2UntCL+ZPuxLnzLQdZCXDJKOj3hv1N3HQzb8dp9ec+SrKjhSx5rdjP33P5hCGx8Kw/MRpi959VAFPMIhTsWGKbwBh3DhVjm0C5YoZk7ZUVPokQw2jFMGQKhAX43Z0it/YbhfeMzeUdfZbFZHzD3gOMFYgn5VdrxAKx4SO0Y/F/fnP6b7QoywPiLyIQphqRtSdIVnHHEDxMj8ejt1L7awFMUIrwCdNYbVrrccjhFPcJz2aQQ+wKXiR7ulsMaU2I22iy5dk+q3LjVFJYphnkEHzzNcnr49HHzuy42zm/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=val+63hI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1235; helo=mail-dl1-x1235.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=val+63hI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1235; helo=mail-dl1-x1235.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1235.google.com (mail-dl1-x1235.google.com [IPv6:2607:f8b0:4864:20::1235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jRxm10cqfz2xGF
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Nov 2026 14:47:59 +1100 (AEDT)
Received: by mail-dl1-x1235.google.com with SMTP id a92af1059eb24-1438d9363fbso1125594c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 19:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794714477; x=1795319277; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LjmFqyVwuBvTU6cvsaTkZ3oz9EU+ZEVRCv7g4CuSLzE=;
        b=val+63hIvE5y1YvRryfI2Ei6CNBYDN7qPkxXj9T5IuEZ+L4WC9XzxRB2hA6jP1mWB2
         LBoBzVl8p2rXY+PrguFM4qAzPTUTDaQS4RHF+wnGj8NR/6G36ky7GAOu4saXczVeJ8gQ
         IU83tTtzSAeie987NOYcWDWpwgIuyOXRrDAkYjtsWXov/x029gHepTC0LxKZNRID7qoM
         Hq9X3K77qpBPQoAXHNsfKbNpuf4U/o+3I7NbTdjTk6CRQUkSsY80P7tM4eVUa8zb4jsl
         01jSiRTo1q9ju/ifrwdqY0D5Lv2MueFeIIsiBfvHLlvCm/7wzfhWJPUUX9z3XVwJiY5H
         11Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794714477; x=1795319277;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LjmFqyVwuBvTU6cvsaTkZ3oz9EU+ZEVRCv7g4CuSLzE=;
        b=fQ7tG2KKjyTodlMAullGSL9qkg9LUc/Utb4Su3DmBVGJp0Eh6JrxCZNnHWXF6f/YHx
         TFo1FcE3ORcRk2DIVoSSc1C2gbm1juoVZOo5X2pWc+bpTrZ7pt1qTlqExajjIJA9e19k
         sReAYQEptGNdOjIR471UAVqYYQZxLIHyGWDPSG3c/TW6/XzeONtudbRYB6jEgVy/92GU
         e3RDIuhWi9kD5awEIVTp6EFy0y12X8e4edsri6lfmxJkVC5IpiGgLc79SqKQD0gTX7zS
         p71Bw5iuXnH/opS6rtr4/kTjReunZ3D/3i2mDgizspxqLWWS4RO0Py6fXKZStoZ8Q2n2
         zqkQ==
X-Forwarded-Encrypted: i=1; AL+hErE35RMzxOUKmB7/YYxxULKm4ohVIpBQInt4fMhHD21HC1qxZ0zyTtLAkMgxna7f4u+ndhHpEKeghad5DSc=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8Vvfo2zcxQXr0aeM2uPgwj1RLx3F4VDyWSev+zPltGFHjN/+RL
	/dOYLq7nD84OcamLoIHu1LAS3PQ7aYxrAPV0HuPqqn9O0stqpp03LJwF
X-Gm-Gg: AYBFou1PnV4Z+uslOcKCBAwPCoK0FJZ7kCpDj13fYu2pegUe3V/P2NZ7RJN8dnoBYH9
	WrtgsWPb1xjdtg94jsqH3p9RKk9MztjNbuCtwKhIFUVOW51W+s3pc7Agek4SQoV7wXjyVGVkSax
	WoUuHAo+eojsmzquHfcRNn66V8TrXydZCL35p5feK6RlIqlwdIJ8FBb86jeIe9KRmHidtGzlus5
	JB4krE4jD+mB7z8qkUHJo+GRpUWJI5FZP7eNmZUWQy6DquCZIRtmhYdlZvkxPYRKM3wtmQvDH52
	UawVYEx4Vot6X5sKG61YUQCrVR4IZRW+bwccie/3ADMeyHeedUAgLL/KlZEfzWiInVgORZc8jmF
	/2K8AAenUKUGStqgrSNdSJaiIPJ6TwcagGMCksgZ4UkTJL+5SwqjwgaA6OuimM9wSrRZ5YOu1gD
	LsCD26UAW/m+M9yPaGdx4ObAzPAKLEOhXaKYFEji/FKihJrHwTw2ThxErPJ/tMdmnffT9RcWy6u
	i4pq7OoGJYuQDqkn5BuI56V6FMoMw5fyCi/Lq2dTh3NzfqeR6pQoIirwtkkMTjKx3MqnTQuW7RC
	X361L3RJYmmPzeRcUtoJwE1KkS8=
X-Received: by 2002:a05:7022:1407:b0:1a7:4c5f:57e9 with SMTP id a92af1059eb24-1b4f5f92e6bmr9170170c88.27.1794714477032;
        Sat, 14 Nov 2026 19:47:57 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50319e381sm19896393c88.12.2026.11.14.19.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 19:47:56 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gaurav Yadav <yadavgaurav386@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Gaurav Yadav <yadavgaurav386@gmail.com>
Subject: Re: [PATCH] KVM: PPC: BookE: Use vcpu_err() instead of printk() in kvmppc_dump_vcpu()
In-Reply-To: <20260807084050.25216-1-yadavgaurav386@gmail.com>
Date: Sun, 15 Nov 2026 09:12:47 +0530
Message-ID: <a4na92vc.ritesh.list@gmail.com>
References: <20260807084050.25216-1-yadavgaurav386@gmail.com>
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

Gaurav Yadav <yadavgaurav386@gmail.com> writes:

> Replace generic printk() calls in kvmppc_dump_vcpu() with vcpu_err()
> and remove the corresponding TODO comment.
>
> Using vcpu_err() provides vCPU-aware logging context, making it easier
> to associate register dumps with specific vCPU instances in logs.
>
> Signed-off-by: Gaurav Yadav <yadavgaurav386@gmail.com>
> ---
>  arch/powerpc/kvm/booke.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)

Fair enough, this will print vcpu_id as an additional info here.
Looks good to me. Please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


