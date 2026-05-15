Return-Path: <linuxppc-dev+bounces-20992-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6A9CD4851
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2026 20:44:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gHK1c3dFxz2xTl;
	Sat, 16 May 2026 06:44:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::136"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778877860;
	cv=none; b=VNHUkwpQZD+QGoDQ4EaiW4VmJ59IortvngfKNfMuie62vCK9ktUajUQOrj9F+zqWQXmg2NujMKI3alKnKu/QuxbtFBhO2I5Oi17TGZVjQ9BPto4u1gImD/fH1c+pkisiMWJcpbpeStYjSOH2iOORJ/4lYxVnGPEr8GrFXaXazHGrj6N/D3Wt7fuY5NB4WDibnQC90CTWCHzEALde4atvVJlbnOzQI4SMT5KGYlYWdxLcaqycULpJ6qZ8PU47JVAJphN2Yu3C7qwXxRFAoaA8Yo+1sTmQYmoJy0BxlCqukRoc4KYCJcYwMGT9ETcg7sQaPE+lYy8SxbC1jZHZDVjQDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778877860; c=relaxed/relaxed;
	bh=yOPbK2OFF6IcrfoJraZaWua7RTa6T7n9+bq8VLS6qCY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=IaGd6yT2RCpBZ5GVmj2QSHxLYfaueI0jWi4Ix2Bl5eAe8nCsBFyIaz+J/nvZRZeZA7De8Tg2iI74fEjdIqv/BB+IKWUBFCyURFPisBilUmyqhr4DW1SjOzNaZntIIsuyWNt9AYgO5wVyl8tNzmmNLs4wUF0z4evcrrrEn7TlDYo4ti2QOr86HSZI9wUR+ezpdHxKtBas/SjDkKVmddcTrg8ngQaKdHwc7Tu+3eBpJ/OPqdpQ0l8Pj/F96zyxisvj4aKbo0rD+OlWuV9RLraFimLhj5aKu7f6aHOgDA6Mo+CHJu9O7R8c2z48WzJw/HsqIobAEYSLsYq0EgpfYuwh0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zytor.com; dkim=pass (2048-bit key; unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026042601 header.b=HvwBqnLT; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::136; helo=mail.zytor.com; envelope-from=hpa@zytor.com; receiver=lists.ozlabs.org) smtp.mailfrom=zytor.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026042601 header.b=HvwBqnLT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=zytor.com (client-ip=2607:7c80:54:3::136; helo=mail.zytor.com; envelope-from=hpa@zytor.com; receiver=lists.ozlabs.org)
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3::136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gHK1Z1VBMz2xFl
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 May 2026 06:44:16 +1000 (AEST)
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 64FJxdt93762934
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 15 May 2026 12:59:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 64FJxdt93762934
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026042601; t=1778875185;
	bh=yOPbK2OFF6IcrfoJraZaWua7RTa6T7n9+bq8VLS6qCY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=HvwBqnLT38+P8wOr09I0oo/MRbA0gltt1BvxpDB/CXoHAI/p9iMtZP4Acni9CBE8i
	 UuQANyZJcLZO9XcaPLGm0i1Xg+soCjS4z5NjIoUETnDDa930DiHBVRAOT/MRlLb9jY
	 QYrQ9QMS7lPYMHGvM8plKfNxe30Gl9az6f+vOCv0hNim3O4/Bdo2qSTnUxGO9V7Nx4
	 F46aEk0Mx5DZE0TAlF3l22P0Yw61+alulS+V4O2YtDdYTlzt2T6qIuwD2KE0nXfR9T
	 jNDuDCJ8yXY/CId0JmSkw1Ar6+GJQTs5O0RqwrWv5l7cMbOBEgdh93GvzIYQG1gbNB
	 I9HJmsdG2PKng==
Date: Fri, 15 May 2026 12:59:34 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Christoph Hellwig <hch@lst.de>, kreijack@inwind.it
CC: David Sterba <dsterba@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Song Liu <song@kernel.org>,
        Yu Kuai <yukuai@alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com>,
        Li Nan <linan122@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-raid@vger.kernel.org
Subject: Re: [PATCH 01/19] btrfs: require at least 4 devices for RAID 6
User-Agent: K-9 Mail for Android
In-Reply-To: <20260515043705.GA3855@lst.de>
References: <20260512052230.2947683-1-hch@lst.de> <20260512052230.2947683-2-hch@lst.de> <20260512114231.GG2558453@suse.cz> <20260513054742.GA1018@lst.de> <0a8d1ff4-f5a2-49e9-aa45-d25dbe4ded40@libero.it> <20260515043705.GA3855@lst.de>
Message-ID: <34C16854-1065-4542-8836-DDED58EC1844@zytor.com>
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
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On May 14, 2026 9:37:05 PM PDT, Christoph Hellwig <hch@lst=2Ede> wrote:
>On Thu, May 14, 2026 at 09:51:59PM +0200, Goffredo Baroncelli wrote:
>> I think that the David concern is : "what happens for an already
>> existing btrfs raid6 3 disks filesystem when the user upgrade the kerne=
l ?"
>> (I am thinking when a new BG needs to be allocated)=2E=2E=2E
>
>Then it will cleanly fail to mount instead of constantly corrupting data
>and memory with every write, yes=2E  Which clearly suggest that such
>file systems don't exist in the wild=2E
>
>But if btrfs wants to keep supporting this I'll just add a _unsafe
>version without the check in the core library=2E

I don't think this is a good idea=2E Error out; it is the btrfs maintainer=
s' job to ensure user data isn't lost=2E=20

The RAID-6 code has *never* supported only 3 units, and if it ever worked =
for *any* of the implementations it was purely by accident=2E Speaking as t=
he original author I should know; this was deliberate as in some cases the =
degenerate case (3) would have required extra trays in the code to no user =
benefit=2E=20

I would not be surprised if the kernel crashed or corrupted the page cache=
 in that case=2E

