Return-Path: <linuxppc-dev+bounces-18280-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007D7FB5E90
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 23:23:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZWNp1vk2z2ygl;
	Tue, 17 Mar 2026 10:23:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::630" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773703402;
	cv=pass; b=Q3I7ZOWUYcKhe1AUJ55NwPBQPp0eSi/64DGsmTyfvENty1JWT6U4QFVd1ScrwaZXy6+X7ZpDTCw813G1Jns36IAC9dMjkMUnH/y5kNUHSbPAgprspWQsR5Rbibc9uyaghBy0wt26Ho925o7aPO8raRUiQfo7r2S8oZL/znc8SaOei90EeS8RjfGPVi4ga6uuAJyVL/bALEzsv/42us6/3rMRbS+dJYaDbp6RLsspjBCocJ0cbiXJM2Kbpd/C9e6lM+h5OIl6ynu1cfj9+HTItrnr7nAWzEccCQn8laa1oQRhEJPWpdESYL4ISyshx8uGA9vae4Iw8zqX4OsEUl912Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773703402; c=relaxed/relaxed;
	bh=OjoL/xI+JfK24mJlLYQ/qQdhvwGI+GcsV2kW/9vszrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+IcP1jUupACpNqa/5q+H50nsI6BJ8OjuTyH/snAWb8bTLrCPY6Y70qbIqk/F5xvL7Fi4zF9C6KTn4wbioHrXn/N4b3adasc30Oi60h+rIZ4SI4cPtTBI1xhrYOVLn8EPsa0jpvfQCgfyd44Eb5T6XyZz8sUW2pIXeyprhGJEymih2OQwFLJbC2pLy4whmIJO7zofl/R49ze3jZs9QPKyXp2A9A9cGncVNn/5dH/VgNpCOMfySUyyIwj2HTEevqDiwZDdYpp5il6YCVVtf+EEW32nGCtNzShHJb5HXXBn1x9kS6r8x8BOovHJti2XiJqRrwoLG3Tzh2aKsoBOpqnWw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=LnZk8oZx; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=LnZk8oZx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZWNm3CmHz2xb3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 10:23:19 +1100 (AEDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2b062069f80so5537015ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2026 16:23:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773703396; cv=none;
        d=google.com; s=arc-20240605;
        b=LK/Azr7WyjanmxLshImXjZppSgyXyYKqcJd2EU8rS93srJs6lQeNf9JgTIbu0eNE0S
         D+RM+Wd3EY3KnFu68lo2GL9hjRqUzHUoICBY/pTDWfgkFLJlmRthrt/LeY9kRq/GgUxA
         9oiFRf6RL2/50s+DYo+50VLBzXA2h5whSd+BaAXBeI19+UDbCaJYSdfaad9cXnbDtwmK
         HZ3Jioz1LSUE1wF6Eg1D854ezYEnYNKexcQqELWqwEPPUEmBz7n724cFjwBdARnAO1QT
         4yzQf0B9iqN5ru+SWXun6BOUyeH4dwKQRNbuvWT7H5sVPIzkLlcuo9PLxEQNXOfSlYoP
         AJnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OjoL/xI+JfK24mJlLYQ/qQdhvwGI+GcsV2kW/9vszrY=;
        fh=L1EUF2Yduqo33AxlDG3HaSSqF7CoInjMrDbGocpnmvw=;
        b=jEy9ErP15VWCrfe8lkqHa5zGGLQZrT2LGLrvTsey6fFTVL4g7kns4iJpfk43fDc4Vb
         oDVs9Hymu2CCdvDr9fyGJuiNkuRsBKu8FUzYp9WZFF4/t2sN9BPgIqplYRApKVspFkm4
         C7wZc0WlRhTTD/grfSTxCHUMDvt7fLsIkiLdyb25Zagnsdk996x0GbsBAHSyqwd6Ac4b
         GnQBmJQU23rLM157bJFtLRNewEqVyXYO9x6Lpee/wGhBXR9glIE6SEOvUQQ1khY+QgXD
         rWPHsyX5EmEYYAXsvrVLeXG2Lv2dUIzbvWpgNzgzrnwHwyseaB6tRLHVvA0hrlv/I6Dw
         9+Xw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773703396; x=1774308196; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjoL/xI+JfK24mJlLYQ/qQdhvwGI+GcsV2kW/9vszrY=;
        b=LnZk8oZxR8agc4sE+MLLRqzgbzxP9zxjbV+rL7rHl+FiNWIFy88rHALWpmQC+PJMAr
         orHl/zJ3P9G6Il+cP+eqnAwK8h3GhSylWZi/uCxmEAyhmuiB6ygfvXIlyWHRWaw+lQfH
         yM3xFAZHK0ZNWo99IyZBUzf7TcgOBrF9kkCB0gPBor4iF5LdPsybp/nVV5EddWfGceKW
         n6JlLTOL8wXyI5907AyMmSFOTL8Ldk79/6eHeXOupA9skxWzE+WFKGTZEtKJTv4ttCgz
         m3dVtTEXyXlGubY21N6XXde47EkJRM+AjUFetzPClsG/bsUpGKwPT9ictshiszZOAZEk
         m8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773703396; x=1774308196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OjoL/xI+JfK24mJlLYQ/qQdhvwGI+GcsV2kW/9vszrY=;
        b=Pk58sB3h0vz9ZAFB1mtgzQHOxZjU2O9em+pgxEpu9ZiSLTj1IPPtOEr9EgFe5wIWqL
         hoN3XALJeWMhvWI5wuW1/JRUdZHXVOQLd0kg9lM9OBcaNfS5/4Nz3bTbbVAiUVanKF/G
         2jcCKY57CPrXw+BTGV93hqj9RWEbIc4OwltcTfBa10shO18KXWB6X18THiPGbUw5ShfV
         1nMCiSspCekCnLp+SWdjHZafHBhL1SZHt4kgu0YjcKNAoCZT1bCS/IL2EFqlZxBspJDu
         f/9J9UTu/ObqSW3RG0vYOl4h4K/ogi9/sxr2nZK/vYfo7bsB9VROx/HunJyV9ZG3IZ8E
         S2yA==
X-Forwarded-Encrypted: i=1; AJvYcCUSrC98B++VuifLF5hgON00Tun0uIBZ1hKmFlG171ZIxMjLAVr5CHmFgXrkDDcOIQ8TzBUxqT2puoJbLHM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxr0M0WJqBFtiv3ikX68qGLI8r4gpz3ef9kildkr6xFpQlrisRG
	qCNuvjBMUT7oB9tuCIlvChluF9AqcFvcqOGoWLCg6O62pPNi6MvHy6vTtIFQztlWWVRlSgtaO5J
	YX9B2yOasP2jKFkvrPtR5XnKAjeIHmk/5MOx69DzK
X-Gm-Gg: ATEYQzxBXw8cUH6ZNqz/ul43POyotnsAMq+qDVkqF8cPyrFyCxv6aiTYksQDPNA1PnZ
	AXDHvNL6IifGMLnqEj6TOcSuC07vDMtfO/ePC1RvPmIhzNgYo3hfX9oq0URMID8kPAyu4MpwssZ
	JRqUhsPFdgFj9NPtOSYxLUOhTDLz4XDD8U1tx5eYvi7iQZ/xBAGNokSgKSVQA72nRAtwQUR0tPe
	1UE2I3zcINplvV7eQPxJUXKMb88V/E//fAMVeV04aXDjNg16EY6ATgyAycbEZEgfdaMgNB3Qoqg
	H4UfVmVfM1MZLNtL8w==
X-Received: by 2002:a17:902:ea06:b0:2b0:5c3f:c0d8 with SMTP id
 d9443c01a7336-2b05c3fc4damr40223235ad.47.1773703396327; Mon, 16 Mar 2026
 16:23:16 -0700 (PDT)
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
References: <cover.1773665966.git.ljs@kernel.org> <063af0422d99bee0195589aa63f8f44edaf409fa.1773665966.git.ljs@kernel.org>
In-Reply-To: <063af0422d99bee0195589aa63f8f44edaf409fa.1773665966.git.ljs@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 16 Mar 2026 19:23:04 -0400
X-Gm-Features: AaiRm50DdYFqfixz3H6HRwMmLfdf5osoLUZfr0b1blDqz3IzGNPvd_xOI_ajOas
Message-ID: <CAHC9VhR2T8ujtfvz-HgkgSFByptTLmhbCYS+scY53aYg=sgfqw@mail.gmail.com>
Subject: Re: [PATCH v2 17/23] mm: convert do_brk_flags() to use vma_flags_t
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Kees Cook <kees@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Dinh Nguyen <dinguyen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 9:09=E2=80=AFAM Lorenzo Stoakes (Oracle) <ljs@kerne=
l.org> wrote:
>
> In order to be able to do this, we need to change VM_DATA_DEFAULT_FLAGS a=
nd
> friends and update the architecture-specific definitions also.
>
> We then have to update some KSM logic to handle VMA flags, and introduce
> VMA_STACK_FLAGS to define the vma_flags_t equivalent of VM_STACK_FLAGS.
>
> We also introduce two helper functions for use during the time we are
> converting legacy flags to vma_flags_t values - vma_flags_to_legacy() and
> legacy_to_vma_flags().
>
> This enables us to iteratively make changes to break these changes up int=
o
> separate parts.
>
> We use these explicitly here to keep VM_STACK_FLAGS around for certain
> users which need to maintain the legacy vm_flags_t values for the time
> being.
>
> We are no longer able to rely on the simple VM_xxx being set to zero if t=
he
> feature is not enabled, so in the case of VM_DROPPABLE we introduce
> VMA_DROPPABLE as the vma_flags_t equivalent, which is set to
> EMPTY_VMA_FLAGS if the droppable flag is not available.
>
> While we're here, we make the description of do_brk_flags() into a kdoc
> comment, as it almost was already.
>
> We use vma_flags_to_legacy() to not need to update the vm_get_page_prot()
> logic as this time.
>
> Note that in create_init_stack_vma() we have to replace the BUILD_BUG_ON(=
)
> with a VM_WARN_ON_ONCE() as the tested values are no longer build time
> available.
>
> We also update mprotect_fixup() to use VMA flags where possible, though w=
e
> have to live with a little duplication between vm_flags_t and vma_flags_t
> values for the time being until further conversions are made.
>
> Finally, we update the VMA tests to reflect these changes.
>
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> ---
>  arch/arc/include/asm/page.h        |  2 +-
>  arch/arm/include/asm/page.h        |  2 +-
>  arch/arm64/include/asm/page.h      |  3 +-
>  arch/hexagon/include/asm/page.h    |  2 +-
>  arch/loongarch/include/asm/page.h  |  2 +-
>  arch/mips/include/asm/page.h       |  2 +-
>  arch/nios2/include/asm/page.h      |  2 +-
>  arch/powerpc/include/asm/page.h    |  4 +--
>  arch/powerpc/include/asm/page_32.h |  2 +-
>  arch/powerpc/include/asm/page_64.h | 12 ++++----
>  arch/riscv/include/asm/page.h      |  2 +-
>  arch/s390/include/asm/page.h       |  2 +-
>  arch/x86/include/asm/page_types.h  |  2 +-
>  arch/x86/um/asm/vm-flags.h         |  4 +--
>  include/linux/ksm.h                | 10 +++----
>  include/linux/mm.h                 | 47 ++++++++++++++++++------------
>  mm/internal.h                      |  3 ++
>  mm/ksm.c                           | 43 ++++++++++++++-------------
>  mm/mmap.c                          | 13 +++++----
>  mm/mprotect.c                      | 46 +++++++++++++++++------------
>  mm/mremap.c                        |  6 ++--
>  mm/vma.c                           | 34 +++++++++++----------
>  mm/vma.h                           | 14 +++++++--
>  mm/vma_exec.c                      |  5 ++--
>  security/selinux/hooks.c           |  4 ++-
>  tools/testing/vma/include/custom.h |  3 --
>  tools/testing/vma/include/dup.h    | 42 ++++++++++++++------------
>  tools/testing/vma/include/stubs.h  |  9 +++---
>  tools/testing/vma/tests/merge.c    |  3 +-
>  29 files changed, 186 insertions(+), 139 deletions(-)

Not that the SELinux changes are really all that significant, but they
look fine to me.

Acked-by: Paul Moore <paul@paul-moore.com> (SELinux)

--=20
paul-moore.com

