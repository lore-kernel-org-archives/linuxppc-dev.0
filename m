Return-Path: <SRS0=DyCn=ZM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E469C432C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Nov 2019 15:19:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75DAE218AF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Nov 2019 15:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75DAE218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47J5w74vL6zDqsX
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Nov 2019 02:19:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47J5sm4bbxzDqlg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Nov 2019 02:17:46 +1100 (AEDT)
Received: from localhost (mailhub1-ext [192.168.12.233])
 by localhost (Postfix) with ESMTP id 47J5sY6tDmz9v2Xl;
 Wed, 20 Nov 2019 16:17:37 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id b9WuW4-B4Uio; Wed, 20 Nov 2019 16:17:37 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
 by pegase1.c-s.fr (Postfix) with ESMTP id 47J5sY5ysFz9v2Xk;
 Wed, 20 Nov 2019 16:17:37 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
 id 49EB08D6; Wed, 20 Nov 2019 16:17:41 +0100 (CET)
Received: from 37-172-92-181.coucou-networks.fr
 (37-172-92-181.coucou-networks.fr [37.172.92.181]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Wed, 20 Nov 2019 16:17:41 +0100
Date: Wed, 20 Nov 2019 16:17:41 +0100
Message-ID: <20191120161741.Horde.zNDnbMKk_BJpkUOkWeRMsQ1@messagerie.si.c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 2/8] powerpc/vdso32: Add support for
 CLOCK_{REALTIME/MONOTONIC}_COARSE
References: <cover.1572342582.git.christophe.leroy@c-s.fr>
 <4644ccc9b4da78639ae9424db878c48711abf05a.1572342582.git.christophe.leroy@c-s.fr>
 <87eey2btxi.fsf@mpe.ellerman.id.au>
In-Reply-To: <87eey2btxi.fsf@mpe.ellerman.id.au>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman <mpe@ellerman.id.au> a =C3=A9crit=C2=A0:

> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> This is copied and adapted from commit 5c929885f1bb ("powerpc/vdso64:
>> Add support for CLOCK_{REALTIME/MONOTONIC}_COARSE")
>> from Santosh Sivaraj <santosh@fossix.org>
>>
>> Benchmark from vdsotest-all:
>> clock-gettime-realtime: syscall: 3601 nsec/call
>> clock-gettime-realtime:    libc: 1072 nsec/call
>> clock-gettime-realtime:    vdso: 931 nsec/call
>> clock-gettime-monotonic: syscall: 4034 nsec/call
>> clock-gettime-monotonic:    libc: 1213 nsec/call
>> clock-gettime-monotonic:    vdso: 1076 nsec/call
>> clock-gettime-realtime-coarse: syscall: 2722 nsec/call
>> clock-gettime-realtime-coarse:    libc: 805 nsec/call
>> clock-gettime-realtime-coarse:    vdso: 668 nsec/call
>> clock-gettime-monotonic-coarse: syscall: 2949 nsec/call
>> clock-gettime-monotonic-coarse:    libc: 882 nsec/call
>> clock-gettime-monotonic-coarse:    vdso: 745 nsec/call
>>
>> Additional test passed with:
>> 	vdsotest -d 30 clock-gettime-monotonic-coarse verify
>
> This broke on 64-bit big endian, which uses the 32-bit VDSO, with errors
> like:
>
>   clock-gettime-monotonic-coarse/verify: 10 failures/inconsistencies=20=
=20
>=20encountered
>   timestamp obtained from libc/vDSO not normalized:
>   	[-1574202155, 1061008673]
>   timestamp obtained from libc/vDSO predates timestamp
>   previously obtained from kernel:
>   	[74, 261310747] (kernel)
>   	[-1574202155, 1061008673] (vDSO)
>   timestamp obtained from libc/vDSO not normalized:
>   	[-1574202155, 1061008673]
>   timestamp obtained from libc/vDSO predates timestamp
>   previously obtained from kernel:
>   	[74, 261310747] (kernel)
>   	[-1574202155, 1061008673] (vDSO)
>   timestamp obtained from libc/vDSO not normalized:
>   	[-1574202155, 1061008673]
>   timestamp obtained from libc/vDSO predates timestamp
>   previously obtained from kernel:
>   	[74, 261310747] (kernel)
>   	[-1574202155, 1061008673] (vDSO)
>   timestamp obtained from libc/vDSO not normalized:
>   	[-1574202155, 1061008673]
>   timestamp obtained from libc/vDSO predates timestamp
>   previously obtained from kernel:
>   	[74, 261310747] (kernel)
>   	[-1574202155, 1061008673] (vDSO)
>   timestamp obtained from libc/vDSO not normalized:
>   	[-1574202155, 1061008673]
>   timestamp obtained from libc/vDSO predates timestamp
>   previously obtained from kernel:
>   	[74, 261310747] (kernel)
>   	[-1574202155, 1061008673] (vDSO)
>   Failure threshold (10) reached; stopping test.
>
>
> The diff below seems to fix it, but I'm not sure it's correct. ie. we
> just ignore the top part of the values, how does that work?

Your change makes sense, it is consistent with other functions using=20=20
STAMP_XTIME.

It=20works because nanoseconds are max 999999999, it fits 32 bits regs.

Christophe

