Return-Path: <linuxppc-dev+bounces-21745-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3533CD6E49
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 16:11:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRpJJ6ZD2z2yQL;
	Sat, 30 May 2026 02:11:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::529" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780071088;
	cv=pass; b=UvPYtxUjfFbAlXFeJg+XCRvb+OlQ9LeDov2LRqoVQMuxR5pig/6D7nXrmg8YsnpqUrm4zMGE+zzsXSyIKf8W7Jjch98hfgue/SuFXF4JTrQwT4cwXCpAb0n+JMI8wCFuimyLmzpT4vdN+obGurmPbrU0ZRv6PJlUz8L2fpNE194yYYxNuuwhiEJYPl1LDhpTUF9fyCenfld9sct4LbiatSHm/cc5hM6sCL62rhqFGKG+ukc+7sOgmjoZP6vUrgUElODBOsv5kbLc8atSmnRykeUy+Tmttf4b7HQ7LLHc8LRoHqzeq5BMlcX3kS6FJrcE32NGnAJlMrCYnioGDF/ebQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780071088; c=relaxed/relaxed;
	bh=LOEaPD7Rz0zsPbSOZbfxpmu2DbPZ8teKVvGhPB/4or8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ro7ooHXrYH9A1w/AN4lmr1jmRELncBerEra4rl6ogOTlvi2eNXTioaOA3hDJZrsmGO1q1v8jzPcwO6Kbp0bx7LlAJnaY7siRi4lIAx6G2vHx9WE4T47qDK5XXh/wEhslQOFUJe6p8ENyWgTZOmrlPRiV4IiTzE3wKI7d0yPKcZPh6sMG4zssRNK+EkNeqUnjwFhUBlOuPNQCIr1uDam7Tid9BNaMi3PS2nDlvO9+MmtgiIKpxxKtHvSACLoHWs4X/YMqQAdtyjvzunxaC89NQWiCybpwVll3MBxSx0x3Rl9lO9rAybF8HzsplCqfHgxTmfdmLrF1zW2lYFEDXbHEBw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SxUXYtla; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=stephen.smalley.work@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SxUXYtla;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=stephen.smalley.work@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRpJH2mrzz2yQH
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2026 02:11:26 +1000 (AEST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-c85714efa22so803195a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 09:11:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780071084; cv=none;
        d=google.com; s=arc-20240605;
        b=KG8pXMNHh7UlZKoS/PIqt76jtPkcQYIZDh348u6BZmDn/DsBsRIbhqhTiSxcSZV4Y7
         9ObAd2sLtlSuJ/GaRkAU0Yfavd7vBgH2hNC3/E3LhcLbZyA5Pf1kZYLV0790jGrLxtGp
         7XWo9DWo0moaRpFu/2dju8ZVUYZX6vUpQ6rC7x4iIUHmYiUcJ9AO/KO26GeI4D6QmT8H
         16y/WmKaeaScAd61T3ZPwQr3vuT+88rIRTYfxtPS+yp+IlMvN0s9usT2SXc4vm9Ew8XL
         3OsMD20wxqesfWIwCUESP6jZFrjXDUr3E4absM57LPtBcwfpxWB+wr6cMa8jZtmo6Fxm
         XICw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LOEaPD7Rz0zsPbSOZbfxpmu2DbPZ8teKVvGhPB/4or8=;
        fh=1WcuVaVp0srxfZx71EWB4CMm7dXlECJLNhHgIvBbRHY=;
        b=ACIebzu59QMYHxnc+EMUs2O2IgSQcmXgw8WnjixGge27VYfcU7deusU08W44UH16od
         jjVGV6kr6okJ4JmHD55MXQ39O2gxNIAd9StFAYCTcMpIf/BS/8FRW5CIsqgmgxTeGUaJ
         tnu6eHXMx6Rx7wdcSdLWMn8zp1JDLZ4EsJLWxspcVSM//NN0FF3ZpeJp1RtBemw599i4
         kifR4GYTArCfYheB1h/w6oGFYuJL56DjNj7dvusdp3JGgIFZblPt2ToZc84vrpjOCRbm
         mJTNMFGpAzv4FeUWvc8nMMU8d84oc5AmKbJxcTshcGAZIKWrR+FpxsIYVDB35Hkd+jeM
         kCDQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780071084; x=1780675884; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOEaPD7Rz0zsPbSOZbfxpmu2DbPZ8teKVvGhPB/4or8=;
        b=SxUXYtla8oomHQpqc8M9ZvUbQnVEJeDc+YqfD19kVa6iUf6mPeSPOmLfVu3Ppag485
         fPIkBiojX5jI4DqWwkeQam1T/PkUhprySaXpDpQzeCzkaqmVWzdOdZUfRXXRDiP/przy
         mQyXiiTjQzE1M8sWuNXj9isNLXir23U0gn6OntERTMPc3vOmZ1q2NjthbKPR9gIIYlyS
         0nxdhn/aT9NgQ60lqKcRHfY5SILzAnlHcekrHJ+AvIquHH9QggrL06SgQMF9yBsvAtJL
         gF0TmT0KozrwEriv0WoSo1Ru0Zeek2AjvdimWGwesP4/oPYq77pUPKl3r6WCGuqXyop6
         BRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780071084; x=1780675884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LOEaPD7Rz0zsPbSOZbfxpmu2DbPZ8teKVvGhPB/4or8=;
        b=GoPW75KuvyXc8yOtS9NhIWnVwJDDmiCK/vszt9ez9IVUvTy+wzMb1OvaX7VVOkDN0h
         +RbHj35PBteuFuDRppP8DO4sy3gkFusEKLZchQSKNvYDnPB81QusPvTHc/idsREh9t3g
         /SWTsDdMS0Gt+uZlmBdTqP4DNg2soamo4cQbyGeQGu+I0HivycikSpMuiQooWRCbmYtT
         9Sr2I5pVjh/BzRt8kq4J+WoCSemxIEe8xrcsXonhiWkMv4G917TjwCfl0y4rL0chr9uc
         DDtQw3Sh+TV0JHvarBW00PRVDzbORbpbQznRsrmOwalUzMGZtPkQ6o8u5PBuEo0My7nQ
         SGxg==
X-Forwarded-Encrypted: i=1; AFNElJ/h5JfJbkkH9Xbef60M+rhicLgYDgi3UoWeEl2StBgwmjLN8sfEliXQABYWOvhVMRYcBHxaWE25F8vN5eQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxbRujNyHI6pfKy/vSvNLXXIxYWcx+GqRbo1edj9LrkePQrhAqk
	8GCssSAYXZsQUTQaS13CicUmIwAQhWsMA7cSOCP7JruaxuixZf4HWzPUJU3weSaj4xj8dKO16of
	aIjq46tOAoN+wNAifp6Imjf8kfyP+xX4=
X-Gm-Gg: Acq92OHMoidTrJNWZniJ75DWbf8h8Dtufj39aJNXQt+bfxl7s2q/oKIodEuUAwIR3tW
	9XGOzIXh4HdhHV9wdSkFHFcMjSoOg62zH5/bObtXEGczMoE71ryueQE7/Nfr6kOXOTUt5zVZI9Q
	0QxkisLMRolRP1elc8PBvsTmCBJpWdCOm3qwgYIS10Hf7RDFkCFMxr2r3ZLkt2lP02phIX4OxR8
	x4YcxkG9VlAR5yOcjVS3LWe/fEs3D2IeUr2EwlD7MbqZzssgXmjc/m3IE1i3ORj2F2d5yR4Lxxp
	E0yXznoLnUd4jMfgSA==
X-Received: by 2002:a05:6a20:e306:b0:398:9d5f:e093 with SMTP id
 adf61e73a8af0-3b411cd03aamr4325288637.19.1780071083461; Fri, 29 May 2026
 09:11:23 -0700 (PDT)
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
References: <03e5151a-f420-46f9-ad5e-109420132021@linux.ibm.com>
 <8f0c86f7-eab4-4e82-97c1-5d190c390770@linux.ibm.com> <CAEjxPJ7Y+9AqEVTJswUsan4OOP+DVkFG3vXukQVtcJZbVaoZnA@mail.gmail.com>
 <CAEjxPJ6DqhHKdjwC3ddZfUK4HVPwOTzb1Kkuabi5WmwmF8Lu_A@mail.gmail.com> <CAHC9VhSEjSmdVgNxg=PvwS6RXnJzFybJtFhCJbOsKiRhXi5PJQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSEjSmdVgNxg=PvwS6RXnJzFybJtFhCJbOsKiRhXi5PJQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 29 May 2026 12:11:11 -0400
X-Gm-Features: AVHnY4L4gN19PG3AQEBx0PURc8Ls8mq8w1hJmRjX8Fp47k7jg82ZQUCRn7L1ESw
Message-ID: <CAEjxPJ5wS+sXvCjO3q2sfrckuMo71_Y3uSdgu+Vte7xLkW0Huw@mail.gmail.com>
Subject: Re: PowerPC: Random memory corruption causing kernel oops on Power11
To: Paul Moore <paul@paul-moore.com>
Cc: rppt@kernel.org, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	selinux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Ritesh Harjani <riteshh@linux.ibm.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 11:39=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Fri, May 29, 2026 at 11:19=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > Alternatively, I suppose we could just update the dentry_path_raw()
> > call to also pass PATH_MAX, but
> > I don't see why we want to use __getname/__putname() instead of just
> > direct kmalloc/kfree here so
> > the size of the buffer is immediately evident to the reader.
>
> It's reverted, see the posting below:
>
> https://lore.kernel.org/selinux/20260529153608.30853-2-paul@paul-moore.co=
m
>
> I think there is still value in using __getname()/__putname() here as
> opposed to a simple kmalloc()/kfree() pairing, but either way we need
> to adjust the buffer length in selinux_genfs_get_sid() accordingly to
> use PATH_MAX instead of PAGE_SIZE.

IIUC, __getname()/__putname() were originally internal helpers for
getname()/putname() and allocated from names_cachep for struct
filename. commit c3a3577cdb35 ("struct filename: use names_cachep only
for getname() and friends") switched __getname()/__putname() over to
just generic kmalloc/kfree so that other users of those helpers would
stop allocating from names_cachep and noted that those lingering users
could be converted to explicit kmalloc() over time. So I don't think
vfs folks want new users of __getname()/__putname() but I could be
wrong.

