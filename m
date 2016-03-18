Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qRGHX3RR0zDqVL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 17:57:12 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Fri, 18 Mar 2016 16:57:10 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3505B357805B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 17:56:58 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2I6uioO61997128
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 17:56:53 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2I6u6kV004132
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 17:56:06 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: "andrew.donnellan" <andrew.donnellan@au1.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] cxl: fix setting of _PAGE_USER bit when handling page
 faults
In-reply-to: <1458273681-18588-1-git-send-email-andrew.donnellan@au1.ibm.com>
References: <1458273681-18588-1-git-send-email-andrew.donnellan@au1.ibm.com>
Date: Fri, 18 Mar 2016 17:30:23 +1100
Message-Id: <1458282296-sup-2460@x230.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from andrew.donnellan's message of 2016-03-18 15:01:21 +1100:
> Fixes: f204e0b8cedd ("cxl: Driver code for powernv PCIe based cards for
> userspace access")

It doesn't fix that since there was no cxl kernel API support at the
time, so this wasn't a regression - just something we missed when the
kernel api was added (I believe the broken test in the code was a left
over from some early bringup work and would never have been exercised on
an upstream kernel until then).

> Currently, this should only affect cxlflash.

We haven't run into any problems because of this that I am aware of - do
we have a test case for this?

> -    if ((!ctx->kernel) || ~(dar & (1ULL << 63)))
> +    if ((!ctx->kernel) || !(dar & (1ULL << 63)))

Should it be the top two bits?

-Ian
