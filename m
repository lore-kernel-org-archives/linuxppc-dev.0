Return-Path: <linuxppc-dev+bounces-18498-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE3D1099B35
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2026 19:34:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fct6x1fV7z2yY1;
	Sat, 21 Mar 2026 06:34:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::831"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774035273;
	cv=none; b=MRjL3Z3g5COU5GNFCBoQ7bCv2Oh+H40CwRitw2rZ4EkH2tDmv503Pzyrya4xT2iHjmT+VVCEiIgsLWvOyJSGgPdB9I7eB3sI8Zw7T2Q5R0hYNbODAB65cU7+BigiBXo/A4l1IFfMpMBbQIT0cgXbN90pwAceqekNG1GATQ09SSz60MHVNh3KoEA811hn/N9vNt0+kGctKtiwlB10FgFaezfdVNim4tf7zhiD2ZeWUfQyk8GlTSrHTX08sv1XJ/bVd2gCTyuOpIzz6Uu2qtxFK+zqxWrfGd0I4xfU607+oFO+aW4B32ehF/wHTu6xMDimffQCFYdZ2zdY4lvEdSOtqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774035273; c=relaxed/relaxed;
	bh=SPJ27qWkI5c96vhdp37WS6c9O6xFfPoS9NHL0cnjclQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmnu2NGEY1QCS6s7vH3g3m20yaWBedbk1uo1yqT4LYFT4WnUlUvGusDLM5PAS/JKfgwzH6gcL0Uh18BB6g7miHHHNjPc5Tk4lDyhh6uoxMtkzMfZ7f8CrGCa7wZILtNg+Oe72RIg/ST0SNQtyy0E0qDdO16LTOi6s0FL0VhZP/3jcwvufUqwUZPJdUS1QBXMQUGBfAAR1W4cvjGHRqYrslQ0jcCxJm3Nn3PIws//4w3GbfImCsKE9LAQ13H0qD1Z7TfgZlawMRet4oYHHSIo37zR9N3SD01rSTg8iqXkIs6YiKqWosq9T4hL7210WMviF49/f5ZJ5Rvy4Ou/iH2ZeA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gourry.net; dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=ObffDRQt; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::831; helo=mail-qt1-x831.google.com; envelope-from=gourry@gourry.net; receiver=lists.ozlabs.org) smtp.mailfrom=gourry.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=ObffDRQt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gourry.net (client-ip=2607:f8b0:4864:20::831; helo=mail-qt1-x831.google.com; envelope-from=gourry@gourry.net; receiver=lists.ozlabs.org)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fct6v2hNyz2yWK
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2026 06:34:30 +1100 (AEDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-506a747448dso8058971cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2026 12:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1774035267; x=1774640067; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SPJ27qWkI5c96vhdp37WS6c9O6xFfPoS9NHL0cnjclQ=;
        b=ObffDRQtb7I/ZqVYnRHe6jsp7dK6bItKCbEmNTw5WNtgHcKS1wJH/6mn9sYKf5BDAT
         pD9RoRrEliiCH/8jcpHwklPFVAQyK3+SiOtOX4KxlqhXvD4Oa59FWdjiwabvDFRBnfGt
         FWvWJS0S6pTbchPM7a94viVaZYFBmzkvD4Y2un2p+2WygzrBVgnxRCxU3an/7QPDcM5/
         ccyLsCpgLs0MBr6kW+LPt6JIEKhqW6QLvFRed3chQn+eTW8yE7Uh820kpGbT2snUt2to
         5mdKgIBVhwZVYn/FceTZbA4nPUc0Q1L8ZR2oAA3uG2RtxiACYJ8DRMxpei5tCViZqg8G
         1Hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774035267; x=1774640067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SPJ27qWkI5c96vhdp37WS6c9O6xFfPoS9NHL0cnjclQ=;
        b=ID95v3iC0BTsN9afpHRkOwaFKMOiYeT8dCjKBlnctGZRTQCZTzxhhHMXyvGo9VemNN
         HrynYKtMLIjKHod4uNB1wNhMda3TCSdHAH9ht4AO6QLqqd7f3vazer0DAJlD0F7BMaEJ
         /TCql/Db8DkWZ7w+9ngKyftxstIDBtIzluwaXpHCdFnPq+kQn4TsbYIWs2Toejh+xgfo
         +89DNEw/dZ9YHkoyBsWU/TkzqmLTD0b5rriw5lq68ZergdOYm6oU1iCC4hS9as64xRZ9
         OwvFTwK3fQsjukPEAlMql8J+reMe+8lsr+PCKrNrG0+ejSyvVddw+H3elSmEtocnsaWn
         lo7w==
X-Forwarded-Encrypted: i=1; AJvYcCW8kWWkj3j9NSzTbYihmryimpxtlfGFZojfFdKXvX/kVQmFNXLAVLx5A1fsnsEBCoRSw4p5LiZlSKyPnbs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyzjV+gxfZepknUidLBWh7gOTl/8rzOgihDAyh5mI8O5bbGu3U9
	iTTlghecsHfHa9n+btGk+odPDjS5xV7eL46JHniGiKinefsGvB5PZZ5qANSuVN93lgU=
X-Gm-Gg: ATEYQzzXrE9Op+LKuoSC37Cyeg7Os9M0+9IwGrF/nZsc+yDnFd7J50ZmQh0/HxRogML
	08O+KbT4ideQwZ5CSe5aVTQHP1bCf+WeBBqktUTVhZ1uBfDv8Pz2oP+e9JueUAGl0wmRlkJbdM4
	1iTBkzGKQtrvQ9kVIhwP+EON7c/ZhMcI8VPFJskwtgkNWvhn8IfR4eepzyxmybtlvVajnXbwhfR
	p/HaV21SjyA4p72gRtwtsEn7DtCzCzMX7nqGMEf3ZSbr9Luh4RpYYZmeUk/b0VL/SO3MioVs7Nq
	lW08XMQyRTDMFsgGJPiUqxgYJ7cB65YIrjGHFjPXhl9+J0vySDD0j1Z1i+LMfAwrE4TegisoxHW
	mJ82p2cfBtKj40mew+uHEBiQkT30C5Ufxl73hlbHmzbLBTx5DASgl7Z+T+KfUEaw+a+Vi/OT8tZ
	GiI8BynDzDTsmI5RcQq0LIZopElnglAg+jESP516AQx6TxBAsmL3wTEK1Aa0EADCHMwjH9rXKKv
	EH7g7SKO2L3hqUDgZav
X-Received: by 2002:a05:622a:4512:b0:50b:36e4:a614 with SMTP id d75a77b69052e-50b373ea96dmr54489661cf.6.1774035267172;
        Fri, 20 Mar 2026 12:34:27 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b36d23237sm33063701cf.13.2026.03.20.12.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 12:34:26 -0700 (PDT)
Date: Fri, 20 Mar 2026 15:34:24 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
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
Message-ID: <ab2hQHsCs2MwZqj2@gourry-fedora-PF4VCD3F>
References: <20260319-config_migration-v1-0-42270124966f@kernel.org>
 <20260319-config_migration-v1-1-42270124966f@kernel.org>
 <abwVK8nLpSLVcT5G@gourry-fedora-PF4VCD3F>
 <8ebdbdba-d0b5-4887-98e5-bc45f4565d51@lucifer.local>
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
In-Reply-To: <8ebdbdba-d0b5-4887-98e5-bc45f4565d51@lucifer.local>

On Thu, Mar 19, 2026 at 04:34:04PM +0000, Lorenzo Stoakes (Oracle) wrote:
> On Thu, Mar 19, 2026 at 11:24:27AM -0400, Gregory Price wrote:
> > On Thu, Mar 19, 2026 at 09:19:40AM +0100, David Hildenbrand (Arm) wrote:
> > > All architectures that select CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE also
> > > select CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG. So we can just remove
> > > CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE.
> > >
> > > For CONFIG_MIGRATION, make it depend on CONFIG_MEMORY_HOTREMOVE instead,
> > > and make CONFIG_MEMORY_HOTREMOVE select CONFIG_MIGRATION (just like
> > > CONFIG_CMA and CONFIG_COMPACTION already do).
> > >
> > > We'll clean up CONFIG_MIGRATION next.
> > >
> > > Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> >
> > HOTREMOVE has long been a thorn in my side, I appreciate you cleaning
> > this up.
> 
> That is quite the HOTTAKE young Gregory!
> 
> (It seems my pun crimes are continuing)
> 

:P - it's just more config cruft that always catches me cross-platform
when i poke around in dax and hotplug.  It'll be nice to get less
automated reports from CI lol

~Gregory

