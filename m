Return-Path: <linuxppc-dev+bounces-28030-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7D6C98302
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 14:31:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqfXn0lBLz2yqw;
	Thu, 24 Sep 2026 00:31:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::835" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790173881;
	cv=pass; b=JSdLSMnxke3o5p1Oqn2IGG3ocyI9Gg3qr8YZBCQrlivYkcqEf6Yf2K0kF0OzFYcsvI1/eFrCMUluiMYgkn/7OOb6JgmMrHfwWB1U1yKTnvFqIXLA1HpCpsLSvku4ZaNLXz4Dp+hT0En9Ta1v/oeJW8BkFnCmooZmxyoQgDeWCxH4k55iHkk2fITVKm0hQ7QLQbP37AccH9tAQfFOpkr/3aSvvw+8yC5bi4n65BcOvbTKZUBSU6F6Ac4mSRoJ2PLV3S08w2EuemggoY+M7CLIlhbXcFD+jYlnwJ3vYrtQs1kFwm+1MT6Zag+cP6kNrl5oS4C7b7QO+lORdFY9Q/xs0w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790173881; c=relaxed/relaxed;
	bh=3IRQTfCkVu29EAhzhIq8HL8xV9bhN+vmwTvfaTzW1hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YuF3kGSUZ5khQ1uTe4bqTyOaJIWPkJ7nkU/gk7PpMZifK10NwXs3ooHEv0vkUJCxjwAzsGWaFsSuQFrzN528pp5S4PRfDCPNDNDX4Uub8OPbLJBlJWJ81zAdVT+47L4vgcHiuYdzF9qhQzhnm/8MMl4LTXobCWvaOg4ODUulk/eyncEZr04MWuaTWMYuiloVNePq1sDI+Ydu0F/pBM1MWI+7Qsd7g8ghXKrTz8eeI9kdVjSzaiIfw8JFV117F5eFsdSAO+AnLEJG6BjjM3I2+7E+lonNh5zSU8pEM7odWOKcXEBTu2J5orAyrRxNEDhlCXOeG04csMhxvrYi4jknPg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ZgiWTznd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::835; helo=mail-qt1-x835.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ZgiWTznd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::835; helo=mail-qt1-x835.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqfXl33swz2xjM
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 00:31:19 +1000 (AEST)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-532e9ad9a1eso208411cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 07:31:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790173876; cv=none;
        d=google.com; s=arc-20260327;
        b=Y+jp9niZiv5OSQu+OlX+JTjD1isgPKpjP+9kKfPWHy356kPCSV2i96fYZDRqFeZKYW
         VpZQyC9RVKKWVyNB/d1fllTzUvN/52HuGp/fpkaWypjMb5nTyw/Fv777yDC8CA+4xOQq
         zfOU5tPn5wkR3bLIjWwrdyEA+GMVWhPvFmgdtpGVvO1nypffxjvscFgwmSfMkMEPRFvp
         08Ry8t2r3MeJyQIXxK6sHV4LmgmSveGNwLR7GxERqPKfKaPv1u6kA/DdIbCH94mlwDyi
         5abxFZYongbPKPYsn9bnpo396I5hpfQeOtfOPDcWGA7eESKPdavUiipcy9Et7r7WBhrq
         dRnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3IRQTfCkVu29EAhzhIq8HL8xV9bhN+vmwTvfaTzW1hg=;
        fh=5oxTsT98qCdzTa/eB2WMy7aticDylOl0m7FsIaz/cpc=;
        b=jBPBGHEUgZhGfkjU9o4VYWS6zi3gtDg9gf7E4KKBgq7voJEstUef6LSBkJrjkd+byt
         BKlk+U2RoYtm5aiYVMkCZVvMOvogiIEOFa06BB+Pnbqf6IHYHDVJ8fn8edyWofxoLDU6
         +hG49c90S7YsKgkRYB6JxrhZUS6TWXikhGJ1ixYKeEnFBXi04pHFgwthK9RBkmowVJbE
         EA5p3PaZM65J86fZ11/r+8vytKx0+CtogvDWBO6eKr/bK2keUB+BtACWJS5MeBCSj4e9
         cYpSpYmrpWV18Ndj7jmeqmXhvW1Vlk3+qc2ceoRS0Q/kau7137WNI8YucvZLUL0/WjMp
         Uq9Q==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790173876; x=1790778676; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3IRQTfCkVu29EAhzhIq8HL8xV9bhN+vmwTvfaTzW1hg=;
        b=ZgiWTzndoglj3Y5YARn0tWrVEd8HEUCjQZ+TsTD2DNqf3JM6n0yqnZmGZgL3doRVGK
         iR9mEE2KWLjsjybFaqHU8yAGPWI6cXPLnbt/H4Lyi0yjM3eM8nBX3y4QFninSEdB3tNa
         byX2I62ubDHJeTwdOX+Pt5n1rI4ava70WFUSIyuF9B2gI2W2nLNopbnHuj7bprxHDxJt
         UxrvGgENRbpnXZ/oaNi6Q6J+5pQFlpB8OWDXUG0+kvmM8M/SEuNQFpL3NH2j2dLueIG8
         gG6tD5Ml+30LuKrnIx3+KHRzUDGcZknADtCboyZ4h0AZD9E27s+p9995YXwTQ3NXZ/XJ
         zOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790173876; x=1790778676;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3IRQTfCkVu29EAhzhIq8HL8xV9bhN+vmwTvfaTzW1hg=;
        b=2GannVc0Z1T4VmM5MVfCHaEFrs78ej+QPA82RGo8TAV7l4wk+r8e60UkG8voyUiyRh
         ye7ObKVMWMpX037KQtT2vIkRbZeCnjDD7tUEZuM4oR0Lma5su6ivEboXMC2OAIPvnGkP
         JP3Gnx5kBvmsxR+/w2JRH3E6dD37QwowS60FnGOpVlF8bhqBcIjZC9d5IW7/zle12g/C
         2JD7sLwAdniyUvEl8XIrRhk3Khslyfq/BP0WJ2zg46auLAOVXCvYMZTrjo6rbZ4BMUQQ
         /9Sq1MGx/4xZ5B8kZcBiF/oYEIzhbzlmfjwCv63LaX776sxT7574DWAwc/pEJ6D1fcpd
         5+1Q==
X-Forwarded-Encrypted: i=1; AKwUvBxKMcekA66F1X8hM+a76G/F+wYXZ3cYm9dCYw2f7LtirbAG+Y41EyyqIOOqR2tuUPuGd58/7ANx597oCnY=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mnHYxE4o7IZ/iyuoVXTYAViidi6ecZQyEVylMhT+9pxL0rqO7H
	pjxyhQ7iBN0OYzCNULucB/I/CRrOxOcUJPBXYPqvt2Dp9rXZLoajBmypUCc5fFT+w/rquyssc0L
	f5Y1Ev3bb42l4NWVS9WfyFaZ7HtG4TdWTNuL6Gk5t
X-Gm-Gg: AYBFou2TlHWSmnYM1TXt8cFOq61IeBf5yxfoPAjgkWlBSDhlXhmjErGjQFzLVdXM3bC
	h9rEJ98qjOqiPhp/ixhZzOTPb/IKaSOTC8liTIwxl8Jz8EUCUwz9tALQYJ5k8H3+ST+Gi0L7upY
	WpAbSCDUVL1qhfJZcyZSet64PbDGjMPJoROLq3gWOMJ3U8rC+FTK/Mj1l1BdAcJHDtoqT9M9a41
	9fHpVbREq9KTOoYflkmMQTv9gWHefqQebPjPve5CFzpdoJUKSspYkyc3k+y9ftTPHYzPc2sWs6y
	H0YbUPmzvry/DBJAqytXme0b5AsG+Kr/kFxBcDfPTSbcvwQDTzJ3OXuRhBbjgm4M/7wnPYpJsb/
	LyZW8WR5pEQ==
X-Received: by 2002:a05:622a:260e:b0:532:9d15:2e5a with SMTP id
 d75a77b69052e-532ede89b29mr14598791cf.1.1790173874906; Wed, 23 Sep 2026
 07:31:14 -0700 (PDT)
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
 <20260914180811.057cba8fcc48d6e0b53a2683@linux-foundation.org>
 <0b064fe6-ddb3-4f26-a1f2-2e9dd88d590f@kernel.org> <CAJuCfpFBichJH4OcmSHTb1rOuQBT6k5pXeua9_KgpWjDBKvsYw@mail.gmail.com>
 <aq6kzpK7wPl3iFGe@gremlin> <aq6lW9FvL69QeA9H@gremlin> <arOCPN02xB7mykju@gremlin>
 <b007cd0f-29ef-457a-8e44-63ab26f3bcd0@kernel.org>
In-Reply-To: <b007cd0f-29ef-457a-8e44-63ab26f3bcd0@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 23 Sep 2026 07:31:02 -0700
X-Gm-Features: AclHuK_ZGTwaB8ygIyiOyIIeQNRzbEtns-G_Cds8CuZ4q61CHw7YMjTifucik0o
Message-ID: <CAJuCfpHL=dHjT=O4S88ZBvT1DyodAtCL9QTryepzs3EMwoECDQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/40] mm: make VMA flag semantics explicit, eliminate VM_SPECIAL
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
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

On Wed, Sep 23, 2026 at 1:40=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 9/23/26 10:13, Lorenzo Stoakes (ARM) wrote:
> > On Sat, Sep 19, 2026 at 04:09:13PM +0100, Lorenzo Stoakes (ARM) wrote:
> >> On Sat, Sep 19, 2026 at 04:05:57PM +0100, Lorenzo Stoakes (ARM) wrote:
> >>>
> >>> Thanks guys!
> >>
> >> Note v3 has been posted to fix a stupid bug in 1/40 + attack some very=
 trivial
> >> sashiko stuff
> >>
> >> https://lore.kernel.org/linux-mm/20260917-b4-mmap-prepare-vma-flag-san=
ify-v3-0-4583d8a23bca@kernel.org/
> >
> > Just a gentle nudge on this :)
> >
> > If you guys or anybody else has some time it'd be appreciated! (obv. th=
e v3 as
> > linked above not this v2!)
> >
> > I know the series seems intimidating but most of the commits are very s=
mall and
> > it's been in -next for a while.
>
> Busy with too many other things sorry. Its time will come.

Had to take care of the pile of bugs but I'm on it now.

>
> --
> Cheers,
>
> David

