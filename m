Return-Path: <linuxppc-dev+bounces-22849-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D4ECDB466
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Jun 2026 23:49:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gjWQL3gLdz2ySW;
	Sun, 21 Jun 2026 09:49:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::82b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781999354;
	cv=pass; b=mzFaDtsWb9/Tss7sTbJjmGeFFTnDolr7ijTV8zs7h3rK3hcqGtu43AHGl8IiB88N/tScMBOd8kbXn2ZFfriuH09uNZULFCymyC7wnYIPwMZwrAbpLQn3AEL05ADJJ4EZbgyzl3aOIxyddIgtmVNkb5lKeXOeO9+qOMwTA9HoUCW8rxdAY0OVT/6kZT0lMnSaTcuCeznskTap/eUIHbGHAxdB3IPlnszfKD9HEkgEsAb8sNk6lKRNQQ+UKwZn6JEcg0+SP6kkRde/oY6GKTnB+nJRMVFvHXvUdopSkjMiTeVTNAWREkCaDmaCJ6dYGhdfTbIBjEQyyMd+ZE2ML8rJuw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781999354; c=relaxed/relaxed;
	bh=LVrIryE2VF1sDSS46HMWn0Px6aDg+06V1VeyZcyjwRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DCqhAVQy+aDmcQyOI+a+UhkvMHqqJzlowWZFBwaeUY4xSLQx3henIeS8af20VydKZHFVQRaLhvQzTmTUEs7ueBWgtnDU1Z2NhnVAo9KoNYJ1dHFxtCq8CFkXTHi+kK7p6NHrbOfoyxNT3JoxwoG/1BcLDFAPefsH6PeUM73a1dlEhVwbno+8xAtzK8I41Fe/xSvvTzIlBjDh1WLFpILNFsLPxE58cB2cnrQAsLKJmq1J9mWD/w7PloHstypO8zbu7doRJq2osh/nOD8NxlWeH71f+ukTf/imu4pdkkgg7E9QKOkKb+hrMVNZ8BJvYTzve85ZyL8v8gXz3RnHIRWuNw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Gx7dTWLs; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82b; helo=mail-qt1-x82b.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Gx7dTWLs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82b; helo=mail-qt1-x82b.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gjWQK0C1Vz2xM7
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Jun 2026 09:49:12 +1000 (AEST)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-519ed52bcc6so339611cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jun 2026 16:49:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781999349; cv=none;
        d=google.com; s=arc-20260327;
        b=kviJUXnmmy7Cp2e7uTX71/OFW4Yy9uSNqQaviJQnqRzZnYKtjxh1MTVe/CTI71EPLa
         OBpbFxzcpnc5mJCFTv7tELyZYCIQHGX81xXj5geKw4zOxabYOCrW0qb/QmL1Me5zebU4
         9Pm/Xj6PRQ6wsAbNuTHuCPvHzI8kcrOeG4/uLRXyAvjwVeeTY7Df8wvyglnEtXbov779
         Wo38eTcWGL5zeYhy+rQ8xedggt+c9p80m+jOH3LxOr1c+44nWirSFERLDJXWRU/9xr+F
         UdWq4TnkQtPON3hQGbbzBky1Hnc6lzJv+uHaADOL+AkJFhU1KYVn1jUqa0337EXmiDAE
         dWpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LVrIryE2VF1sDSS46HMWn0Px6aDg+06V1VeyZcyjwRw=;
        fh=PBd4mbZSh47ScZ3dGSloSbk6voYZICqQVCq+X0ImTE0=;
        b=ALoxm5SJoJO0WZvebGRgsQ2pjAv8ybxhNQeXdu/CcKe9eRoMiyoUamdN08g8wLRIA9
         9RWFxjCb9nm/rA6vHcjNVyD7yjM0HdLQ4j2vgiHdF6a4tcpsBNgum3o/Jucgb1H/vBLI
         iKzuuXwo3fdJPHDT3hpDqJQa4pOL9leWQi4gJ0WAZQJP9bGTfXzVx6eB8vcWFTL8Q8eN
         HHmwRQ7eFAVyYO5qk1m80BAcnDx3ElRjhlEdMR7I3lj0TmBwBbfiv10XNz80qioXztzu
         cDzWJWi6B4NHbxG/DzEILgZtEYUsLZ/Axien5f4CKqWhoUVE1IIkCkJw6896CsIcpWQg
         XRfQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781999349; x=1782604149; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LVrIryE2VF1sDSS46HMWn0Px6aDg+06V1VeyZcyjwRw=;
        b=Gx7dTWLs6+KqThcSiMLUFhI5JNMK+TqnVkAJlXPSLH2X7IV143bjCz9RlaTgw8D6Ip
         +shQLF8miKyPHmMvTkwkXDDwzSbCAV7wxqi10W4nEO9i8HACyha0HZV1XLna+7mTKOj0
         UlQI65iT24ii8TcTAZErWuCBOfLIK58+VMxK1piDKB+1G7KYzCEgfa+aL/+kHlrGRMiq
         NJcKDcy2vtrAHDjrDEtfNEnDJxfUEgY3It87mJdUEnJPi9J7EgfUoH36DbitvMbzpLvP
         XmdAGgWcJN/FXDJCowv1mP89nyttc+T8Tz/tDzkqi8gaJm2vGABT2PekuYFkl+IZNEWl
         sgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781999349; x=1782604149;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LVrIryE2VF1sDSS46HMWn0Px6aDg+06V1VeyZcyjwRw=;
        b=A+62wTWx2mJUR+5s5AYt/4RBQHnTE73Z4duLlic0JD1Pe+8pa6nSRiSykkRByS1/CN
         0xICsctxbffTIOVivJ9jA7GjAgq72oOtfJMlcTUTzjMnGSzm+dbFiJKZna9z8DONqAMh
         IOKVUb47stpQDpKnp641bAHAkS8f/7ihQuZ/ENP3ZmeITvhN2c60SZm520DZfSPo3eE1
         FERISHZbdFIhOD5ikF3wGvxJHRdIdhTxu5ZCH7/JrQFLjNplThVHRRtORVS9HpI/2sPH
         8jT8WSm7CphglEwn/EDINa8KIjvbwW0SLSy+ZtjH3g8P2fjXg5GwJf3eTR2IE8U72iHf
         oVoQ==
X-Forwarded-Encrypted: i=1; AFNElJ9P+JzvKcHYqWLCaOfiz8DPzW07+zwLkC1xKCYdXaL17mZ00QPIYt4h28Ry1T1cMgtgvzF9EkDmPCh5BlU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy2hTAGFGXcZfMVvZOkas/+CoiNQ1ewfZKSrckJ/E8fktNkJF+2
	Ye18yfYgmw8KRbS7B2vQm+dpUKS794d1pR1hIux2k20Bmd5PZRVSGDBjF0o0uuwi2dW5m4vyHVG
	ylCaY/L0UzK4LUq4MeB0Mkh/2lpUWI2VpZR/FD7xA
X-Gm-Gg: AfdE7cl+SJOu95iUrJiFi/emeNOD1sv2LpPN7I37g4Mw7SC+NaH8GVMiilMiGPq71n+
	87zcgbmDm78gK3hSAcZOLlfKWaaisr5nKh/m9Um285FANkUVC351VAZSyvJVDNheUUqnN9GSKI+
	VbCgWCtm8JOMv7U7mYbVDHYYV7l5YS7Hy6YGd8t4Q8ySi4ccAzoONCfphA08PbfHMMx1cN0/DgT
	Ok46iUUal06/rjLpYOHS1/7BxVNA4V70Ry02ibqtHTaE1vFLk0w0hBUxh9VhWnpWlP1f7NwSA6K
	M1NUag==
X-Received: by 2002:a05:622a:580a:b0:516:4f62:85f1 with SMTP id
 d75a77b69052e-519e4a744d4mr15890001cf.22.1781999348457; Sat, 20 Jun 2026
 16:49:08 -0700 (PDT)
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
 <CAGsJ_4xC5LdhuoWV1=tK-RZ5rkjc8aOKOkmb1L_8BG_3gtJhDg@mail.gmail.com>
 <ahB6QyHgYq8ksj65@lucifer> <CAGsJ_4zxLvZ01i19vdo0xA47T1hxa1VRYvxLmiDhy5q1GDKPRg@mail.gmail.com>
In-Reply-To: <CAGsJ_4zxLvZ01i19vdo0xA47T1hxa1VRYvxLmiDhy5q1GDKPRg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 20 Jun 2026 16:48:57 -0700
X-Gm-Features: AVVi8CdrqLszoGfh6nxxBjM6ZU4jlgAaXlfN0swetCJNc_4l9-uU6mX0T8CUJHo
Message-ID: <CAJuCfpHTxaU4KdNmefU7C7cWZSLCFDLPdUrnqV6yzxzN+8RQ0Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Barry Song <baohua@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, "Liam R. Howlett" <liam@infradead.org>, akpm@linux-foundation.org, 
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
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 2:31=E2=80=AFPM Barry Song <baohua@kernel.org> wrot=
e:
>
> >
> > Again this is making me want to sit outside and sip on some lemonade an=
d
> > ice :)
> >
> > Yes - android processes are aggressively multi-threaded, sure of course=
.
> >
> > The missing bit here is the forking - what, where, why, when?
> >
>
> I really want to know the what, where, why, and when
> as well. But since most applications are not
> open-source, it is basically a black hole for anyone
> other than the owners of those apps.
>
> Let me try to do more investigation to understand what
> is going on, although it is really hard.
> To be honest, I would rather the Android framework
> completely prohibit apps from calling fork(), if
> possible.
>
> > And then you say zygote is sometimes multi-threaded but sometimes
> > single-threaded, which is adding a whole bunch of confusion on top of a=
ll
> > that.
> >
> > I don't find these stack trace dumps all that useful (though thanks of
> > course for taking the time to gather them), I think we'd be better off =
with
> > specific data on forking, in some _concise_ _summarised_ form, ideally =
with
> > numbers.
> >
> > There's such a thing as too much information :))
>
> This trace shows PF I/O in one thread overlapping
> with a fork() call in another thread.
> But as I explained, I really do not know what kind of
> user behavior is behind it.
>
> >
> > Anyway, again, please let's see a new _RFC_ with the approach proposed =
by
> > Suren, with some _succinct_ data demonstrating _exactly_ what the probl=
em
> > is, so we can make some headway here.
>
> Okay, sure. Thanks for your patience.

Just checking in on the followup plans. IIUC the RFC mentioned will
try to implement the solution we discussed at LSFMM: splitting
VM_FAULT_RETRY into two flags - one for retrying under per-VMA locks
and another one to fallback to mmap_lock.

Barry, if you need any help or clarification, please do not hesitate
to contact me.
Thanks,
Suren.

>
> >
> > And now I'm off for a cornetto! :)
>
> Sounds good :) Enjoy your cornetto!
>
> Best Regards
> Barry

