Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xV4h3vTdzDrYj
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jun 2018 00:21:08 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <oss@buserror.net>,
 Diana Madalina Craciun <diana.craciun@nxp.com>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc: Leo Li <leoyang.li@nxp.com>
Subject: Re: [RFC PATCH] powerpc/fsl: Add barrier_nospec implementation for
 NXP PowerPC Book E
In-Reply-To: <1527621245.30674.30.camel@buserror.net>
References: <1526973031-9543-1-git-send-email-diana.craciun@nxp.com>
 <1527020969.30674.13.camel@buserror.net>
 <VI1PR0401MB246345AD11EC8666B7187F8DFF6D0@VI1PR0401MB2463.eurprd04.prod.outlook.com>
 <1527621245.30674.30.camel@buserror.net>
Date: Fri, 01 Jun 2018 00:21:07 +1000
Message-ID: <87wovjykh8.fsf@concordia.ellerman.id.au>
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
> On Tue, 2018-05-29 at 15:22 +0000, Diana Madalina Craciun wrote:
>> On 05/22/2018 11:31 PM, Scott Wood wrote:
>
>> > Should there be a way for the user to choose not to enable this (editing
>> > the
>> > device tree doesn't count), for a use case that is not sufficiently
>> > security
>> > sensitive to justify the performance loss?  What is the performance impact
>> > of
>> > this patch?
>> 
>> My reason was that on the other architectures Spectre variant 1
>> mitigations are not disabled either. But I think that it might be a good
>> idea to add a bootarg parameter to disable the barrier.
>
> Is there a specific policy reason why they allow spectre v2 to be disabled but
> not v1,

No.

> or just a matter of not having a mechanism to disable it,

Yes and no. Some of the v1 mitigation is done via masking which can't be
easily patched. eg. array_index_nospec()

> or the parts which could practically be disabled not impacting
> performance much?

That's the mean reason AIUI.

We can add a nospectre_v1 command line option if necessary.

cheers
