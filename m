Return-Path: <linuxppc-dev+bounces-22550-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54FC3CD8CA8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 10:30:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcG4q4txmz2ykX;
	Fri, 12 Jun 2026 20:30:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781260251;
	cv=none; b=KK7h5FWutuXj9UIudSZf2drixdEXRK/cAyjzRc81fk0KKPmpdHlw8tpJMaCsyoSBbmj9O2ICrf7tNc/BykmM6H7Xyry6PUmdNC8RLpM46M/xgbC1n2xao7LU9UYJM3XKHtuHqA5ScJepW0JmS6fQpW7howcq/8IgQ3Ujmgi6p9AWv/BTAi/5WouevVNCTXmdoxmD/zh5Q3sXu+jKjLA9d4Lj+/2rFPwRwh97p+qVgdt+dyvA1ojAYYnuvoJcEeGIFzt5mRZbe9yUuvDL4nQBrV2VLCLx8C71WmYDgIRCM2l1Q2zDeWM68ZauI3OBuWKmoiYVHy8cCcxX4o1jLRzF0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781260251; c=relaxed/relaxed;
	bh=oARqs+T9JbWNb6W4wENAtGBSBaXfYyAinTQCHjHTX1s=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=cB2XxELGDpcIrZN1a0K4Y6l18sKCqR/D6v2YGNzwJYrZxsYg6mXz9SUt+QwmNQ23FWlFuLs+YPEPZ0dUgOKhmvbqeK9NHqGNYVHHa++7XIp8tjPU+kKTSAWPLB8GMQ+vs1Wxc505WTuxNMx1UCaXgScE12ByN/4V9cmbkTbHhufL9pMl3XhlUgpDReqAyXsQrwnD/VTD/HIxAERkLvXxf7MsCFsXr3XrN3Pz+0hVaMD75xxKavTdLr9LN33eGkfwxK+IX81N8IBJOb65l0gVe0bM1pyHpqc7xWRLr63knaz9pWGivZTlzMp7HA4Fm0bbiomHV4v52HD2E2Njd06/ow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=de5zPOns; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=de5zPOns;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcG4n2CSLz2yjp
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 20:30:48 +1000 (AEST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2c0aa420401so6319015ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 03:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781260246; x=1781865046; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oARqs+T9JbWNb6W4wENAtGBSBaXfYyAinTQCHjHTX1s=;
        b=de5zPOnsdvYCrHhAKLCJIDypRxtYAKBIgD/NWUvn0EPcQb9VCjqTfu/Ko4MHPjr0g1
         18jbPw6M+oUemWqKqkeDkbf0ghBa+FAFylh51AYUHlvjC3OsLTIPV5kMNvoLhx/qHjaY
         rqMP11TSJZdjaNt2djCAawFJ6PEJ5woIqIBq5Szf5CjQdZGzYEyqC8HhXT50F7/47Em/
         +UP5t7tlfktRPUjmBr5E+NJujp/TdqnC2YhwqVP73hjWnXHxSaT1RUvCprz0e4oW5353
         5MGNen37p+kwqoyj/lDJo7P0dPphZ+SKAGAVdluOjY8PRwoWKQn2U8bwxKY4XY46HP+b
         qlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781260246; x=1781865046;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oARqs+T9JbWNb6W4wENAtGBSBaXfYyAinTQCHjHTX1s=;
        b=L4rZU9j0ydk9bI21yabn+gdhbc6EEmmchujDpYQPfCEkcw7VMdCIwkmM6XL3Zc78jK
         E0XjNfKiSFIOum/vUKo2f93ZC3MwTlG4mfyQInwlDgAMERksSijPZKUaFOA+z0uI78WB
         F9/47ad8Rfacd99jEQuLGyP/TV3H1lBjGQittpGIPy44duur9W03VA32w8sOQ1Iy91zX
         Gb9wDWTA/amYtZqQ5U9VZLZ5WIs4ZgAr/CroONFhnSEhVNjMW4gkUwAqWw1BAXBBP6Ue
         zFaBKWjQmhp46MVzvUFlDkieR9BXheCGLQ5FdWI8I649petrHbLF3NnVaNOkkrjxsh56
         OMtQ==
X-Forwarded-Encrypted: i=1; AFNElJ/K/JnctHMBvaRg94RlFUjKAhfCAljGpgnmGfw+Nj1JK8KOwaoaaIYsUQX60gdnwnM1deYRO2eX/K/Yvdc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyQkzUmrwtwSmqpD7hwaW+JRPAsfvR1CyTLZz+zgxQbTvvKA4/f
	gw2zxGsods/H0qd0k7k3kGvBEGiX0kCIsvxyB1refoqDltgeqzbCSyFA
X-Gm-Gg: Acq92OF9RbejhcyZqywR2yxNo+xtUwpQ2fTqb3HtiCJjivKC2xk5EmOXSoor5nAIFBx
	7hkUB1g6fMfInOsivjeoufyCLEQDyPfkO4wljix49j4FDWivncYN8rUStpK4hOVBFPNjZCmvx6P
	rBdvIX/CkJ8zBiBNm/FH31llutos7j9LcglhOeJU4PMfu6SqXwIahwWB2WPM3D6i03HY7gKXYya
	9D40RuUW7+rdoLPKvnT3MnZN1BpoGLmoa+QaVPZpitKvxmCcyjkc45q6A58nVlfurcaCmFqzrpm
	6468hOTvrWfgBcup2zqymwCzhwHZ+yDb0kBKINVBrMXjgpVqs007Hpp+VG9Lb2RILzsp+JXDc51
	lFR0PdhlUmd8uDy1kBLHOWfc8mr85AzLFo6kT+3TCzy2Kh6D5ypgpImT6JwGJL6Aygu4AWg45e9
	7gJxoNGFkWKFhNYE1TITiMiJAItA==
X-Received: by 2002:a17:903:3887:b0:2b2:4d36:7ba with SMTP id d9443c01a7336-2c40e0350d2mr27814135ad.0.1781260245979;
        Fri, 12 Jun 2026 03:30:45 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42fbb50e5sm17778985ad.35.2026.06.12.03.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 03:30:44 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: kernel test robot <lkp@intel.com>, linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Memory Management List <linux-mm@kvack.org>, Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, David Hildenbrand <david@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Sayali Patil <sayalip@linux.ibm.com>
Subject: Re: [PATCH v2 3/3] powerpc: Kconfig: Enable THP_SWAP on Book3S64
In-Reply-To: <202606121305.h0cxjhP2-lkp@intel.com>
Date: Fri, 12 Jun 2026 12:01:26 +0530
Message-ID: <jys4e0ch.ritesh.list@gmail.com>
References: <3abf510d24c8ef17bd5e324cccc5e03e548afade.1781170904.git.ritesh.list@gmail.com> <202606121305.h0cxjhP2-lkp@intel.com>
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

kernel test robot <lkp@intel.com> writes:

> Hi Ritesh,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on akpm-mm/mm-everything]
> [also build test WARNING on linux-review/Ritesh-Harjani-IBM/include-linux-swap-h-Remove-unused-leftovers/20260611-111124 next-20260611]
> [cannot apply to powerpc/next powerpc/fixes linus/master v7.1-rc7]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Ritesh-Harjani-IBM/mm-swap-make-SWAPFILE_CLUSTER-runtime/20260611-181121
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/3abf510d24c8ef17bd5e324cccc5e03e548afade.1781170904.git.ritesh.list%40gmail.com
> patch subject: [PATCH v2 3/3] powerpc: Kconfig: Enable THP_SWAP on Book3S64
> config: arm64-randconfig-r133-20260611 (https://download.01.org/0day-ci/archive/20260612/202606121305.h0cxjhP2-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 8.5.0
> sparse: v0.6.5-rc1
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260612/202606121305.h0cxjhP2-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202606121305.h0cxjhP2-lkp@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
>>> mm/swapfile.c:133:6: sparse: sparse: symbol 'swap_table_use_page' was not declared. Should it be static?
>
> vim +/swap_table_use_page +133 mm/swapfile.c
>
>    131	
>    132	unsigned int swap_slots_in_cluster __read_mostly;
>  > 133	bool swap_table_use_page __read_mostly;
>    134	

I had noticed this after sending the v2. But by then it was late.
Good that the sparse checker caught it.

So, I will declare this variable as static - that should fix the
sparse warning. I will spin a v3 in sometime with this fixed.

-ritesh

