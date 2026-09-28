Return-Path: <linuxppc-dev+bounces-28358-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1A9CA5FA2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 02:48:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htQk21yyrz2yQH;
	Mon, 28 Sep 2026 12:48:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790563738;
	cv=none; b=kgBZHkDzjgvfByT0b6bs/eM3sdEqcvFvQCCR00qnmcK3s+RJUgasvj4GPb+C7PuEYism0xSXCNtghUlXXrHFzEWSTekqodN/FWFW5pUC31xoqNrf8SrlpQvKtr+092zZ4pfPVdR6U6ZcrSwAl90FM39vKGFZXctvFFtTfqxbOQX+NApoVvQ8cxsnbag7yuCxY1NN/tsPNzbSG8gs+coQj8cAlRGDCDjACab8A8Y6Wm2IUIuvYWHUzRV4CLH3ul3Fs30FrMwhiigMbQqy11WN8LaIJYh3xVSFS1Q4Prfn7Xp+ZOC4UrijeogPcX6w0E31gEvXM/TiyPegdYtKen/F/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790563738; c=relaxed/relaxed;
	bh=YZXmNamni8YTdkgj3WsVi9gU+V406f6mQymnA8E88y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c91lFJPWGEVnei2AwY/m5Vv8M4bPMI6tDuRi6cH75dIdF4vDFUo5Ru0MAX5GBmR63qcV+mjc4qFaC7yhr0DhtDGWUUKiGeOUlThGrgNrv4HpQ5DoAl/Lw9siBcNwO8nVKb6pBTt3HN1zs8527ve0LnoONHurbDZb1k9D9LFe4e/7gw38BXUxZRFQyE2YiJpzdf9GtVNGxyUNmL8+hysrnhTZ94dMNwIVw8iz7tWmzVLXrdYgOtGXkk4uYlHgZfp6Fg8DCspXwMEHt8zAivIfLvwVgOp3GrsORSpasl4gXPZyD6qvFKu1uklvQDNiRNe9LeRH6wZYnUz7y1MLDutYgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O25pkvFH; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O25pkvFH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htQk10Kfzz2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 12:48:57 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 94C6D43F3B
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 02:48:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749A01F008A4
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 02:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790563733;
	bh=YZXmNamni8YTdkgj3WsVi9gU+V406f6mQymnA8E88y0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=O25pkvFHPnrIrFqD4jTGb58pzeF/yYdz+xqlud6LvYLra40cEEfQW5YVOGDAi1+yq
	 WtTq52ls8MYgjOKyFspGXIbInelB+hKEBDO5TT0OWe6OZGinzQp6HhGD4F67v+hvqY
	 ppriEstVjVqnmzJeKR0y48f9O0JuR6ACyGsS0llxzK9xjAUnxKguffRUk1P4tc/dp/
	 wCimEJYqg5qIHscksIE7jZ3a1BOFofxmNWSzDrcFKKWrM7NJWA6eTM089/fvoaCIEX
	 Qp6vJhZJ97UA9xb1WCxQ+x8+nm2t4+LeXDylaENFl4AjkT438bc5izWWWaXpPHyYoQ
	 1/ewTcsMuEi6A==
Received: by mail-qk2-f38.google.com with SMTP id d75a77b69052e-5333729ca3dso11688471cf.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 19:48:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxciK4Onh3gtc6omfzg0ruE1xbQYmtdh9srJLSJTIWJeZdY11Vj/qQ1I0RI8i15Ys5iUkGGEIAErix2Y8Y=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nknjHSIYCnHrlVgrJ6cFr/QMzLF9QxdkTD9it3cwCkDKdICItq
	aBf849+3xTeWGl/rBv2b3GDsI1seJLcr6xYsxLJ27MEO00ppXZ5suy40VVYPKnas19s1l86k7Ut
	P0YixSpyHQ+tUykAl1tR5U3I/WgH23qs=
X-Received: by 2002:a05:620a:2614:b0:93a:2bdc:cd57 with SMTP id
 af79cd13be357-93c43b7f72amr1824335585a.2.1790563732750; Sun, 27 Sep 2026
 19:48:52 -0700 (PDT)
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
References: <20260911025613.1220845-1-zhanghongru@xiaomi.com>
 <arFYRAa-i7CIwmHL@gremlin> <arF-E3Nsw9ZliH0t@casper.infradead.org>
 <arI_w2wTfA00Mgy9@gremlin> <armexcXDiG8ryZd6@casper.infradead.org>
In-Reply-To: <armexcXDiG8ryZd6@casper.infradead.org>
From: Barry Song <baohua@kernel.org>
Date: Mon, 28 Sep 2026 10:48:41 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4xuFi7K+crAcFQ998SxXS0xPM6QeA34JV+6+Sy005rXLg@mail.gmail.com>
X-Gm-Features: AclHuK-KBiQtm0KE630BoXAk92dmhRT-WqzJYFoYV9V1f9Qw5fyAD0u8MfblD04
Message-ID: <CAGsJ_4xuFi7K+crAcFQ998SxXS0xPM6QeA34JV+6+Sy005rXLg@mail.gmail.com>
Subject: Re: [PATCH v6] mm: retry page faults once under the per-VMA lock
To: Matthew Wilcox <willy@infradead.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Hongru Zhang <zhanghongru06@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com, 
	david@kernel.org, liam@infradead.org, mhocko@suse.com, rppt@kernel.org, 
	shakeel.butt@linux.dev, vbabka@kernel.org, zhaonanzhe@xiaomi.com, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, 
	chenhuacai@kernel.org, kernel@xen0n.name, loongarch@lists.linux.dev, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-riscv@lists.infradead.org, agordeev@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, linux-s390@vger.kernel.org, 
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, 
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de, x86@kernel.org, 
	hpa@zytor.com, Hongru Zhang <zhanghongru@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 6:55=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Sep 22, 2026 at 09:55:23AM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Mon, Sep 21, 2026 at 07:57:23PM +0100, Matthew Wilcox wrote:
> > > more to say on this in two weeks at Plumbers.
> >
> > I look forward to it :)
>
> So while doing my slides, I realised that what we need to avoid doing
> is (a) sleeping while holding the mmap_lock (b) returning RETRY while
> holding the VMA lock
>
> And that turns out to be as simple as this patch:
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index dd09c438fa23..94ed2333f8d8 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -723,6 +723,8 @@ enum {
>   */
>  static inline bool fault_flag_allow_retry_first(enum fault_flag flags)
>  {
> +       if (flags & FAULT_FLAG_VMA_LOCK)
> +               return false;
>         return (flags & FAULT_FLAG_ALLOW_RETRY) &&
>             (!(flags & FAULT_FLAG_TRIED));
>  }
>
> OK, this is a hack.  The function is spectacularly badly named, and
> needs to be renamed before a patch can go upstream.  But this should
> fix the contention on mmap_lock.

Thanks for your suggestion.
This is exactly what we did in Android Common Kernel before we had
Lorenzo's proposal (bypassing `fault_flag_allow_retry_first()`):

https://android.googlesource.com/kernel/common/+/1b9b045a586245cc1c29b2747c=
6586234c7f5bad%5E%21/#F2

At that time, we couldn't modify ACK with a GKI hook that introduced
a new flag. All previous versions of this patchset introduced new
flags, which would have broken the KMI.
So we had to choose between two evils:
1. mmap_lock contention
2. VMA lock contention
We chose the lesser evil =E2=80=94 no. 2 =E2=80=94 and sent the Android hoo=
k for
merging into ACK.

Now that we have Lorenzo's proposal, which doesn't require any new
flag, we are adding a new Android hook just to mimic what Lorenzo's
proposal already does:
https://android-review.googlesource.com/c/kernel/common/+/4307957/3/arch/ar=
m64/mm/fault.c

Note that Lorenzo's proposal avoids mmap_lock contention without
introducing any new VMA lock contention. It also doesn't require a new
flag that would break KMI. So this is clearly the preferred approach.

>
> Could somebody try it?  I've verified it boots and runs some userspace
> fine, but I don't have the workload to test the contention.

Both Nanzhe and Hongru tested it before and reported the fork issue.

Best Regards
Barry

