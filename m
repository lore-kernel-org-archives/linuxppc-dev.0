Return-Path: <SRS0=Efpx=BA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5505C433E1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2020 00:59:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 277B92080D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2020 00:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="JkPIN1uB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277B92080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B9gHD27WhzDqg3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2020 10:59:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=axtens.net (client-ip=2607:f8b0:4864:20::1041;
 helo=mail-pj1-x1041.google.com; envelope-from=dja@axtens.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256
 header.s=google header.b=JkPIN1uB; dkim-atps=neutral
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20::1041])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B9gF50f2dzDqRv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2020 10:58:00 +1000 (AEST)
Received: by mail-pj1-x1041.google.com with SMTP id f16so808176pjt.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2020 17:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version:content-transfer-encoding;
 bh=CyZewwJ/9T1Tpc8QUgwXmunL/VTH+2pPz4CphZ1hWQI=;
 b=JkPIN1uB8pE+0G+vQgr2GiI3n6LIQg1HY47Kpnws6Dl4Rs4k9TnpIrGNiXTEfJHwqJ
 DaMTqigCGZDbzcQAflhBZHyhISdGZs6COuTsOxEBjSzW2KGNzmHasA6SNJhreoWgaBLX
 Am1L8WjBCrJ4OtPB79MCeALEhGwhMyHH1mAGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version:content-transfer-encoding;
 bh=CyZewwJ/9T1Tpc8QUgwXmunL/VTH+2pPz4CphZ1hWQI=;
 b=SPs8wLvEA5R2bzq6w3wfjfIgjLljYAYNlrbZK1BmXnZtyl0qSZZtMF9mzk13QYx6xS
 L032tR5U2z828/qDGYr8Zlxmn38XzUjY+yY1Dh+MrYj0AwjTcrNLQD57BX5c5qINqTDa
 Cez0M3FPvLZlRiQ6iToiAQJBEwBzk4IVPE1JnWVz0ISbLZhUvPGQxd49OfwRwowhPwMk
 GVZIUm2Nde3o7QWZvTZz/XlIplDi8pJPqf+WS20NJH5qh3Os7eOFkRVc6LJKYEKDM6+V
 wvUdtPdfHRARN4tiyOH/7IZGheoAtzbK/NSnIdf8ksEUD5ipjgu3W3TNVLrjiAqQfpa0
 QAOA==
X-Gm-Message-State: AOAM531/nx9aNe9/27578iXXZepWjiR1E+Wh3TWlce+SfdQH3yQFQCFA
 Hw2uHE1qdwI3dL054+FiM7x36w==
X-Google-Smtp-Source: ABdhPJyByrqpQllPpR0D7RidLYxzmu6IdnoEYesyOjrcV+UdH3fsseTwq2S+bcVyg98FHM8YrNXg9w==
X-Received: by 2002:a17:90a:9606:: with SMTP id
 v6mr2020005pjo.110.1595293076875; 
 Mon, 20 Jul 2020 17:57:56 -0700 (PDT)
Received: from localhost
 (2001-44b8-1113-6700-a406-9b33-fa24-f289.static.ipv6.internode.on.net.
 [2001:44b8:1113:6700:a406:9b33:fa24:f289])
 by smtp.gmail.com with ESMTPSA id e10sm821383pjw.22.2020.07.20.17.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 17:57:56 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Michael Ellerman <mpe@ellerman.id.au>, Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>
Subject: Re: [PATCH] powerpc/fault: kernel can extend a user process's stack
In-Reply-To: <878sfethsj.fsf@mpe.ellerman.id.au>
References: <20191211014337.28128-1-dja@axtens.net>
 <20191211072806.GI3986@kitsune.suse.cz>
 <8736drciem.fsf@dja-thinkpad.axtens.net>
 <20200720105116.GO32107@kitsune.suse.cz> <878sfethsj.fsf@mpe.ellerman.id.au>
Date: Tue, 21 Jul 2020 10:57:52 +1000
Message-ID: <87k0yxu1kf.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Tom Lane <tgl@sss.pgh.pa.us>, linuxppc-dev@lists.ozlabs.org,
 Daniel Black <daniel@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman <mpe@ellerman.id.au> writes:

> Michal Such=C3=A1nek <msuchanek@suse.de> writes:
>> Hello,
>>
>> On Wed, Dec 11, 2019 at 08:37:21PM +1100, Daniel Axtens wrote:
>>> > Fixes: 14cf11af6cf6 ("powerpc: Merge enough to start building in
>>> > arch/powerpc.")
>>>=20
>>> Wow, that's pretty ancient! I'm also not sure it's right - in that same
>>> patch, arch/ppc64/mm/fault.c contains:
>>>=20
>>> ^1da177e4c3f4 (Linus Torvalds         2005-04-16 15:20:36 -0700 213)   =
         if (address + 2048 < uregs->gpr[1]
>>> ^1da177e4c3f4 (Linus Torvalds         2005-04-16 15:20:36 -0700 214)   =
             && (!user_mode(regs) || !store_updates_sp(regs)))
>>> ^1da177e4c3f4 (Linus Torvalds         2005-04-16 15:20:36 -0700 215)   =
                 goto bad_area;
>>>=20
>>> Which is the same as the new arch/powerpc/mm/fault.c code:
>>>=20
>>> 14cf11af6cf60 (Paul Mackerras 2005-09-26 16:04:21 +1000 234)           =
 if (address + 2048 < uregs->gpr[1]
>>> 14cf11af6cf60 (Paul Mackerras 2005-09-26 16:04:21 +1000 235)           =
     && (!user_mode(regs) || !store_updates_sp(regs)))
>>> 14cf11af6cf60 (Paul Mackerras 2005-09-26 16:04:21 +1000 236)           =
         goto bad_area;
>>>=20
>>> So either they're both right or they're both wrong, either way I'm not
>>> sure how this patch is to blame.
>>
>> Is there any progress on resolving this?
>>
>> I did not notice any followup patch nor this one being merged/refuted.
>
> It ended up with this:
>
> https://lore.kernel.org/linuxppc-dev/20200703141327.1732550-2-mpe@ellerma=
n.id.au/
>
>
> Which I was hoping would get some reviews :)

Ah, I missed this. I'll give it a look as soon as I can.

Kind regards,
Daniel

>
> I'll probably merge the whole series into next this week.
>
> cheers
