Return-Path: <linuxppc-dev+bounces-23458-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41DAC43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 00:23:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grvbl1R5Pz2yRC;
	Fri, 03 Jul 2026 10:22:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783032595;
	cv=none; b=gxKyOP/+GYA03/GHbSDIHbl6wSzrUfPpG2lOrCU/cj/bJ8W9yjT68SFMIMj8Zjoqj1qjgm+y928PYFaeKt3xd7StZQUDm8vsYnazqn7N5gkPxT3gRbRuPlJwCfqlq+ZuxvP7LwhGAzJh+sdHzyTcMYMOL9XTtUr6yjkik9F8Vg/Jak5DtbZQ8i1y3ijMZqSEetCcn2SqMx7UunuYlL7/qHkt8w5C43+XbGd9Yi1ipn5cqmZz/w/mbzVSNLqGNSqXIolH382MpzjlbUolK5Jc+fLG4X4SvWI+oHRPMXBc6vLDiuk9YrZf3l1RwOPP7WU6U1v8DGlwaZlFRzbnUBz5Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783032595; c=relaxed/relaxed;
	bh=G/2hym407OvJVwtz5j16/UTy0OY66ylRy9CZIkkSmIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J0ouTF/IAer5aZBYL4DrBXXFfjoq5FjZnX7elcB6uJO9nF19k76q9ZGdN/TYO3I6a3tggEvCBIckLH3vHbNHtHyZ9XmGkeGmnAawaqA9rsKuLh358Ly8ypMNprBaYqQ3eG8hxVaywIVcs9oMdb3xGMHxn3xozLzXdb4Z8aMIgDGFj4PaN9rffSkwnOaDcr89pj+0aPovAWErVlBRnodalSQM4I3S+oBVRCHwZNY1V1g0FHk3qdq88liAgj1SJV20kszZkcM+CYRVZSy7cFGp85FLcmK6DyEDgguqCyzotABKOMlMF9cpzf72i1PEtl6YbsNz2si7iDzICYOTDEUaBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L7OqUGYd; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L7OqUGYd; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=rrobaina@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L7OqUGYd;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L7OqUGYd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=rrobaina@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grsXK46CKz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 08:49:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783032588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/2hym407OvJVwtz5j16/UTy0OY66ylRy9CZIkkSmIE=;
	b=L7OqUGYdQf63BDBU5JzJBnKZaAWWc+GdLJzeY8ENHU4s68l3iNm9Xtq2TOPOcaPwIN8NUG
	PdZvocpQ8828OPNVFInIMwaRSm/uJvdszksPOLtc5sxAMo3gZvbULMqDx4vwXNG0fkMnmS
	WRYIuSHuHdO81oqFK7PfCQ4vclhyenM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783032588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/2hym407OvJVwtz5j16/UTy0OY66ylRy9CZIkkSmIE=;
	b=L7OqUGYdQf63BDBU5JzJBnKZaAWWc+GdLJzeY8ENHU4s68l3iNm9Xtq2TOPOcaPwIN8NUG
	PdZvocpQ8828OPNVFInIMwaRSm/uJvdszksPOLtc5sxAMo3gZvbULMqDx4vwXNG0fkMnmS
	WRYIuSHuHdO81oqFK7PfCQ4vclhyenM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-HYdd1S7ZNwqu0APWtCIfPg-1; Thu, 02 Jul 2026 18:49:44 -0400
X-MC-Unique: HYdd1S7ZNwqu0APWtCIfPg-1
X-Mimecast-MFC-AGG-ID: HYdd1S7ZNwqu0APWtCIfPg_1783032583
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c1288e572c9so239812366b.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 15:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783032583; x=1783637383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G/2hym407OvJVwtz5j16/UTy0OY66ylRy9CZIkkSmIE=;
        b=mkrwtwusmrL2Bl6F5Gw/fm1/u1IwStTxfb9n0FQWTS+zTEOmnCwx30BYnrNP1bZiIT
         qYekMJjlNGWPEb3PLRx+OFnfv2U/BR4XzjD8tSyr3T95PoUXgnJ4WGvXx1mm1V3htUJh
         uWLBjzDftLb9uUi15RcRXtyZlfFdIB9DQCIg+oisZ/sdIje+64gRlXRMiFOJc0MafgUJ
         dULac3tuaRPBdRgkdv4fq/K4YZW5Rxsme1B+WTksS+MxsVa9VicE9AXcSk/XZ8wPWgD5
         1Jakrlb2IQpYSnxnip8sC4cikiXcm49zGtCs8+5vEgAv+wxFE5s61tXWd4nbGyUdeJcF
         mVjw==
X-Forwarded-Encrypted: i=1; AHgh+Rp4cg2U1IxyByL2eTPAimXzDkadkLr8jm+EsX64vfB79rHSBTsoLnWG033GXYS/qlY6W4i4pM4Hlwzp53U=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwJhWKpQ5QdirAnYjfC8vXVhIGwAEu8qfYwt3sERZjCdVaCrDpc
	hiUnxmjb3YQxcQZLJ59uXNNm5Ce6ZAb0Jw0Mmsi0CRp4opL/dkmND1JB3EKmHh7MJmrifHQDrzX
	D0MvM2b9Z3ZJ+abfsz87B88xcUZnCtOb4Z6nFmc0e4A8SMDws8GyS79/PlORsZySE8PkHnIdYI5
	H8m8AVxkcLCYVXsyovV5XkoxxbBRo9xB4zTkGfshnVRA==
X-Gm-Gg: AfdE7cndcbn7nwJZotzsErZtmE4RwUNepPE48t6fYbpJhIrCmIYWRVW/my9pilw+Kqo
	kL+CtiR84+4GrQ7ltITpvru39HnCYN6kGtBQlx3qQZ3xN//wz7g5JzvoyoAaUj9iN7JVdz9KBID
	ZyWu/+S6VmzmsuWvOcrExFYaq7NBV9O9MLQCeDxUnkmzEkW/DTpTGUM6YFrcJXl9cxuiFG7oRx+
	JbMM4yimb4yKnArKnFX5VFbxUjwJlctWZmt3ZorX4ztwGiJaJsdgcHa
X-Received: by 2002:a17:906:46cc:b0:c12:93ed:47dc with SMTP id a640c23a62f3a-c12ae7bb5efmr256939066b.40.1783032583030;
        Thu, 02 Jul 2026 15:49:43 -0700 (PDT)
X-Received: by 2002:a17:906:46cc:b0:c12:93ed:47dc with SMTP id
 a640c23a62f3a-c12ae7bb5efmr256937566b.40.1783032582582; Thu, 02 Jul 2026
 15:49:42 -0700 (PDT)
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
 <CAHC9VhQvoK4uYP0NBnd4FGbXCQkDka4nHqdz9kAn2bGnm4qVHQ@mail.gmail.com> <CAABTaaCQCBuR9Ny6zBHNK=gy3Cd0WGj-f9qgzwuyjWD_i=v_dQ@mail.gmail.com>
In-Reply-To: <CAABTaaCQCBuR9Ny6zBHNK=gy3Cd0WGj-f9qgzwuyjWD_i=v_dQ@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Thu, 2 Jul 2026 19:49:31 -0300
X-Gm-Features: AVVi8CeRFl__1Bqk-jk5FxN5LO-w5tjorS49FId6RokuADqCYNXoGJwL1nk7uKc
Message-ID: <CAABTaaC_vQTM8B0wLqfHuv-S9JDzXeuDeLd0Sh3M21pO+=Zg2Q@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: JWBM5mEJ1ZCZ346vrz4Hx_JYK3-7Aq5V8N_BPiJr5SQ_1783032583
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 3:19=E2=80=AFPM Ricardo Robaina <rrobaina@redhat.com=
> wrote:
>
> On Thu, Jul 2, 2026 at 10:28=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Thu, Jul 2, 2026 at 8:50=E2=80=AFAM Venkat Rao Bagalkote
> > <venkat88@linux.ibm.com> wrote:
> > >
> > > Current remaining issue:
> > >
> > > 1. amcast_joinpart
> > > ------------------
> > > Still fails due to a missing Perl dependency:
> > >
> > >      Can't locate Socket/Netlink.pm in @INC
> > >
> > > I searched the configured repositories and could not find a package
> > > providing Socket::Netlink / Socket/Netlink.pm on this EL10 ppc64le sy=
stem.
> > >
> > > Latest run summary:
> > >
> > > amcast_joinpart/test ................. Can't locate Socket/Netlink.pm=
 in
> > > @INC (you may need to install the Socket::Netlink module) (@INC entri=
es
> > > checked: /usr/local/lib64/perl5/5.40 /usr/local/share/perl5/5.40
> > > /usr/lib64/perl5/vendor_perl /usr/share/perl5/vendor_perl
> > > /usr/lib64/perl5 /usr/share/perl5 .) at amcast_joinpart/test line 10.
> > > BEGIN failed--compilation aborted at amcast_joinpart/test line 10.
> > > amcast_joinpart/test ................. Dubious, test returned 2 (wsta=
t
> > > 512, 0x200)
> > > Failed 7/7 subtests
> > > backlog_wait_time_actual_reset/test .. ok
> > > bpf/test ............................. ok
> > > exec_execve/test ..................... ok
> > > exec_name/test ....................... ok
> > > fanotify/test ........................ ok
> > > field_compare/test ................... ok
> > > file_create/test ..................... ok
> > > file_delete/test ..................... ok
> > > file_permission/test ................. ok
> > > file_rename/test ..................... ok
> > > filter_exclude/test .................. ok
> > > filter_exit/test ..................... ok
> > > filter_saddr_fam/test ................ ok
> > > filter_sessionid/test ................ ok
> > > io_uring/test ........................ ok
> > > login_tty/test ....................... ok
> > > lost_reset/test ...................... ok
> > > netfilter_pkt/test ................... ok
> > > signal/test .......................... ok
> > > syscalls_file/test ................... ok
> > > syscall_module/test .................. ok
> > > time_change/test ..................... ok
> > > user_msg/test ........................ ok
> > >
> > > All tests now pass except amcast_joinpart, which is blocked by the
> > > missing Socket::Netlink Perl module.
> > >
> > > Please let me know if there is a recommended package source for
> > > Socket::Netlink on EL10 ppc64le.
> >
> > Thanks for following up on this Venkat.
> >
> > I'm adding your colleague Ricardo from the RH side of the house.
> > Ricardo is very familiar with audit and should be able to help you
> > with missing RHEL packages.
>
> Thanks for looping me in,  Paul!
>
> Venkat, unfortunately, perl-Socket-Netlink is not packaged for RHEL-10
> ppc64le. An alternative is to use CPAN[1] to install the
> Socket::Netlink Perl module.
>
>  # dnf install cpan
>  # cpan App::cpanminus
>  # cpanm Socket::Netlink
>
> I'll reserve a ppc64le machine and run the tests locally as well. I'll
> share the results shortly.
>
> [1] https://www.cpan.org/modules/INSTALL.html
>
>
> >
> > --
> > paul-moore.com
> >

Hello everyone,

I built an RHEL-10 kernel with the patch applied and verified that
audit-testsuite passes successfully on a ppc64le machine. Please find
the logs below:

Tested-by: Ricardo Robaina <rrobaina@redhat.com>

---
# uname -m
ppc64le

# uname -r
6.12.0-245.test.el10.ppc64le

# make test
...
chmod +x */test
Running as   user    root
        with context unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
        on   system  RHEL10

amcast_joinpart/test ................. ok
backlog_wait_time_actual_reset/test .. ok
bpf/test ............................. ok
coredump/test ........................ ok
exec_execve/test ..................... ok
exec_name/test ....................... ok
fanotify/test ........................ ok
field_compare/test ................... ok
file_create/test ..................... ok
file_delete/test ..................... ok
file_permission/test ................. ok
file_rename/test ..................... ok
filter_device/test ................... ok
filter_exclude/test .................. ok
filter_exit/test ..................... ok
filter_inode/test .................... ok
filter_saddr_fam/test ................ ok
filter_sessionid/test ................ ok
io_uring/test ........................ ok
login_tty/test ....................... ok
lost_reset/test ...................... ok
netfilter_pkt/test ................... ok
signal/test .......................... ok
syscalls_file/test ................... ok
syscall_module/test .................. ok
time_change/test ..................... ok
user_msg/test ........................ ok
All tests successful.
Files=3D27, Tests=3D300, 252 wallclock secs ( 0.12 usr  0.01 sys + 54.34
cusr  1.38 csys =3D 55.85 CPU)
Result: PASS
make[1]: Leaving directory '/root/rrobaina/audit-testsuite/tests'
---

I hope it helps!
-Ricardo


