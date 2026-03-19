Return-Path: <linuxppc-dev+bounces-18447-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5717109022E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2026 14:14:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fc74P35pTz2ynW;
	Fri, 20 Mar 2026 01:14:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::c2d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773929685;
	cv=none; b=f+s5zS8H11CV/EJAl7wHFlMJUPcnLvqo907ipjrTxItFyUScUPkM+2G75tIH9LGkK3/BpiUzHe7r6f3Kh1i/5LcZSzhjMve5fRNHDt4JyWrY/h4vrUv3cDibz6ZDUoZsJu3E9+uRuzO/F5LSkaSPyBmpw4DwkeXpxD7EpsUpeyyxEA2QIWwMqMOTvgo/aLtchufkM+oAaM4Mser77aXfJ1OsORCwtDtPi7SvIrrnLlM/QomXxUf0Y6BFuItOoocXsZzO5hCWRmPIpYsMCkbj6HLGS3AgJKQkfbvAHVmAdaUxm5B+q6j3acRN61qZgvqQLHFt2MhuKtHNmQIMsG5rXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773929685; c=relaxed/relaxed;
	bh=ntFH0htT9ffFrh9knb0jn+m+GRQSXC/6K3X5v8dqre4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BL+3N3HnwA20TdYiyHh22xAcAOYB7rJcswHmmq3iIHZ+4pf2WeQmoFPZkRve7gdhtriTZONIuyAiITrkEXTvH7WQizHjmJDJCd/APHXbRUlhTdAXmTzL3LsjTC8rFM2nezaaOzjyDNznhP+TJMeb0uxe1W6817CRDsQoT5N6Qzviezj6kKWcD5UcKnuh0lmpuqG6BKzcikyEsBNaD+B8oTPr+nWCj3CwRRjb7sHErSFiaUvk4JsW3ShqZsAp8PkIr0XGOv3gPW9FsLF7S8nwimPU/DXdpqusUxfzV74fuM2AtlDIMybyy82DCJ6NDSksZV1d6YfmJ9t4sY24+qtveQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=HAyxvvNc; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::c2d; helo=mail-oo1-xc2d.google.com; envelope-from=joshua.hahnjy@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=HAyxvvNc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::c2d; helo=mail-oo1-xc2d.google.com; envelope-from=joshua.hahnjy@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fc74N3b3Xz2ygT
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2026 01:14:44 +1100 (AEDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-67bade86c09so469898eaf.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 07:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773929682; x=1774534482; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntFH0htT9ffFrh9knb0jn+m+GRQSXC/6K3X5v8dqre4=;
        b=HAyxvvNceWONHcSTJpKAx3OqROZJtq8n+2DF2c7Ez25Jhl4YFnMd+MRfNVXPV6N99+
         yk2E2L74CQlJNGR8MGxrQ4eZLA3KaUWHR43k63Rq1xn61GESS5oykKzOLQJzxCrXqEqu
         ooj8KLtFOih7nZUdZccf6FGMBIMx0UTmHHF1diXSWoI5EWgDJQI8HUOTaSp8LsVA3YIq
         VhzSHm+ZeTz2+igAeRad7Ca19PV0YnhvfMlcLyPdLA6GEuXXBiLMd6JoYyEmXwY5cEAj
         TgaFMo8C8AeLAomV3fLu1F7sj3ZOe9rU4zIUHFZQn3aijRBllaOulc0FZasBrVyW70vG
         1kcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773929682; x=1774534482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ntFH0htT9ffFrh9knb0jn+m+GRQSXC/6K3X5v8dqre4=;
        b=HhTL9Z90HppsX0F21CHwn+yO2Jz2HCltEJxXUxmLYYf6HgLLDcGzaE5OE9NPpgILbm
         F+vCqy/rjf+d9dORpVRLZO9cANQOqUUSC5DLiF0mN7IWUSTOycemd6ROss20dqhY7a/W
         TgwsWtyt6sHnF1xkQRrFnyi+2/1EHBpvygdrGTPC9gIIbQE8jq533O9kuOaN/230uuxR
         8GNzasCf/+OcQBInJ0Y8miB/lLf3VkmJSX2p1s5vCgk7fnnAzLx8r/Io88FwdV9sy9el
         xgjoGxv27s4SQ6Aa+B6EseT2kuFsh65tUyyflScl/CXQbDKqpDp9zzYg60fOH65jf7NQ
         aN0w==
X-Forwarded-Encrypted: i=1; AJvYcCUYLsDYwlOU3sPGdAgP0soKIeI16j9Cl5PhO4+S6AV3VIbhlMlx1VE/o8ZMkbcoOsVh++cF0sJUAEfG480=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwCDsyZ8FemiRQIMC0nK7Ynv3TmpkcKl5/XAYoLAzmRIF+51Yr3
	YRvw0FEodJ2anv/jyyg0+jSD6oUVEGwZ1t3TGMGVxfamvlerfF+YZnOz
X-Gm-Gg: ATEYQzy6poH76CmKgSwC3f5pslgtrQ5i4DB/Mf5NJJIRToVk7GcbvgeADmYTazGNuM6
	UbmqTyo4DxlAg72GTttNH/Jv7KMNeiVmyr4NyuGuqxdZs/6Pv2xohPvyA0y35rY61sXdiFNJcBi
	cwv3es7u+/uUIXiRmOvPBrBHOzHEpKxkNRAVtt2f6T/0PVfvwZGoI4877T7+KqNDvDsgpjRTFdT
	92duWnZFaBguegIvUiPKN+uSLR0PcIBHcXGCuF4u1L2ek2rwUcEcT3Jhme0fhO32GFscfH9902e
	S/heFrZbSKj7/N70kuF4AdWNZLXwGMB2j2dwF2ncTlvBqSkHSy7W8rsJsXJMsR+Iw7RKzriRO0A
	HOIbQR4RIp3C6kGmjYaqUY4yHRNPx/uxdt/qdZ2nNxHCPPREIeP1JI8GyKbW4snlZBPzCM1jCaH
	5xppDeAqJdOdNtluZoXtfr
X-Received: by 2002:a05:6820:1518:b0:67c:c4e:4ca with SMTP id 006d021491bc7-67c0dab23c8mr4161966eaf.29.1773929681867;
        Thu, 19 Mar 2026 07:14:41 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:8::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41bd689e3cdsm5313808fac.6.2026.03.19.07.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 07:14:41 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 1/2] mm: remove CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE
Date: Thu, 19 Mar 2026 07:14:36 -0700
Message-ID: <20260319141439.218078-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260319-config_migration-v1-1-42270124966f@kernel.org>
References: 
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
Content-Transfer-Encoding: 8bit

On Thu, 19 Mar 2026 09:19:40 +0100 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

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

Hello David,

Looks good to me : -) Thank you for the patch, I hope you have a great day!

Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

