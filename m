Return-Path: <SRS0=Loi+=XP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E336BC3A5A2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Sep 2019 18:33:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C5C32070C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Sep 2019 18:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="A+jpbUMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C5C32070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Zj5y0vy3zF3m7
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Sep 2019 04:33:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="A+jpbUMt"; 
 dkim-atps=neutral
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Zj3W3dlTzDsRH
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Sep 2019 04:31:33 +1000 (AEST)
Received: by mail-ot1-x341.google.com with SMTP id s22so7004031otr.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Sep 2019 11:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YhEh8bVzYUGuUCB/RpHUx78n8Qc9+jFz1obXEDydgGw=;
 b=A+jpbUMt0eQyN9IeJlC+6ZG3CYqMX3zZLIMp0aWDMveI99go9TGsKvmQQYHQU/DrQT
 rzDqBeTODojWZUAHWTBfF65DPs1ZYeZp96wCBpIV59NW53jvSnsdtPBs4NemKWzgiWws
 crKQJb2NIE9OvYaBFANsTHDHtqOVg69nieaZDOH5CKSXAiRKHOQ5M3XoY4Z1Vxw57Snl
 +MbA6DAPhFag6JTu1b0fFiN+VgAu62Zuus5tgsYTvGZIoxZBSIHSy7hFpxIP8dOPmkoB
 dFOWcZXf86ENnEuRv8zBV73wAFcTTPKcHRhs1oz0ialrnNLtej2MgHiKXCojYMynJXT8
 kxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YhEh8bVzYUGuUCB/RpHUx78n8Qc9+jFz1obXEDydgGw=;
 b=Lf+l7X+k3prqY4f/rQt5GVUjotP1VaTS4mGs4QoD2mcRys+wwUKhFV75fsi4y19drf
 y1Xw14Yi4pAp4P2Q6frpBTK67l8UK5oaMtG80T6vcWxOSaIgW6fUq8DUGJNlroqLrnxb
 9HWLnzRRqOLpiP6Id7eIWoM+n4VjPqewLnJvw7B08WTTf9SJhYaR1/9WqiBWZcJDWNNv
 DjPqxPcar4Lb71Q33qFxfcHLOiSJbduxuoatBeyu0RA73TjJcCMtGa7fKcW/Fg35WMAu
 btr7PQ+3ySTwELtsbPFkWgRbHU7tUr0FtrFDjvmeuP33o+hd2eSWp0GSR4YC34NH2TnT
 L9fg==
X-Gm-Message-State: APjAAAVGRg0/YwnoA4crONNINYR6K4JssQWqfadBQHcLkEjChAykSxZj
 prQPjimAcEmRrknVdeVtwne5RLFUmP1ZR+zh0gqV/Q==
X-Google-Smtp-Source: APXvYqw3ifHvoFnzQ3exGPJpJXSnXKYAdYLlKTBTPDAEXq5TsrOPPKZJgZpC1mlD62hN93w9yJRbykcofvi3kYWSMGo=
X-Received: by 2002:a9d:3b02:: with SMTP id z2mr1415168otb.71.1569004288709;
 Fri, 20 Sep 2019 11:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <1568988209.5576.199.camel@lca.pw> <87r24bhwng.fsf@linux.ibm.com>
 <1569003478.5576.202.camel@lca.pw>
In-Reply-To: <1569003478.5576.202.camel@lca.pw>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 20 Sep 2019 11:31:16 -0700
Message-ID: <CAPcyv4idejYpTS=ErsEJWgBxBsC1aS9=NCyvMEDO1rwqRktEmg@mail.gmail.com>
Subject: Re: "Pick the right alignment default when creating dax devices"
 failed to build on powerpc
To: Qian Cai <cai@lca.pw>
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Sep 20, 2019 at 11:18 AM Qian Cai <cai@lca.pw> wrote:
>
> On Fri, 2019-09-20 at 19:55 +0530, Aneesh Kumar K.V wrote:
> > Qian Cai <cai@lca.pw> writes:
> >
> > > The linux-next commit "libnvdimm/dax: Pick the right alignment default when
> > > creating dax devices" causes powerpc failed to build with this config. Reverted
> > > it fixed the issue.
> > >
> > > ERROR: "hash__has_transparent_hugepage" [drivers/nvdimm/libnvdimm.ko] undefined!
> > > ERROR: "radix__has_transparent_hugepage" [drivers/nvdimm/libnvdimm.ko]
> > > undefined!
> > > make[1]: *** [scripts/Makefile.modpost:93: __modpost] Error 1
> > > make: *** [Makefile:1305: modules] Error 2
> > >
> > > [1] https://patchwork.kernel.org/patch/11133445/
> > > [2] https://raw.githubusercontent.com/cailca/linux-mm/master/powerpc.config
> >
> > Sorry for breaking the build. How about?
>
> It works fine.

Thanks, but let's delay "libnvdimm/dax: Pick the right alignment
default when creating dax devices" until after -rc1 to allow Michael
time to ack/nak this new export.
