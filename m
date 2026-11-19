Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD0660A2602
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 05:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=M+OG+uov
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVSBM3pk4z2xlP;
	Thu, 19 Nov 2026 16:46:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::831" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795067163;
	cv=pass; b=kGqulSU1VDyG22ea1eCwcAbW7OwU9vs66AG5I/APK0sVdvP1h306xkwAK1uAw/WzbcwuRkFOy3nV24u0prPuXsbilTjXWwFFKw/9yPLMFbi0KuXoXHJEDw0HHkBx5Eu4W3H0LA2wr+VMV6jxlsZc1FrUDPjVSQMqHsLUabi4ChCeQEIO8IZagYhNV/tz8XC8E6ypC+4OsIZCmPEt+RpbogvE+dtXyX9oRGsoHYNNSfgF11DsXuz7NPBHmXzhopZ16CmCcV/to6XFcQ0X9aZOdA1/VQaFRhg9qTWfRoRiXXPjZiaj0vrYbk6pHDg63tBeQYkKxwiZgvoPKMw8Vr9ZVA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795067163; c=relaxed/relaxed;
	bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YkOHGVH+RBU0oDquSAV4M2sBkzDmYWUA97AlCjI3O17rZsFeEET3KY1PsvZcrrs72fiPzJARbjWUUY2AbRYXntZX0RVM/zE9gXrI6OzPQSMlZ/vRTGftNfr1hjdK7UlReMXaGAOfGN4QroL1Bj4srmi+CpC79wAzdvvecXRCCb8L38DqADXz1Hk67bEl9daeP1TNmuZK2+C7lfqKqHAEYbMCRahYBd74DXPVMTi20O+tRV3DSr+lyKGbEqQWodyAmlEfI7WjirS/+CciSdNIYUE1uOEXMf9wM8qIwpmBu9HqJsRy5q/a3RaeVfI9YpXEM2VcuEq+gu2zf+JW+u4uSw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=M+OG+uov; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::831; helo=mail-qt1-x831.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=M+OG+uov;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::831; helo=mail-qt1-x831.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVSBK5WlBz2xN4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 16:46:01 +1100 (AEDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-55be673e029so117331cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 21:46:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795067158; cv=none;
        d=google.com; s=arc-20260327;
        b=Vr4hX7/PitYLydR+sTFeZ/cN3VjH+S36mmH7lm8q4te4ruXAvSnhtOYQFM9QVxj406
         LTZYaWsBgaVs0Y+vN5I42eARbiF12tdjLNvYIz6gyH/udwK8CUsJ4d8php2l9yjVCJGx
         Uf+aWld/fVCV1Cx0adnCh40yiIwvjWTy3VW8coW40+YqU4oWkcGuAjvJCFjRFdQfjZwZ
         O5muH/MwWPjX76JSt3U3yz55adTFkNgt4iF5w58XsuIlj6rfX5rVq0rQNQQWbn7R3uBZ
         NcVtLMqPzTF0bZ9oQL/xp2VzxoHL5dPbCNT9GBxjvLr8IoE3Ha6YN6se/hSidupO5r2c
         IMDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
        fh=X32bZKynFphT5m2RqCiGkau6NzHITMRZDqGfDeIN2Oc=;
        b=l8pUtefGpcOOEvqkBtMnaRGWLpQFBme/9yxZR8rqgjogOviqCe+nY6dwHyvtzmImXl
         MK+Gnn/rBAFgyZ7tShIz/zULtOCCMyisuZ0VvJekgw1zgH4oFT/P8M34Y2/lb33Yv1Mw
         vg6jc13uFCv1VxTSto99PnKgCtrJ4LtLGv2ovGrijTF6qz69Fo/KGhO4cXZx3P0WNgJT
         bxz19v8cSj+9ByoUB+PP27WXCKcpPXWDFNBehyEvHXgYQBKwTDuQxisidd0b00FNQGon
         ptfR0ahk4BUc2JfJNT4isZ+JSE6YruRxnZ1m1QzqqliKi72HEES1j8Y98DZE6a2y+pj6
         K69A==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795067158; x=1795671958; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
        b=M+OG+uov3DpKRX46N6NLsHvy5lkBgbquQ7uNv4ubVsJVkRKFt5lCG9yisbR1GVVe6H
         gmTNdrBgKvuIa3zc5tvTdKf2nWhzMc1RPI2ick0pxJJch2xJtTCj+MZEj/gjPTKaz2nA
         So/DMg/2hUPioRFKwzOjxrJn4zTFf35Z6JI4I6fo1uIwK359A857YrUTf/DL05vtCZT8
         CAZj72qA4669LTNZPezbNasll1ysimeVTqs7jZkm1cQ/xJsQZPnu6oeDsv0V+U5udBz4
         7ny7xitQw+c7qLOb0+Uy/wzhuQpx3X7wDyk+VVxgkO0Nhf8CtSpqKw0XYotgWWvq2jsB
         FKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795067158; x=1795671958;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
        b=BoJTSN0mmXQU64noHU66ketJleA7uBKMuQmksEOJynQkSnPhUIJFp1iY/ZoZy9HWTm
         jpOtwU1rJ2imN6LKFtceKq9WNxEXvD4cXfo4Yv67jiHicBqe19P1UGiv7OPy4GhhSQFf
         ytmtPpgTVo17hZbmOReSnBxBulVc1UgElxasoFnmnhD+yX8UgUxAJe8xNorp5SEUNJ9p
         JIEeI+DRbD/RR3IZQblUa5UNoDttGiNPH/Q1k3QHgti0q5dHMwN0WOiI/ByuLZ6hVuOI
         8rUR48zEyMa90uKHTfcb/Ay/tb14UoICi0q0oiCD9BdSDJeFw6DoUroO9gIb3ws9HVsz
         unQw==
X-Forwarded-Encrypted: i=1; AL+hErHtk9iHZVx2rMFHyiAV6YUp8i45oVQk9al+ifWL/MpwMG0mcEGCHIydXdKEuFMHyFgPrj7z1i3hpu6Ofgo=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/lD3XFXXFojTsAIMhOwCHea6UnRcb23HvmyFxrCxM8wBXL7zhh
	uwigTRBPPs/YKVCr+JglXcsJkGUr53yCHPVSgwysB7Ep6QuEsW9Iu0QdQKNf+PWPGlt8IIkfb/q
	3P1p82WBDKV2a+sDL8Hfbb6SDyCCCB/rmyopT6OB3
X-Gm-Gg: AYBFou2xLCrjMi99KpWlO3rVQXQl77SQ3Grx04tOMG89Io257aZMe2FmnEyi6uHKKYm
	0sCBUECdd0gR6N52XiIENeG2pGq61rIIsX1RN/RyrpmH+EeSmqc068OcgMERt5kQq15Rxp8mDa5
	kM9iAfvz/5kbcx0WIq2314XEEb/byKRjZptXc01G6XXNMQ+h3aXLbbusRJw09BaQA/ZHaNuhiWq
	NWdPpKZiueqiSFwFfTj8B9nk6PcMrupa+TRS8kjKTMrqNTIE3A88Hc2TxFbTW250xFKVhnbj1vZ
	l9bXEEdDAxzJ/bQnGVrJhXwyh3yOHCaqYOtvVuQEcrmaSQ/FRR7IHuo0XrFxWC/0RubFOJBdcRk
	PkB/BS1KROWcSpu3rzdFCr2/EEyQWAEbv3OEV
X-Received: by 2002:a05:622a:4808:b0:536:934f:7da2 with SMTP id
 d75a77b69052e-55d6c7995f9mr6557911cf.2.1795067157461; Wed, 18 Nov 2026
 21:45:57 -0800 (PST)
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
References: <20261108223913.3624571-1-irogers@google.com> <20261108223913.3624571-10-irogers@google.com>
 <DMYN979QJFNV.LM3T6O68OHW6@kernel.org>
In-Reply-To: <DMYN979QJFNV.LM3T6O68OHW6@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Nov 2026 21:45:45 -0800
X-Gm-Features: Aa3M54p8GzPfKDPQ_HJcPbdLHGq3vwK7n9VGnVvnVB1ODjbFHeHwrlgOfVCaaEo
Message-ID: <CAP-5=fXrMyfLFXq6CiqwWMSbtYVRNESxuDo-ddqNwDmq5Nm4SA@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] kobject: Require explicit initialization of struct kobj_type::release
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Alexander Aring <aahringo@redhat.com>, 
	Felix Kuehling <felix.kuehling@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 1:11=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Sun Nov 8, 2026 at 11:39 PM CET, Ian Rogers wrote:
> >  static const struct kobj_type cpuregs_kobj_type =3D {
> > +     /*
> > +      * Pre-existing: info->kobj is embedded in per-CPU cpu_data;
> > +      * cpuid_cpu_offline() only calls kobject_del().
> > +      */
>
> All of these comments carry a =E2=80=9CPre-existing:=E2=80=9D prefix, but=
 that doesn=E2=80=99t
> distinguish cases with broken lifetime management from those where the st=
orage
> remains valid despite the API misuse.
>
> For example:
>
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_xcp.c
> > index ab14079d1c42..0847134a1391 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> > @@ -797,6 +797,11 @@ static const struct sysfs_ops xcp_cfg_res_sysfs_op=
s =3D {
> >  };
> >
> >  static const struct kobj_type xcp_cfg_res_sysfs_ktype =3D {
> > +     /*
> > +      * Pre-existing: xcp_res is embedded in struct amdgpu_xcp_cfg
> > +      * rather than freed individually by kobject_put().
> > +      */
> > +     .release =3D NULL,
>
> Being embedded in another structure doesn't explain what guarantees that =
the
> enclosing allocation outlives the kobject=E2=80=99s final cleanup.
>
> Could you please drop the =E2=80=9CPre-existing:=E2=80=9D prefix and make=
 that distinction
> explicit? For broken cases, describe the lifetime problem and mark it as =
needing
> a follow-up fix. For cases where the lifetime is safe, explain what guara=
ntees
> that safety, while acknowledging that omitting release() still violates t=
he
> documented API contract.
>
> Also, do you plan to follow up on those cases?

Makes complete sense, thanks Danilo!

Auditing all 17 files in patch 9 with that distinction in mind:
- Only 3 built-in sites (arm64 cpuinfo, ACPI hotplug profiles, and
s390 sclp_mem) have backing storage that genuinely remains valid for
the lifetime of the kernel.
- The other 14 files either free/zero an enclosing dynamic or devm
allocation without waiting for final kobject cleanup, or are tristate
modules that unregister static kobjects/ksets on module_exit and can
unmap module memory before delayed cleanup finishes.

I've dropped the "Pre-existing:" prefix, documented the specific
guarantee or FIXME lifetime hazard at each site in v4, and yes, I plan
to send follow-up fixes to the respective subsystems once __must_init
is in place.

Thanks,
Ian

> Thanks,
> Danilo
>

