Return-Path: <SRS0=0xlf=J3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85327C433B4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Apr 2021 14:42:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C97D7613EE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Apr 2021 14:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C97D7613EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FWw7s74jMz30FD
	for <linuxppc-dev@archiver.kernel.org>; Sat,  1 May 2021 00:42:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=iRrhDC4O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f30;
 helo=mail-qv1-xf30.google.com; envelope-from=leobras.c@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=iRrhDC4O; dkim-atps=neutral
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FWw7P14CFz2xVt
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 May 2021 00:42:07 +1000 (AEST)
Received: by mail-qv1-xf30.google.com with SMTP id h3so33714063qve.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Apr 2021 07:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :organization:user-agent:mime-version:content-transfer-encoding;
 bh=Oi7QuYoVpkckRDLbY1jEPH0cB2iAdS8yGwTIyJKz/hI=;
 b=iRrhDC4OVkCL63311ThWgLTjC961g9wxj1E6V4cmMI1URotwmd3hFFJ0R2XMRyQpJF
 R5bjBbUonPTT0puEwgiKZsQ1o0jKQi54MtKjyhPtD+sEbytoZ5njD5jyTJOCo0L7t+pd
 G560IdIvH2Tu6jPvlYjJz/jqMcJ3F7Ho+WcMJAPkz3XTiUZXkdeFilWRn9LEQih3J+wQ
 JPHcHYq89Djik1hipyzbumGODyItyH9LN8PFYHyE1RIm1WVbDwduhwUK1NAoDZtvo1gf
 sdxVJ3ZexFw6qtQ/pP8gs7tLvsEiA7NY6DhWFhnNu7bLBLeA2Dn01IdqLPCbpW+Hnak3
 IpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=Oi7QuYoVpkckRDLbY1jEPH0cB2iAdS8yGwTIyJKz/hI=;
 b=p7/cbPvXi1n0OFLBHsa7Hz7hI8txbYfhGIP9EHyJAozShr4BDsVTb3V4cZ6LeIxIof
 bqjkwfWDh7goV0+osnjNknKf2j9O2mRR/9kcfADCOrTi7XQhW7iwcBOSpAu0c+ceNq6h
 pcAbk9DyJKgHHf8Uv9+Qd59Dhhn0AxhkdxjZ8Y7t2Hc1cCsIXkJieWy+5OND/iDeKjmP
 NoW3bsRucFy7Lc3jwfueg4Xw8mqjAxbCGqk1EnYMEkxa9qpsGYLZWpbxxsWaEzI26EQv
 yOkKMmXODpvzBcPSMWjjsgXdn3IbUeujbxroIQJsDUmqw5yb+PmfAsMdMBWtWXDFjhM7
 5SKQ==
X-Gm-Message-State: AOAM531wPRjumPnzhbQTNduEWpAWlhBG9iZHGk3drDjOR4c1wuT237Ti
 SnIAp1Ua2zSj4nXnBuXbQV8=
X-Google-Smtp-Source: ABdhPJzQTFz7FuFvopRcGCrsZbrAiq7Pk3GuRgEXaeMjtXUT8jIzwIQlsZqybs2+vOSi1PUpo5F9sA==
X-Received: by 2002:ad4:4b33:: with SMTP id s19mr5525924qvw.35.1619793725519; 
 Fri, 30 Apr 2021 07:42:05 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com
 ([2804:14c:482:7b04::1001])
 by smtp.gmail.com with ESMTPSA id x13sm2387967qtf.32.2021.04.30.07.42.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Apr 2021 07:42:05 -0700 (PDT)
Message-ID: <90ce7c8849c1a1c1c42ec2901d1c3b689846f6c7.camel@gmail.com>
Subject: Re: [PATCH v2 0/3] powerpc/mm/hash: Time improvements for memory
 hot(un)plug
From: Leonardo Bras <leobras.c@gmail.com>
To: avid Gibson <david@gibson.dropbear.id.au>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Paul Mackerras <paulus@samba.org>, Sandipan Das <sandipan@linux.ibm.com>,
 Mike Rapoport <rppt@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Nathan
 Lynch <nathanl@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Scott
 Cheloha <cheloha@linux.ibm.com>, Laurent Dufour <ldufour@linux.ibm.com>
Date: Fri, 30 Apr 2021 11:41:59 -0300
In-Reply-To: <20210430143607.135005-1-leobras.c@gmail.com>
References: <20210430143607.135005-1-leobras.c@gmail.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

CC: David Gibson

http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=241574&state=%2A&archive=both

