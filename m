Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5A6606A333
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 22:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GSFK3qy8
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNkxd6KwLz2xQs;
	Tue, 10 Nov 2026 09:30:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::82b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794263413;
	cv=pass; b=XN2HlQkicm+aLKSY91Wy8mCRKf7v1UtmCHHJum9bPproqiU5+ykOOxziLtlqoccHjuD/eOR9Hh2UzUG/LOZkCEVQfsda/SLOx6ewtsco56ATWcXnZJv5fA8gtwu/5Ae2C8KtynscDHKUayxZgpWibKxTUgjGtlPfXMHszNJaDT1IzhBtCcVK5vpY99axM1YSI06Px2lGSkKlsykmFE0/GmdqMGnu9fskBWSVVBknNCpr/laTxMv2MnuGo0n3Gdhm3YQl1UyHMC+cFgdq2KZQpK+YNFmCF4+jvclA+vebSoOduroUHkmiLkX7xmKwlYGZS5U2q9dyZtfTpfCSFZOLVA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794263413; c=relaxed/relaxed;
	bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lP1WGnOIzQsD88hilbTmYjxpN/n6OEU2QInc3YM5Z0eBSsaO6MJtbdM2tvkDvbMO7TcK0PmejGRbySLaPoc+l3sj/rv+72WIGa1t0Yj0tUrCtzd3z5yL1v+6ypB4/xbBfInvNdDBiZ1N7puZfi+kPtBVXXBIBM+vyxmc+nf2HPdpvdyIIl8jHUCLCnSzNIIkW/XxnioEVW/mqIms9jPEeThv/sUBbhxlfGOYatMwIawYSq0OOerA08jh0QOCXfyoWN/MnxytgbffuowV9p7ndEmYakt7vUGvYAJgRGmnrh5Ct5gPAuvpJQ201DaxWvoogoqkGf4mvMtGYjTT9mfG1A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GSFK3qy8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82b; helo=mail-qt1-x82b.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GSFK3qy8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82b; helo=mail-qt1-x82b.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNkxc0stsz2xLm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 09:30:11 +1100 (AEDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-535f598d126so39661cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 14:30:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794263408; cv=none;
        d=google.com; s=arc-20260327;
        b=mqyW46APQtEwuIX/b919y6D+64rAiHgLnH9BoxSO5eQd4ktFODv/cofLESlDz9z4Je
         hEU/rssvDo4/K3+0iy/9FlDQc+S3UcqB85uFjkY/H9pYvtz5hYHrhVKeNaxWeXl4POTf
         FXjWXOEokGQISxdMkQ6JfNDlqqVA1ZEOF4S54skzw7yvQky9uVbW0zjorQiCtlYYYdvu
         2wUA3ogppwB/AoW1VkSjkG+8RGD2W2HItqLUGYa57KC9QqZJO7wMslZwp+51ikViQTdS
         v9PqAnL3qOn1SRdTaQnz0mF3eW+rrt38IVbCpwzDMs9hwJ8tsYSoIiXymf3yaXTqniyD
         1gOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
        fh=bDRRs5TjQOXeAvy/TO7jqDVPdLU/bl7QXkkb6ylaf6E=;
        b=lDYT5c7AIXDaFCexsK/HCYExY2ejbP1dWRBzspV4b4FY2Agf33sH2ZMrpuGB4w4lrC
         PU0t5WknqUws2hirdHQyyU0ITkFeCei1cWGWguXGTpgJuOErQm/+lIwfAWGhXdN6AcFb
         WVU2Bmi0K8wR8MGCa/LN9Kdp0eaYKGnMhVQfwpi6hPMfIjv7WdYvOocuOWJu81gO2QzH
         Foe2HhgxMicJq4GSUoPhZDY8lNtPRZRERRKrXUygwjze0EegedxJlUw+HUbLaBAHQzQ8
         KtlDjyXNfScjj1Q/P16E2mLVUS/37wuEyqifN4ulp8cnZPPUEss8mYsL81yH1Ah4ic7v
         VcEQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794263408; x=1794868208; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
        b=GSFK3qy8zfVERKHABUjgEhwNAQFRFoqzxkGEy8wROBIeuPPh+XArndyDImeNtWmhvS
         huVZOa9/1NVMgjpxpcFlFYIIphdoCsbLe08oPII6XWYp+lqQzQ6/8mpmr1Udd63f9GoP
         ufo9n0a30K1uHCFxr7zSt3f/RSWuXrAwzl9boNkHy0MnJG0oi097THKiEgnC1GWYXULZ
         YePUb8UtMcTCXFT5UiUWNzfC6zlt/okgGe++K0dy7OHttNaJDYFNQnzRDftvrUaixQJg
         Nz+n3Jz3q/7BvTs0BnLuIBghM1fAZcgQ+zQAr5Gxp8gJJLe1jJ+/5qmW+dtZDHaBTSoB
         yxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794263408; x=1794868208;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
        b=HWyOQnSuroI8YeNgw9uHrppA5NpLwJdXH/aNVaOz4q947H9yV5lmGUIwUaJzQLxAwR
         tzvg4whxDmk4xKgf8Ib+Q6uy11FEXfo4FcJTxinEtMz/DaEO0Jna8nylxnW/wUoe229Q
         JOWHpuA57EAubv/ge9klc/iyxRhsKrjJ58ezR+jUQys7aHg9ZKUH0O2pzyQxzJz3clhi
         t9U2hlGmOP6Br8jvKmnJvoyjZPof2S0ftGG5ynfwxDHkdJeCuvWauAGXcr2NVFRopyic
         fPZgI7kXLSGeiJid0nHYsMbiHpqSWQaqEwcbhzRuk4fMdRuk6CS9mEycc++exZF8/sSN
         n8NQ==
X-Forwarded-Encrypted: i=1; AL+hErHcNxIirfj1zI1+oUHNCRPaX2ltS+lF2avrmhsL90M+4nyWtiUwuFswzyqa0fhVpDaZcp9nCBYANCyQCqo=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/ocr91jgQvcxWE+SJvmaXaHBr8lhnL8Ju/oR5kMbAfTB6lgw2t
	KEerqXciLkcUl4Iq+l1yoZCYd6B873BBMYBNAgm8i3rBA19ci7tv2bOTU9dV8iiZJnFMb2SbB5U
	pNmW2Qu6vJYbqdMIZJVWwMJ3sA7/r1Dl6SigMzoZe
X-Gm-Gg: AYBFou2MoaW+qpuJXT+4oS8RWXJunlYSWUWMPfxPLlYIR5fEFcKuIFL6wA43rf7zu1I
	UFXRXgInHj4GMLZxok+y1Tf+kbfzh4+jfgOA+quhI9sxdTIQT7Yyb0i7YaElDQbnhpgowYqxlUG
	wqS1B6c7bXJHPJdEIuxMGzGSxkkiqZdQubqVTb+ETV9fJUj7CfoN7nWofCYUlz6x+N+2XpE6ysk
	C98j3nR6v8mmc+uE/wzsyt6D0PKQRIr6K1I5/ic7F0FAoLJPLcB7w8ltCdLaSRthrp8XNfCs4tJ
	8Tylube6om79FtTj3l/ZWcKWoF5dX4RUjarHGclb2jzo835grJ+dZJOlOhW72Jih5VlrS0enu+H
	S46eYLtSaeAI07owC23pmrbgtsvwHHvQQgbZ+otOTm9uSf9GUjOT8mgKZCxxYNbPpYxw=
X-Received: by 2002:a05:622a:1b16:b0:530:e00f:7768 with SMTP id
 d75a77b69052e-555290bb288mr6464421cf.0.1794263407457; Mon, 09 Nov 2026
 14:30:07 -0800 (PST)
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
References: <20261108223913.3624571-1-irogers@google.com> <20261108223913.3624571-7-irogers@google.com>
 <b8d171de-52fe-474e-96db-d119840c6240@suse.com>
In-Reply-To: <b8d171de-52fe-474e-96db-d119840c6240@suse.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Nov 2026 14:29:55 -0800
X-Gm-Features: AclHuK-dlWDp0B4FdK6V9QBR5LM_sA67_T-19O3ovPwDJ5RdBpzojQ18ICzxF_E
Message-ID: <CAP-5=fXd640kfaR+soPdiEV2mfqCPGDANCt04KzaXBphYP4Htg@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type
To: Juergen Gross <jgross@suse.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Stefano Stabellini <sstabellini@kernel.org>, 
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
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 8, 2026 at 10:56=E2=80=AFPM Juergen Gross <jgross@suse.com> wro=
te:
>
> On 08.11.26 23:39, Ian Rogers wrote:
> > hypervisor_init() in drivers/base/hypervisor.c creates hypervisor_kobj
> > with kobject_create_and_add() (which allocates a dynamic kobject using
> > dynamic_kobj_ktype), and hypervisor_subsys_init() in
> > drivers/xen/sys-hypervisor.c then overwrites hypervisor_kobj->ktype wit=
h
> > &hyp_sysfs_kobj_type, which had no .release callback.
> >
> > Add hyp_sysfs_release() calling kfree(kobj) to preserve the dynamic
> > kobject release behavior.
> >
> > Fixes: cff7e81b3dd7 ("xen: add /sys/hypervisor support")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   drivers/xen/sys-hypervisor.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.=
c
> > index 91923242a5ae..0e8a2cd69fd6 100644
> > --- a/drivers/xen/sys-hypervisor.c
> > +++ b/drivers/xen/sys-hypervisor.c
> > @@ -659,7 +659,13 @@ static const struct sysfs_ops hyp_sysfs_ops =3D {
> >       .store =3D hyp_sysfs_store,
> >   };
> >
> > +static void hyp_sysfs_release(struct kobject *kobj)
> > +{
> > +     kfree(kobj);
> > +}
> > +
> >   static const struct kobj_type hyp_sysfs_kobj_type =3D {
> > +     .release =3D hyp_sysfs_release,
> >       .sysfs_ops =3D &hyp_sysfs_ops,
> >   };
> >
>
> Wouldn't it make sense to have a common function for just kfree(kobj)?
>
> In your series there are 3 instances of .release just doing kfree(kobj).
>
> In case this is not wanted or with using the suggested common .release
> helper you can add my
>
> Reviewed-by: Juergen Gross <jgross@suse.com>

Thanks Juergen!

lib/kobject.c already has a static dynamic_kobj_release() that does
this (and there are ~15 other places in the tree open-coding a static
kfree(kobj) release wrapper), so include/linux/kobject.h +
lib/kobject.c would be the natural home if we exported one.

I kept them as local static functions here for two reasons:

1. Patches 2/9, 3/9, and 6/9 carry Fixes: tags, and keeping the small
   local callbacks avoids a dependency on a new driver-core export for
   backports.
2. Since kobjects are normally embedded in a larger struct and freed via
   container_of(), I wasn't sure whether Greg and Danilo would view an
   exported kfree(kobj) release helper (especially alongside
   __must_init) as an invitation for misuse on embedded kobjects.

Unless Greg or Danilo would like dynamic_kobj_release() (or similar)
exported now, I'll plan to keep the local callbacks for this series
and can send a follow-up cleanup for the tree-wide callers if
driver-core maintainers think a shared helper makes sense.

Thanks,
Ian

>
>
> Juergen

