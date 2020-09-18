Return-Path: <SRS0=QDwo=C3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5377CC43464
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2020 01:36:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BF762075B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2020 01:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="c8qMxsvB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF762075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BsxJW0l28zDqWn
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2020 11:36:43 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BsxG35jDFzDqgq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2020 11:34:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20161025 header.b=c8qMxsvB; dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 4BsxG34StRz8xj8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2020 11:34:35 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 4BsxG33ypdz9sT6; Fri, 18 Sep 2020 11:34:35 +1000 (AEST)
Authentication-Results: ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--ndesaulniers.bounces.google.com
 (client-ip=2607:f8b0:4864:20::84a; helo=mail-qt1-x84a.google.com;
 envelope-from=3ow5kxwwkdfi7xycue572ybc08805y.w86527eh99w-xyf8j5uvc.8b0@flex--ndesaulniers.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20161025 header.b=c8qMxsvB; dkim-atps=neutral
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com
 [IPv6:2607:f8b0:4864:20::84a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4BsxG26slWz9sT5
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Sep 2020 11:34:32 +1000 (AEST)
Received: by mail-qt1-x84a.google.com with SMTP id a16so3604975qtj.7
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Sep 2020 18:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=h4DBk/5WkNHPXPPhovT87q0/qS2kLULMROgpGrI8Sbk=;
 b=c8qMxsvBptBC7l19hQyFMiYxS8rT9bWW6Er7flelv6GThJB8Tgm29Srt3OYRFd1npY
 3PBcOqgl6QStlVBpHYzdVMXd8NJEwZHnBJrG5QbZLo6xcOX3iaTkMJjAsxS2ejOi0pyW
 3FPWBJ5HXnekzCAhEIUM942YB+srfZwS58DKx36fRsBiHSU5UBKlto39KwWN+juRNDoA
 M8Lagt8uUjQkC77I7WbPNPCd7T57yi5QFQ3IkZMPg/xkUEHfTwK6PYLR/AT0CkibWQhV
 MKwb7kuObmD++fQ06qhTjtlVaV+9OtlPwdAtrVrIcc0QnXIMTE8RIw9zvOJjEuyGceWw
 IzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=h4DBk/5WkNHPXPPhovT87q0/qS2kLULMROgpGrI8Sbk=;
 b=DmBto/Xqy+oPr6CrsepZI/XTaAS3DyHqpemnAa27LcC5KPyhEDH/aYMElPqUKNCPQk
 sYA53e/M2lbAXOREDivs4vJ01JQTHBBkp5nNWdK7OunnZZcR0c8br7QiPJ9hpAT+hiRA
 6I7EQc2xgEpBLJ/4AynenJtCjfcWe0RpjpFMPhxNgmInvTYoPLqmdT9dfMrMJRmn2v5o
 XOLQjHNYY3aZE4ZfA7HJX1U725yVlbpE2L7ilDS2WmbhIxAOst0pW0VVj3StkiwNqRn8
 nEiVm4o9wyDDc0Tc+MlovfibJWrqVh5LEPGJ5j9PfC0USg2h9dR3Ywmz8RK+Xaf6yhde
 VR+g==
X-Gm-Message-State: AOAM533am6NcHJmifUk0FfTCk2BbWG93ZplKs919keZkdAUFgpCFJ7hz
 h5kxbtgAer3P0kT50iXGH2wAT22q/P05cRw1ays=
X-Google-Smtp-Source: ABdhPJy4Aou6NncEzhaBiNd1L7Fk/QqrUG2xZaa+tpYnHECp9z8v8BAPOUZudAHm9z/8+v1noW8TitdTcQKx6PrX0lk=
X-Received: from ndesaulniers1.mtv.corp.google.com
 ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a0c:fe8b:: with SMTP id
 d11mr15461547qvs.48.1600392867883; Thu, 17 Sep 2020 18:34:27 -0700 (PDT)
Date: Thu, 17 Sep 2020 18:34:13 -0700
In-Reply-To: <20200917024509.3253837-1-mpe@ellerman.id.au>
Message-Id: <20200918013413.910549-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200917024509.3253837-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: Re: [PATCH] powerpc/process: Fix uninitialised variable error
From: Nick Desaulniers <ndesaulniers@google.com>
To: mpe@ellerman.id.au
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
Cc: linuxppc-dev@ozlabs.org, Nick Desaulniers <ndesaulniers@google.com>,
 clang-built-linux@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

https://lore.kernel.org/linuxppc-dev/20200917024509.3253837-1-mpe@ellerman.id.au/

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
