Return-Path: <linuxppc-dev+bounces-18286-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6C3FB5EA5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 03:36:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZd1K6lgxz2yTK;
	Tue, 17 Mar 2026 14:36:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773718613;
	cv=none; b=T/se/v1HDMLpHidhk61b9KnZZ9DlOd6advWnkiTm0coeo/2MHBuyY+I+xJ+7l7mXYyw+UNu1Ezad04dPrramlFbDdLdKbLfBGW+y7J9g7joFFnlzswcdy3lqZZFcmLNH3trjIUhnJm9tZtZ/neBQvwA6OTDtdYYdM9GiZ3Q152RKOLWnekrmrGKGm7CEgf9nmYMxluysKASxvQoFd8MXtn7JZKqT9aGURVMWJ3bkT2uS/XgZdY26Zsq20ibR9lZK4fvYFxADcCFLw8QyEntmGp/DOOvr0nY4lndKNk8+zDQGXgn6+k/y5D0OG/NyIMurewJOoihtZcgDYADUk6xIXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773718613; c=relaxed/relaxed;
	bh=zB79a/FOENLHI8FCWiGrvfZkVLmqf3PzewX8k2/xZr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=EQrhn4B4zAqf1Cw3P3fcL14Dh/kQkr42vguEGZpXohfEd6ER1wVM0YFSg01zp3sOtUXNyOt6Eq0vS1M/V4eqITXSQZz6FzoqzEytVgiG8oOsDdca1vQnp44ANiogUKa+98Qm0saQLdyG0jO1wIJ4QhZ+kwg27yPvzF5CCPKs8+Y/XCx/BNiIOO3Lp+t7q4Copy90Sv0TLeCb2K5hejqQUz4OEmIw42SEqI1ClnbJV4vjk+2JuXl2Yeg4TG1e75Tnu/OMe+xHz4VrotKutrF0nkefPcax2sYHQe+WKED/X04acTHrsPtcplcQE0ZHlDlZ+P3I7G7AAD4gE27SgAbU6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gkTnLIpE; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PRxambLX; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bhe@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gkTnLIpE;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PRxambLX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bhe@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZd1J5XGXz2xVT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 14:36:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773718607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zB79a/FOENLHI8FCWiGrvfZkVLmqf3PzewX8k2/xZr0=;
	b=gkTnLIpEs2S5EadBkKpztO7IIzlLBpW0G0TFwocI4Y/TFc7x6Cj1UedKTuxnWtWjJuKU2D
	A0oDkP3JQPh5Y1XO+uPYnNIUuvcZ82+oyX5tbDNz/ms6dd/6sFgboBrentZmPl5EPxVq/Z
	PGR2OTDD8M4jEl2alyzdWZ08diWTl18=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773718608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zB79a/FOENLHI8FCWiGrvfZkVLmqf3PzewX8k2/xZr0=;
	b=PRxambLXgX3imszZQkq3Pp00RCLoy3kT55sXUzW+z56uwOG103c+0dasNqr2XfCNdgcTdm
	8sTUStaIKnUoGkwF+42Nj/ySoilf/5sGPWAOdH0YHScSpjTZMzlbyAaOFBQCcyOAaXqBjg
	KxFLNo+zDWt2POVu8rIPY6vctVJDvbM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-ivqPJgBFMnCWlq80myHG4g-1; Mon,
 16 Mar 2026 23:36:42 -0400
X-MC-Unique: ivqPJgBFMnCWlq80myHG4g-1
X-Mimecast-MFC-AGG-ID: ivqPJgBFMnCWlq80myHG4g_1773718600
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1AF9A195608B;
	Tue, 17 Mar 2026 03:36:39 +0000 (UTC)
Received: from localhost (unknown [10.72.112.155])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 414B31800361;
	Tue, 17 Mar 2026 03:36:35 +0000 (UTC)
Date: Tue, 17 Mar 2026 11:36:31 +0800
From: Baoquan He <bhe@redhat.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: kasan-dev@googlegroups.com, linux-mm@kvack.org, andreyknvl@gmail.com,
	ryabinin.a.a@gmail.com, glider@google.com, dvyukov@google.com,
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	x86@kernel.org, chris@zankel.net, jcmvbkbc@gmail.com,
	linux-s390@vger.kernel.org, hca@linux.ibm.com
Subject: Re: [PATCH v5 14/15] mm/kasan: add document into
 kernel-parameters.txt
Message-ID: <abjMP58VdUu_eElh@fedora>
References: <20260225081412.76502-1-bhe@redhat.com>
 <20260225081412.76502-15-bhe@redhat.com>
 <f7054184-dca2-4c7c-9e2e-4a5e3e1c81da@sifive.com>
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
In-Reply-To: <f7054184-dca2-4c7c-9e2e-4a5e3e1c81da@sifive.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: Ndh44lZ-ZDqbPm6VhgTcXp9mvMp0Z36Lx-t2kaQQDxs_1773718600
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 03/12/26 at 07:53am, Samuel Holland wrote:
> Hi Baoquan,
> 
> On 2026-02-25 2:14 AM, Baoquan He wrote:
> > And also remove the relevant description in dev-tools/kasan.rst
> > which is hw_tags specificially.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt | 4 ++++
> >  Documentation/dev-tools/kasan.rst               | 2 --
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index cb850e5290c2..e0115fad9e60 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2899,6 +2899,10 @@ Kernel parameters
> >  	js=		[HW,JOY] Analog joystick
> >  			See Documentation/input/joydev/joystick.rst.
> >  
> > +	kasan=		[KNL] controls whether KASAN is enabled.
> > +			Format: off | on
> > +			default: on
> > +
> >  	kasan_multi_shot
> >  			[KNL] Enforce KASAN (Kernel Address Sanitizer) to print
> >  			report on every invalid memory access. Without this
> > diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> > index a034700da7c4..eaae83fcb5e4 100644
> > --- a/Documentation/dev-tools/kasan.rst
> > +++ b/Documentation/dev-tools/kasan.rst
> > @@ -129,8 +129,6 @@ Hardware Tag-Based KASAN mode is intended for use in production as a security
> >  mitigation. Therefore, it supports additional boot parameters that allow
> >  disabling KASAN altogether or controlling its features:
> 
> The sentence above is now incorrect as well. I would recommend documenting the
> parameter earlier in the "Boot parameters" section instead of removing it from
> this document entirely.

Good catch and the suggestion is good to me. Thanks.

Is below change OK to you?


From 317be48b9c1bf9d33b8d8fff5e401e3155531d81 Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Tue, 17 Mar 2026 11:28:39 +0800
Subject: [PATCH] mm/kasan: adjust documentation
Content-type: text/plain

To reflect the change of kasan=on|off.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 Documentation/dev-tools/kasan.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index a034700da7c4..8e65bc04dbcd 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -103,6 +103,9 @@ Boot parameters
 KASAN is affected by the generic ``panic_on_warn`` command line parameter.
 When it is enabled, KASAN panics the kernel after printing a bug report.
 
+The generic ``kasan=off`` or ``=on`` command line parameter controls
+whether KASAN is enabled (default: ``on``).
+
 By default, KASAN prints a bug report only for the first invalid memory access.
 With ``kasan_multi_shot``, KASAN prints a report on every invalid access. This
 effectively disables ``panic_on_warn`` for KASAN reports.
@@ -127,9 +130,7 @@ modes below) support altering stack trace collection behavior:
 
 Hardware Tag-Based KASAN mode is intended for use in production as a security
 mitigation. Therefore, it supports additional boot parameters that allow
-disabling KASAN altogether or controlling its features:
-
-- ``kasan=off`` or ``=on`` controls whether KASAN is enabled (default: ``on``).
+controlling its features:
 
 - ``kasan.mode=sync``, ``=async`` or ``=asymm`` controls whether KASAN
   is configured in synchronous, asynchronous or asymmetric mode of
-- 
2.52.0


