Return-Path: <SRS0=o5MI=RC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C32CC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 03:40:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81D13218E2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 03:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="Z1Jie2jv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D13218E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448Lzv2gQYzDqMr
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 14:40:27 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448Lwr0jdDzDqLC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 14:37:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="Z1Jie2jv"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 448Lwp66C2z8sWM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 14:37:46 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 448Lwn6vfdz9s5c; Wed, 27 Feb 2019 14:37:45 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="Z1Jie2jv"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 448Lwn38jxz9s1b
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2019 14:37:44 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id e17so5188777pgd.2
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Feb 2019 19:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:subject:in-reply-to:references:date:message-id:mime-version;
 bh=3Va2ynfEaYfNNxEbwELw4lpxAN8cyniE9Ote8aHP02A=;
 b=Z1Jie2jv8KEOsXrcZN5BlFWHMkkC/KklwzHFuW0GR7zUqrlNOj6xJRlgnY8kCnfa5U
 L2ExplR5jRLN/6NJC6SE5z9m2I83S+QXr/iAIUIpXWE3wYWgfYN7jy9iLONyTYzZOTq8
 +B+ahHaEhcirN6UZcotb1BIAp7VwM2DcQLpfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=3Va2ynfEaYfNNxEbwELw4lpxAN8cyniE9Ote8aHP02A=;
 b=KNwgslmGp/Uyk0V3h18CLGePGLjiC99Jtat13eXPVlDpufnW4QFiQRzdKGjUuPWpqg
 oHyuuKfmVDqlfTRBCrsVPIBH2aNZgE4fmzQUEAIe1ele94plMx1XEmKOSYNhcti9oAQ4
 te40k2LKqn97ewq+mMWrpwkcC12nmAg+n/LnGx4QVHqNKsutY+QFI1+aw1I1QTu41RYn
 5VmyX/jntp/AI9H1m9JyLlmyT3tpQzMq0pzWWGl/xDCm07KrtyFyN/ghMJ15S3DV0KAm
 /2J07dgHLh4/Jd4mzq+yCzxn3Bxq7y4veNPRhZ0j5kdAChDUyTxJvL9tSJgi8xmRze2G
 Ql1Q==
X-Gm-Message-State: AHQUAubTPVMbZj5QzckQjETvCLbY8YKLqJyHOWX8KVveSQI/6VSyJEPl
 3fy12u1iKEGw2d8l648Cn1nF8A==
X-Google-Smtp-Source: AHgI3IYvL6t1Xm/WfAOVlQVBTPKJ6mvoh/8zYpBl8PBgQtEwrSmjBDJ2fSUwqgBFhpY5//LI5WLWxw==
X-Received: by 2002:a63:2d43:: with SMTP id t64mr880825pgt.155.1551238662853; 
 Tue, 26 Feb 2019 19:37:42 -0800 (PST)
Received: from localhost (203-59-50-226.dyn.iinet.net.au. [203.59.50.226])
 by smtp.gmail.com with ESMTPSA id l73sm45352253pfb.113.2019.02.26.19.37.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 26 Feb 2019 19:37:41 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Hari Bathini <hbathini@linux.ibm.com>,
 Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Vasant Hegde <hegdevasant@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Stewart Smith <stewart@linux.ibm.com>
Subject: Re: [PATCH 00/18] Add FADump support on PowerNV platform
In-Reply-To: <155077048463.21014.13936958730316555495.stgit@hbathini.in.ibm.com>
References: <155077048463.21014.13936958730316555495.stgit@hbathini.in.ibm.com>
Date: Wed, 27 Feb 2019 14:37:37 +1100
Message-ID: <877edlaola.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Hari,

> Firmware-Assisted Dump (FADump) is currently supported only on pseries
> platform. This patch series adds support for powernv platform too.
>
> The first and third patches refactor the FADump code to make use of common
> code across multiple platforms. The fifth patch adds basic FADump support
> for powernv platform. Patches seven & eight honour reserved-ranges DT node
> while reserving/releasing memory used by FADump. The next patch processes
> CPU state data provided by firmware to create and append core notes to the
> ELF core file. The tenth patch adds support for preserving crash data for
> subsequent boots (useful in cases like petitboot). Patch twelve provides
> support to export opalcore. This is to make debugging of failures in OPAL
> code easier. The subsequent patch ensures vmcore processing is skipped
> when only OPAL core is exported by f/w. The next patch provides option to
> release the kernel memory used to export opalcore. Patch seventeen adds
> backup area (an area populated before crash and used in the capture kernel
> to setup vmcore file robustly) support on PowerNV platform. The remaining
> patches update Firmware-Assisted Dump documentation appropriately.
>
> Note that the quantam of increase in robustness due to patch seventeen may
> not be worth breaking backward compatibility for older kernel versions.
> Would like to hear thoughts from others on it.
>
> The patch series is tested with the latest firmware plus the below skiboot
> changes for MPIPL support:
>
>     https://patchwork.ozlabs.org/project/skiboot/list/?series=78497
>     ("MPIPL support")
>

If I want to test this, is there some userspace tooling that will
extract a fadump from a rebooted system and allow me to examine it as I
would with a kdump (e.g. with crash)?  I did look at
Documentation/powerpc/firmware-assisted-dump.txt but it seems to only
cover the kernel layer.

Regards,
Daniel

> ---
>
> Hari Bathini (18):
>       powerpc/fadump: move internal fadump code to a new file
>       powerpc/fadump: Improve fadump documentation
>       pseries/fadump: move out platform specific support from generic code
>       powerpc/fadump: use FADump instead of fadump for how it is pronounced
>       powerpc/fadump: enable fadump support on OPAL based POWER platform
>       powerpc/fadump: Update documentation about OPAL platform support
>       powerpc/fadump: consider reserved ranges while reserving memory
>       powerpc/fadump: consider reserved ranges while releasing memory
>       powernv/fadump: process architected register state data provided by firmware
>       powernv/fadump: add support to preserve crash data on FADUMP disabled kernel
>       powerpc/fadump: update documentation about CONFIG_PRESERVE_FA_DUMP
>       powerpc/powernv: export /proc/opalcore for analysing opal crashes
>       powernv/fadump: Skip processing /proc/vmcore when only OPAL core exists
>       powernv/opalcore: provide an option to invalidate /proc/opalcore file
>       powernv/fadump: consider f/w load area
>       powernv/fadump: update documentation about option to release opalcore
>       powernv/fadump: use backup area to map PIR to logical CPUs
>       powerpc/fadump: Update documentation about backup area support
>
>
>  Documentation/powerpc/firmware-assisted-dump.txt |  208 ++--
>  arch/powerpc/Kconfig                             |   23 
>  arch/powerpc/include/asm/fadump.h                |  190 ---
>  arch/powerpc/include/asm/opal-api.h              |   58 +
>  arch/powerpc/include/asm/opal.h                  |    1 
>  arch/powerpc/kernel/Makefile                     |    6 
>  arch/powerpc/kernel/fadump.c                     | 1199 ++++++++--------------
>  arch/powerpc/kernel/fadump_internal.c            |  297 +++++
>  arch/powerpc/kernel/fadump_internal.h            |  250 +++++
>  arch/powerpc/kernel/prom.c                       |    4 
>  arch/powerpc/platforms/powernv/Makefile          |    3 
>  arch/powerpc/platforms/powernv/opal-core.c       |  602 +++++++++++
>  arch/powerpc/platforms/powernv/opal-fadump.c     |  670 ++++++++++++
>  arch/powerpc/platforms/powernv/opal-fadump.h     |  116 ++
>  arch/powerpc/platforms/powernv/opal-wrappers.S   |    1 
>  arch/powerpc/platforms/pseries/Makefile          |    1 
>  arch/powerpc/platforms/pseries/pseries_fadump.c  |  535 ++++++++++
>  arch/powerpc/platforms/pseries/pseries_fadump.h  |   96 ++
>  18 files changed, 3252 insertions(+), 1008 deletions(-)
>  create mode 100644 arch/powerpc/kernel/fadump_internal.c
>  create mode 100644 arch/powerpc/kernel/fadump_internal.h
>  create mode 100644 arch/powerpc/platforms/powernv/opal-core.c
>  create mode 100644 arch/powerpc/platforms/powernv/opal-fadump.c
>  create mode 100644 arch/powerpc/platforms/powernv/opal-fadump.h
>  create mode 100644 arch/powerpc/platforms/pseries/pseries_fadump.c
>  create mode 100644 arch/powerpc/platforms/pseries/pseries_fadump.h
>
> --
> Signature
