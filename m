Return-Path: <linuxppc-dev+bounces-22951-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A12CDB479
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jun 2026 02:24:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glQkX2S6yz2yVv;
	Wed, 24 Jun 2026 12:24:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::441"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782201519;
	cv=none; b=knMQ9JNYH9vYveuHhmx2uY5IgUXP5UKGfsnQmT1IGEsFDtyQZtNb/1v9cOxhlhrsGdLQBVB/u0iuApuvZFPpo3BAzo6kdHz0pErbN5B6J2oCk2zgUuZuYTLHkBuLzebVYe4fP0YECh640iAj4DIom7cW0+nDx/845o8qaou2+qbPm7uQbOM0PLrvvMf2AIp6r++zuikfBMwbcAfmIBWYXBeeABsYcdJ5ABhiUD0QqqgovykM3Zk0gUqRfOLhKkWuGSzhOVY+9ThimKIrYpcALCC1hHpUTI8J5vQV2B3xO2MjPObCuEsXJdzIchUlUh9NsnpQPW1P/feANl7uQ3iuKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782201519; c=relaxed/relaxed;
	bh=Ek6r0TkIKR0tiCQ28suwzM5bkNpctpIQyqr76NBcjWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQL+2oL7v3DxfBvP84B2PRH+G00aprGmK0x584qjbugQgoNywngYLf4Uz1Usi/pnSA/RdUVjNM5JvX8j0Yas+zUuN4rkQ3+Jk9ej8j1Y+6WjJqXvSul3NPb1/vcOj+Cyyb2mFpOJyDZd8H+RhwzYwJF5AkYc+eA1T/8DSFM8n4VSiATdnq6yaxHH84CdsOYdI/CTcBdEnGlH9cywKIL14WRHOPmOW+cKy7TWpvtkS8puLRjbcyUPSYWapjxfZ5GCGbcbCmMY/e/o3MESmDI11BxE69j3cEVP37QZUW5bOjH728RRMVbJ5YB0Z3Jy+AH4aqNHjiBAaiwFPUfhxprL5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rJpG0/Vr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com; envelope-from=zhanghongru06@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rJpG0/Vr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com; envelope-from=zhanghongru06@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkyB6541Jz2xwL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 17:58:37 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-8453bcf7276so2982333b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 00:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782201516; x=1782806316; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ek6r0TkIKR0tiCQ28suwzM5bkNpctpIQyqr76NBcjWs=;
        b=rJpG0/VrfrWOuZVhg+/QD5p9nbHTk3LKtX4UYOIX8FZVoePyjm6ckBK2uR1E6SXEqW
         avFajxx0KiEjfaf10TCVCpXG0ZdD9y532JXOMdw7Q0dN6F8o0r6FW+AJZL8/QCnW9hJt
         UeAGvXUNJPM1Bbnle3ASu3KuGUKXmRwrB/5wkKv2TOj6hK4y3iAFQigMl58M5v+fvzjT
         YIan21/mLURBQI2BNNtepEjzmZI97g70mN223JRjPm/mVHM4Nh/iboJV08CuFcWT2ZvE
         py1NPsz9t4iHcCByHf4jvaLmKVDBJyn3LnS0QjD0uzaRWO+KPmux09nRcNGlkZJ9EGt7
         mU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782201516; x=1782806316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ek6r0TkIKR0tiCQ28suwzM5bkNpctpIQyqr76NBcjWs=;
        b=hIaAoOzXmxgaEa0F6A8DC332s5TKzIqMYrQQjQYvHXSZmun+n8NeMzwf5ocN8GUpZN
         +v0YYjNHjMzVcP20nZCJxYMfZ1LaO3XeN5BBwBPYA6ew27A3VFyeoiEyh1CVRgv9Ky/O
         iTDWZBRDOdWb+szL2sNA9rtKXxhargGmsG36tBhQw613urkmOjc6qvy90jbJbxxdoJmO
         R4r0MeKrdHZFrGn+YEmtQEQXzX9AYveloVBm66EWUgkiZQfYN/xzb+mBY9kAc266aCWE
         INAMIV2TD/HFaKy95DFW92ypskUmUSSj7nywe7uduLREwKyXR8PiMsh3z0Tp8sZfZdAj
         brdg==
X-Forwarded-Encrypted: i=1; AHgh+Rpq+ggCCvVRaU3XH0+BqsJWFkO69r8FkKUaDoncfg4X47cuvzz9oJaE9LQmCGGeqIYAQHkkc4QfhazHbsQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw3SLWgZpNKMeItaNtVWXwy4uI4rT+vu9K2jg5kJUOOJgq3GqGF
	d+tPyZauqRyxxnovI/llQy5csMR8ofPItQr0WxzNluf7UHQF0Zj4oCmM
X-Gm-Gg: AfdE7ckkb85PcxR9/fFJ47uZL1qCe8HnkDTbotNUrPpDwv4BVkJHQWkCuq8xtfdJn9S
	AenUA9ODdJrW6WKcVErQ8Tm/240cGsIFX7MO78vWtDW0KmyLuVHYDL7b6Ol23+uUJPvrpMcfpkT
	8wBW72t1nsRxBSpYWQTw7MI6ZXWeSXiH82/LPuWf70VtBHGm3e9zIudZTtS0WrniywAJRRy9dz6
	SlqrZVZ4qwGoQB3L7I9GZJ8cL9IwraTC8MbgUJMR7E5e42sYs9yQxhJy6PysL/3urhnAE5Ubb7n
	TJLt3/YIrBXbSse+qFBsy0nnNaGvSE/4Uq0nHQr5F3O7e/d2/bIFI7psU3SuSnjHFS4qrbLtv6R
	Gb7HHuL0J9W1/RbEiVlUS1a76JelO2vldbqfS/KWnXQOxqNxQ3SZQONklxCV8bcipsPUhdW3F0t
	tl+h70f83Z3mFA4xoiwylQVNvRv0Sspt/UsiQH2pOi
X-Received: by 2002:a05:6a00:1707:b0:838:29b3:9ed1 with SMTP id d2e1a72fcca58-84550900333mr19117203b3a.41.1782201515623;
        Tue, 23 Jun 2026 00:58:35 -0700 (PDT)
Received: from zhr-ThinkStation-K.mioffice.cn ([2408:8607:1b00:8:ede9:3e72:37cf:55a2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564e745besm9355930b3a.28.2026.06.23.00.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 00:58:35 -0700 (PDT)
From: Hongru Zhang <zhanghongru06@gmail.com>
X-Google-Original-From: Hongru Zhang <zhanghongru@xiaomi.com>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	baohua@kernel.org,
	bhe@redhat.com,
	chentao@kylinos.cn,
	chrisl@kernel.org,
	jack@suse.cz,
	kasong@tencent.com,
	kunwu.chan@gmail.com,
	liam@infradead.org,
	lianux.mm@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	liyangouwen1@oppo.com,
	ljs@kernel.org,
	loongarch@lists.linux.dev,
	mhocko@suse.com,
	nphamcs@gmail.com,
	nzzhao@126.com,
	pfalcato@suse.de,
	rppt@kernel.org,
	shikemeng@huaweicloud.com,
	surenb@google.com,
	vbabka@kernel.org,
	wanglian@kylinos.cn,
	willy@infradead.org,
	youngjun.park@lge.com,
	zhanghongru06@gmail.com
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page fault performance
Date: Tue, 23 Jun 2026 15:58:05 +0800
Message-ID: <20260623075805.466317-1-zhanghongru@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3be9475b-0e8a-4df8-a130-4262f993973d@kernel.org>
References: <3be9475b-0e8a-4df8-a130-4262f993973d@kernel.org>
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
Content-Transfer-Encoding: quoted-printable

> On 5/20/26 23:15, Matthew Wilcox wrote:=0D
> > On Thu, May 21, 2026 at 05:14:20AM +0800, Barry Song wrote:=0D
> >> My understanding is that we should not blame applications here. This i=
s 2026:=0D
> >> there are basically only two kinds of applications =E2=80=94 single-th=
readed and=0D
> >> multi-threaded =E2=80=94 and single-threaded applications are nearly e=
xtinct.=0D
> > =0D
> > all of the applications i run are either single threaded or don't fork.=
=0D
> > what multithreaded applications call fork?=0D
>=0D
> Traditionally the problem was random libraries using fork+execve to launc=
h other=0D
> programs ... instead of using alternatives like posix_spwan (some use cas=
es=0D
> require more work done before execve and cannot yet switch to that). I'd =
hope=0D
> that that is less of a problem on Android.=0D
>=0D
> I assume Android zygote might be multi threaded? Maybe sshd as well? Syst=
emd?=0D
> But I'd be surprised if there are really performance implications.=0D
>=0D
> Not sure about webbroswers .... I think most of them switched to fork ser=
vers,=0D
> where I would assume fork servers would be single-threaded.=0D
>=0D
> So, yeah, getting a clear understanding how this ends up being a problem =
on=0D
> Android would be great.=0D
=0D
Barry asked me to share observations on fork() usage across Android=0D
applications.=0D
=0D
I wrote a BPF-based tracing tool (kprobe on copy_process, checking=0D
CLONE_VM to distinguish process creation from thread creation) and ran=0D
it against the top 200 Android applications in the China market during=0D
normal usage scenarios.=0D
=0D
Results:=0D
- 82 out of 200 apps (41%) call fork() during normal operation=0D
- Among these, some call fork() from multiple threads=0D
=0D
These are not zygote forks =E2=80=94 they are fork() calls initiated by app=
=0D
threads at runtime. Examples by category:=0D
=0D
  Browsers:     com.quark.browser, com.UCMobile, com.xunlei.browser=0D
  Shopping:     com.taobao.taobao, com.tmall.wireless, com.achievo.vipshop=
=0D
  Video:        com.youku.phone, com.qiyi.video, com.hunantv.imgo.activity=
=0D
  Social/IM:    com.alibaba.android.rimet, com.ss.android.lark=0D
  News:         com.ss.android.article.news, com.ss.android.article.lite=0D
  Navigation:   com.autonavi.minimap, com.sdu.didi.psnger=0D
  Finance:      com.eg.android.AlipayGphone, com.chinamworld.main=0D
=0D
This confirms that fork() is widely used in real-world multi-threaded=0D
Android applications. Since dup_mmap() needs to acquire=0D
vma_start_write() for every VMA, holding the VMA lock across I/O=0D
would risk blocking fork() for unpredictable durations in these 82=0D
applications.=0D
=0D
Tracing tool (two equivalent implementations):=0D
  bpftrace:         https://gist.github.com/zhr250/bf4384202d598bb4cda71cb9=
902f15ab=0D
  libbpf-bootstrap: https://gist.github.com/zhr250/76189bdf51bdc8818500e4c8=
917c6493=0D
=0D
Analysis results (top 200 apps):=0D
  https://gist.github.com/zhr250/06f51092c84a49c602a55ac3d186e9ce=0D
=0D
Hongru=0D
=0D

