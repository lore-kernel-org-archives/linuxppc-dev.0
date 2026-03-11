Return-Path: <linuxppc-dev+bounces-18005-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AD5FD88EC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 03:37:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVxJd4ddzz3bTf;
	Wed, 11 Mar 2026 14:37:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773200241;
	cv=none; b=YB+Dd9WfIp8Lejff1ern4Kjtn/oNafXaa80aq9bbegi54AhJjLLMFXuHMo39ndb6BYBRUeXuWRCQh6Sy69O7VmsmD1ggDprvW/zYmL+58xXyqv4/AYIMWNQoIlc8SqxpWBHo9vsiJhHYiry2cg6qNPn6P5QP5+9xRQV0dcRc2k95ZbajFBQ+uC7uwe4vXT8Ydmbbukt6sWmcK956uhsX4mlKiqNmvA6awjWSnmq2Sukw7veypIY0F8/XgN4tHVvP2zWeVV/3NmM3OGEG3XyyZMThYJSuSW8k6tKoBEsn0r2H496DwfbQi+qiopKx4DS5NJXtzBf7FEoq4byhcqIoXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773200241; c=relaxed/relaxed;
	bh=rHxXiAvo6zOonxHyAewJkbWbuOENn2paNkRQUdILloA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=C/w4kSYYfX+kvkvq6ujHC8ZTDUWtarzjnq0YaEESx4KMSJdkhVJUnAzXyf2Hs5K/Re/mq9dwT/GDBrz44PFlLJTTMrYapZlY/n1iDcklQ6zOqHkeYN2gx0K5lCsCURx4H3RFyXqps25HJ9W8EUBcHIO+PgjxMFYiVC7J3WR1Ov6PkHZjCOl1YyzfuNRJg0dhTp6TwnwjW+rVpJjLn3UhUN6H0tTlTObIz1wtnyuOepzceLx5m+0GQNU9OyQBNuEP6F4kmr5Dm2MSD2/He0nu6eGjblUnH5gN1AL8sqi9WYJ/a5n18NKrWtF428yyapRZzdZMFRx7Sr+XY/nAo22fNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Amca++Pi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Amca++Pi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVxJc1gSdz30hq
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 14:37:19 +1100 (AEDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-82735a41920so5038977b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 20:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773200238; x=1773805038; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rHxXiAvo6zOonxHyAewJkbWbuOENn2paNkRQUdILloA=;
        b=Amca++PitSeJqU+i8tG7WLQR64TdYMWUi4FhDApk7/YkqAJavpNj8dRkCMH3LaVqss
         IpP2v+Q5iMLyoWq7c9K9kGgdpTnVz7Loe1oUD7jxGfjVxtVxS5klon8Kyqqz2UUy4ku3
         yPnAHDsqee1mEOn90t60EdLqJ4sp0QMmpX02SV9PuYt4yEgc4OAI5CxVZ7Y0p0M4aldn
         utQtIKKN3T9NYzZQBSoI/LpbqzJ73McgjCUqpvQ26ku6iUhzvp3auOpaa6wlJTXcD7EM
         crSf8TIl5zYJ68zThggVzcykwMI32CUSz+i8MYVweSHgug1fjxp2XBEWAS6GLHDdLNuy
         KFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773200238; x=1773805038;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rHxXiAvo6zOonxHyAewJkbWbuOENn2paNkRQUdILloA=;
        b=D//8XhucZ7+AMa9uzqgz86tYaWAfLI4OMezfyi+P5eKIJ2vn4Lk5WrQk46x8sMRyqV
         Dxd9F49szAFjBtoesbrboc889443ZdgpubWLd66eFldqlsJ61aZ/tZrdQmsH6oYMiUmC
         p8e9/uiiHjU2sspjjNkPzlcXvUY78HbtTwGxQb4j1Y+dqFKm2wc26ejQxoiRraHLT/uP
         iFuY/2wIMU+MMNZTtwhvPuaGZIXzFt5DL+nR6IXRNVpEfDnQAczlV4R4eGprMcOlRZ0O
         LJH+Q6qLxF/TNqWS4ZJ5fy5hgrxM1C6Bj3+QeNeEA6asI9uFmFj6OOl44M+Y/fB49D1g
         GKyg==
X-Forwarded-Encrypted: i=1; AJvYcCWbrz3X6fBqjR1AKpoTTbeHaAnHgT6BWpseWBvYAu2efYOT5bjL1s/imOptK4Viw6AxYzXBdapf9BX42pM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzEsQJ+RuHiYxpvoQUF/Qrteeqj4DYew/JDi3EZqw0Rt5SMKC2B
	sMKlzQMPItV5i9riSguzCXY8IZYe1gd/5EHzPOTvJoZW6uWsmASYzdXK
X-Gm-Gg: ATEYQzwJbNYdNZQKyHI6dnjvR6V9tQ40+DqZ5yt88YTwuzZAYPJUlbyUQnCtR3WL4+a
	DruKnrjpsTQSVs8nwU8/aZ1eGw59feT+MUAsD1QPi3eHYLfBc7az4sFp8Q+s2w8GYVsWEVa8+Z6
	T+Ym/TWEbgzfMCCX6DRIDyV365pxd1KPGQ7dXqSJjB1sEAaSv8tH3zKFKFHjwEnrTA0O4JJu4bp
	/awZMiS9p7d+IvhRM8csZW0r++Fq8V5eEq98cv37OoRhR3zt+fdgsB+fY85ABUxBG8LjIo6q9jr
	r/IT0vjE3rVgPN7Zpdu94kDLltF3bva3t+lcVphpr49zQ0Rbw93np3hgx42CjQVrWCX4C0gd8DL
	4NMDOo2qqwTxHxA0o0p6dab9Sa1KP+iq5xgIWFgCwOyAQ36fT/Pa8hVP5OJZ15/f6qYBjyIJu/6
	SXLPYQp88Z7BKmuMsDmxFyxvA3ke5eQVmx
X-Received: by 2002:a05:6a00:bc93:b0:829:7d88:34c4 with SMTP id d2e1a72fcca58-829f7274b2dmr1088865b3a.64.1773200238028;
        Tue, 10 Mar 2026 20:37:18 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6df3bcbsm752506b3a.15.2026.03.10.20.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 20:37:17 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 4/4] KVM: PPC: remove hugetlb.h inclusion
In-Reply-To: <20260309151901.123947-5-david@kernel.org>
Date: Wed, 11 Mar 2026 09:06:06 +0530
Message-ID: <y0jzt4ux.ritesh.list@gmail.com>
References: <20260309151901.123947-1-david@kernel.org> <20260309151901.123947-5-david@kernel.org>
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

"David Hildenbrand (Arm)" <david@kernel.org> writes:

> hugetlb.h is no longer required now that we moved vma_kernel_pagesize()
> to mm.h.
>
> Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  arch/powerpc/kvm/book3s_hv.c | 1 -

Make sense to me. Please feel free to add:

Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com>


>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 08e5816fdd61..61dbeea317f3 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -36,7 +36,6 @@
>  #include <linux/gfp.h>
>  #include <linux/vmalloc.h>
>  #include <linux/highmem.h>
> -#include <linux/hugetlb.h>
>  #include <linux/kvm_irqfd.h>
>  #include <linux/irqbypass.h>
>  #include <linux/module.h>
> -- 
> 2.43.0

