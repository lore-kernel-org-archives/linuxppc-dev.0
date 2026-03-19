Return-Path: <linuxppc-dev+bounces-18452-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816601090241
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2026 15:24:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fc8d15dYkz2ynn;
	Fri, 20 Mar 2026 02:24:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f30"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773933877;
	cv=none; b=XYIF8VW03ZIUktX3FnMFr+HrfiQ3cH0ptVPg2lCI6M0UF2OqklhhlvRDn79DaAzH16wSd5mWvAffnaFoMRbRJPEzjdiJ02mM0q6L4UcwA3UMAF2zC22UU8onqdzVa6P5OEU/pZmvM84qd4a9iL0yAoeu6hSNm9ApZKyIJngA8d6VVJ8MFCjR611mw5ZLle41oTVWe8KM3nToMmhbHayBkx9GES1HBw+kgK0UwqDzABmIKcpauD93CagrFbVFHX+buJOxOHA7Of8P+9cUxjdZ/V7nzXSN9ZoS0HX26Eg/Yu96HSXtXICYyQ101TvvMlSfSfLgAxq8fFD2lpBXPQcBzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773933877; c=relaxed/relaxed;
	bh=CAHdFeNRl4yy2sR/1LOHb2d72hyJTySGsjAok8mzB+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SjA3G1oJitKGDdZlScLaYzU0rI3DDFMdDBAcxqLVbH+sPpPDrOpQArYQrwcMF+CHlQMP3SmxV2ugYp5i3ftNH2lS3jWY3/r4HaOI0V7dIKvoyVNkJ3Brdt/ZsR7Vk6GAznyr2jIEacFj+OXbB+5U18r7ECmjTDzTVzFH0aV+VSptxDHonRlqgCtgnEMyi4gOjPODbcyJuAxjQHmHCp5w8uCJxOG71A1/i9Nt1IYJ7t9t/JhiDoN7+hygtSqarm4wOGPaPsYlBWBRCu5CHT+KJpqhAA3ZxS9PZM938By5kpsWPnppta1MPnRkt12A+sdK/bU8MVFj85FKLcdAjwUQGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gourry.net; dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=LAJTVjZ7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f30; helo=mail-qv1-xf30.google.com; envelope-from=gourry@gourry.net; receiver=lists.ozlabs.org) smtp.mailfrom=gourry.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=LAJTVjZ7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gourry.net (client-ip=2607:f8b0:4864:20::f30; helo=mail-qv1-xf30.google.com; envelope-from=gourry@gourry.net; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fc8cz5SCKz2yLG
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2026 02:24:34 +1100 (AEDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-899e87b04d8so16593116d6.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 08:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1773933871; x=1774538671; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CAHdFeNRl4yy2sR/1LOHb2d72hyJTySGsjAok8mzB+g=;
        b=LAJTVjZ78cMV8FkIx6sWY6N1PeLpbGDZ2jA8BsiBa+53dxBA65izv5vr76yJ0IROJa
         Cj0aj8QAyEk1F4mlmTy9ud44Fw0ebm24/e1wq2srBb/1KQhZGhI2PnOJNB2bFnRSfXo+
         J8YmDCQZkMxxWKr3Pjeksc4TJv7hq8DMiV+H8EoWUyI8D8WCPjv78b+tgmHsJjXehsx3
         vEPTpuO/58AAETx8eAoXdEa3+gCqF39uXTSEMDQ6+u98wDTGa9DgM34Ac3fSqgvUcK4L
         kKI7NXYO7ipKZ8k8Lc7nuVpa+tWdP4+UtZlcBk00PgO4a/p+c1Y2AJIdQ5y+0pK5EmWR
         sv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773933871; x=1774538671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAHdFeNRl4yy2sR/1LOHb2d72hyJTySGsjAok8mzB+g=;
        b=GQPA/izEd3z/jRPT9yhSRUGdpH8mJHYBft/gGyUh5UnW6NmyZf6Vwz0sBvYcRcp8nr
         TRhGpQ8GaA8MVVa1RtwyCezBI3HAw6jlSqUthkQFSOzBUidi/KBxFqAEzS4exF+FEbxP
         Qw5OheqxI12SwcP9/iQa7hPPi0Bwa9zOcJuPG05i66Prt36pPbK6LS8KIkU1963wb3V/
         489O3GD4DL3ukuMCAJgB7xRlnqhhNE3GJR4qHYVOmJ+O/PO8gkqzhUWjtL48eXUIUIk6
         1g2niuLIjKCo9hMBuyAYRTkqvIEFE9UPnK5SnidOHTnvJwlsC5unFqQCarA7XQ/fIpEz
         M0Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWzfE581LnGQms54BYnjqNzYb0Dmn5MtDuILa2nEV63OPx5toyFC2DTEICAcFigoXDmvc5uVgJ2979ilic=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzqTMF1Xe3lpD6oJ3BmT4XMz1kSP/IZVbpOmzqEXW3UPth9wm1S
	XIlQ/g0NoQfQIMsH9c45eR4d52SbwSdDie0mBtwIIbhSy7bC0XTx4QpMx9oTaR65f5Q=
X-Gm-Gg: ATEYQzy5ZzeEo4dRfZr1/i/GXGsLyAMzL50pEpt1YdMrfXbTuevYY9Yk7sVpkIO842v
	zrQzwCTg1jwxlI7xaUfbeUoK3eaVi2j10mNpil+tIvm/Wh+ChrN22Q89FdfJDv4+srvMaa1yVtB
	zfEjQreNEiXixUG9Yk/tfh1yNeSbfBC2XK7W1dSsj4ObisBC15MvvagiMA3iF37vlVZL2ulx7o6
	6aftYF3rP+P786ByNoNahzJAPjtyNZq+jRMmxTkWo6zRJiUPs+Yy0hfR3raFi+YfbQOO0KWrKGs
	ZPxhquYDsOKHCDhOUhLEsne9OMiRDGlpi4aodHzTezbQZLuy5br7uPMgXNP2za4B1tsIe1qdcv/
	+pkdFmEJib99iDbWvvHQzK7/OxhqE6+sKYErdygxMm5yKJlm3KtxudtxyBO3uXbEuabuvtHsDRY
	MEnf0EwC9gemKL2TgeCAhqYm++MJpkRZDikiRYLLHYJ+Ps9cxR5wFfrRzb/ZW48lZfEnIHMZZEF
	lqNXEKU/A==
X-Received: by 2002:a05:6214:3314:b0:899:e702:b852 with SMTP id 6a1803df08f44-89c6b5fbac4mr107205736d6.57.1773933870639;
        Thu, 19 Mar 2026 08:24:30 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c6b8dfdf6sm49250646d6.5.2026.03.19.08.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 08:24:30 -0700 (PDT)
Date: Thu, 19 Mar 2026 11:24:27 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 1/2] mm: remove CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE
Message-ID: <abwVK8nLpSLVcT5G@gourry-fedora-PF4VCD3F>
References: <20260319-config_migration-v1-0-42270124966f@kernel.org>
 <20260319-config_migration-v1-1-42270124966f@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319-config_migration-v1-1-42270124966f@kernel.org>

On Thu, Mar 19, 2026 at 09:19:40AM +0100, David Hildenbrand (Arm) wrote:
> All architectures that select CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE also
> select CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG. So we can just remove
> CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE.
> 
> For CONFIG_MIGRATION, make it depend on CONFIG_MEMORY_HOTREMOVE instead,
> and make CONFIG_MEMORY_HOTREMOVE select CONFIG_MIGRATION (just like
> CONFIG_CMA and CONFIG_COMPACTION already do).
> 
> We'll clean up CONFIG_MIGRATION next.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

HOTREMOVE has long been a thorn in my side, I appreciate you cleaning
this up.

Reviewed-by: Gregory Price <gourry@gourry.net>

~Gregory

