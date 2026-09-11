Return-Path: <linuxppc-dev+bounces-27119-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73BAC88E4C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 10:54:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhBJ76w2cz2yFj;
	Fri, 11 Sep 2026 20:54:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789124071;
	cv=none; b=Pwpdm2t2QIAacLjOLwBHUrjeakviar2xhQw7ITEEc7v26ifUy3n70lM4sIDDlRaKEXF7GXtKlcM3BjKLsWWeHyVLIwFV2JvSrXs/8aJbtrUlFDhjjmQOS0jI9SwZwKm1dsrYYrclwWucXkHzV+yTf936lMFaT8739UB0ruPjXVsUjtml5+xF8swUyunhnSVCk2hnP9Z4zm1Vg23UFtMSjs3sdqAeII9OOXZ/EnLhlmvN7R2sp4niaIE620i4LBgh6z2J3Q4rCwS4pFBcL3l/LQisKmryeYnJ9LR5pbmXosDSNj/2NURl7LjIiW+RJyUS9GpNABhe6rL3emXJGUFhMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789124071; c=relaxed/relaxed;
	bh=/ezMD8zfqALMimoW/fcsM54ze0Y/LEslZeze9VK8mNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4rrczYivrYPNj2vAYKcPzau2ot0r80ZHlbcpo7zrlqo5O7KbGgTrfNd2toO0QM0NgFZdPQDBPkw6MtsecGBXFmyYUJX7HF2opJjFDBmh5e71zJLYkLKJqn/AojK1aiWlki+sE2RFKEYSxUvoZRLgVsAZaJsj6xO1/L7JCQ7jOTNx2UM0zyvcx/G+CRuhNtDqlEa4XISMVZrIgSSmz8xWQFATN51prgNCfOtgtzCs9hH3eVyIdPaWTh9/NoFYe8th+bC1LnsCF5bhlcsOr54A1rUzxxqxHyRHH/vAO2mUxI2+cLWmBHECf7JOhc/btcGe7UXw5cGokbHxKbErQ9JFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TDdADIfj; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TDdADIfj; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhladky@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TDdADIfj;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TDdADIfj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhladky@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhBJ61nCSz2xpv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 20:54:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789124065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/ezMD8zfqALMimoW/fcsM54ze0Y/LEslZeze9VK8mNQ=;
	b=TDdADIfjT/S34LTdMR4nSAIvz1LZNXDWrCeFHaTprrAD7w1gJOqpFfPkJC9x8wKAenJXyo
	MeoFUbdNxInhcR9c2KA9H1TLcVlR9AiboUxlufTqVAS8q2DsTCt706+ZC9Hd4YKMEp0OUT
	Eg/A3OszqCjPMps6YY4RWhjz1wwI3GQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789124065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/ezMD8zfqALMimoW/fcsM54ze0Y/LEslZeze9VK8mNQ=;
	b=TDdADIfjT/S34LTdMR4nSAIvz1LZNXDWrCeFHaTprrAD7w1gJOqpFfPkJC9x8wKAenJXyo
	MeoFUbdNxInhcR9c2KA9H1TLcVlR9AiboUxlufTqVAS8q2DsTCt706+ZC9Hd4YKMEp0OUT
	Eg/A3OszqCjPMps6YY4RWhjz1wwI3GQ=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-V8fKuAaJMjuPxbb3O4hdMQ-1; Fri, 11 Sep 2026 06:54:22 -0400
X-MC-Unique: V8fKuAaJMjuPxbb3O4hdMQ-1
X-Mimecast-MFC-AGG-ID: V8fKuAaJMjuPxbb3O4hdMQ_1789124062
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5c82ad4977dso893535e0c.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 03:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789124062; x=1789728862;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/ezMD8zfqALMimoW/fcsM54ze0Y/LEslZeze9VK8mNQ=;
        b=o2Ji82s0pmJjVIseKKMweBR4P4ciCPTWkneY//AXuP9RxBiAAGyfAk2/q8Kr2WkBxM
         aePjnzGzoxBgOBMGLnBJWKWgBdPc17i2APGh3Ar4HTlxgP7f419TNf7mM0hbudtu90nL
         7CAohK/OZhvMV3AnvUIaz9MBq73ygguDQ2WPk7mikF9Bc07ajVZm3P/IOu+YQxOjhfu8
         u/fOuGJGTpFbDYfMqgq1EelS0fM7yr+ml/TvsCvPv4tHpaq2tFPX1fOmHEByTixm3glr
         epkhZDUQgRraAOR8ol+b75rxGqQuzmKpeSCR0fIIU0c84/K+6NjrJwi4v60gOwZWtSCv
         T1bw==
X-Forwarded-Encrypted: i=1; AKwUvBw+/HcHPzsGUS9VK5a7olcBi9pOzz9Qin9wNDyTQYzTK4wo6hktfDmVXT+M8OJ2bZ+okTh8/9z4+LKMoYE=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lUW62+pyl0CeNeJfW0o6CqPVwdIZZmM7BUAv9+cWPS5Z/WX7qF
	MR1oRO/nfCSdqy+UENje2uR33oZpMARj3ugt4eP+M709jUlNI+DCv5uxVHlconly/jnPT17cBmN
	MJeeA/L+mp+A32HrjQfps5TIzswDq+8S03BKo8ePkDjt81ehLTSxY/6TXZImQ9u1nuzcBs4KAPe
	Swxkc13U7wS+VKUksc2wzacdWeaQJNy3HPEJ6yr3WGbQ==
X-Gm-Gg: AYBFou0/Jlbz93IMCZmzP7BmaGy+tC13mbF0XS1buaxZ/YdeW3Ii7fM79w89eoliao2
	ZCgaQieWTJqGyr9f+eBkjGV4W2fl0zj/eju0pWueqjvUdtULRMjf9l54ckAyFy7iVDJeAXW2dzE
	0ulobNqOE5k+ejqm437ZkXbi80kK2JbWqdH54INpWOWMyPWljhBGp7XDNf
X-Received: by 2002:a05:6122:21a4:b0:5c8:3a2f:a497 with SMTP id 71dfb90a1353d-5c845d7d798mr4532457e0c.0.1789124062214;
        Fri, 11 Sep 2026 03:54:22 -0700 (PDT)
X-Received: by 2002:a05:6122:21a4:b0:5c8:3a2f:a497 with SMTP id
 71dfb90a1353d-5c845d7d798mr4532410e0c.0.1789124061707; Fri, 11 Sep 2026
 03:54:21 -0700 (PDT)
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
 <CAE4VaGATCET9F4XXS2oj47aNEZx3HN__Zp1CH4+ASec6BjhjGA@mail.gmail.com> <aqONPHH8B_z_GpT2@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
In-Reply-To: <aqONPHH8B_z_GpT2@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
From: Jirka Hladky <jhladky@redhat.com>
Date: Fri, 11 Sep 2026 12:54:09 +0200
X-Gm-Features: AcwNN1UmXdJHSQxrhvWcqL2EmfjS40g58LZDHLB-m2vGutzs8HsMp2xrex9Qhlo
Message-ID: <CAE4VaGDJy-EzD_iHeb+AQOYi9LZN1dB9OXjf7FtVWM=LWrWVTg@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: rAyhmRMtVUEXOLRgn4wqgpnmALkUXfMf2R0VYTpq72c_1789124062
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000002854ac065b32e80b"

--0000000000002854ac065b32e80b
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

The patch vs. stock 7.2-rc4 differences (+4.8%/+0.9%/+1.3%) are hard to
distinquish
from run-to-run noise we've been seeing on this hardware, but they are
consistent.

I think it's a useful efficiency improvement on its own merits, as it
does avoid the unconditional rcu_preempt_deferred_qs() call on the common
fast path. Even with only small performance gains, the change looks correct
and low-risk to me, and I'd like to see it land in mainline. Let me know if
there's
anything else you'd like me to test before you post it, or if it's already
queued up
separately from this thread.

Thank you!
Jirka

On Fri, Sep 11, 2026 at 7:12=E2=80=AFAM Mukesh Kumar Chaurasiya <mkchauras@=
gmail.com>
wrote:

> On Thu, Sep 10, 2026 at 09:58:59PM +0200, Jirka Hladky wrote:
> > Oh, I forgot to add the actual results from the LPAR:
> >
> > Model name:                  POWER10 (architected), altivec supported
> > Model:                     2.0 (pvr 0080 0200)
> > Type                                         : Dedicated
> > Mode                                         : Capped
> > Entitled Capacity                            : 1.00
> > Memory Mode                                  : Dedicated
> >
> > Results (median bogo-ops/sec, N=3D15 per cell):
> >   Mode          7.1        7.2-rc4      Delta
> >   Enforcing     68,275     70,154       +2.7%
> >   Permissive    68,082     67,166       -1.3%
> >   Disabled      99,654     100,510      +0.9%
> >
> [...]
> Hey Jirka,
>
> Thanks for confirming. Also with the diff I shared, did you see any
> difference in the performance.
>
> Regards,
> Mukesh
>
>

--=20
-Jirka

--0000000000002854ac065b32e80b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Mukesh,<br><br>I built 7.2-rc4 from source with your pr=
oposed rcu_ct_kernel_exit_qs()<br>patch and re-ran the same sweep - it show=
s minor improvements vs. stock<br>7.2-rc4<br><br>Full results, median bogo-=
ops/sec over 15 runs each:<br><br>=C2=A0 Mode =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A07.1 =C2=A0 =C2=A0 =C2=A0 =C2=A07.2-rc4 =C2=A0 =C2=A0 7.2-rc4+patch<br=
>=C2=A0 Enforcing =C2=A0 =C2=A0 68,275 =C2=A0 =C2=A0 70,154=C2=A0 =C2=A0 =
=C2=A0 71,585<br>=C2=A0 Permissive =C2=A0 =C2=A068,082 =C2=A0 =C2=A0 67,166=
 =C2=A0 =C2=A0 =C2=A068,705<br>=C2=A0 Disabled =C2=A0 =C2=A0 =C2=A099,654 =
=C2=A0 =C2=A0 100,510=C2=A0 =C2=A0 =C2=A0101,016<br><br><span class=3D"Asgi=
ve ng" style=3D"border-style:none;background:none">The patch vs. stock 7.2-=
rc4 differences</span> (+4.8%/+0.9%/+1.3%) are hard to <span class=3D"G8OMX=
b ng" style=3D"border-style:none;background:none">distinquish</span><br>fro=
m run-to-run noise we&#39;ve been seeing on this hardware, but <span class=
=3D"Asgive ng" style=3D"border-style:none;background:none">they</span> are =
consistent.<br><br>I think it&#39;s a useful efficiency improvement on its =
own merits, as it<br>does avoid the unconditional rcu_preempt_deferred_qs()=
 call on the common<br>fast path. Even with only small performance gains, t=
he change looks correct=C2=A0<div>and low-risk to me, and I&#39;d like to s=
ee it land in mainline. Let me know if there&#39;s</div><div>anything else =
you&#39;d like me to test before you post it, or if it&#39;s already queued=
 up</div><div>separately from this thread.<br><br>Thank you!<br>Jirka</div>=
</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Fri, Sep 11, 2026 at 7:12=E2=80=AFAM Mukesh Kumar =
Chaurasiya &lt;<a href=3D"mailto:mkchauras@gmail.com">mkchauras@gmail.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On=
 Thu, Sep 10, 2026 at 09:58:59PM +0200, Jirka Hladky wrote:<br>
&gt; Oh, I forgot to add the actual results from the LPAR:<br>
&gt; <br>
&gt; Model name:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 POWER10 (architected), altivec supported<br>
&gt; Model:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A02.0 (pvr 0080 0200)<br>
&gt; Type=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0: Dedicated<br>
&gt; Mode=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0: Capped<br>
&gt; Entitled Capacity=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 1.00<br>
&gt; Memory Mode=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : Dedicated<br>
&gt; <br>
&gt; Results (median bogo-ops/sec, N=3D15 per cell):<br>
&gt;=C2=A0 =C2=A0Mode=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 7.1=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 7.2-rc4=C2=A0 =C2=A0 =C2=A0 Delta<br>
&gt;=C2=A0 =C2=A0Enforcing=C2=A0 =C2=A0 =C2=A068,275=C2=A0 =C2=A0 =C2=A070,=
154=C2=A0 =C2=A0 =C2=A0 =C2=A0+2.7%<br>
&gt;=C2=A0 =C2=A0Permissive=C2=A0 =C2=A0 68,082=C2=A0 =C2=A0 =C2=A067,166=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-1.3%<br>
&gt;=C2=A0 =C2=A0Disabled=C2=A0 =C2=A0 =C2=A0 99,654=C2=A0 =C2=A0 =C2=A0100=
,510=C2=A0 =C2=A0 =C2=A0 +0.9%<br>
&gt; <br>
[...]<br>
Hey Jirka,<br>
<br>
Thanks for confirming. Also with the diff I shared, did you see any<br>
difference in the performance.<br>
<br>
Regards,<br>
Mukesh<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr">-Jirka</div></div>

--0000000000002854ac065b32e80b--


