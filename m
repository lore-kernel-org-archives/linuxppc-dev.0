Return-Path: <linuxppc-dev+bounces-18326-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931F8FED9E4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 16:05:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZxcc209Sz2yhV;
	Wed, 18 Mar 2026 03:05:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::631" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773763504;
	cv=pass; b=c83wWL4/7sfO9DNljqzgyAmsEFsx4xwS+wxiu0urY/HN+v7OHjX+BVykZIIieh1zrPXnkf6AJCdn+HV9LWvyd9TnxI8XmeyGpYROHIhoIS5WvPPxaERcK6EGTVd8a9d34sLevMxybYmy/wEFdVHihslzNKTRcZtNzBMsHNgH67jcbizG1CflAXaN5SxjtDnX/xaOtZ3CKUqcG2QtqTD9u4E1oq9vr5c1Iru3HnMhb45bAGOGiHh1JyNFezS73rgpNjJqWpvW6XwUelLNT/hElb2fDuBlzVkZM/uFG6r5o8HciIl3xcKu0V5cEwTNbDbzWn9YsXSYaGRdFSey2h/Yrg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773763504; c=relaxed/relaxed;
	bh=8cphgzUVxFTizMLis/z4Nd9WdAtFNCPpiUECCCXUPz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLi+gyHtjJJ+7P73ArYHSYQvDcsOL8w/6oPCBhKujSdiGFUg3UoaGZr8v4VJ6hZU9a3bJTyKxMT/NDdUuJtg/zm0fF6qXsE6L8D7Wq+bq2rbmb/fB7x8PLi59z07sEZFyrTDzzNAlunx05D8cLQ5F0LTnRvBevJjuzQGN7TAHK6jKG+XS2zz45WgCGh4kLqabgOp7WDzGZCZJLyNUlT/4IlLhe2lIansN3XzowRd1JTOADlkREpm9GAby9KgGh4eXRjWB/T26XmDZc2d2XPcC3VrxPLYEhYkaRxIUKH5IvsAnTiLSy5Kj1P5SnsJq/4AWUSf2T/2twcfaDaR4EINnA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=S3kwb2qF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=S3kwb2qF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZxcZ6lKlz2yFd
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 03:05:02 +1100 (AEDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2aeab6ff148so94805ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 09:05:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773763501; cv=none;
        d=google.com; s=arc-20240605;
        b=ToDSlwVKdMdk5508Cj0QKP5o5aXjvSy4GLbsBe5WmdNxGu0JBKYdcVqCMCEL4JoSVx
         jnHUpFKc+4pNCVCAl1ww0onvDwY2uwPgi7AuDYjJmuNttJwLXp/jiekyq4MZZ6sSnMie
         8i4sokjSCvqt8JfzcIvLaoiXMut82syOBuJu9qXyRSUnyqf3e/pPPP8IP+G6rJjiqX79
         n+r6Anzc00dIwPood/N/Furp8OKNeD0nE3EAcww+L2RoSJ0USYReiKTUs3UfYK7RHwTV
         kF0YwuazknkE/VRqgn9Mt3wbpOziWhKo6i0xTK/Z2Vf1HPaTvkP7igMONFwOIjTHIohf
         OsxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8cphgzUVxFTizMLis/z4Nd9WdAtFNCPpiUECCCXUPz8=;
        fh=IyVMcA0/U4XgWObH5G/0//d3l9oA/FVUwQIr/aPY5Hg=;
        b=bqPEVVsM/IpDRCpcb3vxAdtLqToISfy/nBORm826EQiHYKThMcC9lAh2O34mRL35Hl
         XEM310U/g2x2HcYxX6+1hdjI0B2ibtDCVabyt+MiNIok6osSr1hUOq7ZBJRziaepNKKB
         VwpWedDDwLlGeGxkk/PMFJ6YwgHPem/Vj4HWPYEsSjToILIwLEmfjnNNRXL7KF5/15bU
         RutltpEWtpHc7+57NZhwr0L5xQbTvzWdMm+dKQbHRKlzZQPPFj3oDGOyh9+eH31BKyvq
         jmOlGuMKeWxzD5p/uxFRUAV7H939wKT+Pi5phRu8bb6G98wEhreeZihC/K1fciEpq+ey
         H8Bw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773763501; x=1774368301; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cphgzUVxFTizMLis/z4Nd9WdAtFNCPpiUECCCXUPz8=;
        b=S3kwb2qFodSrNwr970S8JrPhJ2WK3r5SwoRHMWkNSYPZOfr00WodMrXgVOvMw4lIH6
         95GGpQIqXMxyCQbgjmkV2QNlmoAYCIW5+7XXq/UpuNsjWxp1eUsnIiYmZQiKSVYotsyE
         tPOSXcwyq+zlKDw2Bn6L+qrZsBg2jfQbDXY3+4f7v4yei38zbgbgOw2xX8Aa6FjeCm73
         siCbSdYxWg6lzXMVEuNON7aLkVMAFHLQqKiuaiQ6+icN5rAnNdsrGqnepV0/o7tRNtoN
         ugdl8GxUQ2yI+BeR5ddj/NwLEsDvOJCmCVT/5Ql9tPJZtIfYR47kZ69vrpMgOrGbrHKs
         pmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773763501; x=1774368301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8cphgzUVxFTizMLis/z4Nd9WdAtFNCPpiUECCCXUPz8=;
        b=O5Jt27x7pPrU4HwOhAWVqibS/NF1iFG46h1rIemJiO/tSlS1QYqgrycbGKeTFspuwS
         5pD/4s+Lqrgp1XabSpeRHY62iTmDjDMt7lND4cW6pPk0oWtU6z/xIrLiEsNPsWfzvJzd
         bf0Uud4bGrAwP5aplp4uhFqvZ1tLIXD3YqV/oMtlG0gQTKaAWskW3B4Datj62GYURhIN
         TFHIPZuIdLyYHLuFMPeAsxwybDSYoOEq96Wda99t8JdlEy2X7vtkFd1uoYwc22q+4p22
         448Lw87HkFp4JbF+8YMOD4VWjn+ApZ3sWD4hlFSHutKWBO1IXyKEMCU+VEXqTlQc0nXq
         hhVg==
X-Forwarded-Encrypted: i=1; AJvYcCUK8xAQ/IOODgvstwTONcpHMqHBxIHwSclZ6n2MP6Dbb+WcEZuKLe1UrnRvquFZqek+lepHQmyBluk8MMw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwhTqBPBwpnIZyPMjdh+8E2aR6WJdWAR+8jhCk6XNuZl5Dd8trd
	HU2S7Le3XB9TsXRwjTL1GXPNXB8bclUFQnwCldXsJZDalH6Uho6VxZmy1e2mE7FHY4YAqye+KI3
	HiXHQN7fxpf3GOPCxFvHp9Y23f2ssI7f+3AX0mEZj
X-Gm-Gg: ATEYQzyrCRjC6QfPwz+DY6ieX9fVlJv+D12XteNVqkQoA1n18wDNLgxBjBPTNb8va/x
	T4O4dLaFKguqciAtKePIDiM43PX5+WZr1WIXnB+yeVDt2U3Mf8bYiEJ0b9D3JXOVViTLN8qziqH
	artPU9bQVGSo7gUx/orf7Gvmfxukp+JUs3MAkSG/ubJ8SmZCCJh47HplrNLVvg3zqPY003dULMJ
	t0fku07lpi+kQjc8vaWWmvuflxux4vuxdtGLqTRrtMD1WEG1CF4WJ21qIvVvNDQ+NBLMq1Brcg9
	1C7XIcFYElDmcfeMrmY=
X-Received: by 2002:a17:902:e802:b0:2a7:87c2:fcde with SMTP id
 d9443c01a7336-2b0659d8d7emr2625595ad.15.1773763500133; Tue, 17 Mar 2026
 09:05:00 -0700 (PDT)
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
References: <20260314083722.76728-1-atrajeev@linux.ibm.com>
In-Reply-To: <20260314083722.76728-1-atrajeev@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 17 Mar 2026 09:04:48 -0700
X-Gm-Features: AaiRm5340p5_SgfiTHi2ZB8zSueLw5aT-HV6NIG-oe-Lp6xH-35Td8lvxVkdaBk
Message-ID: <CAP-5=fU8VojUXB9oD1u713WeHQ9oLBn0fQ0=Kif0XetxMg7MGw@mail.gmail.com>
Subject: Re: [PATCH] tools/perf/tests: Update debuginfo check in skip_if_no_debuginfo
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	jbrnak@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com, 
	maddy@linux.ibm.com, namhyung@kernel.org, linux-perf-users@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com, 
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 14, 2026 at 1:37=E2=80=AFAM Athira Rajeev <atrajeev@linux.ibm.c=
om> wrote:
>
> Perf test perftool-testsuite_probe fails as below:
>
>  Regexp not found: "\s*probe:inode_permission(?:_\d+)?\s+\(on inode_permi=
ssion(?:[:\+][0-9A-Fa-f]+)?@.+\)"
>  -- [ FAIL ] -- perf_probe :: test_adding_kernel :: listing added probe :=
: perf probe -l (output regexp parsing)
>  -- [ PASS ] -- perf_probe :: test_adding_kernel :: removing multiple pro=
bes
>  Regexp not found: "probe:vfs_mknod"
>  Regexp not found: "probe:vfs_create"
>  Regexp not found: "probe:vfs_rmdir"
>  Regexp not found: "probe:vfs_link"
>  Regexp not found: "probe:vfs_write"
>  -- [ FAIL ] -- perf_probe :: test_adding_kernel :: wildcard adding suppo=
rt (command exitcode + output regexp parsing)
>  Regexp not found: "somenonexistingrandomstuffwhichisalsoprettylongoreven=
longertoexceed64"
>  Regexp not found: "in this function|at this address"
>  -- [ FAIL ] -- perf_probe :: test_adding_kernel :: non-existing variable=
 (output regexp parsing)
>  ## [ FAIL ] ## perf_probe :: test_adding_kernel SUMMARY :: 3 failures fo=
und
>
> Further analysing, the failed testcase is for "test_adding_kernel".
> If the kernel debuginfo is missing, perf probe fails as below:
>
> perf probe -nf --max-probes=3D512 -a 'vfs_* $params'
> Failed to find the path for the kernel: No such file or directory
>   Error: Failed to add events.
>
> skip_if_no_debuginfo has check to handle whether debuginfo is present
> and the testcase checks for debuginfo since this :
> commit 90d32e92011e ("tools/perf: Handle perftool-testsuite_probe
> testcases fail when kernel debuginfo is not present")
>
> Recently a change got added in "tests/shell/lib/probe_vfs_getname.sh"
> via this another fix:
> commit 92b664dcefab ("perf test probe_vfs_getname: Skip if no suitable
> line detected")
> Since this commit, first add_probe_vfs_getname is used to prevent false
> failures. And based on return code of add_probe_vfs_getname, skip_if_no_d=
ebuginfo
> is used to skip testcase if debuginfo is present. And this modified other
> testcases to call add_probe_vfs_getname first and invoke
> skip_if_no_debuginfo based on return value.
>
> The tests in test_adding_kernel.sh which depends on presence of
> debuginfo are:
> 1. probe add for inode_permission
> 2. probe max-probes option using 'vfs_* $params'
> 3. non-existing variable probing
>
> For these tests, probe check for specific line is not required.
> So call skip_if_no_debuginfo with argument to say if line check is
> needed. This is to convey to skip_if_no_debuginfo() function
> that test only needs to check for debuginfo, and not specifically
> line number. Update skip_if_no_debuginfo to use simple "perf probe"
> check if test only needs to check for debuginfo. And for other
> tests which rely on line number, use add_probe_vfs_getname()
>
> With the change, verified that only three which required debuginfo only
> is skipped and others ran successfully. Also tested with debuginfo
> to make sure tests are not skipped.
>
> Reported-by: Tejas Manhas <Tejas.Manhas1@ibm.com>
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>

Thanks for taking the time to improve the test pass rate! I'm sure you
saw Venkat's comments, but for the change itself:

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  .../tests/shell/base_probe/test_adding_kernel.sh  | 15 ++++++++++++++-
>  tools/perf/tests/shell/lib/probe_vfs_getname.sh   | 13 ++++++++++++-
>  2 files changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh b/to=
ols/perf/tests/shell/base_probe/test_adding_kernel.sh
> index 555a825d55f2..f3db125c8669 100755
> --- a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> +++ b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> @@ -23,10 +23,23 @@ TEST_RESULT=3D0
>  . "$DIR_PATH/../lib/probe_vfs_getname.sh"
>
>  TEST_PROBE=3D${TEST_PROBE:-"inode_permission"}
> +PROBE_NO_LINE_CHECK=3D1
>
>  # set NO_DEBUGINFO to skip testcase if debuginfo is not present
>  # skip_if_no_debuginfo returns 2 if debuginfo is not present
> -skip_if_no_debuginfo
> +#
> +# The perf probe checks which depends on presence of debuginfo and
> +# used in this testcase are:
> +# 1. probe add for inode_permission
> +# 2. probe max-probes option using 'vfs_* $params'
> +# 3. non-existing variable probing
> +#
> +# For these tests, probe check for specific line is not
> +# required ( add_probe_vfs_getname does that ). So call
> +# skip_if_no_debuginfo with argument as 1. This is to convey
> +# that test only needs to check for debuginfo, and not specifically
> +# line number
> +skip_if_no_debuginfo $PROBE_NO_LINE_CHECK
>  if [ $? -eq 2 ]; then
>         NO_DEBUGINFO=3D1
>  fi
> diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf=
/tests/shell/lib/probe_vfs_getname.sh
> index 88cd0e26d5f6..8584ec76f041 100644
> --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> @@ -39,7 +39,18 @@ add_probe_vfs_getname() {
>  }
>
>  skip_if_no_debuginfo() {
> -       add_probe_vfs_getname -v 2>&1 | grep -E -q "^(Failed to find the =
path for the kernel|Debuginfo-analysis is not supported)|(file has no debug=
 information)" && return 2
> +       no_line_check=3D$1
> +       debug_str=3D"^(Failed to find the path for the kernel|Debuginfo-a=
nalysis is not supported)|(file has no debug information)"
> +
> +       # search for debug_str using simple perf probe if the
> +       # test only needs to check for debuginfo, and not specifically
> +       # line number.
> +       if [ $no_line_check -eq 1 ]; then
> +               perf probe -v -L getname_flags 2>&1 | grep -E -q "$debug_=
str" && return 2
> +       else
> +               add_probe_vfs_getname -v 2>&1 | grep -E -q "$debug_str" &=
& return 2
> +       fi
> +
>         return 1
>  }
>
> --
> 2.47.3
>

