Return-Path: <SRS0=fTJU=JG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142B7C433ED
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Apr 2021 02:17:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5A3F61002
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Apr 2021 02:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A3F61002
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FGhbk2vW0z3byg
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Apr 2021 12:17:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=vUlcX0Jm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f2c;
 helo=mail-qv1-xf2c.google.com; envelope-from=leobras.c@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=vUlcX0Jm; dkim-atps=neutral
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FGhbB4jWxz2xg3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Apr 2021 12:16:52 +1000 (AEST)
Received: by mail-qv1-xf2c.google.com with SMTP id h3so1188311qve.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Apr 2021 19:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :organization:user-agent:mime-version:content-transfer-encoding;
 bh=vHCqILecOIPMQuLKMX6nqeGWPqCzxrgf7erUzPmed2M=;
 b=vUlcX0JmHoAeHVh7mvYJUTN5IFH3I+jOTc7imFq83Jp9W+LzGr01bfpD1NAdJONbx/
 vmHAARqJImYAeb863Nw2TMmzMLnBwCPpBhlVK7osUmveksTSMmyPS63zeKwEzbnyor2P
 BRI2aNvNZPLAaBl4snSim/3oaOiMgMN6xv4KlN4ndDDtOZVH/bRjjclTNHhpZMkw8LUo
 YSW0L1QUf0a8sA0NA3i0to87xFzxwEk8xOWWCK7KYYuDNupwRE9k9TU9Dy/fz5y0hgQi
 khqzeLYJW8ihZiO8tl9wqzEwi3PNd1hkfy3+jUJE6ZuixrOCdKP3JRtWJmD4ljQUsZf6
 5E/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=vHCqILecOIPMQuLKMX6nqeGWPqCzxrgf7erUzPmed2M=;
 b=LDoCd0lG5fBl5XUwszScFTXJccaXoY3EGkyyJZulLB7vfxMPfDOgy2zGm+/OplXzNm
 XxupSiuSYnDRoZCjs19Zdx9T7PsL2AzY3N07ISeJpz755xBd7VnMTKYByt0cQ9MHm42c
 5yQF6kA44XYgeRDc8oXnBmmfi1bTcR2BoQmxUwovd8chc2xJkvN3C+AdXBpVzaHbuJo/
 16MYpib5SjGcrX2CwsnDqGiVS2NDYUponu0tMZErOZYNXWbx7kBR2pESQoTKOv9jOfIa
 XNq5qScyh0Qn0Wb2zqcytjsd/FIPEbGcpSN3TQEGzu+MhJ6ZzqkbibYcDuuJuO9wSncf
 J9lQ==
X-Gm-Message-State: AOAM531MJamrMwhdBMHk1pxAvEM3B3dl3LwDPqGwGB8upHOQeQx16+uT
 NAEAmYEmqWQ2Uj3F3D9/YTg=
X-Google-Smtp-Source: ABdhPJzxiJ8LOxfShzSQ06LGn73uHCtnki60lqvmhHu+BVJZf39NIe4lJ5RSfdLC0VSskVlAPboFQw==
X-Received: by 2002:ad4:560e:: with SMTP id ca14mr9581170qvb.20.1617934608675; 
 Thu, 08 Apr 2021 19:16:48 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com
 ([2804:14c:482:7b04::1000])
 by smtp.gmail.com with ESMTPSA id z24sm843211qkz.65.2021.04.08.19.16.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Apr 2021 19:16:47 -0700 (PDT)
Message-ID: <09c57b599f8dd95f4ff1c02b83aa093615257f2f.camel@gmail.com>
Subject: Re: [PATCH 1/3] powerpc/mm/hash: Avoid resizing-down HPT on first
 memory hotplug
From: Leonardo Bras <leobras.c@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 08 Apr 2021 23:16:41 -0300
In-Reply-To: <YFg+Edy6dfmZx3lr@yekko.fritz.box>
References: <20210312072940.598696-1-leobras.c@gmail.com>
 <20210312072940.598696-2-leobras.c@gmail.com>
 <YFg+Edy6dfmZx3lr@yekko.fritz.box>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: Nathan Lynch <nathanl@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Scott Cheloha <cheloha@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 Bharata B Rao <bharata@linux.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Sandipan Das <sandipan@linux.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Laurent Dufour <ldufour@linux.ibm.com>, Logan Gunthorpe <logang@deltatee.com>,
 Dan Williams <dan.j.williams@intel.com>, Mike Rapoport <rppt@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello David, thanks for your feedback.

On Mon, 2021-03-22 at 17:49 +1100, David Gibson wrote:
> I don't love this approach.  Adding the extra flag at this level seems
> a bit inelegant, and it means we're passing up an easy opportunity to
> reduce our resource footprint on the host.

I understand, but trying to reduce resource footprint in host, and
mostly failing is what causes hot-add and hot-remove to take so long.

> But... maybe we'll have to do it.  I'd like to see if we can get
> things to work well enough with just the "batching" to avoid multiple
> resize attempts first.

This batching is something I had thought a lot about.
Problem is that there are a lot of generic interfaces between memory
hotplug and actually resizing HPT. I tried a simpler approach in
patches 2 & 3, so I don't touch much stuff there.

Best regards,
Leonardo Bras




