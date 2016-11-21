Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tMkzM38fPzDvy7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 21:16:47 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Lars-Peter Clausen <lars@metafoo.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] ibmebus: Remove legacy suspend/resume support
In-Reply-To: <57d7b8c5-1deb-937c-5ad9-23912b38bd60@metafoo.de>
References: <1479562934-1541-1-git-send-email-lars@metafoo.de>
 <87polpw45o.fsf@concordia.ellerman.id.au>
 <57d7b8c5-1deb-937c-5ad9-23912b38bd60@metafoo.de>
Date: Mon, 21 Nov 2016 21:16:46 +1100
Message-ID: <87k2bxw31t.fsf@concordia.ellerman.id.au>
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

Lars-Peter Clausen <lars@metafoo.de> writes:

> On 11/21/2016 10:52 AM, Michael Ellerman wrote:
>> Lars-Peter Clausen <lars@metafoo.de> writes:
>> 
>>> There are no ibmebus driver that make use of legacy suspend/resume. This
>>> patch removes the support for it from ibmebus framework, new ibmebus driver
>>> (as unlikely as they are) wanting to use suspend/resume should use
>>> dev_pm_ops.
>>>
>>> Since there aren't any special bus specific things to do during
>>> suspend/resume and since the PM core will automatically fallback directly
>>> to using the device's PM ops if no bus PM ops are specified there is no
>>> need to have any special ibmebus PM ops at all.
>> 
>> Thanks, this looks like a really nice cleanup.
>> 
>> I don't know the PM code at all, is there any down side to removing all
>> of this?
>
> No, dev_pm_op is a full replacement for the legacy suspend/resume callbacks
> and dev_pm_ops are supported by the power management core out of the box
> without having to have any bus specific code. Which is why we want to get
> rid of legacy PM callbacks in general and this is one of the last few buses
> that still implements it. But since there are no drivers that use it
> removing it is straight forward in this case, for others it takes a bit more
> work.

Great, thanks. I'll merge this via the powerpc tree for 4.10.

cheers
