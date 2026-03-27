Return-Path: <linuxppc-dev+bounces-18945-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8DF10F286F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 21:01:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fjCjS1M8vz2xQB;
	Sat, 28 Mar 2026 08:01:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::82f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774645260;
	cv=pass; b=aPam9SOgFAUYBXcAY8oJzZ045v/E4kqhTFuRQnpwTQCEXUxdyKWyAm3xpN5Hk1GCtkzYuBGX5+a+DcFjSAph/vVKgdOKkzEYDbT3caUNuEp+vzTV5CaL3vBaiG1ZyBokEAWhKSDFvrp/kTrkfnZArpqWCDAF4qgcJKyPtoPhwGEu662xr+Js0Oy47NldH2gH5zui1uyN4zDnC7X9GXVGkCWXq1UlNwcsmnLl0hhZwUKB+kimOzl+0auaYaSovu7JAzi18GeFOvi55fhKU6hiotzO1SG+OOy0LegVGchTY+B97Eh5jaJA+7M92oEFE9H586bs2xZfUTEmJxKWQy44Zg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774645260; c=relaxed/relaxed;
	bh=uHvMP9KDYXp5B8fQ+exmdFOH4CKDCprqxecGbubjPqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RdPTAqlicImTM0DoVdC2OHphzRHoe6xkpnms48/tMBWNerHcTISjvdBant3yDfcyA0gdiqHe2RBN6EaP/6c6sA3E2/F13xneNMd+2edZPnM7AdYgcfBTfL+regdDCB4zbT8GEMyWPwMUlNie7bQItBTW9/8o5e0UCJPYcb5SKlAhKnI9KK7D6EMZjwDRziPbtOq1It8I5/3Eq83bYfdflMEhZapID9yDvHMSYsTsEGshXQEJOzQsoduO59Dye5jNa01EWC9Op9nIdJ4CUozEqaTUD/vlOBvSbaCRZA7fJffYWRV87owKK7/U98ImnL9MJFzQiyXoWGKZmC+aYziLAg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Sxoj5x4d; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82f; helo=mail-qt1-x82f.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Sxoj5x4d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82f; helo=mail-qt1-x82f.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fjCjR212kz2xMQ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2026 08:00:58 +1100 (AEDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-5091ed02c54so50451cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 14:00:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774645256; cv=none;
        d=google.com; s=arc-20240605;
        b=F+Kd3J32Xc++qyKHpV0bXLNCy+34sJxBND4ILqBdePAyXw1QDlCPaa3Nv3ObteBOXz
         LdoeHjWx+OjmYTpY5954hm6t7VTEs88J7AS/SqdfRaPRgMx5NVV4RqPSwc9jOyyDHmib
         nL65tRNTScfw7JcTsRiSEBsO0DF/uEndGc4DqlO5S2JJN2js4Sf2sfI60RqrER9ZR9E8
         M1EVYUbzleJdJ38g0uIeBq+4cc45n9/uqKVmIOu3pLPs6Ddyoz/JliWAzMcvJX/K0so0
         UhRajAhdsoZi0ad0rciyYczP+3lAGUvMW9udf621tZm5DqR5iuCrPA1kx8QjP5gheccH
         mchQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uHvMP9KDYXp5B8fQ+exmdFOH4CKDCprqxecGbubjPqI=;
        fh=46sJzz6iw9Sl5VNM0YbUqAo3ulL3kI5594Uza3fPMIg=;
        b=M1sTovO8HUTbFDreM9ouMi53skJUVLj1onOuV+fHbykUkdcsRNoHjTMcfvY21hN/bD
         LnnC0+KAhzpnnxTuS+oMQDmsnVQYu16GcquBxaYrcc+rchTJuilqEEczcKv7lARfmDns
         dCkQizN7CkGs/Wzgop9nmF9QINU11rPHRwVtqxZDexj1EhbV+5BOpbhNKb+2+qCc+7m8
         8HO5JTmvaU1PQKlU4KkMbew2LDD9MhLdEGJ0nKBalnlNnOU2xeuWVR4U6aevBLakQ3TP
         heg3ZSf5ZVGrDsEvk19Z1rLSSadrWSGYbqF21Kps7fPtj8EK9ITym9mN/UOwHfQ5PeWK
         3Hcg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774645256; x=1775250056; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHvMP9KDYXp5B8fQ+exmdFOH4CKDCprqxecGbubjPqI=;
        b=Sxoj5x4dhdYkAoXgTRCId91KOxx9U67gotuPzwluBNsoxsmckD+MDChSm5oXiDLYlI
         2Tgr0zQ7R2LCZeMVHB2AMdsTIApCzhYsARO+PN9vgsnwg+9mne/i4/YVgxAaVaZrrwd2
         DnGKs+SHyAlZ/wvB2F01PWb1xEcn4NDMHcq1NWIElPsdndMavXv7ozaduQ3gMD9FKUyH
         FjIbGV+77YA6biO5+4RO35k/lNyKFc8S/+2Znn5oHWaQfRGy+qnJpXzEUl5A0QmtBBzI
         wGOfimjO/KLZ9w818Ew6rEAzIPYyUWlags/sDcsIJuYxHNpH2dWiwAkTrT/NZHPMwEfW
         SUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774645256; x=1775250056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uHvMP9KDYXp5B8fQ+exmdFOH4CKDCprqxecGbubjPqI=;
        b=IFKRIQz4zRxiZLcmzsXB8VtcWFa25Uuti2O/39+VEUGahqlZX/jKCvZJ0gPnpFtj2b
         5TZ7Trk0R2hbBr0q2FGKTYVdV2YxRojUZFJ1/HhRHncFbPcE7ykTBxKgZKWhbbqj8u9R
         nbk1a947FzWcjEglX/ygZoOlS3OvtaOIholI4yIYFuX+3chrVEJ6oklrPR19JYsFBuvA
         rZ4Mr5W1VsOT59PATIshCQ2ChBvWHfTcFQYgOANj1UKRRDYGrHxNjfgoSPK/d/aqc3Y6
         51R2ljU1KDIVnqg44LEnGoJo3CxyY4gihb+5LclsDIu4HWT1zDQiwg0WIzHtyqigsyxc
         0F4A==
X-Forwarded-Encrypted: i=1; AJvYcCUBJhmi7X3bD1w/8I6ofOkG4gkYkT9tAn5LEj5ghS27XerjtCekkJpZX5IC5W2o4ctjNy5PGlaE+cUUY+g=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyoeTjygDS5sPTVeR3LI3sJtbngnx5jqe7a9q0OER2pBFGJHErZ
	yZFaqiUjvr7fbX8UAko6wDUpNky7+9WwrZE4lyNioHLiqsdCQwajj5UeG+jZxS2ldNBQ01TROGv
	gMehNeZxuQdwynV6knTpullGhKyOme8yfAZzzSEg9
X-Gm-Gg: ATEYQzzZywH/jv4e+0wdBTpdHDF7RMwaMTCaDpYVLiY/2t8m1lWixhN+DgQgbLwbgLN
	B1kj29BM3U3j6xhALoIUr6IO176zF9Hx/TDp7Zu6XBH5hxHZPSRBemcwZr6Aafful1j2dnLqxhr
	zhP3aWHqAdHLAfxk6OtZbjor106YnIju4RgOGks+dt/qgHy0D2MxM5mCmN97VNIjPOgcrh/Wc4C
	wNanWBuIShVb1dlnHrztieXBtgm2Zkt6Cbfrsm538uBy0ekhvAMZupPNqf1plZiQmoFf/pA+Jpt
	FuuRd8i32HhHCu6PVf78UW9Y0dk00Hu8vM5C
X-Received: by 2002:a05:622a:aa50:10b0:509:371:f2ab with SMTP id
 d75a77b69052e-50bb288a2e6mr3465221cf.16.1774645255554; Fri, 27 Mar 2026
 14:00:55 -0700 (PDT)
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
 <CAJuCfpFxZsnZqqfoKXX=JEBrBaqZHNAgBE0VHbTc=GhQzP7X=g@mail.gmail.com>
 <df0c2fc2-467a-4ffb-a697-7c89d64bad6b@lucifer.local> <CAJuCfpHthntC=BNpWWYHePTfJJ5WQr_UkByc_-LViuy5V_xQ=A@mail.gmail.com>
In-Reply-To: <CAJuCfpHthntC=BNpWWYHePTfJJ5WQr_UkByc_-LViuy5V_xQ=A@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 27 Mar 2026 14:00:43 -0700
X-Gm-Features: AQROBzCX6JW1WY1HEKM5C3tQVZuMaYiRbHqFEwYBGPSueKMxsSn6D7aAg6e_Ipc
Message-ID: <CAJuCfpG78eMr8JjXLUi3toipy1chx76Bq5qRnt9dBqVLrxfLBw@mail.gmail.com>
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

On Fri, Mar 27, 2026 at 10:38=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Fri, Mar 27, 2026 at 10:37=E2=80=AFAM Lorenzo Stoakes (Oracle)
> <ljs@kernel.org> wrote:
> >
> > On Fri, Mar 27, 2026 at 10:32:27AM -0700, Suren Baghdasaryan wrote:
> > > On Fri, Mar 27, 2026 at 10:03=E2=80=AFAM Andrew Morton
> > > <akpm@linux-foundation.org> wrote:
> > > >
> > > > On Fri, 27 Mar 2026 09:47:38 -0700 Andrew Morton <akpm@linux-founda=
tion.org> wrote:
> > > >
> > > > > Three of your patches lack review tags so now it's 65!
> > > >
> > > > Three is now zero, thanks Lorenzo.
> > >
> > > I just finished fixups for issues Sashiko flagged. They are pretty
> > > small but important. Testing them right now and running Sashiko
> > > locally. Once done I'll post v6 and will ask Lorenzo to re-review
> > > those specific changes. Sorry Lorenzo, I'll point out the specific
> > > changes I had to make and will try to make it easy for you.
> >
> > No worries :)
> >
> > Could you send to ljs@kernel.org on the respin? Sorry to nag about it b=
ut my
> > email more and more set up for that and makes my life a wee bit easier =
:>)
>
> Absolutely. Thanks for the reminder.

Doh! Just noticed git send-email doing this:

(body) Adding cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> from
line 'Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>'

But it should also land in your kernel.org mailbox.
Just posted v6 at:
https://lore.kernel.org/all/20260327205457.604224-1-surenb@google.com/

Lorenzo, please see the cover letter where I list per-patch changes. 3
patches not listed there were unchanged. That should help a bit with
re-reviewing them. Thank you!

>
> >
> > > Thanks,
> > > Suren.
> >
> > Cheers, Lorenzo

