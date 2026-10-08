Return-Path: <linuxppc-dev+bounces-29074-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7573ECA6016
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 21:31:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j13875gTJz2yLY;
	Fri, 09 Oct 2026 08:31:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::62a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791488962;
	cv=pass; b=COcbFoxQmK688IVyRKhE9KTG2DqNVfDm7aEvcTpMuxHUeDAVR+qFdkR2uMl+75sggezzqH81ZIOdITbOc9zxXiRTQInkcvR0IH/39UVWEJ1gC3QUVpa0M/xNBvNuS6exBrMtBR8GGFAA6T/KAug6A8I5nZ5a2Ue71qvWrQ9CTMbyMF1VDh32Y+/w9Vd5Y3ISliSSBJaT6kcuDOFgzL5yrQQtIW/3RJHZjKPCMBZEgKsrceYQ3iA/5XiQ3uM5ftuWZqnuHbYTkb9GJ7zCAXkGmpItHHA0NOXlb+/nwqnn5FIFe7CLW1wFvBIsykIR3Uv9i6PdNzP/fgB//3iA1imm7Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791488962; c=relaxed/relaxed;
	bh=VF8T3c+JVdlAKxcXmMWBq81K4KmYQwVJxfIeNGY8A0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fEh6YVF0tEIyEKTCXyjZn4MUmwJTzX3V0itSxu/z4ghJ9CK7wch1Qb8C6WIhWgoHbRwC12LyUSLDiwq4mZDoqXrrG8/1sjZpeKKBRHBXb6fAtEppLDEyqdeuSXjMHHuSbF81a9o1pA0HJVgUR0pP+a9HcFDmG7URxpHNCnj8u2Ava70kyQO1kSlAmnJfnVAc2fCQnwuMnIa5YrSBi2enn2KiV4f7gim5GuysaqWCOOfiyl2Mp+jbhoYD1uorI8pm4BWxXrA3qYvHgH20+arhqwLH3uKODam0Fqhm/qMG1X3abLuGzaCN6PIJs4t8LUrxRM92yZ99CXKb5+TtN+Miag==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bUEQF7L2; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=jperlow@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bUEQF7L2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=jperlow@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j10tk0BWvz2xwM
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Oct 2026 06:49:17 +1100 (AEDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-c2e8e738ae0so534830666b.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 12:49:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791488954; cv=none;
        d=google.com; s=arc-20260327;
        b=U1zjqemQyY72OoqOks98sP5EQiChBkPTfgFozsdv/gGWHRG2N4+BmuO0DEKsRcPw/h
         NDSF3epgFqyD9CGifVtu+WJlJEfSO30xEppV4rGP2kgDUTfM3jxa1lETLzkfJATWixb7
         iSUEOXcDCayrCExhZpjNJk/flnryB1EA9pZEcn9YoONQWMah3YwicmYMg0FwKnAAIEG3
         EvrY00/sHB82A0hwnLrBTXY2rAt3DYim7WTsy6AvNqIGsZz8oSx23f7UUqlewW/1/+qr
         C+VMKF1b0v+BQL8tXTs4zfqcZrz1G/OU0HiNFhSK0W3kQxwjSTSPNGuHjfPY3Vmc5HxK
         +/TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VF8T3c+JVdlAKxcXmMWBq81K4KmYQwVJxfIeNGY8A0k=;
        fh=Dpq09KbU9A3W+XeyeGu8ot4Ys+FSE87V7W9XZrzi7gU=;
        b=RsT24xrEv9lAKK9lBYPXGIvx1Xld/2StuWUW5fPKZpdj4KP+wj5ICmoNx1gVCSP4BE
         XksXqIMQ03mJXqD+BXSJOecE9oRdZ2cQFCfmoaekmP588nVHfKHXNipZ2VlI8Iycw4b6
         mNGBfvg6aPGM/v9e7pGCZEj2G/aZ4kUTT9HgjAlkyjMBJBuC0LSI3PavS+E1bqnNfiGt
         O1heQuu7fv1g4eHF5ST4RCeWV6yLbc0Ia9pGVyomK0kOz8kFTLydbFuci+2FZkPsZ3Mf
         Fuq7qqHQvTFi8VRlQmAfZK15ye82Ht3z93rulf8TZoXC5aN7hIsy9hLqfekE8VAKiBkc
         Cx0Q==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791488954; x=1792093754; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VF8T3c+JVdlAKxcXmMWBq81K4KmYQwVJxfIeNGY8A0k=;
        b=bUEQF7L20NLiCnsyVfSBjeCA5e0VWTcMNRlTUjJbuRu8ekwlFfLvu2kmoh7Gx3zc9e
         SQu1JHoyszmiO10vwET9hGgnsx0ExTh1HKyA14eKzyNvKccrAxN3ao5dvIP9qOQayjQg
         qdFs+kw4J3UjQg6dD0ZqAHOmldZg89WqN8ip68gIWFCUpnkM745UqkwyST53wiMRUheM
         xDVpaFBl7VdLmNPnb+vtj3uAesvFCjyjiPQRT+pVpH0hnmqG6H12hcwKkJjSrFiqYcM9
         owAKFxbtHWX6t/9Ih7Txd9IqlInK+1hkZC1Fhq9oObKyxET0Y5c7+Vsbs+dJc6/++Loe
         9DGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791488954; x=1792093754;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VF8T3c+JVdlAKxcXmMWBq81K4KmYQwVJxfIeNGY8A0k=;
        b=tpKs0pOuaUQHWSrdVnUxGRgY28OoL80LkUpIWIPnS03lMeBp4QDVfuutaoH3/7q54P
         Z+8NWtsRPvaZ+oCyrM9faD0hyDFe3KWkJcVZU2HgCxgR0wrTWIcp5vFpQMKn8pO6HIFR
         9+kOnmrv/rRVQo70Z1gtRyzQwDtSKKYam723ERJahNwra4hHE/yNLxi8yV7IQfgEtxu5
         n0jWJBrao003DhB3UOgNOSEN5WOrVnH4not1UVEJSE79DtYdWcrxbyZcHWnYcxMuQ+51
         ueSqyxFAWQNkckxe45RyHQElSBZrY4FvqZAlJ+AkvrLv+zVAWH0zEw/rirscgJCqVObH
         0sAQ==
X-Forwarded-Encrypted: i=1; AKwUvBxAq8hy9yXZeYQ4V1cHIxzFJRb2BlhC7UisK3Og/N94ZCjXPlEJAFPRc0Gif7VbH87qmO1g7Mp/H78sM1Q=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lKHkPjDs615Y/tvQrY16cTWBhUBRgY6YExQpxg4scFOEbBxaJF
	KShcm/iuoFRoeTD/7KMUFXKY2u1aDfDiw3fzmsrKbEYWX1kmYqkfWjd8W/MxAs6grZVeaw+kx1r
	hDu/CSme2gao+43To259Udk2IhwgWArg=
X-Gm-Gg: AYBFou3HrRc2N8C6SToJiN6FV9AlJ58bsMDQklSF93p7RlUiIq7vE5GkhPbIBQyljdc
	dvgEtsavAw7U2TzzuGvXmq76m6wTdtbWTHlAXL2sF0Vo83NXA06ItIJLJU+/ZaNvCrAnUaGR+fs
	I0ckBvquK8ICR78JJ+pH1h2tAm8Y7dUOcrh81ysjVZWIvwdwyY5ZyhVdN9s44uuF5QCKI6DQzTW
	aS+41jLHaHXLsRoGb15sjuhpD7eVtdfNGZ6HpzYf6sZrMAaqFGlf7dkkT2b3wVOG4DUGRASme9a
	JfLmmsi3SVTMpIFRqSVR8Umcq1qrDyEJlS9dbC307ucfJWlvZPUPxtRRD6Oy+KrtIeAkx+Zu5re
	SxcsSCPctPhop4yUdPl0CzyuACr4xQ1ffXd03re540tA2rTSOHuHnfoylHrd5ZzHkaAyGnKEOu3
	Z3wSj9G8netzIfd9B37oSO
X-Received: by 2002:a17:907:1c93:b0:c2e:61e:f4fd with SMTP id
 a640c23a62f3a-c317bb4d1d6mr678650966b.5.1791488953277; Thu, 08 Oct 2026
 12:49:13 -0700 (PDT)
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
References: <CADnq5_P_y-6Ra4Swoxz-CmL1Q3nGhM3RVJUAB2iw1E1D-r1cjQ@mail.gmail.com>
 <20261008193356.GA920772@bhelgaas>
In-Reply-To: <20261008193356.GA920772@bhelgaas>
From: "Perlow, Jason" <jperlow@gmail.com>
Date: Thu, 8 Oct 2026 15:49:01 -0400
X-Gm-Features: AclHuK9lS4qMXsIqQtLZTvbvn4pXQsnJpTz-SJNc1hOoHum8WTGW7X9lZuuEvIg
Message-ID: <CABZrw2ErJVdJ=vm15+9YeCmpn3n2OxS6HypjRJ3dZWU0tdcxow@mail.gmail.com>
Subject: Re: [PATCH for-linus] PCI/AER: Skip error recovery on false alarms
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alex Deucher <alexdeucher@gmail.com>, Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
	Christian Koenig <christian.koenig@amd.com>, Vitaly Prosyak <vitaly.prosyak@amd.com>, 
	amd-gfx@lists.freedesktop.org, Aditya Garg <aditya.garg@linux.dev>, 
	Thorsten Leemhuis <regressions@leemhuis.info>
Content-Type: multipart/alternative; boundary="000000000000ade413065d5986a5"

--000000000000ade413065d5986a5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I will test the patch on MacBook 16,1 on RC6. Stand by.

On Thu, Oct 8, 2026 at 3:33=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:

> On Thu, Oct 08, 2026 at 03:23:34PM -0400, Alex Deucher wrote:
> > On Thu, Oct 8, 2026 at 3:17=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.or=
g> wrote:
> > > On Thu, Oct 08, 2026 at 02:26:00PM +0200, Lukas Wunner wrote:
> > > > Alex is seeing a probe failure of the amdgpu driver after the Root
> Port
> > > > above an AMD Navi10 GPU has been reset.  The reset was performed to
> > > > recover from a Firmware First reported Fatal Error.
> > > >
> > > > However all status registers in the Root Port's AER Extended
> Capability
> > > > are blank, so apparently the platform firmware raised a false alarm=
.
> > > >
> > > > The issue is only occurring since commit eddba19b8b5f ("PCI/AER:
> Support
> > > > Advisory Non-Fatal Errors").  It looks like enabling Advisory
> Non-Fatal
> > > > Errors causes code paths to be exercised in platform firmware which
> > > > were never validated before.
> > > >
> > > > Skip error recovery on false alarms, i.e. if no unmasked errors wer=
e
> > > > actually signaled.
> > > >
> > > > Note that this will also skip recovery if both the Status and Mask
> > > > registers are "all ones", as would be the case for inaccessible
> devices.
> > > > However that seems justified because it would imply either a
> hot-unplug
> > > > event or a Surprise Down Error further up in the hierarchy.
> Interfering
> > > > with recovery from that seems uncalled for.
> > > >
> > > > Fixes: eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal Errors")
> > > > Reported-by: Alex Deucher <alexander.deucher@amd.com>
> > > > Tested-by: Alex Deucher <alexander.deucher@amd.com>
> > > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D222095
> > > > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > >
> > > Applied to pci/for-linus for v7.3, thanks!  I dropped Alex's Tested-b=
y
> > > since he hasn't tested this change by itself.
> >
> > FWIW, I just tested this patch by itself and it works as expected.
> > Feel free to add:
> > Tested-by: Alex Deucher <alexander.deucher@amd.com>
> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
>
> Added, thanks very much!
>


--=20
*Jason Perlow | Argonaut Media Communications*

*Voice/Text * (954) 242-3484 | jperlow@gmail.com |
*Blog: techbroiler.net <http://techbroiler.net>Read my Tech and Food
Industry articles:* https://linktr.ee/jperlow
*Bluesky:* https://bsky.app/profile/jperlow.bsky.social

*Need to schedule a meeting with me? *https://bit.ly/3y8P3Gp
<https://calendly.com/jasonperlow>

--000000000000ade413065d5986a5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I will test the patch on MacBook 16,1 on RC6. Stand by.</d=
iv><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">On Thu, Oct 8, 2026 at 3:33=E2=80=AFPM Bjorn Helgaas &lt=
;<a href=3D"mailto:helgaas@kernel.org">helgaas@kernel.org</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu, Oct 08, 20=
26 at 03:23:34PM -0400, Alex Deucher wrote:<br>
&gt; On Thu, Oct 8, 2026 at 3:17=E2=80=AFPM Bjorn Helgaas &lt;<a href=3D"ma=
ilto:helgaas@kernel.org" target=3D"_blank">helgaas@kernel.org</a>&gt; wrote=
:<br>
&gt; &gt; On Thu, Oct 08, 2026 at 02:26:00PM +0200, Lukas Wunner wrote:<br>
&gt; &gt; &gt; Alex is seeing a probe failure of the amdgpu driver after th=
e Root Port<br>
&gt; &gt; &gt; above an AMD Navi10 GPU has been reset.=C2=A0 The reset was =
performed to<br>
&gt; &gt; &gt; recover from a Firmware First reported Fatal Error.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; However all status registers in the Root Port&#39;s AER Exte=
nded Capability<br>
&gt; &gt; &gt; are blank, so apparently the platform firmware raised a fals=
e alarm.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; The issue is only occurring since commit eddba19b8b5f (&quot=
;PCI/AER: Support<br>
&gt; &gt; &gt; Advisory Non-Fatal Errors&quot;).=C2=A0 It looks like enabli=
ng Advisory Non-Fatal<br>
&gt; &gt; &gt; Errors causes code paths to be exercised in platform firmwar=
e which<br>
&gt; &gt; &gt; were never validated before.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Skip error recovery on false alarms, i.e. if no unmasked err=
ors were<br>
&gt; &gt; &gt; actually signaled.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Note that this will also skip recovery if both the Status an=
d Mask<br>
&gt; &gt; &gt; registers are &quot;all ones&quot;, as would be the case for=
 inaccessible devices.<br>
&gt; &gt; &gt; However that seems justified because it would imply either a=
 hot-unplug<br>
&gt; &gt; &gt; event or a Surprise Down Error further up in the hierarchy.=
=C2=A0 Interfering<br>
&gt; &gt; &gt; with recovery from that seems uncalled for.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Fixes: eddba19b8b5f (&quot;PCI/AER: Support Advisory Non-Fat=
al Errors&quot;)<br>
&gt; &gt; &gt; Reported-by: Alex Deucher &lt;<a href=3D"mailto:alexander.de=
ucher@amd.com" target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
&gt; &gt; &gt; Tested-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deuc=
her@amd.com" target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
&gt; &gt; &gt; Closes: <a href=3D"https://bugzilla.kernel.org/show_bug.cgi?=
id=3D222095" rel=3D"noreferrer" target=3D"_blank">https://bugzilla.kernel.o=
rg/show_bug.cgi?id=3D222095</a><br>
&gt; &gt; &gt; Signed-off-by: Lukas Wunner &lt;<a href=3D"mailto:lukas@wunn=
er.de" target=3D"_blank">lukas@wunner.de</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; Applied to pci/for-linus for v7.3, thanks!=C2=A0 I dropped Alex&#=
39;s Tested-by<br>
&gt; &gt; since he hasn&#39;t tested this change by itself.<br>
&gt; <br>
&gt; FWIW, I just tested this patch by itself and it works as expected.<br>
&gt; Feel free to add:<br>
&gt; Tested-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.co=
m" target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
&gt; Acked-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com=
" target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
<br>
Added, thanks very much!<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"lt=
r"><div></div><div dir=3D"ltr"><b>Jason Perlow | Argonaut Media Communicati=
ons</b></div><div dir=3D"ltr"><b><br></b></div><div dir=3D"ltr"><b>Voice/Te=
xt </b>=C2=A0(954) 242-3484 |=C2=A0<a href=3D"mailto:jperlow@gmail.com" tar=
get=3D"_blank">jperlow@gmail.com</a>=C2=A0|=C2=A0<b>Blog: <a href=3D"http:/=
/techbroiler.net" target=3D"_blank">techbroiler.net</a><br>Read my Tech and=
 Food Industry articles:</b> <a href=3D"https://linktr.ee/jperlow" target=
=3D"_blank">https://linktr.ee/jperlow</a><br><b>Bluesky:</b>=C2=A0<a href=
=3D"https://bsky.app/profile/jperlow.bsky.social" target=3D"_blank">https:/=
/bsky.app/profile/jperlow.bsky.social</a><br><br></div><div dir=3D"ltr"><ta=
ble style=3D"border:0pt;table-layout:auto;white-space:normal;color:rgb(95,9=
5,95);width:650px;font-size:11px" cellpadding=3D"0" cellspacing=3D"0" width=
=3D"650px"><tbody></tbody></table><b>Need to schedule a meeting with me? </=
b><a href=3D"https://calendly.com/jasonperlow" target=3D"_blank">https://bi=
t.ly/3y8P3Gp</a></div></div></div></div></div></div>

--000000000000ade413065d5986a5--

