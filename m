Return-Path: <linuxppc-dev+bounces-21419-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2448BCD5BB0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 21:31:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMdkf3fQqz2xld;
	Sat, 23 May 2026 07:31:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779485482;
	cv=none; b=d0EDMXk8UoRu6UMzG4wQXATbFKfQ2fp9N2TQgy0+b5gGWEXEjcsLsmqVh6c18+5yJy+qdq7qf0Win/gjN2rN46lXlus3oI49V7aGzGq9bXCCe09cQFkSRsTsEoubxXc9kj5lBWPUNGxWp2JFJcW9pe0AtzZfzi9HeO/TFcM6xPCQdurpHcuEpSaGxEVurKGG1VEleZrI7XtwE02C6p8n9ZVSDBqrMzJwH5KsNwhRUbCDXaiSbM2ZanPZDU4KGWb4/JkaEjXK+s3xhAJVR12ufzV21W1tongMtMuyYR3H1JPN8qpz8ipdqNM6ASlD715/YXI/kXxsVNlaqiA28qkIrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779485482; c=relaxed/relaxed;
	bh=C1JkI15vgeu08xV//dtK9AYlWM5a5o5EUbaFA14ty+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aDI0gwPBkVmeHOEt7H5rVoUEukcIVHiY0jmlRv7+20Qo6qdgDByX1eS2ClgRfzI8rTZzZCixgtzJC0pIJJ+029GbJULufCv0SdYzgoIJHLKq2XQJ8c+WBleqxAfm3zYd9haLImrpfGlw5Z5TYKDfngTOZMroBcKsUoFOzUnZu+2w/IQrhwYjNoi4pW+Qq+uTJ20zvI9+qRnHEndiyUUmOpLArfj8rlHxWizaoIf2v8kocGLD4iT6eMRBD+zcml2Mb4wPm7pFBN6WRFRnbGqSO4DpOLE4VfxZzy9Eh9xUMn7WU7ru8bywNZs+/T9g6LQAtd2sUB92YML1sgj7YxDNcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZkBhq1d; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZkBhq1d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMdkd01Cyz2xVK
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 May 2026 07:31:20 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7735B43FD5
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 21:31:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7101F00A3F
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 21:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779485478;
	bh=C1JkI15vgeu08xV//dtK9AYlWM5a5o5EUbaFA14ty+I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BZkBhq1dEMkxCJHLGd9hHIZUnfovj2cBcOHoma7ZqB1sV0+I2O6Ds5hTpwlWo4Mft
	 6cZWdkrBC8UapaBAwm7wTsgf6f8+bsxbXBKEVD6N264a0/eS6r2rdb08YfLVaVXRFl
	 DCfthOwfboPEVZicSPecr1WRFLBuk1+P+LgQEe3wX84so6iEX2i0ZTBrRDglX2hSFx
	 U8IUrYW8hVgwjP8B7VfqK2I0t+/0+rbDVSJLqQ9PbEvde4WIlEtliG3txUqHXy/bwe
	 ykb+eAMoCx2v1OrYATTHe26u6dEHYIyLuKR8dX7rGXbs6//A4IoVMdKRjJahE4F5l7
	 5hZy1XYN8h40Q==
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-90f850473f9so783392585a.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 14:31:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/O53qWy2mtucKbrE60sehgzwY7AF591OKLopU4/2HKKJ5F1EIjJMz378WRPYFAM5ce6xAWKkoITiQc2aU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyVJkqp18x52ZLsrZfrW2HrkYN8qBk+04M4fdixU8XTaoQZ+qeB
	MfdUMH5Q0HpiuBX5DyuU2MOqpubW/3c0X69zEFSaRvqgXwpWtho/EUH4PsAw1WJVAhXj2p4hIoh
	78Ph6RiCmLgNnGIBKJ0vJ0cJw2P0d7pk=
X-Received: by 2002:a05:620a:372a:b0:914:c100:6a0f with SMTP id
 af79cd13be357-914c10072a4mr332092285a.23.1779485477280; Fri, 22 May 2026
 14:31:17 -0700 (PDT)
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
References: <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>
 <CAJuCfpE0WQrB3zJp9qn3jvn5DthS=ttpX7gJJvyEhA_BJGrp5g@mail.gmail.com>
 <CAGsJ_4zgeE3ebEJ+j7GJFzWVoVYHeiOn4dOoOsmWCLA6s=oECQ@mail.gmail.com>
 <5zdaa5uv5oj27q3taopl3amops57ouxgyfsdveudz4ovmbdw7z@6lwrlyvmhcp2>
 <CAGsJ_4yKxg1QugcsJi3WD0KVGJKe-zXycgm5D6cRi9vWtNcpDQ@mail.gmail.com>
 <ag4h87CBd-gph9zX@casper.infradead.org> <CAGsJ_4zA8afu0xXy0WS+tMe-eesDX1W6UBmfAsuouUpcAgK8JQ@mail.gmail.com>
 <ag4kj84EcKqamdB-@casper.infradead.org> <3be9475b-0e8a-4df8-a130-4262f993973d@kernel.org>
 <CAGsJ_4xC5LdhuoWV1=tK-RZ5rkjc8aOKOkmb1L_8BG_3gtJhDg@mail.gmail.com> <ahB6QyHgYq8ksj65@lucifer>
In-Reply-To: <ahB6QyHgYq8ksj65@lucifer>
From: Barry Song <baohua@kernel.org>
Date: Sat, 23 May 2026 05:31:05 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zxLvZ01i19vdo0xA47T1hxa1VRYvxLmiDhy5q1GDKPRg@mail.gmail.com>
X-Gm-Features: AVHnY4IqrepDwpGO5qDQsSaxTVFULk1Thk0Uu8QgQ0mfUUrDDRbDPxaWPMcP1VU
Message-ID: <CAGsJ_4zxLvZ01i19vdo0xA47T1hxa1VRYvxLmiDhy5q1GDKPRg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, vbabka@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	jack@suse.cz, pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn, 
	lianux.mm@gmail.com, kunwu.chan@gmail.com, liyangouwen1@oppo.com, 
	chrisl@kernel.org, kasong@tencent.com, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, bhe@redhat.com, youngjun.park@lge.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	Nanzhe Zhao <nzzhao@126.com>
Content-Type: text/plain; charset="UTF-8"

>
> Again this is making me want to sit outside and sip on some lemonade and
> ice :)
>
> Yes - android processes are aggressively multi-threaded, sure of course.
>
> The missing bit here is the forking - what, where, why, when?
>

I really want to know the what, where, why, and when
as well. But since most applications are not
open-source, it is basically a black hole for anyone
other than the owners of those apps.

Let me try to do more investigation to understand what
is going on, although it is really hard.
To be honest, I would rather the Android framework
completely prohibit apps from calling fork(), if
possible.

> And then you say zygote is sometimes multi-threaded but sometimes
> single-threaded, which is adding a whole bunch of confusion on top of all
> that.
>
> I don't find these stack trace dumps all that useful (though thanks of
> course for taking the time to gather them), I think we'd be better off with
> specific data on forking, in some _concise_ _summarised_ form, ideally with
> numbers.
>
> There's such a thing as too much information :))

This trace shows PF I/O in one thread overlapping
with a fork() call in another thread.
But as I explained, I really do not know what kind of
user behavior is behind it.

>
> Anyway, again, please let's see a new _RFC_ with the approach proposed by
> Suren, with some _succinct_ data demonstrating _exactly_ what the problem
> is, so we can make some headway here.

Okay, sure. Thanks for your patience.

>
> And now I'm off for a cornetto! :)

Sounds good :) Enjoy your cornetto!

Best Regards
Barry

