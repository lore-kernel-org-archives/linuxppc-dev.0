Return-Path: <linuxppc-dev+bounces-29420-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A86CC6B1A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 16:47:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j40cL2tQDz3bs2;
	Wed, 14 Oct 2026 03:47:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::131"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791910034;
	cv=none; b=HeTIxjFvnY/hDVmJb+TERklXPLJLryO32KyFxsM9KP2wOduXvifJ4SP0kEeTIiycKB703MnJ10Eosb0AVKRu6VpARqt+7jQaWMB5XoysE9wwr2Nq49KML4hc3dQMfkA7cYwhP4t/7MWubJOsGaedxu/k5zx+qTw9PpRMQXD/I/0ccrMs651NXtN15iahCa/snEQaJo2RHwusv5mz9aqYaJTmlo/HroWdc/VS4YzA4mbtEDDyYIkXyU+VMLM7XqftzIh0h6kFlKfe6yecoljY4p6Y56oThnswNa9SD74lUZoJ8L9ETmIpmSYc2pRMXui8gEHN5T7iZXMsC1jhxMwfXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791910034; c=relaxed/relaxed;
	bh=W7ehum626aRdlGmi7yPsx5ujCWqhQvPjIn6TPtUOXnM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXsVHy+WZKdsdpM8KW8kAT6D9P2+ahRDFDW4gi/Uo630qGsi+ymzsBcpQGIqxy0AizGyb7Pb7f2Mrx43lUiR9PExmUIr9jYAeuuqwOEMXjtfZ9rmEP3K/97Fe/XDuo8tVg21Xzd5GZ/ilAZvsrM7asQUtzshHrBJf+CKTMV1qVITywSOMByLK/unwiXUZpm3/iF2pmysbG1kZuiev3RmqO9oZE00Ue0THfgYycGh19NGXFrVdZrKeY3uD6sG5+6c/8Mk8L5i31eVh7l+TFJMbPeQ/blcheLh8tclckcBmqhhinOyx+bYbeNm8PfF9wzI96C93tLLkhl5S4eMo+2B7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ASWk1TkA; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::131; helo=mail-lf1-x131.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ASWk1TkA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::131; helo=mail-lf1-x131.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j40cJ748Bz3brr
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 03:47:12 +1100 (AEDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5ba4180a65aso2781384e87.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 09:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791910023; x=1792514823; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W7ehum626aRdlGmi7yPsx5ujCWqhQvPjIn6TPtUOXnM=;
        b=ASWk1TkAzRTj0mA0jnKEN94RNOz+QNVZqC64kMui27hCh9bU7yFONRrxXXH7al9jWl
         YYIHE4CvycuhX8FKMs8UKiOWs8Xs3ChIx1RK79LgHfI37r9huhvYRLPuuRhe+1osKfsw
         EClVEZb+WFYTs6KRTcS1xDLjSb6afcGznDYoChlDhUsBPYgS83SdjL0agSfH1HTIcioy
         r7bkv+s7LT6wwf66V3X1k+M4TkXhFxXxUcImv7OWENfvRreOSDgkKEVLEAmtkOjYVELK
         0rDDeBAAAYzgaJmjMGYB1lSJDtAbPQhue+nQD9bVOlYMxHqpLSFKHGBUbLROl7rXm911
         0Jdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791910023; x=1792514823;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=W7ehum626aRdlGmi7yPsx5ujCWqhQvPjIn6TPtUOXnM=;
        b=zSH5gKrq/hui9SEvK6FEgDpW6QSmMNfPoqx8uUGwdEeCEY3K75Wql/h738WZNp9Q2v
         sYqjTNU82FFZpDOyTL3YLlbYzuE6Go96M1CajIoptmY2T41UyR35JspmRcZ7YnE4e+pQ
         JQenEDZ6DorVs7xUg9o0ahAJK4B/Krn2yiYmDUUXSwVOek2mOf17g+3+VstXxBeUhla4
         RXhgKtJiF/Nijh5kVbntN1MPzjQytJq1L1Q0R6tjspQdhpB0BR164Jxz7FkZtpxRvmQW
         5sa5TVIumjja9tYXaiZGIgQAE4wsnJyd6inIX9MRsbAQv3ecUr4OooqJfuzJuwsiMTMV
         uzsg==
X-Forwarded-Encrypted: i=1; AKwUvBwubUrgha5g8ZZWdUzTffXPJ0r0fkBP/q2iuxmLTHSugtMO1sIrqc/bNIlDjwVAqf67P4GmDXoUHymUK9w=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKKr1ZktjoUVjEZCbe9z/LlyXhoDE27K1FnXszaviVxDKsGaAMZ
	x9IW4aKnAOrDAZcyW8yrNshPYHjBotJD895FD/hVcOumTmORzNikZpIg
X-Gm-Gg: AYBFou3Q2/xtyDYfzp2wzjO0d5egrHH/+BU8qT7cG+vSI4WQCmTI9DXh9DdtzBrWuMW
	SAfo4ht0+pbJdxk6V+vuqXvg/FXSZposh/55/Wo0fHg7gufy+xqzjijupHyc7XcPqVipMyiMRxY
	xJ2NEOEdqbHCxFxbHDfw0w27d2oX3yADnvi+YNDU+0F5bs3GZbLRKck+h1NV94IpgfgFGgri6Ew
	nZB15zSiRv7n9m2PV8eW1/oRg8OoCvroEL5gRYZiq5zd8Zdu/uij5mr1lfMqd7o2OXYPzlBWxt8
	K0jelZNL3YaYifXJRPzrjDkZ0m1rxz9L9SAHiNpl2PBezBx6EQW9cyK3GJiACLF/tOnXYDmE7ra
	ASuyPsApjG+3cVPCJFn+iw8/2A+4756ugZEXqIbs7n4GpsE3xM3/zg9j6RRivKGRpzmk5DrDPlq
	cVojnB4o8+2NEm3Ii25ElBTiRrZoMQ2W9A9Svvf9gsT8l9O/N5/kofZxKnBryX3tx1qUhec8/XT
	HqmUqxmDbGYTbElZwd9bAMFmG/NOfFzdGU=
X-Received: by 2002:a05:6512:2243:b0:5b8:f202:7749 with SMTP id 2adb3069b0e04-5bcde8dec4fmr4962852e87.59.1791910023287;
        Tue, 13 Oct 2026 09:47:03 -0700 (PDT)
Received: from pc636 (host-95-203-22-87.mobileonline.telia.com. [95.203.22.87])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be33d85b40sm52801e87.50.2026.10.13.09.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 09:47:02 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 13 Oct 2026 18:47:00 +0200
To: Suren Baghdasaryan <surenb@google.com>, Hao Ge <hao.ge@linux.dev>
Cc: Hao Ge <hao.ge@linux.dev>, Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Uladzislau Rezki <urezki@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 3/4] powerpc: drop redundant unmaps of failed vmap
 mappings
Message-ID: <as5ghOejcvM5zDOa@pc636>
References: <20261009063619.112313-1-hao.ge@linux.dev>
 <20261009063619.112313-4-hao.ge@linux.dev>
 <CAJuCfpHjX+_AvwgqV3XB_QQuorvnegvd_YjQ85JZWfSk-ckUHA@mail.gmail.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHjX+_AvwgqV3XB_QQuorvnegvd_YjQ85JZWfSk-ckUHA@mail.gmail.com>

On Tue, Oct 13, 2026 at 03:23:41PM +0400, Suren Baghdasaryan wrote:
> On Fri, Oct 9, 2026 at 10:36 AM Hao Ge <hao.ge@linux.dev> wrote:
> >
> > vmap_page_range() and ioremap_page_range() clear the PTEs they
> > installed when they fail, so the vunmap_range() in remap_isa_base()
> > and ioremap_phb() has nothing left to remove.
> >
> > Signed-off-by: Hao Ge <hao.ge@linux.dev>
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> 
> 
> > ---
> >  arch/powerpc/kernel/isa-bridge.c | 5 ++---
> >  arch/powerpc/kernel/pci_64.c     | 4 +---
> >  2 files changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/isa-bridge.c b/arch/powerpc/kernel/isa-bridge.c
> > index 5c064485197a..93029d85e6ea 100644
> > --- a/arch/powerpc/kernel/isa-bridge.c
> > +++ b/arch/powerpc/kernel/isa-bridge.c
> > @@ -46,9 +46,8 @@ static void remap_isa_base(phys_addr_t pa, unsigned long size)
> >         WARN_ON_ONCE(size & ~PAGE_MASK);
> >
> >         if (slab_is_available()) {
> > -               if (vmap_page_range(ISA_IO_BASE, ISA_IO_BASE + size, pa,
> > -                                   pgprot_noncached(PAGE_KERNEL)))
> > -                       vunmap_range(ISA_IO_BASE, ISA_IO_BASE + size);
> > +               vmap_page_range(ISA_IO_BASE, ISA_IO_BASE + size, pa,
> > +                               pgprot_noncached(PAGE_KERNEL));
> >         } else {
> >                 early_ioremap_range(ISA_IO_BASE, pa, size,
> >                                 pgprot_noncached(PAGE_KERNEL));
> > diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
> > index e27342ef128b..f74269636d5e 100644
> > --- a/arch/powerpc/kernel/pci_64.c
> > +++ b/arch/powerpc/kernel/pci_64.c
> > @@ -139,10 +139,8 @@ void __iomem *ioremap_phb(phys_addr_t paddr, unsigned long size)
> >
> >         addr = (unsigned long)area->addr;
> >         if (ioremap_page_range(addr, addr + size, paddr,
> > -                       pgprot_noncached(PAGE_KERNEL))) {
> > -               vunmap_range(addr, addr + size);
> > +                       pgprot_noncached(PAGE_KERNEL)))
> >                 return NULL;
> > -       }
> >
> >         return (void __iomem *)addr;
> >  }
> > --
> > 2.25.1
> >
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki

