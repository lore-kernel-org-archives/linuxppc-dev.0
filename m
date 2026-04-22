Return-Path: <linuxppc-dev+bounces-19982-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0D6FA1FFF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 22:17:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1D9p1SVTz2xls;
	Thu, 23 Apr 2026 08:17:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::549"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776896254;
	cv=none; b=TaPCcenqBB8zJybfm22zluI1U4mV/3LyU8BzG2Plc3ko6s3ud4nEfUgqisF4oT8lGGd9vwyTn+yYesuFF3HpYPAXE/4aWVN6CdJgBeLyNgi8zZRABlI1SXItoI5nXbUMBNtnPH7GOtRsL5GskxfbbLp5aOaeP1f8k/DNz6g73EP1qFNyhD2xm3MBG30eIPH5XlHGTXD+x2yTKuuWXz2w0YIU+7jCcbMFavZMoEoRw0WavJsVGP8+n2zNFnqNCZAeowQEYUfPOmc250TasHY1hMyYojJoOcebqJl3xLHLWvL5h5Cr483qIh/tlx6WOfx1dzcKDa+Gp1J8cqX8okedUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776896254; c=relaxed/relaxed;
	bh=sAdumgiA6yNqtL11BDiLeexIbnD5eT6zsyDy41hs+Nw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z0hnBdPEdC8LPQMa29IeB/ZI1ElijSx5yJVOrOXTOPHFlxswKigopeHnV5fASLCWMtX1cCKoEMxpWSnnkXz6isd9yPsjm8FjfrWTwCtgvE1MdjGHx2lw4IvAss0Tp/qWx5/FLJ5Gva4aOqaYQjp+0n6xIlvnr04zMXr2aOHu0aOONJ0imAeBwhZN7Qzchl6YRiW+BlMFDwWyX0iONKmqeC+BVT/LGl1kjlsVIBnDiCSnBRWtMwu1jBrsrf3w6obU00+xu8VorWd3rRCuPNu1wj9qKdp/5Gddr5b+1IDTr3jm1gQ9cYMbAT4m25I33OKE1sk0mc0TNHNyL4o4NWMzLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=KrgKEwfk; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::549; helo=mail-pg1-x549.google.com; envelope-from=3-ejpaqykdiu1njwslpxxpun.lxvurw36yyl-mn4ur121.x8ujk1.x0p@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=KrgKEwfk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::549; helo=mail-pg1-x549.google.com; envelope-from=3-ejpaqykdiu1njwslpxxpun.lxvurw36yyl-mn4ur121.x8ujk1.x0p@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1D9m3Vn7z2xll
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 08:17:31 +1000 (AEST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-b6097ca315bso8923913a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 15:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776896249; x=1777501049; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sAdumgiA6yNqtL11BDiLeexIbnD5eT6zsyDy41hs+Nw=;
        b=KrgKEwfkFGJ1duNIj3NOGUE44rmQkYtHo6BpmGYUPZ2j1YbRcZatddl9VUpSUtjrcR
         AfO6FCE1rGLDGGJW2PomaiqlU62zjUmONgeyoB8PwAQu/THPGNzoZveirFVN8yOqHbgN
         H3RKAQ4dqkLgtR2XtVnI4dZoUgk58wfO8ZRn9kSUjG1lq2MiPnNyk4cnyqYtAhkJm+zn
         zZZ7r6JCVUjt1MMFH9+lNdXCemly+Zvi02omsFr5qe7eUQCEr7wjrMsfIx1WMNjl0F+s
         ZajIX/ohHkD2unnlKA7+LadSP5wsWM78SQbS3ijb80pjuoK93AsiHAWoFJgOfZDfIJO7
         2Vvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776896249; x=1777501049;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sAdumgiA6yNqtL11BDiLeexIbnD5eT6zsyDy41hs+Nw=;
        b=Ajen5N3v+yhFxw0OczaG0L7e2L5EBkxtGv1jTsiQsxjcYsUZrWuqt4d7V6fiOJLEg3
         gbYlhrfCE07LwOyylWXgeQTbiKMhP9+iMCCeaS+LsXCcVzwAlzbWyv0gNhW4sxD4aewY
         2/dGlM8AHckC/soYcrOjKR6MIJ7MPSouGq0tKaD/wB/8j047PuIBQmsBnIMNypxm7okX
         FlUreTHGUdn/uESb5AJOewrr3Ny/TGUPUxewc1VvkX/rp6nj80OnKqZjX+97NH7eYsjD
         7p8BMymBJeGytBLCQrXzQeFJjwodv5d8RdP9aK+f54/+zGqWj87JZGObphFj4GQ03OQ8
         6XCA==
X-Forwarded-Encrypted: i=1; AFNElJ9ELguTKmn5UV94+L43v8HnXHZjdCjODjoukuVAwlPLhNQf9g0FvcXWkXdvtEJVP9calrOv+/cr26yx5+s=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyWSOp/G5tfuRnZOpXyK44QsHFSUZRwpmIQJo2Lemsk8fskqlW0
	BGbOLFvBiyIMYZj/fCvTcWkirwglK6sETx9uoMYLvSrMUVpZgP4m4LqmgAD7xUhkLpPtQGegmkA
	9LJ+9ug==
X-Received: from pffv12.prod.google.com ([2002:aa7:808c:0:b0:82f:b45c:d628])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:258c:b0:398:a33a:71c9
 with SMTP id adf61e73a8af0-3a08d8d7b4dmr29123088637.43.1776896248711; Wed, 22
 Apr 2026 15:17:28 -0700 (PDT)
Date: Wed, 22 Apr 2026 15:17:27 -0700
In-Reply-To: <CAO9r8zPhxn9dUKoXwM2JHF4TwG+PeTd8GhDO_kqG+kuwRW1g=g@mail.gmail.com>
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
Mime-Version: 1.0
References: <20260408001137.3290444-1-peter.fang@intel.com>
 <20260408001137.3290444-4-peter.fang@intel.com> <aegDJssx-ZvbfggI@google.com>
 <aegF59gToidudIUC@google.com> <aegIPGYPH-nxGsua@google.com>
 <CAO9r8zOsHdsMuyjWr3XafjNnMKDci1OOdw8eJHrH-O+jrDH10Q@mail.gmail.com>
 <aegV3ELp20DlC5Ge@google.com> <aekrJrSRoclZoBo9@google.com>
 <aekw1S5Gdkyx8teC@google.com> <CAO9r8zPhxn9dUKoXwM2JHF4TwG+PeTd8GhDO_kqG+kuwRW1g=g@mail.gmail.com>
Message-ID: <aelI9_CAcZjGXj7v@google.com>
Subject: Re: [PATCH v2 3/3] KVM: Take gpa_t in kvm_vcpu_map[_readonly]()
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Peter Fang <peter.fang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026, Yosry Ahmed wrote:
> On Wed, Apr 22, 2026 at 1:34=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Wed, Apr 22, 2026, Yosry Ahmed wrote:
> > > > > Perhaps we just need to rename the functions (e.g.
> > > > > kvm_vcpu_map_page()), or more intrusively pass in a size and do b=
ounds
> > > > > checking.
> > > >
> > > > Definitely the latter.  Or both I guess, but probably just the latt=
er.
> > >
> > > I think both. I think renaming to kvm_vcpu_map_page() (and similar fo=
r
> > > others) would further clarify things, especially with the introductio=
n
> > > of kvm_vcpu_map_ptr() below.
> >
> > I don't like "page" it's too easy to incorrectly assume "page" means "s=
truct page".
> > There are KVM APIs that do use "page" generically, e.g. kvm_read_guest_=
page(),
> > but for this particular case I'd like to stay away from "page; there's =
a _lot_
> > of ugly history around mapping "struct page" vs. "other" memory in KVM.
>=20
> Maybe kvm_vcpu_map_guest_page()? or if you reaaaally wanna be clear
> about it kvm_vcpu_map_page_sized_chunk_of_guest_memory() :P

And rename all the extensions to .java while we're at it.

I can live with kvm_vcpu_map_guest_page().  kvm_vcpu_map_ptr() becomes a bi=
t
odd, but kvm_vcpu_map_guest_ptr() is even worse.

