Return-Path: <linuxppc-dev+bounces-27754-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D45C982DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 20:31:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmkmw3MMmz30Tf;
	Sat, 19 Sep 2026 06:31:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::82b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789763504;
	cv=pass; b=KzQ0Dafuu3sHO+dAKWr3qC5Bs9oRQUcQi8c7Bq+5eDT0euEtdsr2fJe5UBSBpXxwP1NSa9Yex8bjwD3zZ96s9NAt50oe7awRitHlo+M6Xx43WcnsFwa768ZY51I0UXHhcPwe2qIc9W/qlTo4mAfsq7qbWvPT2UGj7h69tr5LD0E8/dLRub7owQyXat6B8rDA6Uv+9E35rXFk55lSWwPw37n9/HeOPivrEs2UrCVeBUFAFnakraZNRXXUSMY7DOcAM/72MnBtQdAUDs7iu1H0lAHApX/2L0/nD7H4dQrmyxr4UHv/v4XzTHAt2yKa1IzkhJAjk06QwHGsu6oSUlMutw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789763504; c=relaxed/relaxed;
	bh=rakr0DVeS6w19WPN+xiAqZEbcFGWWdpHaQBH8HXSGgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nBObOhhfTeYWASb19SpfY1kY61+8dpYVr7q/g7VXEjOxhurp17LVc/HfT50FMqFgcAKVIblHCsQF+zzq/72Tp1C+lKpwC9nnCPVyqKMsnUKd5ANIo3HxBno/2NeR93Q9kEntPRYFA0e+4mrgBcXTtqzfXvrwX0a3sLbp9NkOnSYp5e3yMrIzlOzC9t2K7fWdy76YbsOpRQpM24sDpJDF83jXFZ2TzMg14pvHNf8DE3ZMhKzco7FYdBECmyShCyR33TzocQgsOOesWpvBSA4dbD7lMGH3XlY91VGM3vqNseblVFLkMs72GR7ORe82L7ufMU2UgqJi6GhH0AVi1+6vZw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=HpQigNTp; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82b; helo=mail-qt1-x82b.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=HpQigNTp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82b; helo=mail-qt1-x82b.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmkms6BJxz30T6
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2026 06:31:41 +1000 (AEST)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-53113d72966so9451cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 13:31:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789763498; cv=none;
        d=google.com; s=arc-20260327;
        b=fqHBzPJOci2EZI6KtzzQmkIdNjkb5b7xM/wwOlUAuJJ0eMvXGZQQ5aqPGSUKJMDsLo
         CSxzEJfui85SYamFKWfPhTNd47DQa7SFaHtgdhxsuVPd+vFUnsLAT4BR1pbL+GBbPBt5
         vVeH3QDaTXR8nuvMlkjt8mdVFhp3siz2iox8NrHL7XajAc61fS4P9DRjo+WgsN95EACG
         Zd2QSkta+87yRWyTBM+Uu2B9RKruTnBYg+KSMpyB1dQ37OY8YhNPxbV4Hw5+OIqFcCWi
         4exxrtjRphf3rFqdZv5cQZEEulMqbYx1Apc66dlIpk3s0da6SMjOTqaU7dAmWj8rfVWR
         n/Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rakr0DVeS6w19WPN+xiAqZEbcFGWWdpHaQBH8HXSGgc=;
        fh=ObwXqgEoSJiEQwyfKUvkzO2mCu4PvPYwEAUl9dCKJWo=;
        b=OCDfEON+XmKsUvwaDN1YrZw3NzRD7bkFW9jwaD8pg74erLCgZSn6K3iQhEuc0kmrjL
         MT1EhwUolOBNXwHpyAcq3487HEo13B/+pbF63leaL0e1v5aYP9ah+GyEjP97KNn55nwr
         oIj2wTUEzOf0Fdf1ZZkpIN663TNskTcOty40yrQ33+7c/vkWXQ+tqA5UjJp3xgTE+lWJ
         KRnqmG4Suln9+WacI7jvd0sZNGzs5F68vMC4DXkd/AICUp1TjtJ2rpV5U5QOgVyOR100
         2JeynvNGF2TY3D9pjkFUTB6AE+oRBx8Ah/dkbTb1QpEF+RD8nCP0Tr4J+5lC3SP471Wx
         LHfQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789763498; x=1790368298; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rakr0DVeS6w19WPN+xiAqZEbcFGWWdpHaQBH8HXSGgc=;
        b=HpQigNTpsTfrLxJABLbQ8S0PO3tAs5XjRBJJ1LV67lwfAgEJNDNhWcAMNf1RH6kzv5
         H9eG9t3mh+7tyMOgUHh1O5JnpZkGNTi59iHZA6RnixdT6d12FoJJBIrAlYKne9QKJyQB
         JYugs0Y8Lb+tHvd3NChcE9KtGY7IRWhE2++C7FEk8ljyLxq2qAnMMfFF7MG53OU/flRB
         qlGjz60pqKCYFXex4DhCJgKERgDf9oFmznTR2z/CIogsZ4L16OmjOBX3yYQa2+d1Q6Zo
         AK9TOm93M36iuw4QZJ0zYbUE9umljodlDFEPqDYyRR9RCzxw9DydfQR5PWDRWNd6CWJ0
         92nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789763498; x=1790368298;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rakr0DVeS6w19WPN+xiAqZEbcFGWWdpHaQBH8HXSGgc=;
        b=zkQjqcXu5ACciW42ZIigUiqlpuRcl7XNCgB4RDvIyryCUdJEpNScM2HgpYZ2twkZyH
         gKYyx2f1r9js/PZ/TuENOndDZOp2vnLZJ4JYKUqoVUXsVtQ3FwGgnd7A1g3myU11S5lk
         0bdr+ZDT72c7eEbxdFD9gIlmaqbKzeGCdIBE+5lc9sWnOxf2cq5hnCcB2HtF3tvEt5Rq
         uoWNimWw8RU1o/6MqIRiApMRAhWG4jb2KItAwut2wTnEaXT3phovRKEgXfUES1zOrNZC
         Vo+OCDNmkv+s0CFWn9V9FiXkCKBd2bAtVZw3wxjmprJKinx9VjAOU9uN+HhMjiOQQ3Ee
         NrgQ==
X-Forwarded-Encrypted: i=1; AKwUvBwco4e112UR13aLUHQHxdMLOYMZrbSPQ37LN/oYRfdcF6T2QEf+6Jcdemc2ZgGO8XFHf3wFTYt3Cn3hTHo=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mYEq+bVeRazsqGYlJ6OU1jRnWAamyDqTcS2fsN6S4GXMhUn8Fh
	u3A49e+ove452ZAVn4PUFh0i3OB3bjYWRHMoYzPiaYAVhHMrSzA9J9LxBYX1sx2+E7LDlltFeRk
	UbUKzaFtwdlEIRTwTqLdK7guuG5X6LZL32qmcC2iI
X-Gm-Gg: AYBFou0ijtESfB6vAU3BSo/RqRwaCmm6kl2dqqKWOOPy1xa7VoOEzMgyxIRtPOC3VUl
	QkvY9T4B/qHZ3l9bEFza2pzkcKux1q3ZE44cvYbuRHk6I3557KXhZ2u0botbjvDYSSyFVDfAqPf
	c0m9OFd1vO48YxZ8EhIFQCFNqTMmLI21nH4LsF8vCbIaFim3tlxa3dQwANoekvIKIvR+sDE87CK
	tKm0EgseO2QP8rdm6m1f5kYQx4iAIVVFV7KL3RtpaDQ1Wn/9Yg8PuDCm+QH/15WeVyBGs3dZn8O
	A6v5lvtBlZhd/DLbJdQWu+a8HQRSNMwkawxETjSfRePo+R+3qek8SQ==
X-Received: by 2002:ac8:5d08:0:b0:530:2f98:cebb with SMTP id
 d75a77b69052e-532b099561dmr605641cf.11.1789763497212; Fri, 18 Sep 2026
 13:31:37 -0700 (PDT)
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
References: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org>
 <20260914180811.057cba8fcc48d6e0b53a2683@linux-foundation.org> <0b064fe6-ddb3-4f26-a1f2-2e9dd88d590f@kernel.org>
In-Reply-To: <0b064fe6-ddb3-4f26-a1f2-2e9dd88d590f@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 18 Sep 2026 13:31:24 -0700
X-Gm-Features: AcwNN1VqLTR47MatnNlBWbpWA8EMmoQNGykspJvqoxdaovPnF0EYfRCWZF-8zh0
Message-ID: <CAJuCfpFBichJH4OcmSHTb1rOuQBT6k5pXeua9_KgpWjDBKvsYw@mail.gmail.com>
Subject: Re: [PATCH v2 00/40] mm: make VMA flag semantics explicit, eliminate VM_SPECIAL
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Doug Gilbert <dgilbert@interlog.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, Jaya Kumar <jayalk@intworks.biz>, Simona Vetter <simona@ffwll.ch>, 
	Helge Deller <deller@gmx.de>, Sebastian Reichel <sre@kernel.org>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Xu Xin <xu.xin@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-rdma@vger.kernel.org, 
	selinux@vger.kernel.org, linux-sound@vger.kernel.org, bpf@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	fuse-devel@lists.linux.dev, Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 1:21=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 9/15/26 03:08, Andrew Morton wrote:
> > On Mon, 14 Sep 2026 15:57:20 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.=
org> wrote:
> >
> >> The VM_SPECIAL / VMA_SPECIAL_FLAGS mask conflates several unrelated
> >> properties:
> >>
> >> ...
> >>
> >> It's all rather a mess.
> >>
> >> This series brings some order to things by both limiting what drivers =
can
> >> do with VMA flags and switching to using predicates that describe
> >> behaviour, not arbitrary flags.
> >
> > That's a lot of patches.
> >
> > Review is thin and I expect this won't improve a lot.  Lots of "no
> > functional changes" changes.
>
> I'll expect to go through all of them. Might just take a bit ;)

ditto

>
> --
> Cheers,
>
> David

