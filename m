Return-Path: <linuxppc-dev+bounces-23634-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80D2C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 14:06:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gv5kH3wxjz3bby;
	Tue, 07 Jul 2026 00:06:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::629" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783346775;
	cv=pass; b=Nn1rvNLq6obkfUbQlyvKfpEAohz3i+mEL9fD1c0jC6bOG/PrIysC0u6gLUpQsWuQpEhFzbb1C8C03njiSPCYZdenI4pkA6GTM9O1f33b0xLsBHgI0f2934b79OTXUEAA8F9LlllSjxsBdQ+/P+MjX2/IXX0F/uOPSFOgWp6zglbapdnp5TYxUe4LFcQwuWbRIGNiR+HAkpcDC3pePxviZPMUaU70Dmi7qFYXZd1bQFJfvSkQ/g3AD5kvGqhjB41F4YfG0dpS+60Eh+Xj5FNFyEiJQKTiyMyXdt4R7qm67C7KSictNo+fus5DlszIp1Psbhn3AbWaWJkYhjfaNuzZmA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783346775; c=relaxed/relaxed;
	bh=IwznM8wJhC3tYJr+9DBy6ZAChqMb/6fSD6dK6crswv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+1vziS9rk5efXMlqc9/yelfuaVxNNFzwMw4wReZWapD2XpnzF7SZfBRJZ2f/Fox5yqK50odB4AdrKdhEkv7nTm1dVQDhKNsK2yme4D5HjDIdjXhCEHrKDeK826Diy2VPI2ujzHbnam0LKeuLt4j5HaNNfUk7NeY9tWIErH/vQuADfQLSL+ZUho+beQZrpaCF3uL9vACmgSB8K1ExSPhpXPuVZ0WkkJgyATY7/DwZ4xlkwU+J5ssc3pOMy4OpnULib9B5DNgz7164OTma1/+b188ksoppaqPiYesb43N6aSn6ylY/AYQjUOpCpmToh5GHfxpm70xhWIKRIPPnWxGMA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=FsxZ0EI+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=FsxZ0EI+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gv5kF3b6fz2yfS
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 00:06:12 +1000 (AEST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2c9bd2f8bf7so40647905ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 07:06:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783346769; cv=none;
        d=google.com; s=arc-20260327;
        b=H6TNnBkJxgoqXI/baDcgxuypTwb0itg78V3IQ2snfw7LXcDmqgDA9D2mYckUuJFq6G
         9hWVMloS55wp0fwx0eJeqFqAwN99TE5GH0Hj7VQgbtxNy3MjnPP7jiuBxhskIGElVPtG
         pYMjXoj5LN+I+cefuRYuco7W7qScQQbJXSGH0wjedkLg/7zqlnB5I5Z2UtjeAFN96/XG
         umzQjkX70RIKGlzTv8qNIEUedLt96BmSEvXTdB4uFQXzJLKyDUj5PofCJiKamJBZeLJg
         GE1664Uv8EQtMD9aQQ4zz/V0vtCK99wSxQzGig0XkMIagK4eWIkMAOddsq8Lz2plSUTT
         w2Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IwznM8wJhC3tYJr+9DBy6ZAChqMb/6fSD6dK6crswv4=;
        fh=8M3QxOWWoDVoOzZ5i4XG42ncp3Af6HpX8UEGOmEW2Ew=;
        b=nLvmx75Qw3YenPDSC2TSR0P0xiATo/Vi0vbtRxxLwJYNp8AdZhmBjWFRc9tN15tHDN
         EOsctSSEKxyWy9F3yLuHaQyJOT8VEEPRyGUlsMnUJCqdTtNa3AjyRxF5gQveo6p8tAfW
         j2MvECv3rgOxbIAhV06XvzOld9ipNug9+tT8iz6DB7HvFru1FDMnA81sbkXxYq0Uuwrb
         4c0r4soU1IrymYj2N73ik9qDTIXcVVIgYP2q6zxHaRR+kc0NylRDRsEKdBnGwo6E3jCN
         b9Ukd5DBbNEOoqBX14ncWIb9PNW/sWVJFOHycu9aVgzy/ixE/F/1/QX69mSdY5E7ZWZ6
         0D1A==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783346769; x=1783951569; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwznM8wJhC3tYJr+9DBy6ZAChqMb/6fSD6dK6crswv4=;
        b=FsxZ0EI+wkCOwhrXgKBpFfifxTb12KetmacmtUbGX3w7lHdr5yWNmkDBCJRYOEoYQZ
         +Iw9k4EyhYF6xa9/WmcvFKb9UeYLZyuIUMxSZ1sKSF2s4DOcpmQDjojvf9rX6dbaQvTU
         mLtEP067LeAF6OV/t1SxIVw3fVZh4u0XTPjAe0mKxRKjUINqi+9iOmL8pPVKorRiLo62
         eKpqT6W3fsL53GwwsgJSMHSKWH1YJ+U9lfqWimoFnlXTvvshZpc2e1Vtn/yUaFke9UeR
         k0OyPt77HKj/n+DG4lQic1kDpav4IAY43o9I7OjIfxw+Ef4PNHWLXAZuJgpBfHEsPMP3
         hyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783346769; x=1783951569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IwznM8wJhC3tYJr+9DBy6ZAChqMb/6fSD6dK6crswv4=;
        b=FpmTCBOVD4XYhZpFGW3+ZEs7OdfNISYyhMVZDHcrOFAFxHRd5ynTcvqD8AxmgQGRQI
         AwqOmX0LUfI+jiQDl2EKbPaDl32Ounku904xHUA7M/YPQq92N4zywNTPUqpvF/AIV9E9
         7Dj3jFnigUGB361aA4nU5XWreKQtw0v/luBn65tLRQWGqstrLvtRU4AAw+BEr8snNao3
         oNeDjExV/h8mdyqPvMk3X4Oa2Ji1YC6c5Fe482SYNi4btGfRqG+2BhRe7Jmdqm26mxli
         Jh8OiPYob0q+7UoVAgMNkfp8mWYXR8YrbdFst++GQT+JcI2Icv7ZW8xYXUmjWranmveH
         fG1A==
X-Forwarded-Encrypted: i=1; AHgh+RoZuoHplrBsQXXpGBiLGxZ+r4LRH9ZINbKdqZQbtvz68lj3NPp35EQnIO6XWyVV30DkZsOZ2SvIz8wFUaU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyFqy8Cz7sCQQlQSEr6+z3hdPma7AVjkv6W8tSLYtwLRoqn3tVI
	FKXQTwBLgo77YafIUORT+x2by6zt4lR4PwL0W0/I5aUZnBqcnUmeUWTJsLw5mxD6ybtElv/6Gyd
	NrPwwgbmo0zYcOQXwBz+hJSg/UpWaPRZVeX7d5xZV
X-Gm-Gg: AfdE7cn3dooxCKHxzcn0VC3YOw0fPLI8YJFxi2t/mc2LueAiOGcfZ5F6T/kp5IUx/T6
	jzELPZ9MUVFxFH3g6wQzoxgKWRyC1Ie8nrQYLx99Xj4tDbuDhH4FIuM7mV9WIxvdruG/9k2i5m7
	mbZXyLcUq6FMfKYsXCzM5sYIWsR1lQ88lY484NLwu/yUPOSOOCilUgWsNgqDbISy5a33up6dKVm
	1Q6vhvX6MKy8L7Yff4asrWYtiQrj/iJmgiJW4o9/suvS3xFyNwh6S1T56xNShcInOhOmIe5
X-Received: by 2002:a17:903:1a26:b0:2c9:97a7:3283 with SMTP id
 d9443c01a7336-2ccbd814425mr8460355ad.23.1783346768737; Mon, 06 Jul 2026
 07:06:08 -0700 (PDT)
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
 <CAABTaaCQCBuR9Ny6zBHNK=gy3Cd0WGj-f9qgzwuyjWD_i=v_dQ@mail.gmail.com>
 <CAABTaaC_vQTM8B0wLqfHuv-S9JDzXeuDeLd0Sh3M21pO+=Zg2Q@mail.gmail.com> <8a568842-0a62-41d1-8e7b-cf2bcce6a71e@linux.ibm.com>
In-Reply-To: <8a568842-0a62-41d1-8e7b-cf2bcce6a71e@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 6 Jul 2026 10:05:56 -0400
X-Gm-Features: AVVi8Ccaf9TSI6FAvWCNR8aEHftBAWQ-1JzBHLz6yYEAqkujo32UH3vUkDXPGLk
Message-ID: <CAHC9VhQAfOcZ=viJ-XmU4=NUowC-sZabukK5c+6HahUUBFw3jw@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc/audit: Convert powerpc to AUDIT_ARCH_COMPAT_GENERIC
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: Ricardo Robaina <rrobaina@redhat.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Eric Paris <eparis@redhat.com>, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	audit@vger.kernel.org, Thomas Weissschuh <thomas.weissschuh@linutronix.de>, 
	=?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, ritesh.list@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 4:29=E2=80=AFAM Venkat Rao Bagalkote
<venkat88@linux.ibm.com> wrote:
> On 03/07/26 4:19 am, Ricardo Robaina wrote:
> > On Thu, Jul 2, 2026 at 3:19=E2=80=AFPM Ricardo Robaina <rrobaina@redhat=
.com> wrote:
> >> On Thu, Jul 2, 2026 at 10:28=E2=80=AFAM Paul Moore <paul@paul-moore.co=
m> wrote:
> >>> On Thu, Jul 2, 2026 at 8:50=E2=80=AFAM Venkat Rao Bagalkote
> >>> <venkat88@linux.ibm.com> wrote:

...

> Thanks for the RPM's Ricardo.
>
> I installed the missing dependencies (netcat, iptables, ip6tables) and
> rebuilt the kernel with arp_tables available as a module. I also
> installed Socket::Netlink using:
>
>      cpanm --mirror https://cpan.metacpan.org --mirror-only Socket::Netli=
nk
>
> After these changes, I reran audit-testsuite and all tests are now passin=
g:
>
>      Files=3D24, Tests=3D279
>
>      Result: PASS
>
> amcast_joinpart/test ................. ok
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
>
> Paul/Christophe/Maddy,
>
> Hope we are good now. Please let me know, if anything else needs to be do=
ne.

That's great, thank you for verifying all of it works as expected!

--=20
paul-moore.com

