Return-Path: <anton@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D78CE1A032F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 09:59:55 +1100 (AEDT)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B0BEC1402B8
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Nov 2015 09:59:55 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <anton@au1.ibm.com>;
 Thu, 26 Nov 2015 08:59:54 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E59AA3578047
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Nov 2015 09:59:49 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAPMxPXn29491448
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Nov 2015 09:59:33 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAPMxHTj001839
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Nov 2015 09:59:17 +1100
Date: Thu, 26 Nov 2015 09:58:18 +1100
From: Anton Blanchard <anton@au1.ibm.com>
To: Torsten Duwe <duwe@lst.de>
Cc: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <michaele@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] cxl: Fix build failure due to -Wunused-variable
 behaviour change
Message-ID: <20151126095818.1e394395@kryten>
In-Reply-To: <20151125161616.GA30262@lst.de>
References: <1442296114-16796-1-git-send-email-imunsie@au.ibm.com>
 <20151125161616.GA30262@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Torsten,

> > -ccflags-y := -Werror
> > +ccflags-y := -Werror -Wno-unused-const-variable
> 
> JFYI, my gcc-4.3 does not like this switch.
> What's the minimum compiler version to build this code?

-Werror is such a moving target. I'm also seeing issues when building
with clang, eg:

drivers/misc/cxl/native.c:223:20: warning: unused function
'detach_spa' [-Wunused-function]

Anton
