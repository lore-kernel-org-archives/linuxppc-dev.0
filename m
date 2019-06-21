Return-Path: <SRS0=Jsh9=UU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D10C48BE3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Jun 2019 23:58:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F02CD20821
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Jun 2019 23:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpPFzcp3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F02CD20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Vwcm3SBxzDqcQ
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Jun 2019 09:58:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZpPFzcp3"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45VwYH1tDgzDqbv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jun 2019 09:55:28 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id x15so4375335pfq.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jun 2019 16:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=x9bZV3T0S6eNYo6IXHrd+kECvmTbbAucaYzxDYrbdeI=;
 b=ZpPFzcp36+Hh5jye0ZKjtgJ550NYI096FfX2rcFyQ99LOi8SMis6xF/dheI3yxj7vn
 TBGcbHMLdJQh068I90oszy1lxCnmI5g4KVT7DQMh+oL+mOljJTN2ljZWYTmOt23yVg2h
 LdyqXTNKqxAmKaI+JKi19peuQtNFJ/A6jfkfKGStmgPKTkapA12DT/MDePfRHMwpeCd2
 tgrx+S6ckAPgkEN6TA/783NZNMh/U4UZX0873+4sMF+NwUUbApR86gBQBtLXNIwieoaL
 GIkk0MteisbTCO2dsnPaZ8Qv7rsQ8XF4reLwhY4yUxl1spYYF0SWL0LStYP/hWINYrnP
 HtFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=x9bZV3T0S6eNYo6IXHrd+kECvmTbbAucaYzxDYrbdeI=;
 b=Gqi6FL0CXvbfDZehxDOudLWxGq/ETUqa58O1dDch3kAqU3Ej5kG/+lsZa7ROpxnNhQ
 +Jw6xwuzGkvR+MgJoL6yUqLC1++FSIpQA3HLU4pJz4p2XRU3HpqVLV5mqQI8jCXNJb4D
 CPf0sFd1kyeiFlLHkwMgngfwFhJR20YbfK2ZGmCWBljNaw4+uRTNyCrZYJmRqyk1fUJE
 O+21noV1bSmos6alpguNqdoTbS/y81DlXL5f7LWnmJbFh0+wIdbOhe8eZwwP8PJr2Lrr
 ARpDiKKMHqCWPuVOlT6kqryQDVnvWY6u4Ku5ut7Ejgznk/2fZGDlNpiD3HvfFELAEnNf
 X3Rw==
X-Gm-Message-State: APjAAAWzFB0cFLeyVj0BfLdTHlu+PdSeto8UFqdmuHNW/wcL78cgfCAp
 4SIxjiG1vxYAVEha5mdTCyc=
X-Google-Smtp-Source: APXvYqyqRRpjMOtRudskKnzHE+bVq170qVap7+EY5kc6j/qI6uUR3V4Zstw2KCShBoXYwoTuoCwbAg==
X-Received: by 2002:a63:545c:: with SMTP id e28mr4210785pgm.374.1561161325219; 
 Fri, 21 Jun 2019 16:55:25 -0700 (PDT)
Received: from localhost ([1.144.144.251])
 by smtp.gmail.com with ESMTPSA id 85sm4623425pfv.130.2019.06.21.16.55.23
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 21 Jun 2019 16:55:24 -0700 (PDT)
Date: Sat, 22 Jun 2019 09:55:09 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 16/16] mm: pass get_user_pages_fast iterator arguments in
 a structure
To: Christoph Hellwig <hch@lst.de>, Linus Torvalds
 <torvalds@linux-foundation.org>
References: <20190611144102.8848-1-hch@lst.de>
 <20190611144102.8848-17-hch@lst.de>
 <1560300464.nijubslu3h.astroid@bobo.none>
 <CAHk-=wjSo+TzkvYnAqrp=eFgzzc058DhSMTPr4-2quZTbGLfnw@mail.gmail.com>
 <1561032202.0qfct43s2c.astroid@bobo.none>
 <CAHk-=wh46y3x5O0HkR=R4ETh6e5pDCrEsJ94CtC0fyQiYYAf6A@mail.gmail.com>
 <20190621081501.GA17718@lst.de>
In-Reply-To: <20190621081501.GA17718@lst.de>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1561160786.mradw6fg2v.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Linux-sh list <linux-sh@vger.kernel.org>, James Hogan <jhogan@kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 linux-mips@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
 Khalid Aziz <khalid.aziz@oracle.com>, Paul Burton <paul.burton@mips.com>,
 Andrey Konovalov <andreyknvl@google.com>, sparclinux@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christoph Hellwig's on June 21, 2019 6:15 pm:
> On Thu, Jun 20, 2019 at 10:21:46AM -0700, Linus Torvalds wrote:
>> Hmm. Honestly, I've never seen anything like that in any kernel profiles=
.
>>=20
>> Compared to the problems I _do_ see (which is usually the obvious
>> cache misses, and locking), it must either be in the noise or it's
>> some problem specific to whatever CPU you are doing performance work
>> on?
>>=20
>> I've occasionally seen pipeline hiccups in profiles, but it's usually
>> been either some serious glass jaw of the core, or it's been something
>> really stupid we did (or occasionally that the compiler did: one in
>> particular I remember was how there was a time when gcc would narrow
>> stores when it could, so if you set a bit in a word, it would do it
>> with a byte store, and then when you read the whole word afterwards
>> you'd get a major pipeline stall and it happened to show up in some
>> really hot paths).
>=20
> I've not seen any difference in the GUP bench output here ar all.
>=20
> But I'm fine with skipping this patch for now, I have a potential
> series I'm looking into that would benefit a lot from it, but we
> can discusss it in that context and make sure all the other works gets in
> in time.
>=20

If you can, that would be good. I don't like to object based on
handwaving so I'll see if I can find any benchmarks that will give
better confidence. Those old TPC-C tests were good, and there was
some DB2 workload that was the reason I added gup fast in the first
place. I'll do some digging.

Thanks,
Nick
=
