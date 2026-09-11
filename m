Return-Path: <linuxppc-dev+bounces-27122-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FDCC88E50
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 12:25:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhDJf1mMKz2yfD;
	Fri, 11 Sep 2026 22:25:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789129506;
	cv=none; b=BntN7u/LdeplYh9zABaAamDnU7OhCd87iY0a87Fd4UbCW6MJqd71kP80hjSUlD3pnAX2Vbnigd9iCLpgZFKQgfP/Jr/HsC1+lIdqFK2GWd8O+JmwThKYwkHasD9q1MnCgYcLZNUD8lNFhd1J9beOZm5wRXa2dt6sOJ2tDYBSsBKR+r146l7RHDocI3RdhggfvizKyoZMg44P9A5CdkEo0ot1H9BMbham1cQBiJdfyeboi98XkLJgco6OCmrgGBsdPlGvnqPMUCyH85THwjjeAekBfFZGEvAqoktWuHYr4AwYf4WjezdWloFqLApCK5Vb7jAXSdAeXkNNZb1pJARE2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789129506; c=relaxed/relaxed;
	bh=Gdz/j6t6cf9YGXTeqcb04DA8yT9v4sG/YjJhKbnHLLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iC14xXzrq/PqLGVh9ReBjP90pqTmzG7hTLom6vErTZ8/rTjlLuWT88cz8YVC2P+mI6lfpFAcDAKRllrFbC5ZBZ9YeD7Cz05WXPRHPGXZ0RaQzPCBpmvbIpD06CCkstIUanp0HOacngczkLSiMk3Q4cUfeIQ8NpzvNyw2jPvPrzZMivPqJFiV1tqHIviaWQYagYLLOqfPb8Xj7CJshkm/WLt7/eeKVsTaimKHuqlyoOXGlUag1+KDS63gX7DwkGz0YILY41YnxgcWV7ZSwELlkb9GkU+pxAtPL4V/EQ5pO89pHZ8KI7qGwL3MkTog2UzZFqPP8jxNynkgYyTNl5i8Dw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FionlYLa; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FionlYLa; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhladky@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FionlYLa;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FionlYLa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhladky@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhDJd0CkBz2xpv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 22:25:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789129499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gdz/j6t6cf9YGXTeqcb04DA8yT9v4sG/YjJhKbnHLLg=;
	b=FionlYLairhOuEOkMtE78FtbXlQVrwWHRl1si4qsUTz5QLbzpz+9M3kzApqNtazAvMRi+G
	+Ln4SOQKFV1+9drAlZr9KiMalU+bg6z4loL3pmbHI19OLlJhoFp6pIR6t1eSBqoXtZdYM5
	Rfx2H8ec0VOrej3qwEuB7GcUG2GbJJs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789129499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gdz/j6t6cf9YGXTeqcb04DA8yT9v4sG/YjJhKbnHLLg=;
	b=FionlYLairhOuEOkMtE78FtbXlQVrwWHRl1si4qsUTz5QLbzpz+9M3kzApqNtazAvMRi+G
	+Ln4SOQKFV1+9drAlZr9KiMalU+bg6z4loL3pmbHI19OLlJhoFp6pIR6t1eSBqoXtZdYM5
	Rfx2H8ec0VOrej3qwEuB7GcUG2GbJJs=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-IX5nMGywMZG3RHAQ8b4rmw-1; Fri, 11 Sep 2026 08:24:57 -0400
X-MC-Unique: IX5nMGywMZG3RHAQ8b4rmw-1
X-Mimecast-MFC-AGG-ID: IX5nMGywMZG3RHAQ8b4rmw_1789129497
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5c7d5444845so1004996e0c.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 05:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789129497; x=1789734297;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gdz/j6t6cf9YGXTeqcb04DA8yT9v4sG/YjJhKbnHLLg=;
        b=T+ryrvmnWz0IEjGKAvabCNuLfu+ZmcX9H47h7B0LwQ32IkAmx2O5rbknnnnHdmP0KL
         85p3f0gNS45dvdGYEcGZV5Hx6Y6oLV+IgdhcXctaD3hqjFrhuclzv1XhXy0J6AsIEEAL
         ABiXzDYWutECbbDk+odA0WaiXeO6jS6GLHk9ASs006Edaq9zPFj1rBCXe+4bMu8sM15Z
         wPoZcNCU0dA3r3Gosa5xrcUg97KxB78DMV5wBrAasKBYn9bVBgQS2LcYnpebyXFh6oUO
         t7gdDx/1+PPPneh35nvEM75CCODECQ3cXW82w1OLo8YjpqWKBM1wkkrSXSiTKeOj50sj
         rXyg==
X-Forwarded-Encrypted: i=1; AKwUvBwHnTfwnn+LZZVKdMLSzuw1Ilz+i2zuEjIFH3wqFGaH81JRzjN8O1lz/3lsNLQizAXlzPCy6tvIIXPExG4=@lists.ozlabs.org
X-Gm-Message-State: AFuF++miXJHiTsL29A3/sbnj86uE/MYHq00QnOypEuSN9PN/pYYzXYI+
	QFOB+AHC863hkwT/8vaqeRSyKyTBm0tyDsWjACxqfN4aJsrJV7rhoPUhPtFZnnrBKrS4aVB9FRe
	dM64XHVtD8x9V4zSfjk2vni/FJsoFBFrIBGlLo03XKcn0Y4m9PcXLGqJob21m2G6sXsnxPFgYar
	9w5sdECpehBdKpV2k0kmEPryVaTwYnIGJ8pKC9pQxEbw==
X-Gm-Gg: AYBFou2+IKIF6A7A9BEV1g7FZesaML/1uIgK2+w/YnwzHEZn+H/WNL6MDn1sMrBFEk/
	IWX6Hcqs5brV4Jr/ihCs3GijUz220fYWZWsbK0QBsutZwuwdmLNZWb4hJhWWxvzndp6B9cF3qGZ
	mu/l5UYRRn7ODzVfhtr2+OAiAqWHuS3witpWpqatxWmcQRlanrxCd1FSAn
X-Received: by 2002:a05:6122:c8f:b0:5c8:2852:36cc with SMTP id 71dfb90a1353d-5c846277c7dmr4489668e0c.4.1789129496798;
        Fri, 11 Sep 2026 05:24:56 -0700 (PDT)
X-Received: by 2002:a05:6122:c8f:b0:5c8:2852:36cc with SMTP id
 71dfb90a1353d-5c846277c7dmr4489546e0c.4.1789129496213; Fri, 11 Sep 2026
 05:24:56 -0700 (PDT)
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
References: <20260427122742.210074-1-mkchauras@gmail.com> <CAE4VaGACd2es4NPQyhbR9pMEoGiTVBSE7Lw7x9VOb1Qbpvc6nw@mail.gmail.com>
 <amsapeQ2Kp6rwPpF@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <CAE4VaGB_EhbWq8_X6FLtOx2MqoP7JEkOKkKSjKB7N--tt-sCeA@mail.gmail.com>
 <aqAMpawvpB7g1XdK@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <CAE4VaGBCmA0+28G=V_Qs37cR2GKYDUTGQWW_uRe0qvEp5io3qQ@mail.gmail.com>
 <CAE4VaGCp7A7NuBC9Hwgzs5xg3bGBuRiDC8PRCu+yXnUZEXmt-g@mail.gmail.com>
 <CAE4VaGATCET9F4XXS2oj47aNEZx3HN__Zp1CH4+ASec6BjhjGA@mail.gmail.com>
 <aqONPHH8B_z_GpT2@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com> <CAE4VaGDJy-EzD_iHeb+AQOYi9LZN1dB9OXjf7FtVWM=LWrWVTg@mail.gmail.com>
In-Reply-To: <CAE4VaGDJy-EzD_iHeb+AQOYi9LZN1dB9OXjf7FtVWM=LWrWVTg@mail.gmail.com>
From: Jirka Hladky <jhladky@redhat.com>
Date: Fri, 11 Sep 2026 14:24:44 +0200
X-Gm-Features: AcwNN1UBPJUphjsK3F5m5iBYyNxwhuRRcIIn2aRlO6YBN2SUHiGkks7JLbwpMK8
Message-ID: <CAE4VaGAq1PugOAomUnJ4vEtmHzKPt5m6VJ21wErdOf19G8UPWw@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] Generic IRQ entry/exit support for powerpc
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, ryabinin.a.a@gmail.com, glider@google.com, 
	andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com, 
	oleg@redhat.com, kees@kernel.org, luto@amacapital.net, wad@chromium.org, 
	mchauras@linux.ibm.com, sshegde@linux.ibm.com, thuth@redhat.com, 
	ruanjinjie@huawei.com, akpm@linux-foundation.org, macro@orcam.me.uk, 
	ldv@strace.io, charlie@rivosinc.com, deller@gmx.de, kevin.brodsky@arm.com, 
	ritesh.list@gmail.com, yeoreum.yun@arm.com, agordeev@linux.ibm.com, 
	segher@kernel.crashing.org, mark.rutland@arm.com, ryan.roberts@arm.com, 
	pmladek@suse.com, feng.tang@linux.alibaba.com, peterz@infradead.org, 
	kan.liang@linux.intel.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SGFL2-Uv0JiLdBWntM2w5YDgCDy6i-_6ypF2p130FhU_1789129497
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mukesh,

I built 7.2-rc4 from source with your proposed rcu_ct_kernel_exit_qs()
patch and re-ran the same sweep - it shows minor improvements vs. stock
7.2-rc4

Full results, median bogo-ops/sec over 15 runs each:

  Mode          7.1        7.2-rc4     7.2-rc4+patch
  Enforcing     68,275     70,154      71,585
  Permissive    68,082     67,166      68,705
  Disabled      99,654     100,510     101,016

The patch vs. stock 7.2-rc4 differences (+4.8%/+0.9%/+1.3%) are hard
to distinquish
from run-to-run noise we've been seeing on this hardware, but they are
consistent.

I think it's a useful efficiency improvement on its own merits, as it
does avoid the unconditional rcu_preempt_deferred_qs() call on the common
fast path. Even with only small performance gains, the change looks correct
and low-risk to me, and I'd like to see it land in mainline. Let me
know if there's
anything else you'd like me to test before you post it, or if it's
already queued up
separately from this thread.

Thank you!
Jirka


On Fri, Sep 11, 2026 at 12:54=E2=80=AFPM Jirka Hladky <jhladky@redhat.com> =
wrote:
>
> Hi Mukesh,
>
> I built 7.2-rc4 from source with your proposed rcu_ct_kernel_exit_qs()
> patch and re-ran the same sweep - it shows minor improvements vs. stock
> 7.2-rc4
>
> Full results, median bogo-ops/sec over 15 runs each:
>
>   Mode          7.1        7.2-rc4     7.2-rc4+patch
>   Enforcing     68,275     70,154      71,585
>   Permissive    68,082     67,166      68,705
>   Disabled      99,654     100,510     101,016
>
> The patch vs. stock 7.2-rc4 differences (+4.8%/+0.9%/+1.3%) are hard to d=
istinquish
> from run-to-run noise we've been seeing on this hardware, but they are co=
nsistent.
>
> I think it's a useful efficiency improvement on its own merits, as it
> does avoid the unconditional rcu_preempt_deferred_qs() call on the common
> fast path. Even with only small performance gains, the change looks corre=
ct
> and low-risk to me, and I'd like to see it land in mainline. Let me know =
if there's
> anything else you'd like me to test before you post it, or if it's alread=
y queued up
> separately from this thread.
>
> Thank you!
> Jirka
>
> On Fri, Sep 11, 2026 at 7:12=E2=80=AFAM Mukesh Kumar Chaurasiya <mkchaura=
s@gmail.com> wrote:
>>
>> On Thu, Sep 10, 2026 at 09:58:59PM +0200, Jirka Hladky wrote:
>> > Oh, I forgot to add the actual results from the LPAR:
>> >
>> > Model name:                  POWER10 (architected), altivec supported
>> > Model:                     2.0 (pvr 0080 0200)
>> > Type                                         : Dedicated
>> > Mode                                         : Capped
>> > Entitled Capacity                            : 1.00
>> > Memory Mode                                  : Dedicated
>> >
>> > Results (median bogo-ops/sec, N=3D15 per cell):
>> >   Mode          7.1        7.2-rc4      Delta
>> >   Enforcing     68,275     70,154       +2.7%
>> >   Permissive    68,082     67,166       -1.3%
>> >   Disabled      99,654     100,510      +0.9%
>> >
>> [...]
>> Hey Jirka,
>>
>> Thanks for confirming. Also with the diff I shared, did you see any
>> difference in the performance.
>>
>> Regards,
>> Mukesh
>>
>
>
> --
> -Jirka



--=20
-Jirka


