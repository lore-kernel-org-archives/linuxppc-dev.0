Return-Path: <linuxppc-dev+bounces-24634-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1018C4452D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2026 08:17:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4nDH4Q5Cz2yfD;
	Wed, 22 Jul 2026 18:17:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784706921;
	cv=none; b=J5g2dDrLdn+NGyqcG4rmmJlB0WmPbASY6ILB04o23G7Yg4owH5IKKzQXFNXn6fQIWx6ivf04JJPNkBw71UY+Oe9stNpD7mlvM50jqbKNuBJavGdznae9C/1brhsYDMlB1Gn2ng7Ak+BwBzsY7wISyfzQJwKgsIqwa3024hZ5m3FelqZwIpMlcqBkwfCZ2UWQni8A3M1oZbKy8q3PXJVRJh66/TUkyoAZfjgeSuO1FrsPxrqiY+VFBRL+rkzf5OaqMptLr1cTM0NaSuxwnL3Oob833ikpXBPFeEDa/5fa85xTuG4zlkJqrjCssixy1e8Y+VQJKJ6xNc99yzVJ7/p8TA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784706921; c=relaxed/relaxed;
	bh=JEHOJ2bzJwJy+o2sep7JfQ5jyg3etVDtYri7Q0U3JXs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=if12TBEAyhmlg/UYp2vbLlWuCkCKnOCdhfo8EVmoa3SlCZAjvUrToMnLBk6DnravzWwXG3pinmqpjzW1nL3DsaNWWNFI1bWknCzLEdlkoIv2NPIwIXh+iEJ63+ukzpZ+XwZNmyimfVS1sFiem7eDrRlhf2g2lNVC4P7rQTKzTIBtLAu06+vTmihz3/PUF8wD3gXMn3LF/PA3yYxG7RcSeHrQBLk4Pa4B9TTPhSxw5HLzjyyetGf0aTTtZkrh2+L2l9zHCaU+5TYILrv9kTmcaDqOLGwpo7q7WLSVmP/SIG1b2OgnPa3P88lG9rZm7EcEyibkHqSwiS7gJAe2xNVzLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A23Kouvu; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A23Kouvu; dkim-atps=neutral; spf=permerror (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=fweimer@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A23Kouvu;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A23Kouvu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=fweimer@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4mkw5M0Lz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 17:55:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784706915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JEHOJ2bzJwJy+o2sep7JfQ5jyg3etVDtYri7Q0U3JXs=;
	b=A23Kouvu7w6rtgXFrnqJd4QorytzozrdVJ1z0koaePu610tZmlCGJVxVn3w8lFU4M5SAUD
	bMO7BKRwVl7NDv+SBpGkIXpcnf7+e8ZkiQLfO94f8tqy9eqAcn/BaOmMz7u5Fm6DdMOJxC
	1L0Wj97j+rkf+cX+wpLT3nMHBMPvfxA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784706915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JEHOJ2bzJwJy+o2sep7JfQ5jyg3etVDtYri7Q0U3JXs=;
	b=A23Kouvu7w6rtgXFrnqJd4QorytzozrdVJ1z0koaePu610tZmlCGJVxVn3w8lFU4M5SAUD
	bMO7BKRwVl7NDv+SBpGkIXpcnf7+e8ZkiQLfO94f8tqy9eqAcn/BaOmMz7u5Fm6DdMOJxC
	1L0Wj97j+rkf+cX+wpLT3nMHBMPvfxA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-cR6fRZaFPPa31tJj9Q-Ggg-1; Wed,
 22 Jul 2026 03:55:09 -0400
X-MC-Unique: cR6fRZaFPPa31tJj9Q-Ggg-1
X-Mimecast-MFC-AGG-ID: cR6fRZaFPPa31tJj9Q-Ggg_1784706905
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 433721956067;
	Wed, 22 Jul 2026 07:55:03 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.47.238.119])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DAD81800902;
	Wed, 22 Jul 2026 07:54:48 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>,  maddy@linux.ibm.com,
  mpe@ellerman.id.au,  npiggin@gmail.com,  chleroy@kernel.org,
  ryabinin.a.a@gmail.com,  glider@google.com,  andreyknvl@gmail.com,
  dvyukov@google.com,  vincenzo.frascino@arm.com,  oleg@redhat.com,
  kees@kernel.org,  luto@amacapital.net,  wad@chromium.org,
  mchauras@linux.ibm.com,  thuth@redhat.com,  ruanjinjie@huawei.com,
  sshegde@linux.ibm.com,  akpm@linux-foundation.org,  charlie@rivosinc.com,
  deller@gmx.de,  macro@orcam.me.uk,  segher@kernel.crashing.org,
  peterz@infradead.org,  bigeasy@linutronix.de,  namcao@linutronix.de,
  tglx@linutronix.de,  mark.barnett@arm.com,
  linuxppc-dev@lists.ozlabs.org,  linux-kernel@vger.kernel.org,
  kasan-dev@googlegroups.com
Subject: Re: [PATCH v4 5/8] powerpc: add exit_flags field in pt_regs
In-Reply-To: <20260722070155.GA11808@strace.io> (Dmitry V. Levin's message of
	"Wed, 22 Jul 2026 10:01:55 +0300")
References: <20260123073916.956498-1-mkchauras@linux.ibm.com>
	<20260123073916.956498-6-mkchauras@linux.ibm.com>
	<20260722070155.GA11808@strace.io>
Date: Wed, 22 Jul 2026 09:54:43 +0200
Message-ID: <lhuzezj8nng.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 80jEUBcDdtFIASb7F9x4zF-FsgCvxxq6uI81j2F5uS0_1784706905
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

* Dmitry V. Levin:

> On Fri, Jan 23, 2026 at 01:09:13PM +0530, Mukesh Kumar Chaurasiya wrote:
>> From: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
>> 
>> Add a new field `exit_flags` in the pt_regs structure. This field will hold
>> the flags set during interrupt or syscall execution that are required during
>> exit to user mode.
>
> Apparently, this change breaks PTRACE_GETREGS as the latter has no means
> to communicate the size of struct pt_regs being written to userspace.
>
> As result, the kernel with this patch will write to userpsace 32 more
> bytes than before, and unless the userspace is re-compiled with the latest
> ptrace.h, 32 bytes of userspace memory after struct pt_regs will be
> overwritten.
>
> This issue was detected by strace test suite, specifically, the test that
> checks whether the actual number of bytes written by
> ptrace(PTRACE_GETREGS) matches sizeof(struct pt_regs), and that test failed
> with runtime version v7.1 and headers version v7.2-rc1.

I think this needs to be reverted because it breaks existing ptrace
users.  This isn't like iptables, where kernel updates did mandate
specific versions of the userspace tools.

Thanks,
Florian


