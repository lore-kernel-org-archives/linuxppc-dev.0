Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72682C282C2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 01:04:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E35DB20873
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 01:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="qIktYmKJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E35DB20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ySGv0Vc4zDqMd
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 12:04:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="qIktYmKJ"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ySD70Mc7zDq6c
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 12:01:43 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id n2so4208208pgm.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2019 17:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=kNQNYw9ilBCIlxdyJpSXq40cRIVxSTAElR2jB/gKRqE=;
 b=qIktYmKJuwKf3SWfBhNqPnq/WeuzUL01QWE7aGGlso94BcuZHnRu6LA3atnLTvSqP3
 zCfQNL558pDQlcXRvvZpbRfcEjPquBvVahGnAoErFMlSjjDvV02IXp5MLMfBIb8s9rR/
 vfUnSqSnXL8mCMIJ5CnN1EhYVMVckUTp4aap8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=kNQNYw9ilBCIlxdyJpSXq40cRIVxSTAElR2jB/gKRqE=;
 b=dKJXDb49Rot3ckfdl/vqYyPV22D1xQGBAC7Bvba75Q0iSngAejNNSXu/ShX11ejpov
 KUcVU/tCb6zzedS3Pz2OUkgB4tW49dJ3PQsCuR8E+LyGO4GOyk984Crkh0yiVW1xbW/Q
 CRwLd6NboEPxJ/cOVogijWTbGNQnBvMKH02pSG6IVs3/oxz+dcL18Bi6KJEhoKiV+F8y
 jeVoE2FFtnCbJevwao5Ldf8ruUkpARUp+9sldj36ztgepOrpFGF11NBQULNQel3PZ14q
 emz6x2xHoTGnsgvcEWU9f/O3k2igdruKE3ZB9PlIjSEhIao/4oHg686Pqh53669d3OAp
 1feQ==
X-Gm-Message-State: AHQUAuZu0+TCNLLC6nl0YdQvWfB7RNyOCEOJER9cUndd+SdFt/Wd9ZV1
 Pd2NeyEdfWBU3mrsAzDFAQBXBQ==
X-Google-Smtp-Source: AHgI3IZarE17qd2k9xyhRQsWdfNO56SJUS6E1wC1Ima8E0QZpaQcukzGkmRg8I9/j1cf8ZHvWD9mbQ==
X-Received: by 2002:a63:f40e:: with SMTP id g14mr22538622pgi.326.1549846901169; 
 Sun, 10 Feb 2019 17:01:41 -0800 (PST)
Received: from localhost (124-171-97-196.dyn.iinet.net.au. [124.171.97.196])
 by smtp.gmail.com with ESMTPSA id z7sm10946534pga.6.2019.02.10.17.01.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 10 Feb 2019 17:01:40 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Sandipan Das <sandipan@linux.ibm.com>, mpe@ellerman.id.au
Subject: Re: [RFC PATCH 0/5] powerpc: sstep: Emulation test infrastructure
In-Reply-To: <cover.1549253769.git.sandipan@linux.ibm.com>
References: <cover.1549253769.git.sandipan@linux.ibm.com>
Date: Mon, 11 Feb 2019 12:01:37 +1100
Message-ID: <875ztr3zpq.fsf@dja-thinkpad.axtens.net>
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
Cc: naveen.n.rao@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 ravi.bangoria@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Sandipan,

> This aims to add a test infrastructure for the in-kernel instruction
> emulation code. This is currently limited to testing only the basic
> integer operations and supports verification of the GPRs, LR, XER and
> CR.
>
> There can be multiple test cases for each instruction. Each test case
> has to be provided with the initial register state (in the form of a
> struct pt_regs) and the 32-bit instruction to test.
>
> Apart from verifying the end result, problems with the behaviour of
> certain instructions for things like setting certain bits in CR or
> XER (which can also be processor dependent) can be identified.
> For example, the newly introduced CA32 bit in XER, exclusive to P9
> CPUs as of now, was not being set when expected for some of the
> arithmetic and shift instructions. With this infrastructure, it will
> be easier to identify such problems and rectify them. The test cases
> for the addc[.] instruction demonstrate this for different scenarios
> where the CA and CA32 bits of XER should be set.
>

I forgot to mention this in my other emails - I think this is a really
good idea, thank you for doing it.

Regards,
Daniel

> Sandipan Das (5):
>   powerpc: Add bitmasks for D-form instruction fields
>   powerpc: Add bitmask for Rc instruction field
>   powerpc: sstep: Add instruction emulation selftests
>   powerpc: sstep: Add selftests for add[.] instruction
>   powerpc: sstep: Add selftests for addc[.] instruction
>
>  arch/powerpc/Kconfig.debug            |   5 +
>  arch/powerpc/include/asm/ppc-opcode.h |   5 +
>  arch/powerpc/lib/Makefile             |   1 +
>  arch/powerpc/lib/exec_test_instr.S    | 150 +++++++
>  arch/powerpc/lib/sstep_tests.c        | 564 ++++++++++++++++++++++++++
>  5 files changed, 725 insertions(+)
>  create mode 100644 arch/powerpc/lib/exec_test_instr.S
>  create mode 100644 arch/powerpc/lib/sstep_tests.c
>
> -- 
> 2.19.2
