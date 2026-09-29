Return-Path: <linuxppc-dev+bounces-28430-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC80CA5FAB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 02:07:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hv1lm0lJCz30Vb;
	Tue, 29 Sep 2026 12:07:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:38::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790647652;
	cv=none; b=RdAhrqH5CTNyVuadfr+6zgDUoqEuK6Kk35ClEB2imC1i/49nBI+Cf4oiMqceey2Cy1jMqoQUJk4R2iw3tYcYBjpTrYSNK5VhoxBcfHNhH8/jjAESUJBBiSMKtokC1MsEYMJhVgEc8uy6V/4DhmcXkJ5kAYmfZ2/UzTCxt1RuvLxac4ttGmJT91P6zkFCl80IVnbobHJ0m5I0vTYtLoaKBIAnNFhd45gJbOWiPv+Ch47izVk+eVw/pz54IsbRAhI8DYjm4qogFujS3vN+XjUF6DN8DM1sF/Yeo8DkAdh/E4d266v9PN5Jc7SpvHAY0NpqqNHXOClTwmAFRko+JCuzpg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790647652; c=relaxed/relaxed;
	bh=fbDwKzts0Y/4dxNxzvKuYePx4Mzwd+ywZtamrjsWr5w=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=f8lrbHAgrxTNh15sX2k9vP+M0VbGgpUJdDyp8dHQRycKWk6ZMeSjdx+Ax8wJpOR81j5jgIdyNWM+NUItiYwSNQXKnfK7XiO31EwtsWO+0yRCU/ysPkN/GLTGVDyfDJBXCmmkA65IkkIRLjQC+O/2Na3F5I9aWh3osVzE4LIMZNTCzS/DaWgz9W817kSZcGyFu14TB+6pdfvoj5mQ9ba/w1iEIKSe2HdaWOYLM1nxtmXjE+nXmlYp/Hv34/dCY5Lx+telYmyL0tISiiEo6u//1+SzA12KehoPNMSlvkLx5vccRnXi5Vb3ddJUScvzB7rkWURV9ZmJRKfezLCA1/8+kw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m3cXLFjh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:38::f; helo=mail-dl2-x0f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m3cXLFjh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:38::f; helo=mail-dl2-x0f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl2-x0f.google.com (mail-dl2-x0f.google.com [IPv6:2607:f8b0:4864:38::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hv1ll1h3Fz30PJ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 12:07:30 +1000 (AEST)
Received: by mail-dl2-x0f.google.com with SMTP id a92af1059eb24-1450541ab18so4104228c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 19:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790647647; x=1791252447; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fbDwKzts0Y/4dxNxzvKuYePx4Mzwd+ywZtamrjsWr5w=;
        b=m3cXLFjhMY1zLm5f3UTlSZ1rOE8p9cZth7/m5LR4+DG1IZwwF5TCgyXTZDtwFVlgpe
         dkcw1DZ1VAnU8slBMeS3qABCtyyc9V22+RzcQgpoypjwYOgM3/BS7M7jMoSmjQU0bc9c
         uXN4tUHJ0yV8QZlYaF1phJdlT7yiPgLKtGCgXq/EdfohBCqraDV81C+TiQ0bXZcYjKXS
         cccMRDMiP1mc2OjAiQrKIL3MBkDWRg/Lr9zB2nY7VlRP45+VSnyhe2fBI2MuUbCmH1Im
         NphH3mNJ5cxzkTOgCvlxBAMb5H3cdsTrU2G6EwmGBpnw1fQuhhEbUpwEBCtKUBIYJJ05
         R6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790647647; x=1791252447;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fbDwKzts0Y/4dxNxzvKuYePx4Mzwd+ywZtamrjsWr5w=;
        b=OYb20Xyskl5ZvF4HeAPPvipFjHFeK/0/QDQx/BvfHNVw+er5H57zMSu40tJkXHplAc
         qU+TW0ygIeSdvRLpwUQifXeQp9X8GGD5WNSMXhxOAU5+yBxl3mcB7/Y9craDNfyl+ejN
         4k9bG+Mbf8CTB1dBDCilEliT8cDvxRZWFgE4y8GhLci8vsttK7gj/0HOKuUOZ4QAqLfP
         2Ck/CLO220WhF11OGwzMbSmbySrwhsyQ9oPKq6zHP8eptH+SzRLY+vJIMpHOGEUnVjPQ
         jeN4zsD61GbnsE8IqRlzpOvU6nn+zcXZ4IqkuSlVriNT0V9vBVQ31B7opuxILV37O2nn
         AsPQ==
X-Gm-Message-State: AFuF++mv+hEVvrOILRYNr2zanj2/fJSq4xX0PtYwrWI1EUH1ozXqczMj
	QPTvLuw63J4N8MDjYHB/jS+nirOX5uMBuW+nOI8GurxmwR41eS8sXQ3Z395CJCRo
X-Gm-Gg: AYBFou0didj3MTyYN3Z+2wHlYys5wc3oEod531wiADf6woJmhWRy5ZpVP2UbYYKJa+m
	Ni8ZAOzjQ246G1oMVviIWbtb69fyneIgt9hbvfqadVpthOQ/XexvYhTR14/1Wy7Vt4kJboneWel
	Nf3NWNJT4xH9Gj2pBy1+4rewD5VDX0feEd1Er/qjKiADXuMGxOMI85T4gaMy2jlleSPppVDB4vc
	d1pMhKjB8STL7orDzauKZ1WtNmeF/wnLHlAjEEK76P3YWUJbK0jL0Fhx32ad3tLFzboi2aLWEf1
	F9QPVYvmn3lR1rGiPMNwIpcDckYrBTd60RfqwhuQgDUzH8xz1+246q3+1Sc7obZuXd0T6aQoVJl
	GYvktsrcGokakGUGICf3q7CjIv3vkzRj/lqT/gy0VfQjKPHCnYU67FK4Vh4OqgYMkp5kYNXomPg
	VhB/4BBncbvCz1aWxHYJmvVgJD018m4Nj6Ga0kw7r/EEiRBqYzOE+aoHb/qrfXlGGEoTj3PIqPR
	Fu50UtVdPaVV6G+bygfvvvW1YJQIklcdzARH1haSmzZFv5Y4n7z1Q==
X-Received: by 2002:a05:7022:1586:b0:143:26eb:18e9 with SMTP id a92af1059eb24-146d00b72bdmr12928702c88.28.1790647647112;
        Mon, 28 Sep 2026 19:07:27 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145a7318afcsm26831012c88.0.2026.09.28.19.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 19:07:24 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC 08/12] powerpc/pseries: Annotate the DTL debugfs read lock context
In-Reply-To: <590f421ed3946c7908783d10de39a9127c4cebb8.1790517984.git.ritesh.list@gmail.com>
Date: Tue, 29 Sep 2026 07:34:14 +0530
Message-ID: <mrt0ke3l.ritesh.list@gmail.com>
References: <cover.1790517984.git.ritesh.list@gmail.com> <590f421ed3946c7908783d10de39a9127c4cebb8.1790517984.git.ritesh.list@gmail.com>
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

"Ritesh Harjani (IBM)" <ritesh.list@gmail.com> writes:

> Clang's context analysis reports:
>   dtl.c: error: rw_semaphore 'dtl_access_lock' is still held at the end of function [-Werror,-Wthread-safety-analysis]
>   dtl.c: error: releasing rw_semaphore 'dtl_access_lock' that was not held [-Werror,-Wthread-safety-analysis]
>
> Add the necessary annotations to phy_attest_sequence_{begin|end}(),
> to fix these errors for enabling Clang context analysis.

Sashiko pointed out:
  "Does this commit message reference the wrong functions here?"

So here is the corrected version:
 Add the necessary annotations to dtl_{enable|disable}(), dtl_file{open|release}(),
 to fix these errors for enabling Clang context analysis.

I will wait for any review comments before revising v2.

-ritesh

