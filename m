Return-Path: <linuxppc-dev+bounces-24546-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7FDC44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 22:01:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3vc06gL2z2xJR;
	Tue, 21 Jul 2026 08:01:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::530" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784584880;
	cv=pass; b=HeMwESgbzbFq8PMC8VfsmJkLFZjzgbKM4Ipt2B6nqVridgw1o4CL8uoT6TKXGRd5AW0OM8rRSOqZgqx1t0gvJeDjYwbCju/5Wm5l/u5DlVIfPwLAZtImWWT45aVBe3cw0uolze1wFPp5BGRjshEGemuzM4x7/BCjU8MWRxl3O/oQSF+uaaI/wjFcEMZvnD2eshi+lLch6L/lr20tMPKusQubGyhDE+cUjopBWDzdxUJPDxXIhSDXw1FQFgYeyUVb3Mkf4Q5X9zpc2VTUCiDmAMtaLQ5G77Ecki/38KSkC+u9a4pnMm4wHt1OT6L/pLSEoHgsMmSb9MwO85ZTcDj3OA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784584880; c=relaxed/relaxed;
	bh=OFKHaLiuiIMT2s5Bf3SZwWbn7++lylaBZHxfNpeM7Fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hD+NHKDmcTxEYhplAFtdKQJvhpIP48RTi19553Xg27MauipnYPKJDc9hNKhxY28efjqChDL0XYd8erJS3dJM3NhWDhIbnGqYAT0YyfL95vYa198Iu8Yg7aoUN3eY/BxuBMiERCym3OhTrcJtLJzFN+RIvnBMjETBUbk6bsPhQIzH+hJoloLyGZJjeSSCcaznDqT28Kb7V+O6gdWt4ISadskxbTMT9gLIlMA7l6klZjVNr2yLSlYEzl4n2GDkuRcLI91rZoL1bg/iSi1rPkFifWVZ1mF5WmymGUqF7ryqNcj0pp3LI0Ts2RqdhXjtkc+rx0/FB0g3mXHIAncei0BHEw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NF602+Jg; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NF602+Jg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3vbz6LKFz2xFc
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 08:01:19 +1000 (AEST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-697cee2eb6dso7540501a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 15:01:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784584875; cv=none;
        d=google.com; s=arc-20260327;
        b=k8E0o81cGTmcjjGOLOOc5U1Io32P21tWScT4wIVk7lBLqburIjQSolGJQqTCB8vZyf
         dSvXWFp5RFHi7I0eXN0//1dPvOYrS3oMliC528fEnPd62mPieH4yHUx9FHNnGK9e3bzx
         dBZv2TqIKdTFR3PaTKyFgqa0umCZ9B5/P703gMjOD2teHbij/UoZxGueefQEZd8PFPMt
         wquyvj8wDTbzo19fjzTdEW59o9LhcYzNdCE7aJksr8BpnjM5mkaqmV54DbKvCT/8BgIg
         65Yt6j9KtF3EYkBml9j4Yzl/e7GybQkpMH72IIdQbJIl4PMAudrMDpsjBes7Sejrsby2
         5WGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OFKHaLiuiIMT2s5Bf3SZwWbn7++lylaBZHxfNpeM7Fk=;
        fh=WeNuOUHw2R+ZNUTSF8363yqYdn9kbeSEfi6AGKYQXK8=;
        b=C/4Cvu8IQJwQD4iG9nsrIQAUvHMibNi7QR4RiOUSkgRN5fdZH9SWI6FEMB/IIHKD/h
         TJrJ+vxuTXiMVlkl3dctfeMjtS88UFJLDqsnMF4JL7wYIuINjL6TafSO+GXZOW2jUrPW
         E5dzaeZsNO/Dxjqw6PnmfjIznHbeq104nb/djJ1bgKzofP3QKQ+hQfqYO20cufw6/WGw
         QOq/mi56D343YrokUDJ1Kg+RsrjSzhccrMlpfjSruH3N4q4HCCGwevjNRwXFS1dgCw06
         JkZYeYhyjiYSFFdA5pg0yu5pQRfhqqDNAVad3L6x5XAlwCkHsbQpLGrjvb+4nTFeRo2k
         HY3w==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784584875; x=1785189675; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OFKHaLiuiIMT2s5Bf3SZwWbn7++lylaBZHxfNpeM7Fk=;
        b=NF602+Jg8rAbRUJOFSXc5FuDDKmIPPEnXp8PDNnuvlz4z5qWuwyA3hpuDdNJzhjdew
         nXFIEj9V75B8uGJJQjP58d12gVm1nqC1ITM9MbYA9tyRwZi2QX4Nm5ACyGmNvkb8DjFM
         rq6FDxXYhsCS24xU8wbi4myuEjFnWbHliyuILXZCAuDUDBmYmLL2rc4qhJZJAuoa0IO9
         JFeAtoBHjz7eFY38qwHd6c/ZJDhEJsoK9EnCubim1tkLsnqzdgn5iszvM70c9S+EiWEj
         oFT1eiGhGkJ5R/C/aFq6SkwRHliDAQm2ZfafikC8G4dTf3tQp5zdWx1aBi3eiKMRZ7ya
         VZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784584875; x=1785189675;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OFKHaLiuiIMT2s5Bf3SZwWbn7++lylaBZHxfNpeM7Fk=;
        b=T7/oTn3aH7FvxGJpZya1dRWytNLontHXx8JTVd6VvwDturVX0ujs4P0qdiMKWsULFo
         KrXcEVuho9EIpFR4wB0DWegKE7F2cojWOAkKuVc458g+lvSSjAL2ivLiR8iSEW+sm84t
         nQVY8F4qirkMGD67Gkpdsnv06MwIdlYtT7xvwA8Uxo9a6BtVMejlTRPZ7L29ScGHp2pp
         ulXgf0ly4mZ99SHPWq2AdlYQRruwFPxRFPTN2TCt+i2w7Fr4J0+35yqX07jDIYEaSlYU
         7I15Phb3HZ/7NBTILI6uY8ATK+h4PWTLLT2aJZ0/TgZsdinYqVISzsjowmJBy0e59d3x
         JDCw==
X-Forwarded-Encrypted: i=1; AHgh+RoX+cQ1pmypku8DzB3HCAg6oP/jmjD9QtrXMyKEhAUamfpVCQ77EBsVRmEmthPQsVCq7qAaxr3j6S7m2YA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxWX+VNO3lLjQ03eEzdHOU/nEGfE7hyCUo7MGnVz+5Nqe4i5eJ1
	NBFYKve1eLkeqF7bmjgm2Cc/qTo2S7+uZGJGxwsM+i2uDjvwoTEflGUDzYIBNC9vCuso3q/dbVz
	ObKWlNKHfZh/RuhQ5r6nWT5v/DIZ3UhI=
X-Gm-Gg: AR+sD11v4QUuuZduRC8rxh6JycVoGSEr2UXNTYgaDNlwDVk4P63EvTozGGOoMksi1Kp
	4SYxYyWA9Sl0hVhexaRt1H0D/o6qDhnsfWt6WFVnptbzpEu0UQlWeVkeCJ0NWbxA25FxfXjM7cT
	fU/D4JWJCpc6ETzSeUz2O3S4IuwQAsFlcMRsA+gjeHP0C5V9BDWVd4xXKe2pnya+uTQyI71s9zr
	bL306HsHUCgXaVQ8KOuk/72ku+uAoVwQ/PuVS9rpER143UAqxUM+TN0tNdmqZ3Hnr05JVwzdESx
	kAzXF+YqjClFBu5ZiWmRzj/Jq4SpFik=
X-Received: by 2002:a05:6402:2356:b0:674:5b2c:d42c with SMTP id
 4fb4d7f45d1cf-69e6525c770mr6536246a12.3.1784584875096; Mon, 20 Jul 2026
 15:01:15 -0700 (PDT)
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
References: <20260707181957.433213175@kernel.org> <CA+=Fv5TDNH8+JAojV9_W36kUkEE68uiA00FQ7i0vJunebqs1sA@mail.gmail.com>
 <87wluplb6k.ffs@fw13>
In-Reply-To: <87wluplb6k.ffs@fw13>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Tue, 21 Jul 2026 00:01:03 +0200
X-Gm-Features: AUfX_mw5696pn_wiz_LjCaJHiFU9IchwhNNUbBWmuIdhtqSFIK3TJnj9-atYCBw
Message-ID: <CA+=Fv5Sd5+-K3-MOiEc2N8z_5CoLQPVPUwjiugSj3u8cBWJXXQ@mail.gmail.com>
Subject: Re: [patch 00/18] entry: Consolidate and rework syscall entry handling
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Helge Deller <deller@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>, linux-arm-kernel@lists.infradead.org, 
	linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-um@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-arch@vger.kernel.org, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thomas,

On Mon, Jul 20, 2026 at 9:21=E2=80=AFPM Thomas Gleixner <tglx@kernel.org> w=
rote:
>
>
> Similar to what Peter and me suggested in the related discussion
> vs. s390 which has a similar issue, you can just have a dedicated
> syscall_return member in your pt_regs struct, which is preset to -ENOSYS
> and operate on that. You have an unused padding entry there which means
> it won't even change the size.
>

Thanks, that makes sense in principle.

One complication is that my Alpha GENERIC_ENTRY branch already reuses that
former pt_regs padding slot, while keeping the pt_regs size and stack
alignment unchanged. The extra syscall-entry bookkeeping I needed so far li=
ves
in thread_info rather than adding more fields to pt_regs.

So the padding slot is not free in my current branch. I can still look at
whether a dedicated syscall_return scratch value would be cleaner, but the
tested version currently handles this by setting the default -ENOSYS result
only on the no-dispatch path, after generic entry processing, and only if
ptrace/seccomp/BPF did not already provide a return value.

>
> You were on CC for the V2, no?
>

Sorry, I must have missed that.

> The whole pile including Jinjie's seccomp bypass fix is in
>
>     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/entry
>
> and is targeted for the 7.3 merge window.
>

Great!

> If you want to base your stuff on that for 7.3, I can add a tag which
> makes it immutable so it can be pulled into the alpha tree.
>

Yes, please. There is still some ongoing testing/review of my Alpha
GENERIC_ENTRY series, but assuming it is ready in time for the 7.3 merge
window, an immutable tag would be very helpful.

Magnus

