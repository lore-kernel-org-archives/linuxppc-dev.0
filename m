Return-Path: <linuxppc-dev+bounces-19112-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F14010F92FA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 20:15:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flfVj38fzz2yjw;
	Wed, 01 Apr 2026 07:15:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::831" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774988109;
	cv=pass; b=gTIVMDpCL87N1hHBunP7sgBAD5lNdpTuee94HPMEBrKwmb3z+6ZlosJgKeakgjSrdJqVNvNRrsBk1NrjcDJfdUMOM0GgyHw0ioNw4MP05wn5Yxfx/chRa5oWdHBE0QYwMokRY134JqA6CGohFlKjmcNzuT3hz9B5jCJHR7x/GFwuGlN7fkkYfFRl9veti05Av3zkho7rCDHI8T3GsVCn2dJefqHNArX4Bh3d5l7IhcYKld+5NM/mGkqUdLWxkCboXVfesz1y88lfgmReDp4CqtlKgG+ilVs2ZJ/1iEijVXpZcGCreMeZxNwAx4QdKCdEaa/IFT1DOZhKuvHkrFzsTQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774988109; c=relaxed/relaxed;
	bh=RwVpGG9S8p/uX+u7seQVpxC4moFh4X8htIhQDky5uWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjSfKJYwkiMOyRkW0GUf/aqy+b5VOHrqmx6+X15GkyeeZjivQwVodOApMfBHGUHXNz9Gy/flQ5DoP6g9WcYn6ITEuYpfNhKcucTwR39HuiIl73m3G4Gf1BOJ8JupKe7Nh5FqkBHnetnffz1kjwXZD5P7arRZ+gHGW37ehQc16YunH6IqYKptjdh+yCyA5ggM2ZBoOqvUqYq+pBlHkSKtjFPTtkwGBPPNWOX/OQo0678mSsZefU9jPJoxTBnbAujNanUPcnmC1mekm6o3OyzzZzuoM5j6ENrjdQqCtEvLJj4LG0jI4GHYz7SVaWz2q3ajOzxY5P5Q+E8vWjkxZoJDRg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=I8Crn2zy; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::831; helo=mail-qt1-x831.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=I8Crn2zy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::831; helo=mail-qt1-x831.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flfVg5jHpz2yVL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 07:15:07 +1100 (AEDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-509062d829dso755681cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 13:15:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774988104; cv=none;
        d=google.com; s=arc-20240605;
        b=gLLy8uCVERrQT5GzgirbLPQtEHTCuGrhB9VWuFFgxwWc0xJYEALeohARHI5hcNr18L
         Fv7x8cMPNcDzAa6DCYl0q3jPJUxMi2g8TOZqnjrFPEPioSRgESPrjPU3O0TKngvIvd7A
         NZJLBuOltoriMNGz7zTPRbbLBwE0H9HkgdCbFGPZOlg5ZGOCfO1Zoe2DYhAHqAI73aEd
         mWffG2awgI/jKOzQJKwDrgDcx84Sl9Wuf6jOt/eIDv33pRyL6ztlyn+ySj46SG9/0Voi
         15CmGcFmTC99oFMY5/k47TBZuemuirusSdWUIogItsVUU5rHElMDhN5wVU1mLU8nlYAQ
         dQJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RwVpGG9S8p/uX+u7seQVpxC4moFh4X8htIhQDky5uWk=;
        fh=7Gh5lk/yQIJTQu3XeMEHmco0NM4iaS8oRUt9SBh2dYU=;
        b=aaxjHaczpJZBjj25NaWTzP3jMC1q600YESztXz1EHZREjSyz3DpboUff8OJzOfndHq
         iOTXD1BZllOaL0cmlcniBXL1wPsUbNynkTkRt+uitdTV6ye+J3pEGutbV/C+jetXAZ67
         xQyjYGAUkXLURQ6G9VURJC5jlOX8PTKRpjN6+LRiazeX3kvTR5dSl/9s6iU0o+qclB0v
         AIKEIndaMQErM8EnMS7diLGFXWiieuSvNvtyrFAzaofITutFAJc/w74XQRvwinUYF0s9
         bHo3iwqJ6/edfe69oWLlv1TbP1FhOfgkXahGMwhC8KUFN1nAhB+6JxoyGXLeOfw3oFkJ
         XeFg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774988104; x=1775592904; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwVpGG9S8p/uX+u7seQVpxC4moFh4X8htIhQDky5uWk=;
        b=I8Crn2zy5SGQsqTyHOFXskcZuL3HbkcEc2Tw900qzAcbQ9D0pe2I13DTrUxwL8J9+2
         k0T1x4U9P0uc0psZkZEBphvxg1EHbtc7bhKtyngWqSI0FSf5tWhrcGJpaw2VBA+aQwAE
         ACxCPfYcTYPIG9+bKXmO6+8tebvTeNwlGE4qcrPnemeM/Hidd5o+yAzVPurdPCDOqR+0
         nTzUqeahR5N0V8TirkatocoMl5L10HMVns6sEQDrNZ+OQ5aPpipI8FrfPCOlj5l6IkLT
         +8ZBa+PJnvavItahFf0+28o7ZymHWzHW2X5duHW61n6B86OHy7mcdDKj1ijbDaTmJ12D
         rYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774988104; x=1775592904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RwVpGG9S8p/uX+u7seQVpxC4moFh4X8htIhQDky5uWk=;
        b=QwtVKVUlOBXPlfIAW1Vfv96u7dyd1rxze3NHBvpQv4dwvnJ0PIj/U7zZxjv8cPx/wg
         45f6MdXl8F27cz7IjXJCdApq9pi/g7kS+jVkUzllCTZnPJdemC4XpuDy7uDnN6XDYqIX
         n6BPWEgAfQCjVVm5tBMptW86ezBzvRAJthUVTxbLR4/QkaYEBTADuW8PB5S9DiwUddYm
         vqZHUKx37uCOvWiVWv0del3z5rFm5CGkexCHMpEQVKSwzW/JVEEsuPJYH3P/nP3V17n5
         uRN+u0DyqQI19IWF9hB+lLa+87lmY2N4yMP8C0YWAL/d0WrDfZTp4DGVdhhwU9fLcZDY
         QqyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgIl2ozQX+oIlY9XXbw/JA+1Bmz6KM1F8+DWgitb+hjEbz9oZyzCvCacaAOdDUQkFGsc1skeIL3wTuZRk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx4n2NI13uJMrLQGLzMMFVU8cWcvBOVrrweD84Bb++zapcj4nUU
	Izp3sdXozC8j6noKDgQC10G+IWYyLQkzUlzgtu6oa9Etg/6R2S/jx3zZ2AKkyZpfFXpy8aOfUml
	CuXTmJ8NNqf9kFrgvSnpq0dOiF1eeoq2AaXBVg1UA
X-Gm-Gg: ATEYQzwg6hL61B3PHYyq0IJ53WE2FJMGnp760Kdm/07ZeHPBvZL/YmHV8c0FOh7lDmR
	d7LtN6e1Qprmla/iFnSSo5HT+u0QqM0QZ8DEROHJh1fkLfssBLYCYDuSJiemFXG1xguEsN7TSX5
	n/Rws869N6LYD3px09zrqPwhX7uKfxuGZZ30GOOnzFz09t3hJn3cM5fu3l43XtVrEm57L9C+oo8
	zvsKWSb0h9KbSPVJixpTuPH4/wh/Ue4aoguko41lvSJ8pa2U7Gg/STEjoqWWL6OWn2yF8jre8T/
	g/D1mGCZ9lI4bFzlxdr6wyQ4sO52eWlMij2H/Q==
X-Received: by 2002:a05:622a:a987:10b0:507:35b2:6b9 with SMTP id
 d75a77b69052e-50d3b7cb8ecmr5105641cf.7.1774988103375; Tue, 31 Mar 2026
 13:15:03 -0700 (PDT)
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
References: <20260327205457.604224-1-surenb@google.com> <20260327205457.604224-3-surenb@google.com>
 <5d90d998-9b8d-435c-b684-260600311797@lucifer.local> <CAJuCfpE5w8r_6Ss=5ZPrEb1RQOTG6HyY8Pivac=iiyqFRZvD4g@mail.gmail.com>
 <20260331112921.854d4f6cc793dba0972ee9f1@linux-foundation.org> <cf6975a6-336a-401b-b122-b9597b5710b7@lucifer.local>
In-Reply-To: <cf6975a6-336a-401b-b122-b9597b5710b7@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 31 Mar 2026 13:14:51 -0700
X-Gm-Features: AQROBzB2U3UmDFrQdi2wX1twdn7twB7j7RYY85tO9ykEBOm_M_3vRiUWXjbFQEo
Message-ID: <CAJuCfpH2eomYbZ0DzKpkae5DKVF69aRsfXx3HzMfPc6cTT5fTg@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] mm: use vma_start_write_killable() in mm syscalls
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	lance.yang@linux.dev, vbabka@suse.cz, jannh@google.com, rppt@kernel.org, 
	mhocko@suse.com, pfalcato@suse.de, kees@kernel.org, maddy@linux.ibm.com, 
	npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, 
	borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com, 
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 11:47=E2=80=AFAM Lorenzo Stoakes (Oracle)
<ljs@kernel.org> wrote:
>
> On Tue, Mar 31, 2026 at 11:29:21AM -0700, Andrew Morton wrote:
> > On Tue, 31 Mar 2026 08:01:11 -0700 Suren Baghdasaryan <surenb@google.co=
m> wrote:
> >
> > > > Instead? That is, assuming we really need to care about this at all=
.
> > > >
> > > > But I think I don't like this change at all?
> > >
> > > Yeah, this was the part I wasn't sure if it's worth adding. With your
> > > vote confirming my scepticism I'll go ahead and remove the parts I
> > > added to avoid extra vma_start_write_killable() call (3 instances in
> > > all) and will post v7.
> >
> > Thanks.  I'll remove v6 from mm.git and shall await Lorenzo's advice on
> > v7.
> >
>
> Ack, if we just drop the problematic bits we might still be fine for 7.1 =
:)

Let's get your cleanup first and then see where we are. I also hate
the way I have to report a fake error code, so with that cleanup the
patchset should be much nicer.

>
> Cheers, Lorenzo

