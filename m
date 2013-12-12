Return-Path: <felix@linux.vnet.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp16.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C96372C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Dec 2013 18:09:56 +1100 (EST)
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Thu, 12 Dec 2013 07:09:52 -0000
Message-ID: <52A961A0.5010307@linux.vnet.ibm.com>
Date: Thu, 12 Dec 2013 08:11:28 +0100
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc: set default kernel thread priority to medium-low
References: <1386661163-4478-1-git-send-email-felix@linux.vnet.ibm.com>
 <1386743357.27999.1.camel@concordia> <1386755340.15730.11.camel@pasglop>
 <52A83EBE.4060305@linux.vnet.ibm.com> <1386811338.12662.3.camel@concordia>
In-Reply-To: <1386811338.12662.3.camel@concordia>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Wed, 2013-12-11 at 11:30 +0100, Philippe Bergheaud wrote:
> 
>>Benjamin Herrenschmidt wrote:
>>
>>>On Wed, 2013-12-11 at 17:29 +1100, Michael Ellerman wrote:
>>>
>>>
>>>
>>>>It would be nice if you could make an assertion about what the state of HMT
>>>>handling should be once your patch is applied.
>>>>
>>>>I think it's:
>>>>
>>>>* The kernel should use HMT_MEDIUM_LOW as it's "default" priority
>>>>* The kernel should use HMT_LOW as it's "low" priority
>>>>
>>>>Which would imply:
>>>>
>>>>* The kernel should not use HMT_MEDIUM anywhere ..
>>>>* Nor should it use any of the other higher HMT modes.
>>>>
>>>>Do you agree?
> 
> 
>>Not entirely.  HT_MEDIUM might still be used by the kernel, in places where a
>>priority higher than the default is required.
> 
> 
> Right. But any code that currently uses HMT_MEDIUM is at the default level,
> whereas once your patch is applied any code still using HMT_MEDIUM will be
> boosted vs the default.
> 
> So any code that still uses HMT_MEDIUM after your patch seems like a bug to me.
> 
> 
>>>>The reason I ask is I still see HMT_MEDIUM used in a few places, and it's not
>>>>clear to me if that is correct.
>>>
>>>
>>>HMT_MEDIUM used to be our default no ?
> 
> 
>>Yes, but I am not sure that all references to HMT_MEDIUM were references to
>>the default kernel priority.
> 
> 
> What were they references to? Regardless they will now have the effect of
> boosting the priority in those code sections. It would be good to understand,
> and document, any places where we still use HMT_MEDIUM and why.
Yes. This needs to be documented.

> 
>>>Also there's an open question... when doing things with interrupts off
>>>(or worse, in real mode) such as some KVM hcalls etc... should we on the
>>>contrary boost up to limit interrupt latency ?
> 
> 
>>Yes. I think that there are cases when one should consider using HT_MEDIUM.
> 
> 
> Or HIGH?
Correct, I had not thought of that option.

> But let's not get side-tracked on that until we've got the default sorted.
> 
> 
>>Shouldn't we define a new macro HMT_DEFAULT, to identify explicitely where
>>the default priority is required?
> 
> 
> That might help clarify things yes.
> 
> cheers
> 
Thank you for the help. I will rework this.

Philippe
