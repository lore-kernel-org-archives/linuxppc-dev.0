Return-Path: <SRS0=VSEi=4O=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C4AC4BA0A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Feb 2020 04:08:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23ED12082F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Feb 2020 04:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsV6sfy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23ED12082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48S2Nj2W36zDqML
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Feb 2020 15:08:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::543;
 helo=mail-pg1-x543.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=WsV6sfy7; dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48S2LQ1tBVzDqHK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2020 15:06:53 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id y30so612087pga.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2020 20:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:references:in-reply-to:mime-version:user-agent
 :message-id:content-transfer-encoding;
 bh=3Zr86Sbul5p9izyfKRiM37PTKkBA4+zhoMmwJQqrXhw=;
 b=WsV6sfy7XbVcGoxLw3ONejcSQM0adacPkQF0ipiMD+M/OyTg4pvF8yfs5258+7LlJ2
 LL0UOX6ON96WwNhWlk+crnjXyse3AxnQE93XsztzHeWQBKrlU3NkuoGZ0sql36aPjHRs
 hexF8/vfIL5mnBJczsD7bCqEFEJBodAncQTYW8A13oHYtQtlIjeTwwydGY5kPnNx4pxO
 3CppJ2W9yvFkQV4KyUemmb3DUchDfQqZSU83/8sf8/bn4WpOy5g/dhkZsOursb9ikD1T
 L3ojwts/+WGtBZ2JgT0sybNU7z6+ZVl1XqUmTnX8cSgAnaZeXzuMrJX/4ANAFFDFEVWz
 ElJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=3Zr86Sbul5p9izyfKRiM37PTKkBA4+zhoMmwJQqrXhw=;
 b=kuM49mT+NECIsXaIpwuLZsuVXYhXIYUZXj+VeY58GO5khEUY+QgxPqyuoqpyW6DLKG
 FPLB1/1jrP9o/uDa5cz/U7KXCrIrr2XgmbCsODQzZ3nHRRhwYhAYshavUo/fk+xUUCOK
 o8bKpAjvTrjtUG2FHRKNKPUkaNDibXQN9nN/4vNzjQv5vM7MA4eb0xxhHv3acrhuRtnJ
 h/ZqrNPScOS1gQN9e0DWgAuEdYl382adahYsUWcUbAhJjCjzjEvYtFawUMhrXyahSRh2
 TYqDKcntLsL5hSQPFeUBq0qxNr1gKiTpV/6B4BSVEHLXiyGdpPsrC6wlDJB3zxRor4BT
 ORbg==
X-Gm-Message-State: APjAAAWFT/G89K4a0KIcQhcu/xDayVpGlbcnsMR3BmMUqFEMuXuCSXKL
 gVtivg1X3+tkmUTABkYLhCE=
X-Google-Smtp-Source: APXvYqzJKU6rXl8Suqx0lYEELojh/h96fHmVv29nYtEFriKMXNXFxa79Zc+3H0VNqbqkx9c8QDWiWw==
X-Received: by 2002:a62:e30f:: with SMTP id g15mr2144928pfh.124.1582690011338; 
 Tue, 25 Feb 2020 20:06:51 -0800 (PST)
Received: from localhost ([61.68.187.74])
 by smtp.gmail.com with ESMTPSA id f81sm641026pfa.118.2020.02.25.20.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 20:06:50 -0800 (PST)
Date: Wed, 26 Feb 2020 14:02:46 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [Bug 206669] New: Little-endian kernel crashing on POWER8 on
 heavy big-endian PowerKVM load
To: bugzilla-daemon@bugzilla.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <bug-206669-206035@https.bugzilla.kernel.org/>
In-Reply-To: <bug-206669-206035@https.bugzilla.kernel.org/>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1582689224.x1y6w8bowt.astroid@bobo.none>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

bugzilla-daemon@bugzilla.kernel.org's on February 26, 2020 1:26 am:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D206669
>=20
>             Bug ID: 206669
>            Summary: Little-endian kernel crashing on POWER8 on heavy
>                     big-endian PowerKVM load
>            Product: Platform Specific/Hardware
>            Version: 2.5
>     Kernel Version: 5.4.x
>           Hardware: All
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: PPC-64
>           Assignee: platform_ppc-64@kernel-bugs.osdl.org
>           Reporter: glaubitz@physik.fu-berlin.de
>                 CC: matorola@gmail.com
>         Regression: No
>=20
> Created attachment 287605
>   --> https://bugzilla.kernel.org/attachment.cgi?id=3D287605&action=3Dedi=
t
> Backtrace of host system crashing with little-endian kernel
>=20
> We have an IBM POWER server (8247-42L) running Linux kernel 5.4.13 on Deb=
ian
> unstable hosting a big-endian ppc64 virtual machine running the same kern=
el in
> big-endian mode.
>=20
> When building OpenJDK-11 on the big-endian VM, the testsuite crashes the =
*host*
> system which is little-endian with the following kernel backtrace. The pr=
oblem
> reproduces both with kernel 4.19.98 as well as 5.4.13, both guest and hos=
t
> running 5.4.x.
>=20
> Backtrace attached.

Thanks for the report, we need to get more data about the first BUG if=20
we can. What function in your vmlinux contains address=20
0xc00000000017a778? (use nm or objdump etc) Is that the first message you g=
et,
No warnings or anything else earlier in the dmesg?

Also 0xc0000000002659a0 would be interesting.

When reproducing, do you ever get a clean trace of the first bug? Could
you try setting /proc/sys/kernel/panic_on_oops and reproducing?

Thanks,
Nick

=
