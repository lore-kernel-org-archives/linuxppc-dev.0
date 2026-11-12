Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A14606A888
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 19:10:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQVMh1ZYZz30gC;
	Fri, 13 Nov 2026 06:10:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.221.177
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794510624;
	cv=none; b=SIBeFmKgo//hZ5txa8flOLWqED80qTSHgUk7uy6LyA8MGGzPQO6VcKRa/Zoem0Iqkd0ZLIFJpnqW52C8HyKFOtOZt7eyXM9xgZEkIgYH6YDeo1mz7haMKkCQKafP5bdLUwau93Ek0S1MTl7F6hN8j1Vo5Py3Saf7Gtpr06jnINOQ7W0nvD72niJTsEnu4kDtoqX99do8OE2b8ffP4CfInW2t2cHWsJBd2N+Sd9Eb7CjC0TiHdLoFNO9w0pDu3UD+OOZPbYLtFr9gTFnLaZH5tVuNmzBEqWAEjBlgYaRG8KqFD7K5MNyJc649k2+JIgN6QGUUvXvMsDfuFQBXsunLjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794510624; c=relaxed/relaxed;
	bh=BiDOWQWnXjiTVlwWz8It4XU8j0IkMRXtLOxSJ2sBmUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SqSprc3uuX3f9QK2eUD8Gx9fQlHffPeJpYiIuSF7+jEoezBzhfe1py4JY/qMGQeGfUqfodHGuyh3CLRjlCzRmTRYjyrGHis9TjsGVYzzihEWhusAxyTJIgLT4uC84QD9HjjUZRzAbz/4jman+eENpYcCghyQs5vu2WUd6h2AhxmGhj6Pgj+/qKSISU0mU9m7gTa6vRcjxSSrs9EaR2Mf7hTZUWa32BsqfeyOeoGiw9EYDok+udTJGtbs8jvS59wJa/deKjClE2cQwUgPhq92xBK0dXqavYooH/CdSsf1IRhl/9gmHdZCF/B6DrHGIoE6+pcRKjwTKRd7llcQp3eOjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.221.177; helo=mail-vk1-f177.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.221.177; helo=mail-vk1-f177.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQVMg2MTgz30WT
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 06:10:23 +1100 (AEDT)
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5eac01ff101so101495e0c.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 11:10:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794510620; x=1795115420;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BiDOWQWnXjiTVlwWz8It4XU8j0IkMRXtLOxSJ2sBmUk=;
        b=FsyN7rqL7Mytxw5ybenC4rgyPn628qPHCxdypr2Z+San/YedESHqu4w6JGTJoqGB3y
         fg2WKAmxG41P+NK/MuXfyf/fzdC49pVJ5/5VN0L0GzJH6J3iwZBPdjdZga1C+xwmvK5a
         DGk2Vu7fQX9ltRVqdrjkMB3LrmtReFGzNzx9vP0VXqV9NPSzEzP+sHuGIGVimgV6l9i4
         xihZvkKR61dlJ+NOHWqEfa06qjdGpCmL3ZXE44bqPyFfesTxos5AB7q1ksIIn0VWKwp5
         yxrbKKRM1/0fsJUZ/x8VYgGp3rcjdCnTFTG2UuHhlMXIWpBbtf87ls8kr4XnlzMBWdeT
         20Ew==
X-Forwarded-Encrypted: i=1; AL+hErGNyLwSSOj//uL+eVMYlJhRRI0km3cSyuec/FYavlu+U+kDoN3iAMiSmL8IVCPVQkcgD+DXPDx2e/VUgUQ=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/tOTa7h8co1wLLZ1DrVb8jk9pd4uTgcI+Ex6sRqokkct0AVUnA
	XW+FGr4XyXCkReTwMW8tD3HzAOScaQXNifcGB0nI33d9wuXKdS6Cc4nfEBH5TuD+u0Y=
X-Gm-Gg: AYBFou1NmzHY83FnCJzQKy1zSRpp4Hg9EbfH+W/rIX9JtbCn0kMN7P7gHuG8PGSbgqw
	BS0SV9TZJhWxHMPmHwz19RPez4Xc543aDCBQBAs1LomPRtpcvn2XjEvUf0TL+hHlgSV5J2ljbhz
	LRlnoJs24IloRLSUGDJOm21EzYKMFWjG8xqb5OSGQf6NPA2NhZp8RbKagAlA/tBEcuX5G/ml77b
	eFuYB9ESFtEISpV1v+/iDCxZWVERSohaUWAZN2k2vLy6u7972Yv/SGxpVOXgINSgsyBHoqriGLv
	doqGUuKdHrBYTB+lIbj+kjkK3gSI4TPPCGoDQ3cR+HhJxzOYCrfhMcQRT/paBSo3TF6Q5wi0vZy
	xTGRO8Qnj27dzKB1Vynod6FEz/J1mRj5j2rQdM2EYuWKQ0bIVOqBYSpRl+6jE2po+sNFsnj03w1
	odocBrtAhhfJKToVTpBSSmy+Ra8b/Hngu9dqaoJQpZZ7fAnH0xriszlOdioxSqNA615eGdponrE
	F7xkaHQn2mxvtf2TKuGAMdtZ1vGOdVWx38F/daqojgshB92HMWplfF/EBukQCK7p4b3BuvgQ4tW
	z+OjAtEY4FA7IVOI+eMPuX8WG7GHJvEmkCC4vxL/SLoLRIBqcvW/32QbFs3NPqqYpLbuYqANg+a
	A5ArRncEVZn6l
X-Received: by 2002:a05:6122:489a:b0:5ea:9218:eac1 with SMTP id 71dfb90a1353d-5ee34aef4c3mr31795e0c.20.1794510620125;
        Thu, 12 Nov 2026 11:10:20 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee34236603sm88814e0c.15.2026.11.12.11.10.18
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 11:10:19 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-7cc91ddf447so28271137.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 11:10:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErE3yDjnb6nuj1+8EpzdF47QwSFDY9eMdxlyPf7HUyHfbx9/MfFwP3CwiETI7UETyX+XPW+VUhTMDfHgzlw=@lists.ozlabs.org
X-Received: by 2002:a05:6102:5ccb:b0:7ce:5952:125d with SMTP id
 ada2fe7eead31-7d64db29605mr42432137.36.1794510618289; Thu, 12 Nov 2026
 11:10:18 -0800 (PST)
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
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org> <20261112-work-procfs-oldmem-v1-1-ecdcafd99265@kernel.org>
In-Reply-To: <20261112-work-procfs-oldmem-v1-1-ecdcafd99265@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Nov 2026 20:10:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXgM_TMX7HrpsvDaQi96Ht-K6KTBu5PPRRBpcCegf3Q9g@mail.gmail.com>
X-Gm-Features: AclHuK-k7G9fpVKu6BhCbcWfXavvnldoQZhCl9e2eioRf49lg5T7xpzAfc2z5gM
Message-ID: <CAMuHMdXgM_TMX7HrpsvDaQi96Ht-K6KTBu5PPRRBpcCegf3Q9g@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] powerpc/crash_dump: check ioremap_cache() in copy_oldmem_page()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Breno Leitao <leitao@debian.org>, 
	Chris Mason <mason@kernel.org>, Thomas Gleixner <tglx@kernel.org>, x86@kernel.org, 
	kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 12 Nov 2026 at 17:39, Christian Brauner <brauner@kernel.org> wrote:
> copy_oldmem_page() maps a page of the old kernel that isn't in the
> linear mapping with ioremap_cache() and copies from it without checking
> whether the mapping worked. If it didn't, the copy reads from an offset
> into the NULL page. That oopses unless the copy happens to be a user
> copy, whose exception table entries turn the fault into a short copy.
>
> Return -ENOMEM like the other architectures do. read_from_oldmem()
> turns that into -EFAULT like any other short copy.
>
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: 54c32021eb6f ("[PATCH] powerpc: Add arch-dependent copy_oldmem_page")
> Cc: stable@vger.kernel.org
> Reviewed-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

