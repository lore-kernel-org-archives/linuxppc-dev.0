Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F506606A335
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 16:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XaJ9jb2u
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTW722YtLz2xl0;
	Wed, 18 Nov 2026 03:54:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794934494;
	cv=none; b=mJ5V6kFoUoJlWdtEv3B036xqNAzglNi2r6mlpuk5LUbseOAwtv0/fIChpckdQ6l5HC3N7I3cJzpYA8/oVZkQSDVHaDoAtj6B2UfOm7UBhxoa6cK4p6PqMXSHygOpChLfyipOVlQXkWczXmavqDvgK6ttAx++dDizT96uXQ62MHxOef8PGXZXHjBwVpDsSH3Vwa7P4K2Uq2YbeUcjonNJLHWNLVzDjoCoWdBaSouCRIb1ol6WREpzTfcvChhTKfVE6EDVGtdFigZK2arnrHCdeA732qZtteMQCMutw4aAv1tnzGSijK6HQJ7+l1anV/7vLvzGERv3zG24Q5V8t8DAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794934494; c=relaxed/relaxed;
	bh=CkKLhtnqbVqX+zHwbFhSKHBuVVeu6ZYa3DYw5fokX68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Uc7ldj8oShUA/On0s49ReXOVRe/DVRghPntGhHEjl7TeV1Ie2aBoRg6FXAWO6ALO39YmHilelzpMTezc6T/grCPMTMQTCAWyVdzrwiEyelpLdOo7FWdToqS5in3+1cMYbfLXRvAO05DD5MIMc3/JMkS7nHVLZhpEXahOzSxcvaPDfn66yIlkA5vpf0jFVq4nSwZBPqh4h7As2+Hu2YavFykPhYnWIVnIayxPWZw1MBKghKApzZux3aS+Rn79oBgdow3oBtbwHDSVovSYQYrYfgU8LpNicdLnX9iOrMmh2A4l1wxqybUShoOuUCe7v9f9pX1IUzUj0NpVNyQVISkH4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XaJ9jb2u; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=oleg@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XaJ9jb2u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=oleg@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTW711rCsz2xcB
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 03:54:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794934493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CkKLhtnqbVqX+zHwbFhSKHBuVVeu6ZYa3DYw5fokX68=;
	b=XaJ9jb2u09SkZFSSfJTKT/cEG70yC0SUkBdqw7kXSlMG5KDUZbo/+r1H4d0SFu2cDgZSsB
	nUNbC+UWay8aw6XKQGzkuN4SRXREM18bxmF3Ib6OUW6p7RS8k1doPBRc68rHlyW9KU/Cwh
	F071mQhYMuHRUTVeFO+SyzilqKwBN1s=
X-MC-Rep: binary re single
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-fB3idbrNOmKXizt0_vf9cg-1; Tue,
 17 Nov 2026 11:54:44 -0500
X-MC-Unique: fB3idbrNOmKXizt0_vf9cg-1
X-Mimecast-MFC-AGG-ID: fB3idbrNOmKXizt0_vf9cg_1794934481
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 16238195608F;
	Tue, 17 Nov 2026 16:54:41 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4D02D3001DAD;
	Tue, 17 Nov 2026 16:54:35 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Tue, 17 Nov 2026 17:54:40 +0100 (CET)
Date: Tue, 17 Nov 2026 17:54:34 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Renzo Davoli <renzo@cs.unibo.it>, Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, Davide Berardi <berardi.dav@gmail.com>,
	Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Thomas Gleixner <tglx@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, "Dmitry V . Levin" <ldv@strace.io>,
	Alexey Gladkov <legion@kernel.org>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org, strace-devel@lists.strace.io
Subject: Re: [PATCH v11 1/3] seccomp: let the tracer skip a syscall
 independently of its number
Message-ID: <avyGylgRmpAHan9r@redhat.com>
References: <20261114181923.370930-1-renzo@cs.unibo.it>
 <20261114181923.370930-2-renzo@cs.unibo.it>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261114181923.370930-2-renzo@cs.unibo.it>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: m9rXzWGLvlBZtdbo7MotLrX7hnuFQtrZRrGFA8K7QZ0_1794934481
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/14, Renzo Davoli wrote:
>
> Add a per-task flag which the tracer sets with
> seccomp_ptrace_skip_syscall() while the tracee is stopped at the
> PTRACE_EVENT_SECCOMP stop, after it has set the return value.  When the
> tracee resumes, seccomp skips the system call like for
> SECCOMP_RET_ERRNO, which every architecture already handles without
> touching the return value.
>
> The flag is cleared by the tracee before the stop and written by the
> tracer only while the tracee is stopped, so it needs no locking: the
> wake-up of the tracee orders it like the registers written by the
> tracer.
>
> The next patch uses this in PTRACE_SET_SYSCALL_INFO.
>
> Suggested-by: Michal Suchánek <msuchanek@suse.de>
> Assisted-by: claude-opus-5-5
> Signed-off-by: Renzo Davoli <renzo@cs.unibo.it>

I am not comfortable to review this change ;) Kees, can you take a look?

But it LGTM. So FWIW

Reviewed-by: Oleg Nesterov <oleg@redhat.com>



(As for the new new member in struct seccomp... we can probably avoid it
 if you don't like it, but .ptrace_skip looks like the simplest solution
 for the start)


