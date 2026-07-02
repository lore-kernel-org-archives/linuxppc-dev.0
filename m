Return-Path: <linuxppc-dev+bounces-23457-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3790CC43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 00:18:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grvTy6FYRz2yDs;
	Fri, 03 Jul 2026 10:17:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783016374;
	cv=none; b=abpC87oU7xJHkv/QuITbGCXY7z9+HVqWJGkxet1PnpZmvVd14xE3eTpkXHzrQM2D5fl1TzvcSPXgPOCQb1V1qxiMMuugE/jr5am2eqNAQXdq156xyVpYSSQoKxZlyPg9tvupqglFe1ftaeMzurTCmM4dyB9nUigr1yt1/6JWrFJFZ6AMFnE89ic4I3ymQqlQWV+iH+6Bk7Xr4001McylGx5Dh0dz4nl0xuB6zPocsHblkloctV3d0D/UH4MWp5dCjfMMCg5ypTSvwCDFgmjOIwXNDdu952qtIAmz44C6eHzB9kLRUMmIbHq/SrXh8xxkSc2uGRt18PzfXVfa//QsBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783016374; c=relaxed/relaxed;
	bh=GnE5UMGB7bIKe4dMgecSQwaH8m85iUChv9iFEZy7XRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bNL6Re4DqbGRR0UVsSfe37/Ep+l7myHGKcnoBxhuG9OTyakHUEETJDH/YTpxFj4ZvuL0Fb4l6ZOgPyW+XslzQNUtPiQtzkVKKw18a2Ukrv3EUOLrZIc2wTYp/wZdg3nqEHOELkxlRwhnKI+o36cQAp6+makIXLZsvxo5N0f1OageO3XhQLkzusE8bBdtQ52SpxUo3ExrLgCTDLIzjWpaGkTBSAymMs8F+3dBn1FjJ9EtmmgAHzwGedBTs78vrCi/DkJ1RxDCFMZQ9263X2bsC85PlLbhXoLWu9PqbovTuYZLFsfxUglY/3mjFCpyWfIhM1fcZm+qQogbxWTBIQKDgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y7JiZLQ9; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y7JiZLQ9; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=rrobaina@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y7JiZLQ9;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y7JiZLQ9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=rrobaina@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grlXN4JSKz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 04:19:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783016365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GnE5UMGB7bIKe4dMgecSQwaH8m85iUChv9iFEZy7XRE=;
	b=Y7JiZLQ9m6RjiU4yKQqiOYuZtrNH5Kq57hI10B20srU6YQsZN4PYD7IN31CKqoN6kkeOay
	yCJf/8xgCgcMxUr+tvkYQ7i+SF0FfSq7iaMGsaktVbwbyNCThqo0TlQMlGo12hOwq/R5S4
	LX9EKXPHsFTDJROZZjWavdm+Wr20j28=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783016365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GnE5UMGB7bIKe4dMgecSQwaH8m85iUChv9iFEZy7XRE=;
	b=Y7JiZLQ9m6RjiU4yKQqiOYuZtrNH5Kq57hI10B20srU6YQsZN4PYD7IN31CKqoN6kkeOay
	yCJf/8xgCgcMxUr+tvkYQ7i+SF0FfSq7iaMGsaktVbwbyNCThqo0TlQMlGo12hOwq/R5S4
	LX9EKXPHsFTDJROZZjWavdm+Wr20j28=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-bbhNVoofM22cGuTZJtmNJA-1; Thu, 02 Jul 2026 14:19:24 -0400
X-MC-Unique: bbhNVoofM22cGuTZJtmNJA-1
X-Mimecast-MFC-AGG-ID: bbhNVoofM22cGuTZJtmNJA_1783016363
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c07d22d503fso206277966b.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 11:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783016363; x=1783621163;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GnE5UMGB7bIKe4dMgecSQwaH8m85iUChv9iFEZy7XRE=;
        b=S8J9DCrKczOegngR1/tSxiXvKkkDr0xEIXYvezmZgStTKctkbde44ripAOppawZ2Hd
         GHqVVYBProxTtLyKNw4qVwDu8+3UXJ0EZZLk8JmgoCTrnPPArbYHJYSfukQYoyKUEHsf
         DfIyl8LrhTlBRMyz/KufzXvZc97YBQ81i6wxJlx9Iy7x5N9hgq6XffbO11Smvb5Aak/a
         N6taAgYJ9x5KroU69OV+i9d0I05qX8CD8rODUqrYziwHjYL3u7F+/kkzaDkWBiG8TrVK
         mI1S/ZWxIP2ja9N3VsgWfcP6HnQWjrP6Musx1Up0OMSYXIdpvPz4mNNTzHPCIEWOX56+
         V4rA==
X-Forwarded-Encrypted: i=1; AHgh+Rrz9DUDEz0GLvYd7SFPb5iKrIC75quIeJhI8cmBLKwyCf3J600iTETASLAURoOalSrmALUSNBdHKS3hnjM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxTe2y8Sr1Pd80pF3Lq9DBSzsiBKVjMPpDzCAfs90Wa5Nn5wYPy
	8ndFtwjzQEpjRMihKbeZZrmdKSjYmc33prRjzNKt48Z29+bmVrhihNEoWoma+vaKcPNH1PnlU/6
	lJhdRUvz389occmwU2zo+VibY0FpPd4q9raleXySkXLeBKGhrI88EAuAMHntWiX6k/+0VhNHqS8
	LXYQXGTdFbJlbbHxswWs/NDJAeQOi1zpeKDN9nKytZ0A==
X-Gm-Gg: AfdE7clAwKX+CtJ8IMpFyDNSjYbvI36FLHluHV+JCZX+JVSV+eHmLRgGXVtvJCRniwU
	AISGwiMKqETY2jr3Z88CUmtrFWoUomITK2X9oKMHlmkiVtU7IiYoIEm/fEe/B2rGouQhov86jTj
	GKUd0wUSHLlf+YVYkCEQslPp88FeTLC6rCu4jG35k+Pb+KYWUN63u5RxgyivGuxjsjOU1iIhbha
	EVSWq2VJf9wbk5GFXAPz52zQihVt7s+ub8hYpIgPxgg8GFnlRjctTpf
X-Received: by 2002:a17:906:f8cf:b0:c12:34f0:f7bf with SMTP id a640c23a62f3a-c12ae798209mr222262966b.62.1783016362695;
        Thu, 02 Jul 2026 11:19:22 -0700 (PDT)
X-Received: by 2002:a17:906:f8cf:b0:c12:34f0:f7bf with SMTP id
 a640c23a62f3a-c12ae798209mr222260666b.62.1783016362196; Thu, 02 Jul 2026
 11:19:22 -0700 (PDT)
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
 <CAHC9VhQvoK4uYP0NBnd4FGbXCQkDka4nHqdz9kAn2bGnm4qVHQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQvoK4uYP0NBnd4FGbXCQkDka4nHqdz9kAn2bGnm4qVHQ@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Thu, 2 Jul 2026 15:19:10 -0300
X-Gm-Features: AVVi8CfgJQQN8srCQcfoEeiecb8Fd_KUMFMpwzDJYWLdhmkZ5R5UO3-WcegNLlg
Message-ID: <CAABTaaCQCBuR9Ny6zBHNK=gy3Cd0WGj-f9qgzwuyjWD_i=v_dQ@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc/audit: Convert powerpc to AUDIT_ARCH_COMPAT_GENERIC
To: Paul Moore <paul@paul-moore.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Harsh Prateek Bora <harshpb@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, audit@vger.kernel.org, 
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
	ritesh.list@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _exbGpRgSgWl_PouXYjpyR0AmBrowSNERTaRkKRL9lU_1783016363
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 10:28=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Jul 2, 2026 at 8:50=E2=80=AFAM Venkat Rao Bagalkote
> <venkat88@linux.ibm.com> wrote:
> >
> > Current remaining issue:
> >
> > 1. amcast_joinpart
> > ------------------
> > Still fails due to a missing Perl dependency:
> >
> >      Can't locate Socket/Netlink.pm in @INC
> >
> > I searched the configured repositories and could not find a package
> > providing Socket::Netlink / Socket/Netlink.pm on this EL10 ppc64le syst=
em.
> >
> > Latest run summary:
> >
> > amcast_joinpart/test ................. Can't locate Socket/Netlink.pm i=
n
> > @INC (you may need to install the Socket::Netlink module) (@INC entries
> > checked: /usr/local/lib64/perl5/5.40 /usr/local/share/perl5/5.40
> > /usr/lib64/perl5/vendor_perl /usr/share/perl5/vendor_perl
> > /usr/lib64/perl5 /usr/share/perl5 .) at amcast_joinpart/test line 10.
> > BEGIN failed--compilation aborted at amcast_joinpart/test line 10.
> > amcast_joinpart/test ................. Dubious, test returned 2 (wstat
> > 512, 0x200)
> > Failed 7/7 subtests
> > backlog_wait_time_actual_reset/test .. ok
> > bpf/test ............................. ok
> > exec_execve/test ..................... ok
> > exec_name/test ....................... ok
> > fanotify/test ........................ ok
> > field_compare/test ................... ok
> > file_create/test ..................... ok
> > file_delete/test ..................... ok
> > file_permission/test ................. ok
> > file_rename/test ..................... ok
> > filter_exclude/test .................. ok
> > filter_exit/test ..................... ok
> > filter_saddr_fam/test ................ ok
> > filter_sessionid/test ................ ok
> > io_uring/test ........................ ok
> > login_tty/test ....................... ok
> > lost_reset/test ...................... ok
> > netfilter_pkt/test ................... ok
> > signal/test .......................... ok
> > syscalls_file/test ................... ok
> > syscall_module/test .................. ok
> > time_change/test ..................... ok
> > user_msg/test ........................ ok
> >
> > All tests now pass except amcast_joinpart, which is blocked by the
> > missing Socket::Netlink Perl module.
> >
> > Please let me know if there is a recommended package source for
> > Socket::Netlink on EL10 ppc64le.
>
> Thanks for following up on this Venkat.
>
> I'm adding your colleague Ricardo from the RH side of the house.
> Ricardo is very familiar with audit and should be able to help you
> with missing RHEL packages.

Thanks for looping me in,  Paul!

Venkat, unfortunately, perl-Socket-Netlink is not packaged for RHEL-10
ppc64le. An alternative is to use CPAN[1] to install the
Socket::Netlink Perl module.

 # dnf install cpan
 # cpan App::cpanminus
 # cpanm Socket::Netlink

I'll reserve a ppc64le machine and run the tests locally as well. I'll
share the results shortly.

[1] https://www.cpan.org/modules/INSTALL.html


>
> --
> paul-moore.com
>


