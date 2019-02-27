Return-Path: <SRS0=o5MI=RC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788B4C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 04:21:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E550420C01
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 04:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJLYOaGx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E550420C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448Mtk0cMRzDqJP
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 15:21:02 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448MrT36DPzDqJC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 15:19:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZJLYOaGx"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 448MrT0qnsz8t0x
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 15:19:05 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 448MrS6s74z9s6w; Wed, 27 Feb 2019 15:19:04 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZJLYOaGx"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 448MrR36kTz9s5c
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2019 15:19:03 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id y5so7323517plk.8
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Feb 2019 20:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:references:in-reply-to:mime-version:user-agent
 :message-id:content-transfer-encoding;
 bh=j3Vlfy6rlr4JafD5gwYwqtqFvuHyEOMDnXrBwMxOY0U=;
 b=ZJLYOaGx0ysB8H9awNSs/UTcoOrSZEvbjmt/b3GwCNxidH6Y6AliwKmLPU1aRsEpMH
 3Pxd/41EXi1ZsWOi5Aque+aIg3yv4SoB1wyQkliAf9jjk0HrVib/jFPWbTwhg9amOVm9
 IDm46zDFCjKOMkNjkwqloUScmcZns3xwHAjD6+gaAIGUZII2Dqt7FVjSZGqhRpv9mKOJ
 4Naz/vIn7BcuqasmCs2U7EWoSJ6XbjmB/2OrHhZag1UmRlKZW/OtSUZnyjPs4abXb+6Y
 T98FMcsyU1xlIPCXhFn0auV7A9FUxMNQaRc3e8VnOrptiXzwbqaVrn539n2rW6nFBtn4
 Agkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=j3Vlfy6rlr4JafD5gwYwqtqFvuHyEOMDnXrBwMxOY0U=;
 b=MZQVQv8mDIckQ2QMT1YaPQ1SLryYueEXD5qVraSOximyn0yQkwpnbGGYZer/csaY1J
 7JXarg1JP2X4VP8RgsA+16d+bI+7d2LopjGIwK3O0+Q+3yPB77kPYhvNcOfBF39N58o3
 iF5QTrBbOB750VtG+lrnBj1kibMQDIWNyGS+DVzEXIotjjpl7cryQA6WrSYNm6Sr56XD
 AiSkSAyjNaPrbYrbbascvH5LdCiMplClX/NLbT69gKU72omqh+KAMPbpjM+9D6s3d0Lz
 FPpylHEMizuKDTpLYuuTsMRXfrTbI31T/AVImio/zeAZdW2eTKv/8DvsIX5mOvW8Midd
 vK4g==
X-Gm-Message-State: AHQUAuYhZckFS7bJdHcr2eHlUkVmq+aRDRvMjj3lQYWn7BJE9tnYg/LX
 ChStAjthpXO6etY1U46hsFY=
X-Google-Smtp-Source: AHgI3IYtFzR17ujH6aINEGJNjyP0ahKayf73bih7xu3ndNUh4dUsKVNguzn6jPt7P8f0Mgrx+WvYhA==
X-Received: by 2002:a17:902:1a9:: with SMTP id b38mr62380plb.37.1551241140041; 
 Tue, 26 Feb 2019 20:19:00 -0800 (PST)
Received: from localhost (193-116-71-51.tpgi.com.au. [193.116.71.51])
 by smtp.gmail.com with ESMTPSA id h64sm28278852pfj.40.2019.02.26.20.18.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 26 Feb 2019 20:18:58 -0800 (PST)
Date: Wed, 27 Feb 2019 14:18:52 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 00/18] Add FADump support on PowerNV platform
To: Ananth N Mavinakayanahalli <ananth@linux.ibm.com>, Hari Bathini
 <hbathini@linux.ibm.com>, Vasant Hegde <hegdevasant@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Mahesh J Salgaonkar
 <mahesh@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Stewart Smith
 <stewart@linux.ibm.com>
References: <155077048463.21014.13936958730316555495.stgit@hbathini.in.ibm.com>
In-Reply-To: <155077048463.21014.13936958730316555495.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1551240037.jlygjm8fzm.astroid@bobo.none>
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

Hari Bathini's on February 22, 2019 3:35 am:
> Firmware-Assisted Dump (FADump) is currently supported only on pseries
> platform. This patch series adds support for powernv platform too.
>=20
> The first and third patches refactor the FADump code to make use of commo=
n
> code across multiple platforms. The fifth patch adds basic FADump support
> for powernv platform. Patches seven & eight honour reserved-ranges DT nod=
e
> while reserving/releasing memory used by FADump. The next patch processes
> CPU state data provided by firmware to create and append core notes to th=
e
> ELF core file. The tenth patch adds support for preserving crash data for
> subsequent boots (useful in cases like petitboot). Patch twelve provides
> support to export opalcore. This is to make debugging of failures in OPAL
> code easier. The subsequent patch ensures vmcore processing is skipped
> when only OPAL core is exported by f/w. The next patch provides option to
> release the kernel memory used to export opalcore. Patch seventeen adds
> backup area (an area populated before crash and used in the capture kerne=
l
> to setup vmcore file robustly) support on PowerNV platform. The remaining
> patches update Firmware-Assisted Dump documentation appropriately.
>=20
> Note that the quantam of increase in robustness due to patch seventeen ma=
y
> not be worth breaking backward compatibility for older kernel versions.
> Would like to hear thoughts from others on it.
>=20
> The patch series is tested with the latest firmware plus the below skiboo=
t
> changes for MPIPL support:
>=20
>     https://patchwork.ozlabs.org/project/skiboot/list/?series=3D78497
>     ("MPIPL support")
>=20
> ---
>=20
> Hari Bathini (18):
>       powerpc/fadump: move internal fadump code to a new file
>       powerpc/fadump: Improve fadump documentation
>       pseries/fadump: move out platform specific support from generic cod=
e
>       powerpc/fadump: use FADump instead of fadump for how it is pronounc=
ed
>       powerpc/fadump: enable fadump support on OPAL based POWER platform
>       powerpc/fadump: Update documentation about OPAL platform support
>       powerpc/fadump: consider reserved ranges while reserving memory
>       powerpc/fadump: consider reserved ranges while releasing memory
>       powernv/fadump: process architected register state data provided by=
 firmware
>       powernv/fadump: add support to preserve crash data on FADUMP disabl=
ed kernel
>       powerpc/fadump: update documentation about CONFIG_PRESERVE_FA_DUMP
>       powerpc/powernv: export /proc/opalcore for analysing opal crashes
>       powernv/fadump: Skip processing /proc/vmcore when only OPAL core ex=
ists
>       powernv/opalcore: provide an option to invalidate /proc/opalcore fi=
le
>       powernv/fadump: consider f/w load area
>       powernv/fadump: update documentation about option to release opalco=
re
>       powernv/fadump: use backup area to map PIR to logical CPUs

The need to map firmware identifiers like PIR to Linux numbering comes=20
up in a few places, OPAL msglog, pdbg debugger, etc. I wonder if we
could have Linux register its logical CPU numbers with OPAL after it
boots. Would that help with your usage?

>       powerpc/fadump: Update documentation about backup area support
>=20
>=20
>  Documentation/powerpc/firmware-assisted-dump.txt |  208 ++--
>  arch/powerpc/Kconfig                             |   23=20
>  arch/powerpc/include/asm/fadump.h                |  190 ---
>  arch/powerpc/include/asm/opal-api.h              |   58 +
>  arch/powerpc/include/asm/opal.h                  |    1=20
>  arch/powerpc/kernel/Makefile                     |    6=20
>  arch/powerpc/kernel/fadump.c                     | 1199 ++++++++--------=
------
>  arch/powerpc/kernel/fadump_internal.c            |  297 +++++
>  arch/powerpc/kernel/fadump_internal.h            |  250 +++++

I don't have much knowledge of fadump code, so I'll nitpick instead :P

Why are you calling it fadump_internal, what's internal about it? You=20
have the framework for the ops table etc here, which makes the platform=20
code have to #include "../kernel/fadump_internal.h", and suggests it's
not so internal. Seems like it would be fine just to go in=20
include/asm/fadump.h and kernel fadump.c?

>  arch/powerpc/kernel/prom.c                       |    4=20
>  arch/powerpc/platforms/powernv/Makefile          |    3=20
>  arch/powerpc/platforms/powernv/opal-core.c       |  602 +++++++++++
>  arch/powerpc/platforms/powernv/opal-fadump.c     |  670 ++++++++++++
>  arch/powerpc/platforms/powernv/opal-fadump.h     |  116 ++
>  arch/powerpc/platforms/powernv/opal-wrappers.S   |    1=20
>  arch/powerpc/platforms/pseries/Makefile          |    1=20
>  arch/powerpc/platforms/pseries/pseries_fadump.c  |  535 ++++++++++
>  arch/powerpc/platforms/pseries/pseries_fadump.h  |   96 ++

These hopefully could just be called pseries/fadump.[ch]? Or maybe
rtas-fadump if you want to be like powernv.

Thanks,
Nick
=
