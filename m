Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 360D51A0AD5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 19:33:11 +1000 (AEST)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F265114077C
 for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2015 19:33:09 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 21 May 2015 19:33:02 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E0B402BB0047
 for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2015 19:32:59 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4L9WpN018743316
 for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2015 19:32:59 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4L9WQNR028596
 for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2015 19:32:27 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Cc: mpe <mpe@ellerman.id.au>, benh <benh@kernel.crashing.org>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 brking <brking@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH 15/19] cxl: Configure PSL for kernel contexts
In-reply-to: <1432034556-32400-16-git-send-email-mikey@neuling.org>
References: <1432034556-32400-1-git-send-email-mikey@neuling.org>
 <1432034556-32400-16-git-send-email-mikey@neuling.org>
Date: Thu, 21 May 2015 19:32:01 +1000
Message-Id: <1432199871-sup-8243@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Michael Neuling's message of 2015-05-19 21:22:32 +1000:
> +    if (ctx->kernel) {
> +        sr |= CXL_PSL_SR_An_R | (mfmsr() & MSR_SF) | CXL_PSL_SR_An_HV;
> +        pid = 0;
> +    } else {
> +        sr |= CXL_PSL_SR_An_PR | CXL_PSL_SR_An_R;

CXL_PSL_SR_An_R is common between these two cases - you could probably
move it to the initial sr = ... line instead of here.

> +        set_endian(sr);

We should call set_endian(sr) for kernel contexts as well.

> +    if (ctx->kernel) {
> +        sr |= CXL_PSL_SR_An_R | (mfmsr() & MSR_SF) | CXL_PSL_SR_An_HV;
> +        pid = 0;
> +    } else { /* User space */
> +        sr |= CXL_PSL_SR_An_PR | CXL_PSL_SR_An_R;

CXL_PSL_SR_An_R is common here as well.

Cheers,
-Ian
