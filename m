Return-Path: <linuxppc-dev+bounces-23400-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE51C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 13:28:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grd473kdnz2yql;
	Thu, 02 Jul 2026 23:28:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::436" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782998887;
	cv=pass; b=l3cR0G8tcfOxLPvTHmmFdWQQXVnsKkqnIT0l5DLmSzWBzfmETE6Pf8iVRbv9k94bptUXR118zQlCwcekXSA0tNuHWWG/b9Rj0cXGtfN2WJDyljrrOf1m4N2a/IItidUh7Fead94NC5nqEa1glmKH7j+/QG3JmZShT0AvDHCUTyhPq4MABlt2iObE+TYoMXFx6xW4csNafBD4pVju7B2a7E0bL1nAPpsPbVTqB0dnqwH6S7mS5lGby9JHXwJ2s0ijuT8fTekYYQQkH7OuZw6Fj2XzmstVhfjSi+iYVcVcvTjs1dlkHdRNCUYz+H6UtxxyBuInK2ae8O50Mh65Ukbn6A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782998887; c=relaxed/relaxed;
	bh=NNJ2RnvoQeNfDsJ73crtioMLjPdXpQiGlVuyqIgcPxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fjwOuA1JX2CkDvDERzYZv9yW6xe4rnxYk6D/W5qGoYe61/Oo+SIRsEbWcYjO7Scs/5FCtNBdm9ToJAH0M/bYZaEGO2LlteDJAxBhTk3C1d6x1uxgejLWvHoiNNdgpLkGXO+Tb7J5o9bLdNxEQkMFV5IgPxJsRnbR8GKOhlTY0ejWP6X/gRHyqUMmPV5EpdlYq/uAWI853yQfD7xbdUh9FUNALnJAj4eAqkVOMLtR3EywhhRkKkE3vaENvVByqW6GydO/QCVWhfGV9NSPxDSQp5zEKjqcHH9DRbQ4mldTmf3DdrbtzQ3e/Y9fZU7q0xqdIub7NVS4WQQWPnCd35OGyg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=LjxSYHc6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=LjxSYHc6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grd462sXKz2yhD
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 23:28:05 +1000 (AEST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-847968ca62fso1679767b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 06:28:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782998883; cv=none;
        d=google.com; s=arc-20260327;
        b=JYC3KiUZN1Kb/uRrqNp70UdFsUSsE6BhDNQQmFQcu+dnByOptZtRGjB/thYinAF5x4
         bkcBBCWNNHKnvfxYrN28rUywAp4kEajmHpO+koQ5SSG2TMIv/mF13pT1e8flU2xkpBgF
         MiANjJmaDPFpW7U3Nko4jxCVVdmVVVQ9HKkecJpnsJas59VMAxMH6ZbitZ4npUgsB1Ec
         gHopWZdTgCV+Y3/NVo2KabB4wT7Cb/Ay8fljKp50gHMX+ud8XStl4UEb46/QzsaY2o7S
         XyL0ucA+NPSm5UAjN9YKzLZViM0ehzcuBW/k1RVIuzw1DggPlVD+apiRMELj3u1hVaFB
         T8+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NNJ2RnvoQeNfDsJ73crtioMLjPdXpQiGlVuyqIgcPxs=;
        fh=mXCSbDsQdCruMVwyLNS7Rzxy7d0O23DsBUrZEpBwsH8=;
        b=WAJKhyvoflDUYURHdSi+oodnyoo8i/EP9qw7EcTuQGo5Tg7V3YkIPG2fR/A0O1AWaa
         RAg3dkjT8BRFgRzKl5hgI+5ecRF2Qkj9ihOdtOx0yagfa3LZK2uv691jHm3i3gwT6n/a
         JyAzwreeriU3rbPPeLRkKcHEQS+iXImurKRhsSVAAWkxURJNiyR2qGD+CRDVxpBDH6gH
         OWJruydrhKpyz4RZelKocFdNqNeSzaIFHsmQSfhdsatMkzbqM4nocMb4rP/2kdB1kOub
         Q2UkjnoDY84pKVXAYWUv/BENsSGFrgLbQ7zTsjtzbWN3rX6JhcsI7H5xJsYBprxJa+N3
         m1dA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782998883; x=1783603683; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNJ2RnvoQeNfDsJ73crtioMLjPdXpQiGlVuyqIgcPxs=;
        b=LjxSYHc6Q8Ss65bbpiVXPbE0GzrIDSN++afEIFsjKpJJE1zEf0E5EKySWawEZKD8yJ
         F56Cr+cJ2bmOPCcnKy2xEs4o9q/ohe4YxFg6Sg8NdhpSdS7BqdU4MRJHTA8tsojAzsGJ
         x/LBAATS3eVEd7DiOXeN0tdeBbiF2k1jJo4wtgbYECHXxRlYPZHlK6OPB/Yvkm/lxGo0
         qOjqIE16yylPVN9768AZt8jdhKN9Br95tR2JZLaDYbb2G9TpovCKLqkzGR5pSWXhapVn
         BSAFNGAewat3hxBClGn/nHAN8r8W3BvPaSDyF2fuA8XWjTGgDqJbB41oOZfOLvb+sUiK
         qXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782998883; x=1783603683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NNJ2RnvoQeNfDsJ73crtioMLjPdXpQiGlVuyqIgcPxs=;
        b=BjgMbcJuIC+ulBMnD8Vh/mnWiGldnPiGUADS+ESrizLVWeQu4acH1CAk+5/ETxzsxE
         p2hzeaEHWJ6GXIjlHvxvTATUYp/vibCCNGvC9wkyE36TefUJMcyEq4FPTt7TEmCzg50h
         4Uz+HECTx8D/ZnGNbizrG9pcIHvoqy2EAe50LWHlH6i5ZvzdjfktWYlGcRUYrtwKfwRf
         TbeBLd0ETZFChz1jmCfZdLi28rAQIHwcEPu9HyUGWfDyldWlL8zd9fjkoOQDWfAIL9Qg
         wL/DHIxgepY4ASuqhNAjxXSJ3iXWdK4MwST3s1B7acwktshiWyeJ+Wha9uZPqmW51f/V
         2l1w==
X-Forwarded-Encrypted: i=1; AHgh+RoT26w5TNBrKX13VDTJYW2SgJYG6d6Vjd6B42HHM123Eh+vn9zt2zYqpFFY9vWNd8cYu7OlTF6734sZXJ0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzJINvr/pYcLdCrSUFgO/OX9y/aT1PD6HOut/FukdSypv5PPRff
	xp+eBhrNBIL+5DtmbyfTI2CzNyE4Ka521T1EGAxR48JEt2BqfYHcAQXJhdUHnpxSQnLBYHrS7ES
	evV0d9ZS2qcOOYruKis83l2POzTKPPkG8kB8yYs/W
X-Gm-Gg: AfdE7cmw9NJBfjkdvaL0zGSqnaBIbOVrkUMA0VvFOxNO42ihIC9eJ2Xvcre8mIUzxMV
	rscCHyIeoUP8LK9RciIAuWbmF25CdKwPZAfmOIyZg8llA6sadbFRcl3ejtvgu7vxsXuifrzWjua
	mfHeTaIj+8Fld1Adk8yqu10ebF+DQXVCcUrYA6YjAXRFBoK7B20m2rR/Kj9W63qUFFi0pVbj3bk
	iyR80VlVYyWQpTukGnN4JhYqA4ObHvFRpmfYLOhErGpu7wbLFDUbB1PVeQfL1l9hxGksl23
X-Received: by 2002:aa7:8883:0:b0:846:bc60:5bf7 with SMTP id
 d2e1a72fcca58-847c0675300mr6113283b3a.6.1782998883309; Thu, 02 Jul 2026
 06:28:03 -0700 (PDT)
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
References: <261b1be5b8dc526b83d73e8281e682a73536ea28.1773155031.git.chleroy@kernel.org>
 <CAHC9VhTyOuuPs1uovodM9M_8zZeJnVXs9xrWSdPhZcjXUb=mvA@mail.gmail.com>
 <fce0a701-ee58-4cb2-b34b-8aec26aaab5d@linux.ibm.com> <09e72f42-e180-4e2b-b379-92b755792a2c@linux.ibm.com>
 <CAHC9VhTzuO=RFtrUUuZyieVdkrM5H4ZCb1=PoL-oEEgiw38azg@mail.gmail.com>
 <ea6e629f-dac7-45dd-bb18-5cd6361fe6c4@linux.ibm.com> <9c53ae3f-ccfd-4e8f-ac4f-0038e9b97a7e@linux.ibm.com>
 <b1d6e9a5-34ce-42ca-906a-d4237e18be25@kernel.org> <50507bb3-4229-4815-90e8-c01eaad058fc@linux.ibm.com>
 <ba00c7a8-b4d5-4d80-859b-d75e9c91ebdb@kernel.org> <203f6e6d-2ce8-4e47-99a6-f4af745e0aaa@linux.ibm.com>
In-Reply-To: <203f6e6d-2ce8-4e47-99a6-f4af745e0aaa@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 2 Jul 2026 09:27:49 -0400
X-Gm-Features: AVVi8Ce7kHZ6K-SM1XnzyYNf6UB60lCb0qSg6t5Q-Zh2t2hWQVqxIh32cuDs3y0
Message-ID: <CAHC9VhQvoK4uYP0NBnd4FGbXCQkDka4nHqdz9kAn2bGnm4qVHQ@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc/audit: Convert powerpc to AUDIT_ARCH_COMPAT_GENERIC
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, rrobaina@redhat.com
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Harsh Prateek Bora <harshpb@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, audit@vger.kernel.org, 
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
	ritesh.list@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 8:50=E2=80=AFAM Venkat Rao Bagalkote
<venkat88@linux.ibm.com> wrote:
>
> Current remaining issue:
>
> 1. amcast_joinpart
> ------------------
> Still fails due to a missing Perl dependency:
>
>      Can't locate Socket/Netlink.pm in @INC
>
> I searched the configured repositories and could not find a package
> providing Socket::Netlink / Socket/Netlink.pm on this EL10 ppc64le system=
.
>
> Latest run summary:
>
> amcast_joinpart/test ................. Can't locate Socket/Netlink.pm in
> @INC (you may need to install the Socket::Netlink module) (@INC entries
> checked: /usr/local/lib64/perl5/5.40 /usr/local/share/perl5/5.40
> /usr/lib64/perl5/vendor_perl /usr/share/perl5/vendor_perl
> /usr/lib64/perl5 /usr/share/perl5 .) at amcast_joinpart/test line 10.
> BEGIN failed--compilation aborted at amcast_joinpart/test line 10.
> amcast_joinpart/test ................. Dubious, test returned 2 (wstat
> 512, 0x200)
> Failed 7/7 subtests
> backlog_wait_time_actual_reset/test .. ok
> bpf/test ............................. ok
> exec_execve/test ..................... ok
> exec_name/test ....................... ok
> fanotify/test ........................ ok
> field_compare/test ................... ok
> file_create/test ..................... ok
> file_delete/test ..................... ok
> file_permission/test ................. ok
> file_rename/test ..................... ok
> filter_exclude/test .................. ok
> filter_exit/test ..................... ok
> filter_saddr_fam/test ................ ok
> filter_sessionid/test ................ ok
> io_uring/test ........................ ok
> login_tty/test ....................... ok
> lost_reset/test ...................... ok
> netfilter_pkt/test ................... ok
> signal/test .......................... ok
> syscalls_file/test ................... ok
> syscall_module/test .................. ok
> time_change/test ..................... ok
> user_msg/test ........................ ok
>
> All tests now pass except amcast_joinpart, which is blocked by the
> missing Socket::Netlink Perl module.
>
> Please let me know if there is a recommended package source for
> Socket::Netlink on EL10 ppc64le.

Thanks for following up on this Venkat.

I'm adding your colleague Ricardo from the RH side of the house.
Ricardo is very familiar with audit and should be able to help you
with missing RHEL packages.

--
paul-moore.com

