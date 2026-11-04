Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAA8606A326
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MrptcyWU
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKT6x5czLz2xb9;
	Thu, 05 Nov 2026 01:56:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793804217;
	cv=none; b=j55Vwb2BWWCjp/axdl9MvVB2VWXdVm6JX7tl3Rf86ic2zMiVjS4pf4m/bpJSm9qiY5G6gxh9Wjy77oiyUeet2/aJiK00qKRFiMx6GsEBBCWy1FFxmlWtRMVolraXI6xFeEA6kkakhbShEvkt90zcXfL+0WjxpLqmGAmxsIh299uo0sajcsvxe/LWPrNNHtvrrA4VfkGoLViUiTjEFAqYg3CtXHzUCWKU6Vvny6XZZyGeL4H3bV1c9FrAV9UEbSTvkqAuoEZK2NAZi4D+URe4PcZQ2wy3WA0+izjbBh+g04mJ0dxL5A3gq6BzMMJX19BqOu+trErvO20JV/GxhZkrpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793804217; c=relaxed/relaxed;
	bh=T7rOMPplLomFK+EC05LzdPzGrXETZLxt3EvKKKVvcv0=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ex9HVoKZJjKb2VMtrAK4JI5wTSSVoOMrmgj9gBG9qTdZh1a8SJ2vy28Y0OEIf6gDJFVe6gBNIoHI7i8+BMiJPGIE/sWeidHIzBFS13vl3ZYimpRsiz5C0waYKWhc7ywX18K4mnhufNTu2XXZ41UflVjii5w97DVr94xia0h61SeURZf7nAKAmqS8FHbKPb8mrsSGNtJcFGkKmrssa93khDToWQ5oA88k5xRuaziVAOn/RCOgjLC9lGeVWyI/9srfdSl1tF7rMStz5NPougZaBsCWJHcAZLQxIEV7nwjy3+FNtCyQs9zMaQFOI0GM0HPl9zXLAZIowVYIs81QGoMlWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MrptcyWU; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MrptcyWU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKT6w6b5tz2xSF
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 01:56:56 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 46D0860546;
	Wed,  4 Nov 2026 14:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29CC11F000C1;
	Wed,  4 Nov 2026 14:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793804214;
	bh=T7rOMPplLomFK+EC05LzdPzGrXETZLxt3EvKKKVvcv0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=MrptcyWUAcszN49zHQTkn3Vlr/HscV8Bl4lEC7R76+MYv7gQJXdxpylZ79fGVxJJG
	 9g2RjZrokNB6qDNHG67TRkFttmgL1t2KdGdPIq0zjGZQ2tpCDDyqj1gOxcwehdfXY+
	 WNHZuIs47sffQbdvvDUJo0zkxJB0m5g+Zo5ngvZRNdtigj8ZxmrYguaza/nDk0M3CY
	 G5c7zitroMfYhwxfXt68GtCd4yiMACIrJ5qsb2puVDshMKSWVxOz6W6kzvD8gW2gAO
	 +MF/8nKz3uZpWHQ8FC5h0nznRoxul5JcWwA09pW2w+j3axirgz6HMdNa1MuyG7qGfV
	 qv8X6UKrIz32Q==
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 00/15] kexec: Fix CMA and elf header leaks and
 rework
From: Mike Rapoport <rppt@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
 chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, 
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
 ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org, 
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, 
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
 akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, 
 pasha.tatashin@soleen.com, pratyush@kernel.org, thuth@redhat.com, 
 leitao@debian.org, yeoreum.yun@arm.com, robh@kernel.org, 
 sourabhjain@linux.ibm.com, kees@kernel.org, coiby.xu@gmail.com, 
 Yeking@Red54.com, tangyouling@kylinos.cn, maqianga@uniontech.com, 
 zhangtianyang@loongson.cn, guodongtai@kylinos.cn, blum@kernel.org, 
 adityag@linux.ibm.com, hui.wang@canonical.com, sohammetha01@gmail.com, 
 guoren@kernel.org, gaohan@iscas.ac.cn, kai.huang@intel.com, kas@kernel.org, 
 vishal.l.verma@intel.com, piliu@redhat.com, jbouron@amazon.com, 
 mclapinski@google.com, me@linux.beauty, graf@amazon.com, bgwin@google.com, 
 x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
 kexec@lists.infradead.org
In-Reply-To: <20261026075201.699550-1-ruanjinjie@huawei.com>
References: <20261026075201.699550-1-ruanjinjie@huawei.com>
Date: Wed, 04 Nov 2026 16:56:37 +0200
Message-Id: <179380419709.28814.2122135856184991710.b4-review@b4>
X-Mailer: b4 0.16.1-dev
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jinjie,

> ARM64, LoongArch and RISC-V load the elf core header, initrd, DTB
> and cmdline parameters with almost identical code. This series fixes
> the bugs in that path. And as Mike suggested, rework the common part
> into a helper.
> 
> Patch 1 stops using the Image text_offset for arm64, which breaks CMA
> segments in both the load and release paths, and rejects images with
> a non-zero value.
> 
> Patches 2-7 fix the CMA page and elf core header leaks in the retry
> loops in arm64 and LoongArch, also fix a modified_cmdline leak
> in LoongArch.

These mix fixes that can be easily merged via arch trees and something
that depends on a change to the generic kexec code.

Besides, elf_headers leak and arm64's text_offset fixes should be
applied to most if not all stable kernels, while CMA fixes are only for
the relatively new kernels.

I'd suggest splitting

	arm64: kexec_file: Stop using the Image text_offset
	arm64: kexec_file: Fix elf_headers memory leak in retry loop

and sending as pure arm64 material, and


	LoongArch: kexec_file: Fix elf_headers memory leak in retry loop
	LoongArch: kexec_file: Fix a modified_cmdline leak

as pure LoongArch material.

And then working on CMA fixes after these land.

If there are real dependencies or potential conflicts, b4 prep can help
you with managing them.

> Patches 8-10 pass the kbuf fields to crash_prepare_headers() to
> simplfy code.
> 
> Patch 11 frees the elf core header from the generic post-load cleanup.
> 
> Patches 12-15 add kexec_load_other_segments() and convert the three
> architectures, and arch_kexec_setup_other_segments() builds
> the architecture specific boot parameters (a DTB or a command line).

I think the refactoring should go before the identical fixes in arch/
code.

-- 
Sincerely yours,
Mike.


