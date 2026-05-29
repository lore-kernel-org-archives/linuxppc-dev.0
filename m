Return-Path: <linuxppc-dev+bounces-21746-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D413CD6E49
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 16:19:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRpT73lbyz2yQL;
	Sat, 30 May 2026 02:19:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780071547;
	cv=none; b=a2UXtrS8Sl0RCar2ljqJLHCGGCWPoapzRflhnDNK1j9MBVFuFm4YRDbjV1MJn34ZA1JH2FBNd9COFHW4uBsXrV/o/8EXCnEjs14ugbhw2Mc5mqo1vqKyeQmJSRLm5YlmWi0aWZpq1g/3lHLoQUOTBGq4dEqNb1oIlvYfWp1bWWABubFRnHMlhOBypaal1WmWHezhxg6Q003eh4AzIFCqJQQnwXiJh8BDHh01HriiiJXzg9sYao7rO8EL19I36XUmHxoC7ssUup1gQilQ1G8uaWp3u+jYsq68kZtmaOIAoz82KGSZIs+6nsI31lntYVjQftid0hq3eMjBDD2zFLhz9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780071547; c=relaxed/relaxed;
	bh=R8ivf4oZU2OMq2EC4pcFXCevvcnJjeHsSceuHKJCb7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JYffypQ6/4s8j/octJ/0DaQ3ZJMRMZTqPafEmOKEfJPJgkP7TMYWpS65YNn/8XvKHwqLrWHmKdteZ7Y4UKLOMThS093e4iYIXHSMuQA140scumKqVIFJ1xJWMylYLwNGuH/pQXOk28lpdkmQrQHp119TfoAuX9oQ0QR1UOGmckxf5Gp6nvj71TQc0zxfHAc2I/eFDBpp16X3UwLNIdBVtyzvhWl3sPySvYIb1vHp6BhgvJo35Er/fvRUqMLskl3vQWJALsik8zuG4GCa3AEX2WHAdERvO60whYhuMyPnIjj2VhovVKSSNOhCATVhwf5t2Otyv2Wf+dwAziQqbBy0IQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m9TJ2j5i; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m9TJ2j5i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRpT62w1mz2yQH
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2026 02:19:05 +1000 (AEST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-490388fd0dbso84569835e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 09:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780071537; x=1780676337; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8ivf4oZU2OMq2EC4pcFXCevvcnJjeHsSceuHKJCb7Y=;
        b=m9TJ2j5izMxMQy44lA94j8JVhW77onnGMFKQic0HKr34rjZ3gY/E4tkVw0QMo1+rrc
         5tDx02vp5GrRXtVMqzbE5MEfd2k1yUnTdYTJXZj15i/duGya+y3YFoGjtchuzTWCetCk
         +AA0iFdaMR7QgwG+2gbth85ZoTqImpnCFJ5fV7Lh5/CA/OacwP1GeYCtnx4W6LHHT4Qq
         hP3MGuSYh7Gu1fEGI3svpznBJ9ndBZvAgvaMiH7qUEizRHRrHdnxf4z1Wodt1TDjwUa0
         9iOb2gqWAsiRoJ/xqOP+PpE6J7m3EGAEiM+FwIP5yv86vsovCwvipgmZF3OxggbBqrnf
         jcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780071537; x=1780676337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R8ivf4oZU2OMq2EC4pcFXCevvcnJjeHsSceuHKJCb7Y=;
        b=VGSa0rJzId581QHMXCiMLLB2k/CeLMu2zH/Xg+kaTaZFUt6sTknnek5Iq0rGqXrxA+
         ggzt8ukxOa6HUP86toizGV2GZQ418ELZqq8Q/hZ2I3AnuRluXr923VrSAyAC7nHwQEIU
         7iBb/VZWk45Ni1EZMHAxUslx1kYRft5im7MY1FwDz10tgs7p7n9koqZTm1dITKvG0byN
         XJm5CHTmphSTD4dhLxm3VDYAaRSijGlvqUc6H8zf00ZaEFuGnMPqF0jz1pleClI0t034
         zXK6W+XDoGTiDhE2SnXQAqUCNjntiVli544uv/dnghucg+7sNlLW8xXl8DBCcWEXla2d
         Z/cQ==
X-Gm-Message-State: AOJu0Yx38AF4LKIsSfNNVOGjskTnbjxra2Hlb8Km+4Ezjexs9iJb9wFM
	5TlD2x7+iioG1Av0i8HWnmcVxr+9FWgZq9w1hW/sSRRSChJqSiqnN0mh
X-Gm-Gg: Acq92OG4pbH2Ki+59w7YW4p8HbOCvKDK5IzanfAI8H4lzvgQTxZBrrQg8V4dKyYLA0v
	7KOWsJnJaYvwvDMuzEz6UVq/3NINvLy097NhnlL6dCLsJs6d1HEbdIpvvJ6/uOSGZOxcrmLNRvv
	i2h2VD1MoGJNIKpVhrMHgMtvmDKH3spQkPsLdf4P/DGgBRzTtjJEWgGpyzTVeXiAnspffjihfYo
	rZX0KTjVaPCaf02fLPokpMuktrm7QK+U3A1Y+F/yE71Z7cMYqB1AobMD+SCcwEnHfuP7fu915f8
	vWuCCKLVhpR+LQblSRjzWaI4yUQbnkifKxvLLIOg1QiQfKzk/O4hE1fiqsArTjBTRTatOxR961/
	JwdDpD5YOhncuVafbCDGfOn2ggVRDjjPezILHQiMLR8Be83FE+AM9D4evpDppZlXaa69ZFiN1ZL
	LM6l9lXDijtaO0dQ93hxQ58pCxthMIq08atZdOfpHTTVMM205rqLOMsgXPxysMFS4eaGjzUhU=
X-Received: by 2002:a05:600c:314e:b0:490:31e:d6fd with SMTP id 5b1f17b1804b1-490a2968488mr4398265e9.25.1780071537044;
        Fri, 29 May 2026 09:18:57 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c0498e0sm25344335e9.0.2026.05.29.09.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 09:18:56 -0700 (PDT)
Date: Fri, 29 May 2026 17:18:55 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, selinux@vger.kernel.org, rppt@kernel.org,
 paul@paul-moore.com, LKML <linux-kernel@vger.kernel.org>, Ritesh Harjani
 <riteshh@linux.ibm.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: Re: PowerPC: Random memory corruption causing kernel oops on
 Power11
Message-ID: <20260529171855.7966b752@pumpkin>
In-Reply-To: <8f0c86f7-eab4-4e82-97c1-5d190c390770@linux.ibm.com>
References: <03e5151a-f420-46f9-ad5e-109420132021@linux.ibm.com>
	<8f0c86f7-eab4-4e82-97c1-5d190c390770@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 29 May 2026 19:07:22 +0530
Venkat Rao Bagalkote <venkat88@linux.ibm.com> wrote:

> On 29/05/26 12:20 pm, Venkat Rao Bagalkote wrote:
> > Greetings!!!
> >
> > Kernel 7.1.0-rc5-next-20260528 crashes randomly on IBM Power11=20
> > hardware. Attached is the config file.
> >
.
>=20
> Git bisect is pointing to 54067bacb49c selinux: hooks: use __getname()=20
> to allocate path buffer as the first bad commit.
>=20
>=20
> # git bisect good
> 54067bacb49caeada82b20b6bd706dca0cb99ffc is the first bad commit
> commit 54067bacb49caeada82b20b6bd706dca0cb99ffc
> Author: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Date:=C2=A0 =C2=A0Wed May 20 11:18:56 2026 +0300
>=20
>  =C2=A0 =C2=A0 selinux: hooks: use __getname() to allocate path buffer
>=20
>  =C2=A0 =C2=A0 selinux_genfs_get_sid() allocates memory for a path with=20
> __get_free_page()
>  =C2=A0 =C2=A0 although there is a dedicated helper for allocation of fil=
e paths:
>  =C2=A0 =C2=A0 __getname().
>=20
>  =C2=A0 =C2=A0 Replace __get_free_page() for allocation of a path buffer =
with=20
> __getname().
>=20
>  =C2=A0 =C2=A0 Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>  =C2=A0 =C2=A0 Signed-off-by: Paul Moore <paul@paul-moore.com>
>=20
>  =C2=A0security/selinux/hooks.c | 4 ++--
>  =C2=A01 file changed, 2 insertions(+), 2 deletions(-)

__getname() is kmalloc(PATH_MAX) aka kmalloc(4096).

The old code was:
	buffer =3D (char *)__get_free_page(GFP_KERNEL);
	if (!buffer)
		return -ENOMEM;

	path =3D dentry_path_raw(dentry, buffer, PAGE_SIZE);
only the allocate was changed.

PAGE_SIZE is not the length of the buffer.
Should be PATH_MAX.

-- David


