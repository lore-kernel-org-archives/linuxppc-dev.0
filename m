Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1E2606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aAnspMWz
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jV5vb54t6z2xSl;
	Thu, 19 Nov 2026 03:02:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::22a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795017723;
	cv=pass; b=R81Cfz14QgXwASvn2yOYMvGLNfOqS7pQbV+spjqzbYX+kCxJGgNCOA99Tk2UfpP75MqWP5BpGOeVD6v73U8HSmaX3gsHAI9Ln5oEKxDxhoQ8TdNdOVRsAxlUud4WScs69DCqInuEAS3FCa5f3Xwr5+idOhNdejW4OWm7VmBFK7cp5S2vcdDOLo3KRsVXJFrkb/BgtB8XWTAerfV5w+QaXQQFGDJr3AKNZkxhuAd41aXYhIQfxT94z9c6eyEo6U6xmUlipC7/G5gETCuiOsloBWVAZoTOIkD9VPBcnNK7aEBT0L0DcuE7wzBZ7TNOClo73j3P3b9v1xf/hnYfpot0TA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795017723; c=relaxed/relaxed;
	bh=qWeur32sDG2NOrrqdHK9VIUZ28NlMpK0IoLZt7fvp/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mp1wRZguU8NQZ8Cax/34FJT4mW33J/5O3TEVW5D6RlPilM+gSk+8Kb/ypLl9q45YsUPqm595K+snSwpqVw/LUwxw9UOge7VMOW2GJL6n30uSU6vFzIuNa6EqWeAtMZXLTAMtxk5UrTf6yBXAuuTzcuUeKhyeviTAXayVXjPI0U99XqyxjyAgIBalCkySXz5ssersVQ533imTF4DkTcBpaEK+f7J3TnmbeW2qEv8J5Udy2G4Cji+05EiDwymRc+8rtGN+Ei0Qf3KdtVxjDWCiWBkjJJyEOW0UfI5iqsyXcONo9nUsS1t7U/28cGVWuCxkd0+Ktz97gd9776lqDjq/dA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aAnspMWz; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::22a; helo=mail-lj1-x22a.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aAnspMWz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::22a; helo=mail-lj1-x22a.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jV5vZ37nQz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 03:02:02 +1100 (AEDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-3ae6a0ffb55so8029191fa.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 08:02:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795017719; cv=none;
        d=google.com; s=arc-20260327;
        b=SmgUQYsXsirmnVJVnoB/7xd5uWoCQ6EdQao2BUP3ai/vzAeWwUcaK77rI4n9GmCFmX
         uR/wZ6M7IVD2dW641N1oGUiv84IzjrZeGI8Ot+zRJ0uHX1sgpP5a7mYyEFR/NbSc9n0a
         9ySs95O8TjNOCEDgS2I4sCEXqbk5UkKKmui+dPXRmfvAyh28xpM33XYQ8tCn4TqNkwWZ
         ZWHM4yVKEcFCem8gQt1YLFjD9Gye8QfOPtna02pn9urMa0Xblm+i3F0//3SsG2bKV8Or
         CIiB7SrNv3vhOg3OBFXYt+ivJVgpA/0qCWsmz5k5RrRpLQ5LXsg1rX7JAWvV+G4mQci+
         RyHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qWeur32sDG2NOrrqdHK9VIUZ28NlMpK0IoLZt7fvp/Y=;
        fh=tesLcHZWlrAcScHzyF51FjfXC7uAberehyovbiDYq/k=;
        b=PMqFRI1yaaQPAS20uy8KGhlQWIuddKmTew+jy567U7O/vd6uZAMXMMpRee370OI9Q+
         OfvH3f34hDHb0Dj5k9Q838zp6rhimaGS2ga2nI7OaQ6rgk8q+e68qLMuQn6+OOtBLxTN
         sv/pyMSAT7WSqdCW/AEzLb9myz/NIVNQ9dsyz+bqBzi6OKQ0qOzedo09Q3/eFLWshgVn
         y4dWZnHqTDpUeXREBW7PelSO4TGwurwQ/P7i7EHiSTIxsg2yi+tIj08PPjSkIQ0f94Of
         h4YCIPuC4hPjM8MlML/XMrop/YVcD6BxN/01BhNB7FG1jzdvZnyB0j4tpdVYN6j/eEFS
         BKog==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795017719; x=1795622519; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qWeur32sDG2NOrrqdHK9VIUZ28NlMpK0IoLZt7fvp/Y=;
        b=aAnspMWzRGL3oOz+8CoGUEmok86283Cze0gWFSYcM/o/nKf7h3YXxIu6YdsMrxHghR
         0xBneJPkiclrJDQ9ci7RcrvReVytMUF9y7QVrodBKXu7R/kDaiUa4Z0ZCgHOgvkleM2Z
         YJYkw9sNDWXVB7QFsb+Ta4inAm4xgGNIewnsv6ZHZ/eXgUgxZxmNJhW34s3/HY3jk0sW
         Wkdx9BsSn5tiesJpqL2f0HDSr1gEHfmBYAfrColO7OBewE4aaklSuYwz7ssSTzOiqGjc
         mF6Oh8focUEEBCqFRFEWpwyYM86OYIXzC4cY/2aE5mvtxbDcLadzETgHpTFW2+lsaBc3
         nLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795017719; x=1795622519;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qWeur32sDG2NOrrqdHK9VIUZ28NlMpK0IoLZt7fvp/Y=;
        b=yHZRJLr8KugSv3e9S+60Tz+r2gBa0bWZ0ahZIINXiJINqtOPnBXq7XF8ilzDAsjvjX
         jTS4tMR13suJ0vmbmYnW1D5vU5VSThRPGlVXcfBepHwZjQfQvCYMQmJduu484Foi77s2
         DvI3gS8KBT7Okuo24TA4SldvLFVw3fjyN+jQQI2h3vgNHZKQ3idq35eZLLxfrbLvQs+A
         qGWpun9olMSP2xAwux8d4I9O/5i/GWryoqnRxjNi3nCxvMV6VIaPz5IinFAJHfJ7RIkK
         y2cg9LRRENVPKvh3edVPKJj72H5bn63sPGDcYFBT062bzFAHwLh/sePmMbPVK5t/p778
         uovA==
X-Forwarded-Encrypted: i=1; AL+hErGhx/Lz1bVC5v3uN44MuMT38HNHyTc8ip5xqi5Pjmm4RNSJYdgncP19SFV7rYQ7vJkhy+l0r8Ime1qLVbs=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+LEBllwy4+q6XblvI138IpIEgMgZ7psmSRj9kyzManBzpi+cnK
	wFC9I/ceWfvea9sbsWdQ+SOlSwB9U4/mXIQ67ayJ0x/MGCHi4uUoXNpLiY6+exiCdfHuGLYh5tP
	qfXFzzYUWBMkwy6hL1hJ1vwF9X6YeFIg=
X-Gm-Gg: AYBFou1tCoeiHJzjsuPtsfG4o/AVMIPO+9jWeXxEt0K9jctjnAc4IHDfepYf3jvCrBj
	Cj9BQxSLzB/GAgmeX6RKp5S4Xk+bwFp8dhjzr81OwN95YdvEYGt/UEyuB8KJBROvGl4GAaJthVm
	+eiq1ZeZjricEGd1XjpX0oOiaOSLFb0lwZc++b7uXkxuIOT1d+RxRpRJG8wCa3Pe6jtsXRZFpFi
	8Jiroxn4AVvxZR6isFOYqCsb5jJ7uhCFuL2I9OE+iVRXr6/7PW5kIJ6ebvu4werR+y701+BVocm
	1QZP04wmXNKG+8sUGu3RsQ1nwH10TQjVGhsaFj0wooMKkTP/FhsmnLDRCJ3s68xxVhO5ztEOVLA
	H7jLu2md4RTdXwoaDcnu3tbzDVkCqpXJXm4wZExdZtzqL2vMngTnXohYvjKU6b+KjSjpTfMGGpk
	zOlgG/Vis6oPDuntNnXF0Y2+U74zijxguRiT0o27qFc2peZAc=
X-Received: by 2002:a05:651c:50d:b0:3ac:ddf0:f91 with SMTP id
 38308e7fff4ca-3ae670d17a3mr10433301fa.15.1795017718248; Wed, 18 Nov 2026
 08:01:58 -0800 (PST)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117-ppc32-perf-v2-0-2072e9b90009@gmail.com>
 <20261117-ppc32-perf-v2-7-2072e9b90009@gmail.com> <53a68daf-e694-4c88-b99e-fb8a4c17c1a7@linux.ibm.com>
In-Reply-To: <53a68daf-e694-4c88-b99e-fb8a4c17c1a7@linux.ibm.com>
From: Matt Turner <mattst88@gmail.com>
Date: Wed, 18 Nov 2026 11:01:46 -0500
X-Gm-Features: AclHuK_8SbeIetAuAxVk5cUH8H6DpVcwuDu7-4JcvC6SDnui_bzwIAqMlYKvZ6M
Message-ID: <CAEdQ38HmRZUwkh2TKSW8_Vg_O8yW8JdcEbj2j-EJtq2_u4zprQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] powerpc/perf: Use SIAR for sample addresses on 32-bit
To: Tanushree Shah <tshah@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for the review!

On Wed, Nov 18, 2026 at 8:20=E2=80=AFAM Tanushree Shah <tshah@linux.ibm.com=
> wrote:
> Thanks, v2 looks right. One concern: the rule infers user vs kernel
> from SIAR's address, but a real-mode address (translation off) is also
> low, so it can look like a user address. The 0xc00 samples in the
> results come out right only because the regs are kernel there. If a
> real-mode SIAR ever pairs with user regs, the rule would trust a bogus
> address.

It does pair with user regs. On the hash MMU CPUs, a DSI or ISI for a
page whose PTE is present but not in the hash table goes to
hash_page_dsi/hash_page_isi, which call hash_page() with translation
still off and return to user space from fast_hash_page_return. EE is
clear the whole way, so if a counter overflows in there, the exception
is taken at the first user instruction with SIAR holding the real
address of the hash code.

I reproduced it on the 7448 with a loop that mprotect()s 2048 pages
read-only and back, which flushes their hash PTEs, then reads one word
from each page. With -c 10007, 1674 of 2659 user samples landed on the
real addresses of DataAccess, hash_page_dsi, hash_page, create_hpte and
fast_hash_page_return. My syscall test couldn't have caught this, since
it counted those as user addresses in user mode.

> This rule avoids it and still fixes the interrupts-off case:
> regs->result =3D siar && !user_mode(regs) && is_kernel_addr(siar);
> User samples then use regs->nip, which loses little (SIAR was only ~4
> instructions closer in your table).

Agreed. With that, the same test has no user samples at kernel
addresses, and 99.9% of the kernel samples still get their address
from SIAR. I'll use it in v3 with your Suggested-by.

Thanks,
Matt

