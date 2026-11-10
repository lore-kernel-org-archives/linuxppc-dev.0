Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5BC60A2604
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 15:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q5xrzrEx
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jP9VH0v3Dz2yNj;
	Wed, 11 Nov 2026 02:26:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1332"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794324391;
	cv=none; b=k03yOohoCjV/NacNKiDRMFag33K0R+971w6glkDqoMSJLrtVqzLU+l43CSsA5Glb6vnR5Jg8s45bIRoVS6MfEskv5dhMHnMjpLz2K6m5rld8mbnFRA8YLnhUn1ZsvL/jUXFbcdAp0jV/EIqeDe1sFYTAXNQdafGJfuTpSl/rF6PHQEaApQv6BbOKFiyXAi8yxUI7inVTbz4zwAwV2JZYFw6ryKSN65WpodB2OVA6AN1/p3AsmXSCP8XqSQqDNQcskLxoDd0ktqgeFUkMa2uCkyt5rylsKLjtOTcxyRuETLXB/2KV5pizOboMh1EB9tbU+2b0rY27cuInyfhFKIFrow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794324391; c=relaxed/relaxed;
	bh=/rNbcmd5Epz0U56BKGmsQmjNGEGUDaMDB1UCVAt5F+0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=fJI5QgowsJcwLb/7276NqRsfoMoueJwNfX9yf4aPiW1dZeWX4xpJlXkCoSRFBD+SWAFORcc9ppYyARAf+G9rwjGsvS5JBzefJrWMe5+6KBnZM0pdKORAmK6I91VhWWt5fk2Y6nyYRBMe+2UaHMTJtyY4nqXf2SmvlD1psjfyioPlFbZcLo/qQZvuIdltBtHv/KDJ4/NXZ8kxX/sIk9pgS4RwpUCzIhkX8frybtdTollWUB0MRsPYA2H4+jSsV3T4sKObNr0JEoJV4+nMcZ6Ruiqt72/Hj3HmRh4U9dZbmTeWI5korOWtpgx7baoAVRcWg4xG1Zbz1oSR31kEQAk39Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q5xrzrEx; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q5xrzrEx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com [IPv6:2607:f8b0:4864:20::1332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jP9VG3tBvz2yMK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 02:26:30 +1100 (AEDT)
Received: by mail-dy1-x1332.google.com with SMTP id 5a478bee46e88-36dbde64409so4434444eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 07:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794324388; x=1794929188; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/rNbcmd5Epz0U56BKGmsQmjNGEGUDaMDB1UCVAt5F+0=;
        b=Q5xrzrEx/fOWaUjYB/GDyaEwIHClSerwDN0VVd9EBzyYOuDS8NrF6IU3GEkTIP5KB/
         ew5cfwYZ/E/wXHQQ9OR0IJ4U35c1spw9GfhAJG2aYex/0HolQ1nIyIoDmLIjSlnjhmeR
         m+36fam7cwUN8fBqGO8SuA3G9CeZ3n7la0jXucMEBoDCJpyLDGsbwHnIVDhuyV6j50cy
         maSDM+5JFGt9hujFtiU6loUDQSk5x4TeVLrLHQoLDkFEBFxh8FIlMlT0pSrsamKIyhhO
         miUmXkLQQcRRlGHTC72wTQTlRGmPDA5KuE/v7h2uxIYi6OpTOicqbeNSTGdV7i8ZhJsh
         qBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794324388; x=1794929188;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/rNbcmd5Epz0U56BKGmsQmjNGEGUDaMDB1UCVAt5F+0=;
        b=Y7a1SmehK+vclAF3mrzMogJLzoKumIRABbzqHjnax9Igsq2eUY+ZYnvGxk5MflVkE2
         iS7DM3uMxMwMdJqd3kVy8Ssx1ar7e+N44wWgWttmCOacCP+j+5EJ6BbAaLBK/wjmPj6Q
         KPmljNqs1xKSNB9f5dyoNcWTh7RbPiYh/mJXfaCMbYo6okydVr5uZ5P9QCryHadOKvM6
         ybiy57+t93AXTO839vO1/6K6afrEtjZjcuyQbFmSf8uYBNFklxmhb3KRtBUFc1fgocjl
         rOc9oEqUuaI9tBETiFoEA+ucv7E0hFRCm8W3dFkIfcBIzjqNk/jQ03TpAhgx5Uvp0wXq
         1Byw==
X-Forwarded-Encrypted: i=1; AL+hErF7jUp+3+AkwVs+d1DKMuOS4rmPDTM1cztNoxQnMh0GbNnJTIo/77htR423YvspZehdMBjaehmBwZTLjU0=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8G/YpT6GKOTkkR51YoHoch6pbAlB7MyX6kc/CcUdDx3EkuF8bX
	Q2CqSgD5qjS5/8ItmywW5JLdsUbDQqS4yE34/9P8CYlIg2PEHqgVS/nf
X-Gm-Gg: AYBFou2nt/x0xVOGKu5mTLgUC10+vmoQOQ8RFycMahzk0s1eLDJ+DwLoeBuyef0F0a0
	eajqlAMrHrzCnUyqjqkNOeAJwk59a56Fg7LAx3iA/RGFMSEEWVR4z/zKwiW3HY+pdmbhvKiYKJq
	FSCEuqSPe78oBYvrJb0989QVuENlcy0FVaHmVxx/flgVC+qMYAeKyjTSi94ZEHJ+EIMOL+P7l5D
	gISgpX1Zi9L9gCqD3lPVm/yqKALAQ9mp4pfILkytWkqh+ubuC6DmL8xrCdh9CyXg+DDe6k/bDRL
	DtMReYyH4eyxAoWq00C0M/HQQVEB2IDUErOi3NOm44qFJvceuK9Gg3b+JHZYLPpvhMd4PHeDjrd
	26I+W+nqvPx4oEovfMeQcShaXvs5zi8t4EwGUoEJGaAbnwt/BnXNh190RZMrA/AAS/e7KyD0CVX
	l6v/XMMS5v2DtOKj2Qoc42pAN2NGkKAoc5UvBoEYIHLLIl913HdD8mXoE0JTL0SnR6U5Bz66MEG
	wedQoJObLprOOqF8r/XXSzKP3ikg8VB/vjdNqPcg1eF3odzRvtZdshJcQcJPgoJm+YLsEoJc0Hx
	sboSqd86IobNhrM9Ai3CLbLskTU=
X-Received: by 2002:a05:7301:fc0b:b0:36a:18d2:8c79 with SMTP id 5a478bee46e88-37520216c5fmr3078818eec.19.1794324388197;
        Tue, 10 Nov 2026 07:26:28 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfe07dsm8049288eec.20.2026.11.10.07.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 07:26:27 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Nathan Chancellor <nathan@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, Kees Cook <kees@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] powerpc/smp: Handle of_property_count_u32_elems() error in parse_thread_groups()
In-Reply-To: <20261109-powerpc-smp-handle-count-err-v1-1-e777fde7f71a@kernel.org>
Date: Tue, 10 Nov 2026 20:55:05 +0530
Message-ID: <mrrg90a6.ritesh.list@gmail.com>
References: <20261109-powerpc-smp-handle-count-err-v1-1-e777fde7f71a@kernel.org>
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

Nathan Chancellor <nathan@kernel.org> writes:

> After commit 0af298e62e5c ("treewide: refresh kmalloc_obj()
> conversions"), there is a warning on boot for several PowerPC
> configurations in QEMU:
>
>   WARNING: mm/slub.c:5459 at ___kmalloc_large_node+0x174/0x1b0, CPU#0: swapper/0/1
>   Modules linked in:
>   CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.4.0-rc1-00262-g0af298e62e5c #1 PREEMPT(lazy)
>   NIP [c0000000006074e4] ___kmalloc_large_node+0x174/0x1b0
>   LR [c00000000060782c] __kmalloc_large_node_noprof+0x3c/0x150
>   Call Trace:
>   ...
>   [c00000000369fb60] [c000000000614ff0] __kmalloc_noprof+0x490/0x690
>   [c00000000369fbe0] [c000000000051308] _kzalloc_noprof.constprop.0+0x1c/0x74
>   [c00000000369fc00] [c00000000200b450] init_thread_group_cache_map+0xc0/0x2c4
>   ...
>
> In this case, of_property_count_u32_elems() returns -EINVAL because
> there is no "ibm,thread-groups" property. When kcalloc() was used to
> allocate thread_group_array, the multiplication overflow check in
> _kmalloc_array_noprof() caught that a really large allocation was
> requested (as -EINVAL was converted to size_t) and returned NULL.
> kzalloc_objs() has no such check, so the large allocation check in
> __kmalloc_large_noprof() triggers the visible warning above.
>
> Check if of_property_count_u32_elems() has returned an error and bail
> out if so, clearing up the warning.
>
> Fixes: 790a1662d3a2 ("powerpc/smp: Parse ibm,thread-groups with multiple properties")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/powerpc/kernel/smp.c | 2 ++
>  1 file changed, 2 insertions(+)


Thanks for fixing it. Looks good to me. Please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

