Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E005606A32A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 12:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S94u70lW
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQK8Y2jxRz2xmV;
	Thu, 12 Nov 2026 23:15:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::52a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794485709;
	cv=none; b=MTGjjE0G/QWEAOQdQ02P+Sq13qLQqKl/737p/uqypY9fFlLM4gvDIghgqR5sC4dVfT3OjobsjDyiRF/jQQjn0L4ooXZLmykWe46Fr2D81uKe1BC5wafnSX42XJaqJz+dyn0AhaE0I+KvBca90Mdog2Av8uRXCJLrjnZRw9GeyhLiaJmF6ZaFyPIFOA0niG6llQ3stKXV8zU54+/g5Vmjb9AZedt3LQ/aPFNC6C3EEh1lKRXRdk9Lsx/xGPMiH7r/ouilZFYgQ8jFgfeCZoI4vHStuTfrcXjAeoV4rGmIwL1G9OMgC8LwzsoV+/Bq9Y91KPdpbinNuNSiHpoYtNZurw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794485709; c=relaxed/relaxed;
	bh=cpDaJnSBpbTWNByfkYn2gGCZr1PGzjLso15YyBRA1S4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ui0qaYuKhgr1Alug5DQZCJm9ODKs803LyHp0KQvABuWB4BZnOdotaZvX8KKak75RXRYKZFer9MnnOQbaWBd3ptLwus7Zq2TbKMxbyzletF4g9T7nIKZ7aqzi+hhZVX/Hw/EK6Ry5uFjrSJBtQxt5luzUo7lLjFwahdc8T5xEkHQpuS1oUa5hjlSA1JAzJInMnF3V3L8T3zNlmCrdThB4Lo2XZQ3TyyHrwqPRxHTs7JFqxSpoSw2df4mtJUNWiZDhixSVCRvEa8Yn+jpt2DryYUFMR7EgGhw8cm0765pirJRO42Z9cLDJzS9NROfHpnK1rrMXRHoK6cg9PjDafQdYzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S94u70lW; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S94u70lW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQK8X3Dkhz2xly
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 23:15:08 +1100 (AEDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-6b570ff3dfdso4547161a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 04:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794485705; x=1795090505; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cpDaJnSBpbTWNByfkYn2gGCZr1PGzjLso15YyBRA1S4=;
        b=S94u70lWIZ1sUkSY/6fOQD4re81+WGhOBryflMvI2XzHYZ+M7MNEm32hbgJQuIIKTw
         O2XU0Df+bbheebQsG10ENP0LKdbYhQElo7d/a997US6TFn/JHFCRd/o/4gpq59P92tN+
         Q3IrNkVyKLOhRo4FUj/b5f86yH4Ztg6CGvX8W3o/pleV/v2LkmdgemARPsGoHcC50dzb
         I0//r6k9riScgIhoRn4J88jCaThU88q0dCuOkLM+Ic4wy4kVZew4SOKJqDBDQrH00u9c
         MkHavPgdWJFytvuniy3E7ajULTUOboDRAYs4u/RvE68SbH6DJspite402TxJ/xS8hQ2f
         IpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794485705; x=1795090505;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cpDaJnSBpbTWNByfkYn2gGCZr1PGzjLso15YyBRA1S4=;
        b=2zZvfVKQMpqepjuXZdwPACw09ucCAqfRHaki7j9etO5se3YELXzapOjwA98ldZDPiH
         QjYh1p4DnUWvIooCB2q7uVi+vICp9/59l3OYlFovI7KmlzeSaAtTtnjUFwScWrY8VA3T
         EIFM5/3+XGNUpo0IGZDHKtp1oB8CQKmp97e7VU4846eKxQehkkqxT4tsOguOSmeMefCZ
         uqIDFRII926f4vfJwbY+cidEyWfGyYa+aFwJBdHMJOfqX6innWkSDc1lZfjngJM5NS7F
         tyP5PlwAOLQtlhZbjefYsKu8quTsJ87VsUDpPePq7u98N5sVa8pwDbWbJHsRQAz3HIcX
         DrKA==
X-Forwarded-Encrypted: i=1; AL+hErHImY6p7N9mISdlWJLC/Z4PW+mRvBFJDGPOhiKtlvWwjW0WK+DVm1nywHEim4BcrkBg1NEQxAA5DKAH5o0=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+dT1GWce+6XiOIO1U51CTLg/ynWgU119/s/OkYXr70mEdZT6xy
	4FvHLSDrp2+cNF2fxbE5YUQOCXOt1Lf4dq3z5nDwQlQ6WdaelZXYUhsr
X-Gm-Gg: AYBFou1+qCofhFAoQZpCidlAHNx3GubPj90DSBODRTMdxA5K6kTutz5/cU6pV4ePqvw
	jgem3setv2Z8NE4EmPfz/33+zp8eFj4c3wCs3rb136lZbL1PCY/POrWUwLF3SRIYOtnQQVIKAM2
	4kurJZE7iGux7Sv3eBx4VadtB+KYtf0Pc9+206M2hzp306D+Xs00LDwbhZjSgVuXZmKDrPCEP90
	eJeuEGd0x5UnvWcQx3a3LuU/eEIQV8Vo66EjJ1jOku5vvabPFrQRp+rw4C6C9RTzY0AaXRLxfgg
	SIQh0ljxqB2gSaVjR9e2G4Z6sPcaBdBUuIWFFqkZJmda1OXs2tq7TYufbzR9+BgjTUCqBb4cBJd
	9Cph+ytjPrM1QeW1sfcERmR2uGsegGkNg68AdHET4PXOxttDSFsU0MUvMUiPx2XhvFdt2Mv8Blc
	xRgN4WWfhJCqTJ1PDfg7n9cK3i1/HiwW/l2/D+QzUjSjgcL0k0KBzgCjfcpgu8erSmliu3igrGy
	JEAZn78K7k5xG5je9m67uL3eAPks7xyyu0c4hUCuuk5Np7mnAOUQ4ZN6ydFHRsdjji+xg==
X-Received: by 2002:a05:6402:c4ca:10b0:6b3:c422:9257 with SMTP id 4fb4d7f45d1cf-6b777702f43mr2869009a12.25.1794485705031;
        Thu, 12 Nov 2026 04:15:05 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7578d57c4sm3241614a12.18.2026.11.12.04.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 04:15:04 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Thu, 12 Nov 2026 13:15:01 +0100
To: Hao Ge <hao.ge@linux.dev>
Cc: Uladzislau Rezki <urezki@gmail.com>, Dev Jain <dev.jain@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 5/9] mm/vmalloc: BUG_ON() on an unaligned range in
 __vunmap_range_noflush()
Message-ID: <avWtxcH2mKw7dgbp@milan>
References: <20261110112546.261415-1-hao.ge@linux.dev>
 <20261110112546.261415-6-hao.ge@linux.dev>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110112546.261415-6-hao.ge@linux.dev>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 07:25:42PM +0800, Hao Ge wrote:
> The PTE loop of the unmap path stops only at addr == end.  With an
> unaligned end addr never lands on end, so the loop walks past the
> range and keeps clearing.  With an unaligned start the loop begins
> in the page containing start, which extends below the range.  Either
> way the unmap clears the mappings adjacent to the range, and that is
> nearly impossible to debug afterwards.
> 
> vmap only installs page-aligned, page-granular mappings, so an
> unaligned unmap request is never a legitimate teardown, and there is
> no way to tell which pages the caller meant.  Check addr and end at
> the entry of __vunmap_range_noflush() and bug out before any PTE is
> cleared.
> 
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  mm/vmalloc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 86fbb1d2b27a..0565cbfe325c 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -518,6 +518,8 @@ void __vunmap_range_noflush(unsigned long start, unsigned long end)
>  	pgtbl_mod_mask mask = 0;
>  
>  	BUG_ON(addr >= end);
> +	BUG_ON(!PAGE_ALIGNED(addr) || !PAGE_ALIGNED(end));
> +
>  	pgd = pgd_offset_k(addr);
>  	do {
>  		next = pgd_addr_end(addr, end);
> -- 
> 2.25.1
> 
I am not sure this is good to stop machine at all. WARN_ON_ONCE()
and return?

--
Uladzislau Rezki

