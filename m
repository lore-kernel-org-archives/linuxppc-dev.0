Return-Path: <SRS0=k87x=4T=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B40C3F2D1
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Mar 2020 20:23:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0C1621739
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Mar 2020 20:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="lV8GXcPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C1621739
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48WWmZ2kG5zDqY2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Mar 2020 07:23:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::a42;
 helo=mail-vk1-xa42.google.com; envelope-from=eranian@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20161025 header.b=lV8GXcPA; dkim-atps=neutral
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com
 [IPv6:2607:f8b0:4864:20::a42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48WWkh18DjzDqW1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Mar 2020 07:21:23 +1100 (AEDT)
Received: by mail-vk1-xa42.google.com with SMTP id y125so209313vkc.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Mar 2020 12:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GrNNnjItPXoUSAp5/6CuW8AHlrS1JSgSwId4oyjSgCk=;
 b=lV8GXcPAD9YUu7oqVXNTN6JNL/pszISLDCdNOgt79zz4pHerK02MjVMnhAURV3NvCL
 FVFoNlTCfa2PZhHk3fEYezlSqSKM62JrSPEwYjwOHyRnUFDTozemgg9LyngGdXKjUq7p
 Wmh18IXVYhHE4ZDnjl8Mf0viqutS8huzuUi4hNPhnMUbUoyCXJGSijzCz8L9JWEW9l2f
 hukDFobeolOUmuTVrc93oy20GgtW0hHalC9pjb/i9j75FuU7JC1vidgsB6RVK9We/eWP
 BJdPE9etmq//Wogoiq4/GZCgdD0EPRY7KHiZqjnzThzLdSAHgMQChrrg3U+Va43dmx2h
 8gpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GrNNnjItPXoUSAp5/6CuW8AHlrS1JSgSwId4oyjSgCk=;
 b=ZF3XaDCOls4lGhco+TtFY1nPsizpKLClU15d0tHX++iX5X87T0bmYdci3IaFLS+9IA
 c3FCw3mVsQGqMOA/uqGX/ugd14YQpIPtyWFMnVjD02qXWx5+kwSXWWfPod6HCnPIBaBK
 mM6I27x/0RA78IB3VRATiy9wnXnqQIiKBfnSwYwwSv5S4i7xKpD6v/gxpLxQZGVhFSIH
 njDmDL54NhPvDVCzNWvWKxNUYusy+fH22WPCZe/qvlzozKy4MNWmxhvOojnevTVJ9V3a
 8dRo2jt8orlvtsVYgsEvofTxDDJ8+V/QMW5tAtpLziWQ8+jqoEyeciK9Vp8ecyiwWuRz
 EY4A==
X-Gm-Message-State: ANhLgQ1QiQ9uC8tSJ8z042/LV5rCQtAe5a1V/aufsOvXkNgZLU/LNPgo
 BxB+3AWylp1bnMLuF+oVGE93RWaRJUcQNdO82g8nmQ==
X-Google-Smtp-Source: ADFU+vuHDDUez4FqqKiHhS43fjWXjrsrzfWXTcjtessfBqf9EPjwVXyf1gR166Ynvh9kTlFxmW/y8N+oPw7+f3OE5cI=
X-Received: by 2002:a1f:a9d0:: with SMTP id s199mr926630vke.40.1583180480007; 
 Mon, 02 Mar 2020 12:21:20 -0800 (PST)
MIME-Version: 1.0
References: <20200302052355.36365-1-ravi.bangoria@linux.ibm.com>
 <20200302101332.GS18400@hirez.programming.kicks-ass.net>
In-Reply-To: <20200302101332.GS18400@hirez.programming.kicks-ass.net>
From: Stephane Eranian <eranian@google.com>
Date: Mon, 2 Mar 2020 12:21:09 -0800
Message-ID: <CABPqkBSzwpR6p7UZs7g1vWGCJRLsh565mRMGc6m0Enn1SnkC4w@mail.gmail.com>
Subject: Re: [RFC 00/11] perf: Enhancing perf to export processor hazard
 information
To: Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Andi Kleen <ak@linux.intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Robert Richter <robert.richter@amd.com>, yao.jin@linux.intel.com,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 maddy@linux.ibm.com, Namhyung Kim <namhyung@kernel.org>, "Phillips,
 Kim" <kim.phillips@amd.com>, linuxppc-dev@lists.ozlabs.org,
 Alexey Budankov <alexey.budankov@linux.intel.com>, "Liang,
 Kan" <kan.liang@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Mar 2, 2020 at 2:13 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Mar 02, 2020 at 10:53:44AM +0530, Ravi Bangoria wrote:
> > Modern processors export such hazard data in Performance
> > Monitoring Unit (PMU) registers. Ex, 'Sampled Instruction Event
> > Register' on IBM PowerPC[1][2] and 'Instruction-Based Sampling' on
> > AMD[3] provides similar information.
> >
> > Implementation detail:
> >
> > A new sample_type called PERF_SAMPLE_PIPELINE_HAZ is introduced.
> > If it's set, kernel converts arch specific hazard information
> > into generic format:
> >
> >   struct perf_pipeline_haz_data {
> >          /* Instruction/Opcode type: Load, Store, Branch .... */
> >          __u8    itype;
> >          /* Instruction Cache source */
> >          __u8    icache;
> >          /* Instruction suffered hazard in pipeline stage */
> >          __u8    hazard_stage;
> >          /* Hazard reason */
> >          __u8    hazard_reason;
> >          /* Instruction suffered stall in pipeline stage */
> >          __u8    stall_stage;
> >          /* Stall reason */
> >          __u8    stall_reason;
> >          __u16   pad;
> >   };
>
> Kim, does this format indeed work for AMD IBS?


Personally, I don't like the term hazard. This is too IBM Power
specific. We need to find a better term, maybe stall or penalty.
Also worth considering is the support of ARM SPE (Statistical
Profiling Extension) which is their version of IBS.
Whatever gets added need to cover all three with no limitations.
