Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40y17J4sqYzDr2n
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jun 2018 20:40:12 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <oss@buserror.net>,
 Diana Madalina Craciun <diana.craciun@nxp.com>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc: Leo Li <leoyang.li@nxp.com>
Subject: Re: [RFC PATCH] powerpc/fsl: Add barrier_nospec implementation for
 NXP PowerPC Book E
In-Reply-To: <1527804215.30674.35.camel@buserror.net>
References: <1526973031-9543-1-git-send-email-diana.craciun@nxp.com>
 <1527020969.30674.13.camel@buserror.net>
 <VI1PR0401MB246345AD11EC8666B7187F8DFF6D0@VI1PR0401MB2463.eurprd04.prod.outlook.com>
 <1527621245.30674.30.camel@buserror.net>
 <87wovjykh8.fsf@concordia.ellerman.id.au>
 <VI1PR0401MB2463C17743BC5C25C2152631FF630@VI1PR0401MB2463.eurprd04.prod.outlook.com>
 <1527804215.30674.35.camel@buserror.net>
Date: Fri, 01 Jun 2018 20:40:11 +1000
Message-ID: <87vab23i44.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <oss@buserror.net> writes:

> On Thu, 2018-05-31 at 14:35 +0000, Diana Madalina Craciun wrote:
>> On 5/31/2018 5:21 PM, Michael Ellerman wrote:
>> > 
>> > We can add a nospectre_v1 command line option if necessary.
>> 
>> What about nobarrier_nospec (or similar) instead of nospectre_v1 command
>> line? We are not disabling all the v1 mitigations, the masking part will
>> remain unchanged.
>
> I think nospectre_v1 makes more sense as it's about the user's intentions
> rather than the implementation.  The user is giving the kernel permission to
> not defend against spectre v1, and it's up to the implementation which
> mitigations (if any) to disable in response to that, same as any other
> optimization.

Yeah I agree. We also have `nospectre_v2` on x86/s390 so I think keeping
consistency with that is a must.

cheers
