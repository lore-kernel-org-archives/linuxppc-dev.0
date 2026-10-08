Return-Path: <linuxppc-dev+bounces-29075-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F19CA6015
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 21:31:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j138v72kXz2yLY;
	Fri, 09 Oct 2026 08:31:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::62f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791489130;
	cv=pass; b=MujjVDLFZHHidJiWhQP91ar6lCMRhKcq6wXYVoqmWsbusYp4+XNZN2RHyGrRA4SC+xRYmt1X33H7/vFtVRkoYIX0XWSUecUQaSiKi3nDmTFroFjytZEdai5NQZUCJroaOCQllGthKLOanul6fbtgzsP8pR4vOyfIb4mVaAfJNxxQcrTPu9YqKC7EpgH7nYRScHPKcwDcVQNxHBqj7UYpHM3sIbYVRGI5sRFnzVsa92yD6IJwNOGiCXQew5UufzfLHiZrk/7omy9YVLYanhAjUfbPcpnB2kK2zTI/OkZdzWgHOAcSAuk0EuAeuQFyV5yyb1upktRdoVnNI5/K2jCPfg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791489130; c=relaxed/relaxed;
	bh=IBn8UBl59QaQ8yJvSSYhTj/Sj9vsUATA1ocADrmat4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBKqG1Nx7d0n5Kr3J7iNbdO/KhtMrOV4PIumRLGjnXKJFh6fm537A/QO1wFEGCj8etu3nkdEGcCG3B6gQ3g1mNp+YdhSZYcrH3CENaNR+VkM5JS7plPBarFtRfJ3vmud4Otp7gRzolW6D95UOFiHBfNu0G0Wu/u8XecxdaHy0kzXvlQNQRAky+wbV15GY2aKF+lauCVDPaKVF8A41Pep1R3iiD7qAdra/ZuCAL8WW8vWOiECJn+c/jD//KfntIs18NVCiCjjz6+tV9RyAmikJStFG6NgAJf7Qto5WE822oyIw9j6pUrcZ/rmURa567AqjmIUr9fOnVmLneWgd8do/Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j2cmV8VK; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com; envelope-from=jperlow@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j2cmV8VK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com; envelope-from=jperlow@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j10y10wzBz30Vb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Oct 2026 06:52:08 +1100 (AEDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-c2e3846d1caso504311866b.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 12:52:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791489125; cv=none;
        d=google.com; s=arc-20260327;
        b=GgsuDBWarZ4//Km3F6J8W6PRroLTZnO4G2Fjms/5gietBEleUhEOAP5/pVej4QGjET
         o/QfuDrZHGbl2IWjL77D7pNqgJD6c+pZJj34CAK3sdOzepIub1TKDU3QmSFaEiwH1LM+
         M5RttHFn98pCAkphH623hUqGEqc3jixFxwsU9KDF8qmm6vf2uLvPzUBI9SsU32ZXnmaj
         z6rRwDjhZP8Xt65PrHmCWbSj+e9e1gNzy1GQGdw+wpH9JisClJ+jJFD6cyM3UXmOmWJD
         MiH41JmZ3TmyY1pNfUYzvG7QDtxLNCQmMgXOBBrxk29Gq70h3smTXN4oUa3p3Y+wndSk
         hmLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IBn8UBl59QaQ8yJvSSYhTj/Sj9vsUATA1ocADrmat4c=;
        fh=FmdKdKkzpB1kEdxpFsMVzGrJ4+3m8mwzn5NOS5oDBSg=;
        b=SI6MKZRyWoggMyiTiSujkhuHD6d7aMlBcd5A3W7z+mbKqzNMCPXjWtL7RtzRdyXyD2
         /t2kEkdC1G3E3+3IsDoCjSLGN8DaolI3i/T9HLGECEbDgpkJwfg+fL3EBAeWH/7ZyUd+
         jbHnTjNm5F5j6ZKopfQNx6lBPiVfXu7oHhsHDSV1KoNCunwDVfWFU5jkmCZkB6dXfdzt
         fy+lTBHDMJI/CGEb0Qjok03HLsH8GE+jdxViqABtAQHZN4ca1BkV+2arZ+Xp7jgMWaBY
         3MGKgff3tzyNukU78s0Q77cW6FM9aBKVIQPAC7ebF/0A0aJgCxBVbUHyZ3cVB9fs/xC0
         /C0Q==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791489125; x=1792093925; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IBn8UBl59QaQ8yJvSSYhTj/Sj9vsUATA1ocADrmat4c=;
        b=j2cmV8VKJw9qK9SWS964dJ0z3oTnkkqXL5tfnUY+Ss6o+CRQ+9CQBb+DE5FrgijyCS
         1gTfg7Vog4+pgXsQ2mvIwq/n0Jbo6cKl3oU4NiR3kt8HV7CmeKfgahlq8hseem3rwlLH
         0BhJmcunNABT3aL08YHnOV7aJXmiwP4WJuls5Yl9LI7m6GNTZY1YhdJehhDldd5f2DIn
         MXlLX130gfYyweAaR6Kqe6rK8prg2YJf2dxKDop6018NE8k6dN5lxz21+OK7aNzsiUaR
         n8lN7OCdFCzg7a6X5L5didER0xusPpEPxOEQC5hDYcRafjVdw6uaG6JS3010M2BPo0ip
         zupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791489125; x=1792093925;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IBn8UBl59QaQ8yJvSSYhTj/Sj9vsUATA1ocADrmat4c=;
        b=h0HvXeDCzZP1MLeA0N1Y1DMrPItSCeAg7C1x2oQACDyW9ezPCL74M2JHSgFPXDvP56
         fZMW9rlxljJ2mpuHcqdhwoKed7WZnpmxMkuVdnN65Tf0usp5yRAPTXhSHE1u4Nyxknya
         B6ZukPmgE9qin8Rbtw4dU5jZIAuIEsLoycTkAsjLmycxDRiW4vH6D+cMyFAWpRmsxVvE
         QT3Y0Maj0ugAY+g0UvgjiJ9ceXf8Zbk5ni5qNSI4Y9wjKPokQwsUgED4fkWZLcAyYTB7
         cKJPjLtON0jptUxu/vL5emB8ATX61mAwA5Ou+/jOCluHxDtjMRcfKqK85uL+G0QS1LpL
         WyfA==
X-Forwarded-Encrypted: i=1; AKwUvBwiGkx8zJPMiVkJqj2VZ1Sos0rzw4pFxp25Q1MNa6V4417cujzGmOeaBHvSp8NB8J7ZiFGkiPLlpVL46yM=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lKJS5lBnAplEBOIs8nSQCQmp++THmNzLRwXeTJ42Eq5xEi592Z
	QlTrX3q+w34NZnNmaaqPKJa5fFh9OjMyFlhup6Jz96gC/eR9zD4jUvW2gk3qHyP/M+bqigomcMC
	IgzYOI81zxk955kCh8ofbu5diL/1qiE8=
X-Gm-Gg: AYBFou04UwywocutYgcVchledyo+3OFi/hwNPbyNTEUbi5dKSW/mkLvHLqjvD2hxbRB
	OHCxYfTpiQjuC+M2r6CySfS4m5XBLJepUbevINVcmUvrJykjz63QF8dkokCXdb83uYOwrLWLdpV
	wP3F8urDtCpzsgKr92dEKKlAwf6CJ14SsJiphR5NVIEf5Rc1Wa7ukiJj/RpXMROmsUzHglM9r60
	rAosB11DHgjzc3pBirj8GjtBpoWQxP2b6C0wIDfyyIllprr75L3CkGq2j3kXdcfKt9KFG1bUJg6
	EqH7z116Yn8tz2wqMqKdReCoeVnF3EkKxwohSv/yWjrPd8z67TX9eybwkuuA7uTxkUqd1opfpiT
	9AP2H/kwDQflo4khS/Ib0ZqV5NE55e1OtJ+pB2cJEzXXla0R2684APTvuj8QPrOVY+lEHM+h2yi
	7pI4m8UNqP5JyNdPyvav3h
X-Received: by 2002:a17:907:97c2:b0:c25:5faf:b207 with SMTP id
 a640c23a62f3a-c317bb259bemr616599466b.3.1791489125110; Thu, 08 Oct 2026
 12:52:05 -0700 (PDT)
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
Date: Thu, 8 Oct 2026 15:51:51 -0400
X-Gm-Features: AclHuK_zMRWk7ASXID34xVSxpJcH7wIRiAis5r8LGwSDA4hkaCnUCpps2BIgt-w
Message-ID: <CABZrw2GqV53Th=QNMZa5+hA0TcAJ1vHyPjKgqMykFxhTCp=2WA@mail.gmail.com>
Subject: Re: [PATCH for-linus] PCI/AER: Skip error recovery on false alarms
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alex Deucher <alexdeucher@gmail.com>, Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
	Christian Koenig <christian.koenig@amd.com>, Vitaly Prosyak <vitaly.prosyak@amd.com>, 
	amd-gfx@lists.freedesktop.org, Aditya Garg <aditya.garg@linux.dev>, 
	Thorsten Leemhuis <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I will test the patch on MacBook 16,1 on RC6. Stand by.


On Thu, Oct 8, 2026 at 3:33=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Thu, Oct 08, 2026 at 03:23:34PM -0400, Alex Deucher wrote:
> > On Thu, Oct 8, 2026 at 3:17=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.or=
g> wrote:
> > > On Thu, Oct 08, 2026 at 02:26:00PM +0200, Lukas Wunner wrote:
> > > > Alex is seeing a probe failure of the amdgpu driver after the Root =
Port
> > > > above an AMD Navi10 GPU has been reset.  The reset was performed to
> > > > recover from a Firmware First reported Fatal Error.
> > > >
> > > > However all status registers in the Root Port's AER Extended Capabi=
lity
> > > > are blank, so apparently the platform firmware raised a false alarm=
.
> > > >
> > > > The issue is only occurring since commit eddba19b8b5f ("PCI/AER: Su=
pport
> > > > Advisory Non-Fatal Errors").  It looks like enabling Advisory Non-F=
atal
> > > > Errors causes code paths to be exercised in platform firmware which
> > > > were never validated before.
> > > >
> > > > Skip error recovery on false alarms, i.e. if no unmasked errors wer=
e
> > > > actually signaled.
> > > >
> > > > Note that this will also skip recovery if both the Status and Mask
> > > > registers are "all ones", as would be the case for inaccessible dev=
ices.
> > > > However that seems justified because it would imply either a hot-un=
plug
> > > > event or a Surprise Down Error further up in the hierarchy.  Interf=
ering
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



--=20
Jason Perlow | Argonaut Media Communications

Voice/Text  (954) 242-3484 | jperlow@gmail.com | Blog: techbroiler.net
Read my Tech and Food Industry articles: https://linktr.ee/jperlow
Bluesky: https://bsky.app/profile/jperlow.bsky.social

Need to schedule a meeting with me? https://bit.ly/3y8P3Gp

