Return-Path: <linuxppc-dev+bounces-18933-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D00B10F2861
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 17:39:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fj7DR4T4Mz2xmX;
	Sat, 28 Mar 2026 04:39:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::82a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774633143;
	cv=pass; b=i+hYAS8vR0+AlZ9gqA/KXNYiSmeIU5E+TIqsYwj7VIEegu+TyPOpEkitoIN/4trSMVaJI/erAodraiOG6OCw0zZuD2Ju9f+T0UUEYMydJRpmbnZNdWUwDLbrEzpB4kRRFzGawj6UYPeU3cPj2S6lQ/S0x3SznRpRmRSa48Muu3+eJpfaIuVWJN+dW5O2ktVO4YNoXGtZpeKELJ+jhgTh/ZcqxkSRRmMjgR202AXG4oAqJva9vOQ9/F5NxSgWnswz0FoWBZ8CnCkW6V5h2aoLTgc56fgY1ZXOkWqdErqEpO3kOSQQ0TausmA4t5XoJUom2Rnt6HoHZlW+7OdUspLHAw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774633143; c=relaxed/relaxed;
	bh=iIqtQ0hEleo3fj3bC+fegFfEomfWKxCj28r2/iHbUtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DqfIeMdRmXTfwI6bqsEjJOjRwgAlDM+zVNNX6tB2gDx6wDiEhgWMfK1YadqhScAo5prVnFxe+R3qtfVBoHswb3fGDFwfFExElFr7KEzZZY5tY1pfKwcCuEJ5ai/+fgzdP7A6sNxGz7jMcPH2dMIkSQVn/Jz1CcQoM1sBcXVy13y9IuuEbt0CabxbE95G/cefKvi7OrNrr3xgj7heUgtkJGPNjLUjHrzZS1SbiYaLTrHVpYiSZZjBfiPy0cXgYh+wvZbt05QNQ2GxExeYdb8nDwAm1fpH553sl9gVFnobodbU6quUTdH09Z//xXCa5Ndw0hYlyp3wJLC+cUdCZJuWPw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=kLjNZ/3Q; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82a; helo=mail-qt1-x82a.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=kLjNZ/3Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82a; helo=mail-qt1-x82a.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fj7DQ4DLzz2xR4
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2026 04:39:02 +1100 (AEDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-5091ed02c54so33641cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 10:39:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774633139; cv=none;
        d=google.com; s=arc-20240605;
        b=ADMURuObJ2FLiPRCW1hbhFSdA9LVjwAUpWWnhsNoDIU1VSKXYhx7j3HYvt1UfxgKkl
         NJjjUKW1Byb0FGcxbISoRM62zJ/MbzbQeT5r5W7nL6gTKO7pVJvHQ/14iEl0x+S+CEAj
         wDUj7oOSMS1ZryheaVyHk3/mkLI0s3URXlIvq/sBz1mFf7mIqnEjbw4Yuf/A8Vf1Ca7y
         i3NInqZZC6gRDi4fYAYqoEQWQxEZaHPce54iz4EujE3adjxDirfQZFO1J3cY1QfpNKhU
         6l9RiTAJSCgyf3DsNd64p3jFufcvtCDjEN1PG1D/jTOx53XEcCIoetQ05MrlMJ1QWzf0
         VXyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iIqtQ0hEleo3fj3bC+fegFfEomfWKxCj28r2/iHbUtQ=;
        fh=eCheGhPFjmR9M0fz6MeB98X/EbfGyVY3/hyFTHK+Apk=;
        b=KEiTBVKJNNPVelUB4SprH2NOa8PiYLJO9v18FsKM+ZqOcpHkDg6jIAQup6bG08cTOv
         vhwEInbQjp1kU0oUNZEsEQh97QJ358xVTx4mLD4z8FuuorAQOX6qoPoSl0S3wHEN82GC
         aUuzLY8C4HycVAPF+o8VCbayPH+FXZ0M9Og2TKIhGtOJlHKfNmGdnt9C179HTpQ9eWgR
         SojfWj46GZ4FyZXRhlykupk8aKWtoZbipgmJd8rrtYqV4ANWO/jd0sq5urYqLzBBM1Z4
         4o2odPQsEmNWTnsKKQl7hLQQugV7DeDqedBu7RmrH7FsWczH8mextbLEcCjuL+pbzsRw
         dzEw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774633139; x=1775237939; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIqtQ0hEleo3fj3bC+fegFfEomfWKxCj28r2/iHbUtQ=;
        b=kLjNZ/3QpuAXa6aDRh6Igm0XO+ErVWHaRCsQ/i6fGwj1QxBsq4NChD44FlIcGolpaD
         kh5CfYiuMOGRTmUUk0/LI+pKBUF1DmjLt02OxOrOhBrWR3NDMFPEoORHgtTXp2fwe4y7
         3QzA31xvWvGNg3JY72Bt2jolvcaevoP1B31touWxUH+BIXkqGw+aspboKFAoevI5XYDU
         D5gQr4UA949zMH5LAo/7TaNt5fYfZhu5trBWYePTlzCi1JjG5Sb+cEeXGXJ6fk7mPFlw
         QGKUE3IwFO2bxaKjs8kLXd0215R+FJUpGwpgtgdMASX54cAQahUvgWPrsuf3dDOgze7e
         3r0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774633139; x=1775237939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iIqtQ0hEleo3fj3bC+fegFfEomfWKxCj28r2/iHbUtQ=;
        b=Od50w4UFt1t4D/dNB+o0srLqmnnSo/P5Mv4wQpxyt8kBV0VfC5lR3t87RjT0WVDPdP
         0QLZ64k/ncDYy1q7P4W6Q9BV/CAY6fUOF0NyV1j85uMWlvRJDo+OWhtw7hQvU9dKIN+f
         KXXJ1szoD2n2p4pZB91wDpf2PmMMUaUywWt+Y1D/FMv2KLjdQzRqRcxe8/Gh2kjOV8Nj
         pR55Rrj9eV2l9hbA9BxFZGdeO1LamodIGcympqYyKHwpaDfRLZD7A0pLVNibiqnjQrg2
         EgHY1B6cQvJZsJr781qEqQRn4OUACuRhoPuGzCSew9jtkLf1KToz16tJEz0B3H2gw1EF
         yjng==
X-Forwarded-Encrypted: i=1; AJvYcCU7T8eb8BLK6hSKlnPrUOuJ02aOjHAMucSSzyx8RCWsT8qt4V2GhLZ32TZZSflAdAj0aYQXINKQoUk+E8k=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxvR0A8zJRia3Ll3XlMN0PyP+sVk5mkJ5bGUCaIyXdn7UsniOOt
	ALkkWWTelEgHNG+cuu/UhWAi98/N3XIIIOF0uyvUVX3n2ZFvWLQTfi08+jIZMvYkNFOZjxDepCN
	n4E2d8OqRPFrk/zaEHSqkP0V1T9UVkAuk/FplD1wF
X-Gm-Gg: ATEYQzzpG6M+bd6jxeRaFdg0W+guv7YpSVnje10wFjyl8WJiU81PxW+lFgm4y32bQ5e
	/vEvnoZj+wBTyodui26A0DuZM+qbjxYnCkJxt3WnbD1Kak7sIkhLyxgngrQgenF9C7Ag91ov30K
	VOd6yYMrF1eHvzHOaIH+JXg4hRFq1EGMQsMn0Kgv8el7TdQR30Jklkuf9/1Be2vVcndMdEXN7s9
	OQMZzdqsFXNnncUbRh7iY+lJal7L/cbGSjI+3+R79AHyDAE3xbssgVkvGJ7DMBPvRq9l/4z3GUo
	SMx9415fRF9qQH+vev3UrDLCGIy+o2YIBin5
X-Received: by 2002:ac8:614b:0:10b0:509:1eca:6d24 with SMTP id
 d75a77b69052e-50bb268ef28mr670671cf.2.1774633138943; Fri, 27 Mar 2026
 10:38:58 -0700 (PDT)
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
References: <20260326080836.695207-1-surenb@google.com> <20260327094738.7150efc3b0619e6ccf095c23@linux-foundation.org>
 <20260327100322.b539f1a9f3662a0a4c080cce@linux-foundation.org>
 <CAJuCfpFxZsnZqqfoKXX=JEBrBaqZHNAgBE0VHbTc=GhQzP7X=g@mail.gmail.com> <df0c2fc2-467a-4ffb-a697-7c89d64bad6b@lucifer.local>
In-Reply-To: <df0c2fc2-467a-4ffb-a697-7c89d64bad6b@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 27 Mar 2026 10:38:47 -0700
X-Gm-Features: AQROBzDcdJIiYfqLEUVIyX_QE3l_JxzoPz7imokMkPm7FnH6uOW_OZAJgfsGn0o
Message-ID: <CAJuCfpHthntC=BNpWWYHePTfJJ5WQr_UkByc_-LViuy5V_xQ=A@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Use killable vma write locking in most places
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, lorenzo.stoakes@oracle.com, 
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

On Fri, Mar 27, 2026 at 10:37=E2=80=AFAM Lorenzo Stoakes (Oracle)
<ljs@kernel.org> wrote:
>
> On Fri, Mar 27, 2026 at 10:32:27AM -0700, Suren Baghdasaryan wrote:
> > On Fri, Mar 27, 2026 at 10:03=E2=80=AFAM Andrew Morton
> > <akpm@linux-foundation.org> wrote:
> > >
> > > On Fri, 27 Mar 2026 09:47:38 -0700 Andrew Morton <akpm@linux-foundati=
on.org> wrote:
> > >
> > > > Three of your patches lack review tags so now it's 65!
> > >
> > > Three is now zero, thanks Lorenzo.
> >
> > I just finished fixups for issues Sashiko flagged. They are pretty
> > small but important. Testing them right now and running Sashiko
> > locally. Once done I'll post v6 and will ask Lorenzo to re-review
> > those specific changes. Sorry Lorenzo, I'll point out the specific
> > changes I had to make and will try to make it easy for you.
>
> No worries :)
>
> Could you send to ljs@kernel.org on the respin? Sorry to nag about it but=
 my
> email more and more set up for that and makes my life a wee bit easier :>=
)

Absolutely. Thanks for the reminder.

>
> > Thanks,
> > Suren.
>
> Cheers, Lorenzo

