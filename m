Return-Path: <linuxppc-dev+bounces-23999-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E714C44506
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 09:33:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxRTr290Pz2yS4;
	Fri, 10 Jul 2026 19:33:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::c2a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783676016;
	cv=pass; b=i5rlHpMlZ3WfZS9XRGKdnKJ87DCFmKojvSI1RHiasXb4WrpmoP/0hVvRVNkKaqGPWqVDmef8fLWEV3TLoWXgjxZjNfADZVS9z1nincq5FR0zJVWai4C+raRGssabDISGyPuPH1D3423kttzmCG5+3hd3BFf3owhb5XuDwxiqyvWPg780WIljMbNPLKa+x4RCmCHdkf5RWq9WBzfHrX7IiwxJNa+3eBUQH+ymv7YYJNkkx+8Gl0TeAxI/beYeSjhs+rCSwt4TgY0Rf9xORx5ms1X5od0JnuRHkWWHHj+kwk/3BZu4+axq9aBkDiudpOA+dzedczoUyHXgHvCqM6bjkQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783676016; c=relaxed/relaxed;
	bh=FOfAMidp8rQWZVqstmTup6Rkr74TOq97Goi620POv9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I8p+oXjlu2v2SE0Spp9HO0EDpeiTkhKC37LJI2NXP8nPfSAemCofxY2EF0raiWc+DuHxBE93gIunkGJl9We2HGEZJu7t8bonMlYn3ayUUXPVyromhVuyLFRJjRe6gn1McRvQudhOd0/TGcKESRODhJfP+TwIl1vder4xYevDoWVAMAtc4/kb8xJJoIACjFajNplqZ8XpXdVcxRZ+3hz6GS7CsrwhpA+2Slsf7gAt+7btpsouk8fEuxNnwjR6kpGX7AbL6RI8pkMQrKeL6eruOtdhcKox5y7f/uSZA7YVDgSyRHW2kurdc+KtiLobTY948FF5g8jIkqMjfzFIEWLF2g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Guh6ukU0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::c2a; helo=mail-oo1-xc2a.google.com; envelope-from=devnexen@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Guh6ukU0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::c2a; helo=mail-oo1-xc2a.google.com; envelope-from=devnexen@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxRTp0Kznz2xlt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 19:33:33 +1000 (AEST)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-6a1888969ddso452378eaf.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 02:33:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783676011; cv=none;
        d=google.com; s=arc-20260327;
        b=BtsyELySXebvyu8kuWst49MAclP+hirCG652+6LCXzGxkJq22T2VTKr/xMcve9OV69
         S5z/v28Nzi5OWG7WpNRnaCTnC6joR8J3By7GQmICHHggLQtch8z55Q1Pz0bQAZW4FigZ
         0M2J3+rA5XQW0bCMr7J5XjPgvu/QINSJjz28R5coY69EdTEoZeYzxXTPTD+YVzNTsMX7
         IVsh08MISR/IsgWzxDEhRl1zDytciOdzoVs1QXuvlqL4i92WA0cc8ORj5lpiO0mj5LjL
         sEDK7B5r81lIQQR8F8EgDi4Wtagjt9NZCJ7iMaTCZT2ZB8C3Jcs8mlyhVD+FZkcDJ5PP
         OfQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FOfAMidp8rQWZVqstmTup6Rkr74TOq97Goi620POv9w=;
        fh=CvWOkZHVC/P96/Df3wnOsYaL5K+jWBIz3r7ddywQJmE=;
        b=EB7W6CLYfQSqjUk1oANOUIfoBXhToaONkzq7avfAS5OdNOa41wMAs0NxyfYw9kY861
         fzHEJjPuY+YiRRaPmu1mYHJPROJy/FttnCMoAJ0ToPLWDaAhmO1P3JSnOAuasx7XEHjd
         XHYBed5r2DM2qITrnrs/eJY+7nOwtRoUd0diMKKMM0pMiUzfJexThsTHXa3gANobg878
         LzYxuTxBBkuf+2gZgNUcXTkFKbWK0YWwW7SragGI4naAF57hWyTonn872Z3+cF46XeU5
         /jdVdbxYufNtu68jHblk+BZ/e10uFap7lBgqxJ2oR/vYxmpXB8yGt3PUQzxZ/0kL8zpN
         m8Og==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783676011; x=1784280811; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FOfAMidp8rQWZVqstmTup6Rkr74TOq97Goi620POv9w=;
        b=Guh6ukU0OSj4saZFgOuuwVyRprasGZCfiAniHOlho1GnJpvNhi06+PWbdzhSae4Jy7
         RptRSp+yn8cjYE0mJ9RGEBJtj95mVdgOgpOhHYwEwiUxWy/s9kbTusoCTtjL66eb5EgB
         SlK4kgGzq6+ojksJmnXF2x1wcVibo3u8aOw7125WzcheulFhzFUZeooiLX6CtASBaB1z
         jILzFjGVJvKrgwBhOnfkHDjG/6X4fl0rXbwfotOwa0UEtMXYw0RbBbilv2jp+VGa9m6K
         H0rG0xs1NdwyuAPgK8yW9Kw6pudBjwINMQgMhVkkt7NN0Hz7BkvLzkkHTMurdTxxsVaA
         QwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783676011; x=1784280811;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FOfAMidp8rQWZVqstmTup6Rkr74TOq97Goi620POv9w=;
        b=pZvrIck95F02RfjMqx7MNBKMiYWnxpkOKyLiYHWtkSET7Gy/u4tAf4nmim3f5T6Tq0
         3iEryYiENHk/zbI5i5j/ILxQeiql7MZWACVc00kWzdvl8YyMT6RcaucPZJ4ek0PJCwYB
         hANRqeMY/JcO/Gt1bXwwqwoSUVnSsPkUSSdjRVMoqRzfxDBGGP6ikgwQFNW3qiXPCKsF
         37r7VqiaXoGISq03H45Y7fIFAHcfaeUNMPITr7YW+Q1aPbqWhsH239So0PNf3alocTA0
         uP+UKXgh6cKI+OyjMfM0irNQOWlfMQdhO6maKzs32JcdHwbI7kvriCpBy6QMWJwB7CpY
         /3jg==
X-Forwarded-Encrypted: i=1; AFNElJ808je0u2ez25w5k5pc+Wvh6z6IYJkEPv2JgRf/QNbSUtcS5e++Tk0r8zTXwf/s95g1r4i904vesFmg2TU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywe/TZSui3MalTv7q5mpn68FXe3wPgZVpBcM/A+q35QJpzhnZlf
	kTp1OD3kj4GLvTVgs1ha4pd1EHFB6eV0LlamBKuxT5W2MLp8SHpXvSgMpM/C5Ah0h01YCmB9Ou6
	2Kbk7h3CGJph6G5AOdaQ6T+Tin5NDP3A=
X-Gm-Gg: AfdE7ckxfhDOLGvp8XanUK3w7KGuinnkJRfLX7m/glLYXVWSTlSj5FcvegfMjf4/jYg
	lfkIB2fXX1i+0TlhbTZlzpuht2EAd4d0vyPed8XFb0a1602Lo3Uz4AYd8Cs8WnBPcf+ykjVuOGs
	wMlh51/9fB+yVm/xqnw+rq7oF1eILpjp/rNt14OY2ZZyVhrStu2eW55V8lkcwOZybRJlIEyor7v
	bN9pDHpuJXRt2f5Zy0X6scTegCVyKtlpj4Tb88eWNV9HK+E1UX+tK5dOeF+u1H2VcTSBmOXjLGM
	dHOPW3Qnm3pWA77lggprUi7GCcwKSuo59x2TxQ==
X-Received: by 2002:a05:6820:a09:b0:6a3:129b:e617 with SMTP id
 006d021491bc7-6a36dad9b1fmr6981190eaf.71.1783676011361; Fri, 10 Jul 2026
 02:33:31 -0700 (PDT)
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
References: <20260706203128.162335-1-devnexen@gmail.com> <ak0YI9KjSstnj9rJ@lucifer>
 <CA+XhMqzvFtLq1OT-qh207aJhSf+okdE8o8Joe8e_KBvdCjcQfQ@mail.gmail.com> <alC3HqLVTBA92Prx@lucifer>
In-Reply-To: <alC3HqLVTBA92Prx@lucifer>
From: David CARLIER <devnexen@gmail.com>
Date: Fri, 10 Jul 2026 10:33:19 +0100
X-Gm-Features: AUfX_mztOU5_jS5IjGzUbvmTi3ipFisydF61T_Ppm1lypDXePa4kecWsqywAZ5E
Message-ID: <CA+XhMqzvW=Ar__NFVCLEcJYUnfmnRhTEtAV_iT62U45B7tAR6A@mail.gmail.com>
Subject: Re: [PATCH v8] mm: pgtable: free kernel page tables via RCU to fix
 ptdump UAF
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Dev Jain <dev.jain@arm.com>, 
	David Hildenbrand <david@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Ritesh Harjani <ritesh.list@gmail.com>, 
	syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"

Hi Lorenzo,

On Fri, 10 Jul 2026 at 10:13, Lorenzo Stoakes <ljs@kernel.org> wrote:
>
> On Tue, Jul 07, 2026 at 06:08:49PM +0100, David CARLIER wrote:
> > Sure thing :)
> >
> > On Tue, 7 Jul 2026 at 16:19, Lorenzo Stoakes <ljs@kernel.org> wrote:
> > >
> > > Hi David C,
> > >
> > > This has been through a lot of revisions so I think for the sake of expediency
> > > the best solution here is for me to grab this and fiddle with it a bit then post
> > > it out myself.
> > >
> > > TO BE VERY CLEAR - I will keep your authorship and attribution :), and simply
> > > stick my name on a Co-developed-by tag.
> > >
> > > So this will remain your patch.
>
> Apologies, but the approach I'm taking is very significantly different so it
> would be problematic in terms of patch provenance to do this :(
>
> I will make sure to credit you directly in the commit message so there is proper
> attribution, this patch and follow up stuff has grown a lot (been working on it
> all of yesterday afternoon/evening + this morning) and need to ensure the stable
> stuff is backported etc.
>
> Thanks for your contributions here, very much appreciated, and sorry to have
> messed you about on this!
>
> Cheers, Lorenzo

No worries I understand.

Cheers !

