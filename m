Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44B511A0151
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 15:13:08 +1000 (AEST)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1205714076F
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2015 15:13:07 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 19 Aug 2015 15:13:07 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 764853578047
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2015 15:13:03 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7J5CuEk1966496
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2015 15:13:04 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7J5CUAn009561
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2015 15:12:31 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Matt Ochs <mrochs@us.ibm.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 mikey <mikey@neuling.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] cxl: add set/get private data to context struct
In-reply-to: <1439959770.24918.5.camel@ellerman.id.au>
References: <1439957971-30483-1-git-send-email-imunsie@au.ibm.com>
 <1439957971-30483-2-git-send-email-imunsie@au.ibm.com>
 <1439959770.24918.5.camel@ellerman.id.au>
Date: Wed, 19 Aug 2015 15:12:01 +1000
Message-Id: <1439960447-sup-3936@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Michael Ellerman's message of 2015-08-19 14:49:30 +1000:
> Do we really need the accessors? They don't buy anything I can see over just
> using ctx->priv directly.

The reasoning there is because we don't currently expose the contents of
stuct cxl_context to afu drivers, rather they just treat it as an opaque
type.

We could potentially change this to expose the details, but there's a
lot of junk in there that's just internal details of the cxl driver that
isn't of interest to an afu driver that I'd rather not expose.

We also already have another accessor function (cxl_process_element) in
the api, so it's not out of place.

FWIW I'm not opposed to changing how this api works if it ultimately
makes things better, but I want to wait until the cxlflash superpipe
support is merged so any patches that change the api can change it at
the same time.

Cheers,
-Ian
