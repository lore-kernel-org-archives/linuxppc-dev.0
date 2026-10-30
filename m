Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6EA606A31F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 13:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NFoafTsO
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGMqv13hmz30Vv;
	Sat, 31 Oct 2026 00:48:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793368091;
	cv=none; b=CZvQM6OhasGLRLPvKMIU3mUUrUgMygBXQFYfV//qNRBUzLIpa11xj/Fgrrq3GYMFmwMtAXdd89wvMihEwO1NMDfd6N3F24WTQZtCKr2wDMSNCS+7pgPbrta3MMRbmpNco7T0b/+2umeoFY27GfSzyOwoxBpR8pn8/ZBsq7K9NRnvwH3/bPobuymk0wdTU3NDNF9mcU9JDO8608Xi4MzFhro5jCvLk2QlK1tpq2pNqgwE7emiddjsi2CMeAIKOX6LvTUTQ3kxgpdAp97Oxn6Za98PlvmclclXwOJg9LtL/PBw5Bf8xY2U22bwKo49LSM83v5uCIrWskwksV9cmCRpWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793368091; c=relaxed/relaxed;
	bh=rmX4JEwV7qAmy43PkgvX967p02rESGhBBxr09gc4cBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFbV8GTfhD2pDEt/tDQH6HOovEWoSk/07grjb+1HMq+MqJm4Zd9+MAXxkHOXQNltxg6xYMLFYbr+RETU65uMzihvtDVrIblxBmQO85kLbw9pHi7MtNiXz7634ZKGOMmlOB2m6t13qGjLgpmtnJVZWWwO34PAUMbrv4b0aiy7rLmgZjOCYbb0935iw9aMI+GOvXIwChxyHH3bHXw1inC6nxVdasXSjhXBgK2kALyidqDWumeqzDo6SrUk5VpfqHYF61CjoJjo4SZfIn5XRBC00OBsukfVfoR3LMH3wXccQDCVr/eUT+Gd7rLiy0JRRA5n3W+WpkcQQTv7kg1N/eWLAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NFoafTsO; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=vishal.moola@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NFoafTsO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=vishal.moola@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGMqt0KMkz30VV
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 00:48:08 +1100 (AEDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-49d05d51553so4210095e9.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 06:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793368085; x=1793972885; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rmX4JEwV7qAmy43PkgvX967p02rESGhBBxr09gc4cBg=;
        b=NFoafTsO1VndE6qw03w3+BvO0Fc07NictWJZ+vNftcVlXInoZaVzS0FXmANaTd83xp
         m81fjpfuzBqCg8YnXcO3oUehwgw8TBrNlKZCGetXXGtYy1C0NI3ftzQ5zBX2vJu0xlE0
         ekAOILnjtFy3r9E9yErVqYtndw2PjivE8ivIPgoGj80/cyaw3prKBDVYANQ97VdDm4a2
         GkhY7zr87nJsBQkvOhAalzuQqGVTUaC646pHMKWVD3SjZqlIOtyAceZ735newO0sZZCq
         4c+VzlsFJIbEBkbupURDXn8i0r/NQFhGdor343OsMTz1x+DfDFkxc6S1Eycn4I2S3Vu1
         bHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793368085; x=1793972885;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rmX4JEwV7qAmy43PkgvX967p02rESGhBBxr09gc4cBg=;
        b=uP/0iHjpIe2ZmFbPDib+rc8ejbZI2pMRGzugCueLaDI+7qpvXtC7pC+EEQwTeqhBfx
         liXRLuBN6YgLsdc09vX9YvLli4aydspazZfm8VbAtHrRSfxwMw9gwJaQviRMuj4jVqO4
         ELS/RPOJm+dcx3AN29CP4suNppejxYvoS7VmOPccLVnjPa65z/5tkjIGaie29s5LCA8M
         h9HW1Rzm/n7uQElQiwTXra4HhfyJa73Ssy2ai0jOxZ203uJ/CTBSArJreSxC62LXR5Kd
         yIfhbbCIAQcrk7HkoM4bps6vG1K4wv3tV+V8K+i47eNu1yrC1a8AWN/fQnoyQLgKuAeb
         yBAw==
X-Forwarded-Encrypted: i=1; AKwUvBxVsuCiPcWSW0MTy82Fy2Pl/3dnM25nEUI/OjOD4aRg9NXcC3cBekhB9IgDtJJFfTVe2cDd3zj0Bbq6ve4=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLPOXsZiVmGs8Y8u9leGp2oHhReFKHEu2yOz7rKIOoFk3JdF2Nk
	pPnAo/RTnekXUK6ryRyYil+WxVAQs9nUUKFCfwXbexROB+pNJkecLtcU
X-Gm-Gg: AYBFou21T6d3G0VZR14lxUx0QNUeGB6xbMM6h4j4lt1ULgulk5QWXxTb4mh0u5F6p6J
	49sMnT6Cq8nsH5QxNnIykvFXh5uiooY/pHE6L8TmySpETmousOOYPpQqeITk63Z6nazqsEtSZzs
	oTFpCXqvr4Px2YrZ8oFWc69WFogpayBAI2S0xFqR42CWhVz/vRrSfABak00dU3NAlWcRffMdD/N
	YV4saXJAvUBKTzbrB3XiFh4Z8GS3ve8LNziviInnfC0hLXgCbUBazduR88tuWidr0hW90NH7MLL
	97MQNIpPLZr8HXH/PtTF2F1CVC0Nj+tMUm1ItSKSyvdyZBpSslNb450s2g8ke1paDxANMkGd7Rx
	xnf9nAT9BBDB5rjvf5I4qSoXLIIKLBp4731O21LMJ10siFBvKqaL+4fgCbK5vTMvR61Ls8UmFS5
	MKGwzBdQ8ACkdGItH+6fKp74vzbPNuSjTuwHl5H0HtX6Gmi5B6jrLl6loHrVUUu3aY8PgyPPbwm
	7G5Ua0CH0Q8hV9HIwRl4G6Pc1MSVocxIbSNjjvg7r1rqDSWm35+9KiQoZQwOePThU3SnZvWdVIn
	AAUdS11Dt1d6qsx1zF9nXFf6cCTe3Ae71oxB11TYQg9xoD4HsSTgJMAkqT8d7k0tQ/SBHtvkfYp
	b/0uWqy4GF1WIAQ==
X-Received: by 2002:a05:600c:34d1:b0:4a2:526b:d3fd with SMTP id 5b1f17b1804b1-4ac1793fb5emr50752935e9.15.1793368085145;
        Fri, 30 Oct 2026 06:48:05 -0700 (PDT)
Received: from C422HJQPQG-Fractile ([130.43.154.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ab69b54742sm172048905e9.15.2026.10.30.06.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 06:48:04 -0700 (PDT)
Date: Fri, 30 Oct 2026 13:48:02 +0000
From: "Vishal Moola (Fractile)" <vishal.moola@gmail.com>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Alistair Popple <apopple@nvidia.com>, Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH 0/2] mm: Remove pagetable_dtor_free()
Message-ID: <auSgElFWW4n3sJLb@C422HJQPQG-Fractile>
References: <20261030083800.599152-1-songmuchun@bytedance.com>
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
In-Reply-To: <20261030083800.599152-1-songmuchun@bytedance.com>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 04:37:58PM +0800, Muchun Song wrote:
> This is a follow-up cleanup to the page-table teardown fixes [1].
> 
> pagetable_free() now invokes pagetable_dtor() for constructed page tables.
> This makes pagetable_dtor_free() redundant and leaves explicit destructor
> calls immediately before pagetable_free() duplicating lifecycle handling.
> 
> Remove pagetable_dtor_free() and convert its callers to pagetable_free(),
> then remove the remaining redundant pagetable_dtor() calls. This keeps the
> destructor decision in the common free path. No functional change is
> intended.
> 
> [1] https://lore.kernel.org/r/20261023063428.3658761-1-songmuchun@bytedance.com
> 
> Muchun Song (2):
>   mm: remove pagetable_dtor_free()
>   mm: remove redundant pagetable_dtor() calls

For the series:

Acked-by: Vishal Moola (Fractile) <vishal.moola@gmail.com>

