Return-Path: <linuxppc-dev+bounces-27161-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9DCC88E4D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 20:54:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhRcs6HPWz2y2L;
	Sat, 12 Sep 2026 06:54:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789160093;
	cv=none; b=jp2EdrGLqP5joNGCOsSBE4kgdFkRwBNixxYVCmUt3//ubM/w+zC1PoAtLf2A2EAa3yYDtDGeyNtud7NI9hQK2f1798NOtlB1C7fe9SONN9vWVuYmzo0Hqf+M05UxqtNLwH9AcYleHo49tScngdYKXWrVGc0XHxtYgYr3GRCXiBJnugWvLd8xLao+pzuWJ/ymvg+ON3brhP6lVdHQ2pmOyZR0b83I1/xxJaO7cyHFCZgplyLap5Bl3h3finnpcUd9eQhcMSP4O6izuQcRzGK4NohVBCrNw4dCCfwBZo708czgSdmuPy+Ll3RrRq3/sxa23Hu4JZLksB7JnXSplpcoxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789160093; c=relaxed/relaxed;
	bh=FlPA41J6GidnJ18HqQ+NEvzxuLHO13RlGgnl+HX9oI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EArRfWIUwpQiuZCANmG66q9Up7+TnjW5STZfID5cZZP6gGIqkeQ/EesNlSSg8p1SKbecz6pvoJum6Oz8Lt9ADQGWm6Oi73jkVzlNvIocnQmKnrL8+xI5M8qcw3BWTnSxRgGCxdN8FLbHGBqbaz9RHCcUuv59WrWtn+pnNS/whZNQrvU9ULYQyH7NF2eT2fZtqWvoxCtBP/eOR7rD6jIFTFnH57OALBGW/E6l70rl+bXo+dAYZyu164aeI7xkkGm8zvCAPCOTXzDiczG29wMDAawt8jGqvR3uDTTamLI/g6PKuTv4qhfrvBpsccW9ZYa3Gb87nglko+fjqUGlkvOPAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dFIQCiH0; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dFIQCiH0; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhladky@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dFIQCiH0;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dFIQCiH0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhladky@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhRcr2wBpz2xpv
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Sep 2026 06:54:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789160086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FlPA41J6GidnJ18HqQ+NEvzxuLHO13RlGgnl+HX9oI8=;
	b=dFIQCiH0EkJqwno7nPD6kVUVJmMsLURNicpmhNqmSZp7022Wq2+2GoKOHEC+xaY8guPnqD
	ViNRHUkMWMYvA1+4n70utp25jAvYMgCZEo7JRem6OldxOZoB/DO1jQZCCmcIjdwwRYRRtU
	U1/dpmK471+3+8mdJXpwbNT54BgYzmE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789160086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FlPA41J6GidnJ18HqQ+NEvzxuLHO13RlGgnl+HX9oI8=;
	b=dFIQCiH0EkJqwno7nPD6kVUVJmMsLURNicpmhNqmSZp7022Wq2+2GoKOHEC+xaY8guPnqD
	ViNRHUkMWMYvA1+4n70utp25jAvYMgCZEo7JRem6OldxOZoB/DO1jQZCCmcIjdwwRYRRtU
	U1/dpmK471+3+8mdJXpwbNT54BgYzmE=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-K1QZ_c2wNa2RYQmj8QvJVA-1; Fri, 11 Sep 2026 16:54:44 -0400
X-MC-Unique: K1QZ_c2wNa2RYQmj8QvJVA-1
X-Mimecast-MFC-AGG-ID: K1QZ_c2wNa2RYQmj8QvJVA_1789160084
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5c82f879767so1425052e0c.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 13:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789160084; x=1789764884;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FlPA41J6GidnJ18HqQ+NEvzxuLHO13RlGgnl+HX9oI8=;
        b=m1nHbGgWv+mXZ071xVQWFPILQbCJOcmo6aLaQ+D6VHg7AQGQKSXDLbgSrIG66sXx/C
         j/ugWl8oaqUV/2jQM4QxyJq1CzSOkVJ1S4tXCLBpEYn/Td8BlLQ6aY6RFtg2IJY4824J
         kvceAN/LjPqCxkFwf5Ef3uEW21ntoeNw4llVl3RVLwzsVKl18OSMP5KrukID9dKKMHz9
         QpSPFxN1wKhvCX/WNBfRIbFIJ66bPIQYAu3Srw3p7dXmZg1CvYm7RqkOTHTB7agndWPJ
         8CflRXsSuMNbTAqi1ys5H6R/OXDz7UR6xXxuaey7T+C+QSGWIY54XhquGYbPt0ZkdF+x
         axLw==
X-Forwarded-Encrypted: i=1; AKwUvBygra/nTXE7fLHyLdLAjRi4MZptcYZREnk0rz2RlQzOxQ+GLDuWAqNRkne7hGHVGjVIOvOO4CTYq3nZa+4=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nHs23o4+M4lP7Y34zthsECUimYLHH+TBMZS98sSjz4LW5o9mMT
	mHLyUOc7P0olOmo4bmIjJ23DCph7rsBtuvtUaIyKpVWX8arzzzIHYIAMkFkllCNJyQgs+cqcaRg
	gWkxEEPsLlFb6NWhChHmvVUyygCTb0yzIeOG6v4lQPb7fKzS9c2mnxgsxVo7ntokAnvKpfZRCgc
	xrPnqxg2qFY0A7ndJUQkeF+Xkw8ZjkyKsJLgQFT7t/nQ==
X-Gm-Gg: AYBFou1UTi75+ROZHTXHPQW1c5NNTYYZzBzWD74XnDyeSntYdiSntafODIP2ToaySms
	VOGorOBfP9r3iIQ1ByKH9cpP14hoyw1+9MLXxLzFv5ktcfNnzRRx3vq8vixVFf3fETr3kKQaBYR
	BEvk2s2CDK+6g7nfoAv0v9oD5BVLHIKXGkbbtYgyDAne2ubz1mEEEEYrhL
X-Received: by 2002:a05:6122:f05:b0:5bf:d3cd:3d64 with SMTP id 71dfb90a1353d-5c845d7f9ffmr9989582e0c.0.1789160084083;
        Fri, 11 Sep 2026 13:54:44 -0700 (PDT)
X-Received: by 2002:a05:6122:f05:b0:5bf:d3cd:3d64 with SMTP id
 71dfb90a1353d-5c845d7f9ffmr9989568e0c.0.1789160083744; Fri, 11 Sep 2026
 13:54:43 -0700 (PDT)
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
References: <CAE4VaGACd2es4NPQyhbR9pMEoGiTVBSE7Lw7x9VOb1Qbpvc6nw@mail.gmail.com>
 <amsapeQ2Kp6rwPpF@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <CAE4VaGB_EhbWq8_X6FLtOx2MqoP7JEkOKkKSjKB7N--tt-sCeA@mail.gmail.com>
 <aqAMpawvpB7g1XdK@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <CAE4VaGBCmA0+28G=V_Qs37cR2GKYDUTGQWW_uRe0qvEp5io3qQ@mail.gmail.com>
 <CAE4VaGCp7A7NuBC9Hwgzs5xg3bGBuRiDC8PRCu+yXnUZEXmt-g@mail.gmail.com>
 <CAE4VaGATCET9F4XXS2oj47aNEZx3HN__Zp1CH4+ASec6BjhjGA@mail.gmail.com>
 <aqONPHH8B_z_GpT2@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <CAE4VaGDJy-EzD_iHeb+AQOYi9LZN1dB9OXjf7FtVWM=LWrWVTg@mail.gmail.com>
 <CAE4VaGAq1PugOAomUnJ4vEtmHzKPt5m6VJ21wErdOf19G8UPWw@mail.gmail.com> <aqRB8aSzbeQ-UcYY@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
In-Reply-To: <aqRB8aSzbeQ-UcYY@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
From: Jirka Hladky <jhladky@redhat.com>
Date: Fri, 11 Sep 2026 22:54:31 +0200
X-Gm-Features: AcwNN1VnXyX6goxTYVa2E2ck7PdO3F14PO76Zg2Rek1nXQVAwJIE2cqMc_bw6SU
Message-ID: <CAE4VaGA42zWqhqXfzzkCfN_F__Dh+QQyCX3CvmDx0Wx4u3VzqQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] Generic IRQ entry/exit support for powerpc
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, ryabinin.a.a@gmail.com, glider@google.com, 
	andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com, 
	oleg@redhat.com, kees@kernel.org, luto@amacapital.net, wad@chromium.org, 
	mchauras@linux.ibm.com, sshegde@linux.ibm.com, thuth@redhat.com, 
	ruanjinjie@huawei.com, akpm@linux-foundation.org, macro@orcam.me.uk, 
	ldv@strace.io, charlie@rivosinc.com, deller@gmx.de, kevin.brodsky@arm.com, 
	ritesh.list@gmail.com, yeoreum.yun@arm.com, agordeev@linux.ibm.com, 
	segher@kernel.crashing.org, mark.rutland@arm.com, ryan.roberts@arm.com, 
	pmladek@suse.com, feng.tang@linux.alibaba.com, peterz@infradead.org, 
	kan.liang@linux.intel.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NOtZkF8IjE212uz1Fc_ei7D3rGeY8d9JsLXlgFY2XTk_1789160084
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 8:02=E2=80=AFPM Mukesh Kumar Chaurasiya
<mkchauras@gmail.com> wrote:
>
> Hey Jirka,
>
> Thanks for the verification. I think that's all i wanted. I would send
> out a patch for this soon. Thanks for all the support.
>
> Regards,
> Mukesh
> [...]
>

Thank you, Mukesh!


--=20
-Jirka


