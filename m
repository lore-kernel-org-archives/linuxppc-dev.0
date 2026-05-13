Return-Path: <linuxppc-dev+bounces-20822-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3319DCD37AC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 04:16:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFgC328HFz2xld;
	Wed, 13 May 2026 14:16:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778645807;
	cv=none; b=gK9fRFxJxOsk7QNaDVP+7h7R6waGI7Ik4Z+AmRYWuVlIZP3rf7ol0BTPSmpBsfdMQV5QJZXHhCvF9qZmt2SFPbUeGi6m7dSf29if0ojK384PPDXqb3M1APOf/JGRAhr1wbsocY6i79AQTfx+ZUF7+UdCchc3VZGWZgWt+n/8o707ay9rLVZyzU3E0Pjse3RmPjrGbY6K5EVmUgqLB/cirAFBwiMTvyOFdjqX+qr2UMM2si5eMJ5Mx2v5ukxfI7Tek23z3F9tjro7bHeTpqSNkNDsRyaiFFuc/imC14BqYBUOkAIZ2FBv7BWZrlNFRi5BRMV1naeTCIUvOViaLfA0ng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778645807; c=relaxed/relaxed;
	bh=dgwjs4Wmc3SmAqImPeb+QvEd0ROSS5ez6gLjaZVs7/o=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=Nd9POoprBaQbmMiSW9Fn5+HZ8Tia+AY3FzpErMCBhGe1jk2AooET6Td+lN/ekPFLtrBhWeWgd/h+TZDyJ/8b/mKOwYapLJiWbJNgSz4sbr7wrDTdgxkcDKI5+yflVjQGs7HMWoTVXQKGU7EaUjqzMr4FwiUW4czQV9HzPvX2rsigBTFjCp5E1tzdIgAaTVfUM6MSCr/UVu2kr4ksBCWlZ7SOXDA6G+b2xlplPqMa5F1YXWpsZZcBeXmnwihqDV02rE1PPgdwBb9S0HBd307zR1K/n7VSuwyMNeGq/5peEp0hWQXfDVdRjYco7fcUf7UrP051jhlQrO3jqIIUCYTD1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hqqoHYCn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hqqoHYCn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFgC21s9mz2xlV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 14:16:45 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-367d88b9940so2949667a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 21:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778645803; x=1779250603; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dgwjs4Wmc3SmAqImPeb+QvEd0ROSS5ez6gLjaZVs7/o=;
        b=hqqoHYCnuJY6aQwEZIe0GHj/ofwxdDoy4jV2UUSVvFSEVlnwVyApR6pagu4YRUGEfs
         71PXNAYii+XdVPgyZJ6b9lExdVnfQ9Lld5LDL/ypK8NnMp6YpNPKR4x3Gs6b1GuhmlEi
         jzvtREK5XkZfp24ZnrX5MWcH3dK0Gj0c3LDdnpyWGVpuJXope9CaEal54kvygu1i3nkr
         xR3nPfG5eASg9MD8sq4sYAxJHT1D+OWE8DVP86lMy6Ny6KXvOMRJSL7qYsgqBpki5X8e
         iUnxnZvpWsYIioMVAWqftHBcydzfOA/rCWBmexJnqDsujNcqtE6SxZlDh5HQ9GcA7VBJ
         bE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778645803; x=1779250603;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dgwjs4Wmc3SmAqImPeb+QvEd0ROSS5ez6gLjaZVs7/o=;
        b=MHcccCuwsTHEZVeY7IQJH5RYG2HGQjtx2y1e2AD3hU4KTxKUPEgw/zafTsQI5C/KZX
         51IvpreoX9GQnGQ9cpiluzeyqx7EKq0/2w188QxaT4atf1nOvHRYOeapmb5L1FC/nC7z
         tBhu7/PFFnr0GUMixRoed3qXrS959r7Nx29i4bcR0FNoEUA0RuFEDH+f63FyuuJHwz6D
         IHu32IXlhdlle1RyH3Eb880akpygj4HXeo2mkcuJ/dsAb2+sWbQueh9baERGY7OrCeZm
         oaVTd6ZdRFXUksq5k2jqZE4GHJJbRt3lPX+NMjOS66vgLgBFzqAYx2hGWADGPRKCg3kU
         P3PA==
X-Forwarded-Encrypted: i=1; AFNElJ8KEVEPbwjVnt29+4XZqrj/BhOoy+bvgoQd6xqvAjvUaP8+ApKVXL9YdA5u8nE7EamJ6kKHAh7lv1258/s=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyLh5taE6eqbobQ0gy4TMFwdARGr4i/enZGAY/CZU8WwN79uA94
	Bp90jvOcHO3p66BGgy8KO5NBvf2qNL/KyC4ij4uLgDTZPAN6DK00CBQs
X-Gm-Gg: Acq92OEDuRBp0iuEEW7n3/JnxmhYHrDYZ95Xikw5ZS/GvR0VmM/ImvhNCqH6y3AJX0o
	J/CKdgaPs5HMB6amA5NwFfKKDkzYyCVImG286dMVuOKkP15p1njOERG8RHc9aw+naN/4UldB3Zo
	wzZ4BiuJ0nvKcXq1koSgD1z6RbMecA9oNzu++d6Ae6kjuDx9LYjM1OBNRrNkv/kE+zCDO4dY4NZ
	/U9yaDbnW4m/ZHcoeYt6LTPQyuoBvwitQ6qPqvugZnThIc60XGJDEshwedZvBtZdZpffvOOPeob
	CX6OPDAXT0NluCQJLTFUU6celKcsDQpQzgTWUkETCkZ9aBFnrceWNWcyZOE1GTTeFYgVU6Hspb0
	JENUFEHHl9ExSouz6bi4Kw5tCqTIhUD2R80BCmY1EAAQhfaUht52Lk7ZF/IyVHna/LjNmTzKNI+
	IRia49tWHCbZTu7ZHKFmW0Fg==
X-Received: by 2002:a17:90b:134d:b0:366:3ac:f725 with SMTP id 98e67ed59e1d1-368f409cefbmr1683736a91.25.1778645802683;
        Tue, 12 May 2026 21:16:42 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c826771b19csm13145401a12.22.2026.05.12.21.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 21:16:42 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gautam Menghani <gautam@linux.ibm.com>, Ian Rogers <irogers@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Subject: Re: [PATCH] perf kvm stat: Update the exit reason mappings
In-Reply-To: <agNS2p8vXm-Pkkfv@Gautams-MacBook-Pro.local>
Date: Wed, 13 May 2026 09:33:10 +0530
Message-ID: <qzngq7lt.ritesh.list@gmail.com>
References: <20260512120408.59332-1-gautam@linux.ibm.com> <CAP-5=fUzQRCpF4U_0dnPxrx5sa3U-XbpLzn=c=EbeRsCY2=dPw@mail.gmail.com> <agNS2p8vXm-Pkkfv@Gautams-MacBook-Pro.local>
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
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


++ linuxppc-dev

Gautam Menghani <gautam@linux.ibm.com> writes:

> On Tue, May 12, 2026 at 08:25:08AM -0700, Ian Rogers wrote:
>> On Tue, May 12, 2026 at 5:04 AM Gautam Menghani <gautam@linux.ibm.com> wrote:
>> >
>> > Sync the exit reason mappings with the mappings in trace_book3s.h
>> 
>> I see:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/kvm/trace_book3s.h
>> Would it make sense to have a copy in perf and use the check headers
>> code to keep them in sync?
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/check-headers.sh
>
> I'll take a look at this, thanks
>
>> 
>> Could you add the commits that add the H_VIRT and H_FAC_UNAVAIL
>> definitions? I don't see them in Linus' tree yet.
>
> I posted that patch earlier today - https://lore.kernel.org/linuxppc-dev/20260512115724.59299-1-gautam@linux.ibm.com/
> should've pasted the link in the patch
>

For patches not yet merged and having such a dependency, this could cause
confusion. What I generally tend to do in such case is, group this
patch (changes in tools/perf/util/kvm-stat-arch/book3s_hv_exits.h) into
the same series which adds H_FAC_UNAVAIL to trace_book3s.h [1].
This way it is easier for everyone to keep track of the dependencies.

[1]: https://lore.kernel.org/linuxppc-dev/20260512115724.59299-1-gautam@linux.ibm.com/

Note, that we should still cc the relevant mailing lists, reviewers and
maintainers to get an Acked-by. Since the changes in this patch are
largely powerpc specific, so IMO, it should be ok even if it goes via
powerpc tree via a common series, as long as everyone agrees.

-ritesh


