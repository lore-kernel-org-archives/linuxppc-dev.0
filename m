Return-Path: <linuxppc-dev+bounces-24883-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFD8C53219
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 10:59:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7wbL3GMsz2yhY;
	Mon, 27 Jul 2026 20:59:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785149982;
	cv=none; b=i+gxtNt+0z39zbDSAS0lnX0hDIkasqXXXm0XA3RtKcfBdP8Yw4uJONPI6Ag/VgbuhFL/XE4txbvjVZd4qKERKCvmwnjD6LuZl9Y8gRso+eg9btU+7hKc2ms8lJv0D595bM/x2b8klwvZzKJwFJHfpEhP23L7RusPvYlJKXizwLj/7Z1rzHlMGqCeXLbI66Ay4OV5yYtsnr02v8TnFe/4lzFQcLkuk3K1PA71TaTzgk+Xio3G1L/CIMnf9pauMIKnAO6qPa1IyrEiqGN8vQCOQivPhQ5qJ7OZRv/95iaLry09QnAZOf8rggRCe3f1XUalgxKVah7LG4dXFEDxk4Vkrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785149982; c=relaxed/relaxed;
	bh=WMiWSnOQ64xTj4+vdJ19aK6+fipsHH2WeYASnOPcjnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IGG4HgE3FaG6cZQiHXNT3nBMrGpCwwjf82snaHRw5gtmWuklzVQ872Tw35qImmGabeCaPPqZRtvXCFFjW0ptpebgrEriIC+yxbYW9zs+BLB8XsIsChTB9KCA7yQ6bvxe8+eSSTI4+nPikqQ53IV08XMsvNi7IxzHBHvND7wE7fWCHD+m+gZs/OVXEDdX3v6f33mJpn7RJn45EM4m/vA+Xifjym8zsY4mrRCZpu7myrSAzrDa3PPOjO5sDzLYVW+IxaiiH/Toi03hjd2WW4A/EnwrdlQHLST+vE3zys0Rr4P4kkIUTLy9Mr2Sy7aa2DiC6j8wf3pEEefTWZEH6CoHTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b5ncA0x3; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b5ncA0x3; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhladky@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b5ncA0x3;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b5ncA0x3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhladky@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7wbK23gHz2ygn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 20:59:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785149976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WMiWSnOQ64xTj4+vdJ19aK6+fipsHH2WeYASnOPcjnU=;
	b=b5ncA0x3AvwKSN2MrQDd3+rEXgFQ04UegPjrGDXTndamMkjgZ5MMTxcH1f8hbjxDWBw+D/
	CffG6X0FmY4mBWt5bazTbnKIDpjdQg4+AUi+ggW/BLl0PuaNfx0HJPGC+K7rRacl9dVVbz
	4NlpvSehZeF3qxcUfzU9TFpKD0y2nTA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785149976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WMiWSnOQ64xTj4+vdJ19aK6+fipsHH2WeYASnOPcjnU=;
	b=b5ncA0x3AvwKSN2MrQDd3+rEXgFQ04UegPjrGDXTndamMkjgZ5MMTxcH1f8hbjxDWBw+D/
	CffG6X0FmY4mBWt5bazTbnKIDpjdQg4+AUi+ggW/BLl0PuaNfx0HJPGC+K7rRacl9dVVbz
	4NlpvSehZeF3qxcUfzU9TFpKD0y2nTA=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-4QZ2U6eUNPG0Ad5tcZWyLQ-1; Mon, 27 Jul 2026 06:59:35 -0400
X-MC-Unique: 4QZ2U6eUNPG0Ad5tcZWyLQ-1
X-Mimecast-MFC-AGG-ID: 4QZ2U6eUNPG0Ad5tcZWyLQ_1785149974
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5c2e166dbc4so2398666e0c.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 03:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785149974; x=1785754774;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WMiWSnOQ64xTj4+vdJ19aK6+fipsHH2WeYASnOPcjnU=;
        b=AhmnslBGTvKNwwb+VwIISKJ+HoadhRf6KCmuMnhEuGQ7ymOqSTwujGwGXSqI/pqKz9
         8U4GW4jwA31Q9hG1DQH764nRcS/CAawI8gDSPzL3hcucV2YlpXvsUOYOkj0i7+NNhMTw
         jNlSodp9R6H/Lv8kyXxo2M9gmFd+BgmjxUyv5eig8eNb5Cgu2jiDitVeTqsATAE5eYSJ
         QRjm+5NWeQyGhmXZ2jL5M3ZazJTIs8iEZToH0P3fmb152Zb9N52ACakHRSt1x1WI+RUM
         BMA0G0VBPRiDA5QtZZiJqK6r+84G2rr7/mbXmG40fO3EIOliLNcMdA4VfP1U2bUGkFz4
         OukA==
X-Forwarded-Encrypted: i=1; AHgh+RquBeyOTr06xV75lFq9ZuidRonkvgCSEIAh05m6tktGgyOGj233j9jRXpFBtfQHJRwacTwTxKCqQFcv7Vo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz6t/WC0tXzv0lW3nalkjVeeVjzUNVxWMWo3wxHbHV1z98DTe/w
	EWJRM6uG8NsDsNS5TdvPCEG82z4DVqAwLHULysHcOEWXeSHWdxVQ1HbmK3z/OgQFyxS8exFFVSL
	7mhYSK2BTWHqGVHWyY/NZeAQqVPDu//KFiBEWIcaBujX/Mcqhip25oLXLMDE0/DilA9Sc4SpQjP
	E2O0RJvMAPY0pmI/YEqvWsI/E/cH8MFuRgXYssbIFzyQ==
X-Gm-Gg: AR+sD11Wibov08oMr53D5itSaeIGm++bmCEBBCFCUZQaMLPXdhU98DC/R16XLYVe001
	qn8G/fx3uWyIVGuyz2wb7gHqogN44zksboqpzdABqyqtQz3bmhZzeC6Bl+CuKmaIg6fiKE0oe6W
	UeJb/g+41JwzspoMmxbNIlRbB4ztpncOHBZZfGZThBhyU/N2oYaq8Kzis=
X-Received: by 2002:a05:6122:7d3:b0:5bf:bc5e:e24 with SMTP id 71dfb90a1353d-5c306d72c10mr3617390e0c.12.1785149974455;
        Mon, 27 Jul 2026 03:59:34 -0700 (PDT)
X-Received: by 2002:a05:6122:7d3:b0:5bf:bc5e:e24 with SMTP id
 71dfb90a1353d-5c306d72c10mr3617381e0c.12.1785149974106; Mon, 27 Jul 2026
 03:59:34 -0700 (PDT)
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
References: <20250210184334.567383-1-sshegde@linux.ibm.com>
 <20250210184334.567383-2-sshegde@linux.ibm.com> <CAE4VaGBwMp3Ke1+Bt11-v6CCE0h=mPm8k_Cf8DazFSQNT9Mz8g@mail.gmail.com>
 <c0f51eda-21c4-4e9d-95e9-75b2740c3f43@linux.ibm.com> <CAE4VaGB-W9i0nNzH=VN9GJr6Dy9R46NtMC3V3ELUxdDhypj8bw@mail.gmail.com>
 <85cb5e0e-feb5-4a54-b7b6-a5f6a053dcda@linux.ibm.com>
In-Reply-To: <85cb5e0e-feb5-4a54-b7b6-a5f6a053dcda@linux.ibm.com>
From: Jirka Hladky <jhladky@redhat.com>
Date: Mon, 27 Jul 2026 12:59:22 +0200
X-Gm-Features: AUfX_mxs9ZFQ9PXlMHxPVidmeR61Eru4qQ08yQacaj1lgUMFRVUpahfr80wqRkM
Message-ID: <CAE4VaGArvyKqvysRP_FC39XTLAsiPhGMkR1v3UM4+ykWBHJYyg@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] powerpc: enable dynamic preemption
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, 
	christophe.leroy@csgroup.eu, mpe@ellerman.id.au, npiggin@gmail.com, 
	bigeasy@linutronix.de, will@kernel.org, linux-kernel@vger.kernel.org, 
	"Paul E . McKenney" <paulmck@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fBixMj-ZZUVohsardgmd_hQul5qviw9drF5R0eqTc18_1785149974
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 12:29=E2=80=AFPM Shrikanth Hegde <sshegde@linux.ibm=
.com> wrote:
> That means comparison is between preempt=3Dvoluntary vs preempt=3Dlazy.
>
> If you make it full preemption in 6.15 you will likely see similar
> data as 7.1+. Only on 7.0/7.1 there is force switch to lazy/full.
> Can you give that a try?
>
> If it shows same data, that implies the regression is mainly due to
> change of preemption modes, rather than the static key stuff.

Tested on 7.1 by switching the runtime mode via
/sys/kernel/debug/sched/preempt:

Mode       kill bogo-ops/sec
----       -----------------
full       57,476
lazy       56,892
Delta      ~1% (noise)

The preemption mode (full vs lazy) makes no difference. The regression
is from CONFIG_PREEMPT_RCU being enabled, not from the choice of
preemption mode.

And as Christophe pointed out, it's CONFIG_PREEMPT_DYNAMIC that pulls
in CONFIG_PREEMPT_RCU, not CONFIG_PREEMPT_LAZY:

  config PREEMPT_RCU
        default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)

So the chain is: your patch enables HAVE_PREEMPT_DYNAMIC_KEY ->
CONFIG_PREEMPT_DYNAMIC takes effect -> CONFIG_PREEMPT_RCU=3Dy ->
expensive rcu_read_lock/unlock on ppc64le.

> Plus, it may call schedule in lazy/pull preemption.

The full vs lazy results above suggest extra scheduling is not a
significant factor here.

> This seems strange. How come rcu lock/unlock depends on SELinux
> policy? One should call rcu lock/unlock if they are working with
> rcu updated fields.
>
> Does the policy change itself protected with rcu lock/unlock?

The rcu_read_lock/unlock calls don't depend on SELinux policy -- they
are in the SELinux *code path* itself. SELinux uses RCU to protect
its AVC (Access Vector Cache) lookups. Every call to avc_has_perm()
takes rcu_read_lock() around the avc_lookup() hash table access.

When you boot with selinux=3D0, the SELinux LSM hooks are never called,
so the AVC code path (and its rcu_read_lock/unlock pairs) is never
reached. That's why disabling SELinux removes those call sites from
the hot path.

The call chain is:
  sys_kill -> check_kill_permission -> security_task_kill
    -> selinux_task_kill -> avc_has_perm
      -> rcu_read_lock()
      -> avc_lookup()    <-- hash table lookup under RCU protection
      -> rcu_read_unlock()

With selinux=3D0, security_task_kill() is essentially a no-op and none
of the avc/rcu code runs.

Jirka


