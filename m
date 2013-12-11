Return-Path: <felix@linux.vnet.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp13.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7E1D22C009E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 21:28:41 +1100 (EST)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Wed, 11 Dec 2013 10:28:37 -0000
Message-ID: <52A83EBE.4060305@linux.vnet.ibm.com>
Date: Wed, 11 Dec 2013 11:30:22 +0100
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: set default kernel thread priority to medium-low
References: <1386661163-4478-1-git-send-email-felix@linux.vnet.ibm.com>
 <1386743357.27999.1.camel@concordia> <1386755340.15730.11.camel@pasglop>
In-Reply-To: <1386755340.15730.11.camel@pasglop>
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

Benjamin Herrenschmidt wrote:
> On Wed, 2013-12-11 at 17:29 +1100, Michael Ellerman wrote:
> 
> 
>>It would be nice if you could make an assertion about what the state of HMT
>>handling should be once your patch is applied.
>>
>>I think it's:
>>
>> * The kernel should use HMT_MEDIUM_LOW as it's "default" priority
>> * The kernel should use HMT_LOW as it's "low" priority
>>
>>Which would imply:
>>
>> * The kernel should not use HMT_MEDIUM anywhere ..
>> * Nor should it use any of the other higher HMT modes.
>>
>>Do you agree?
Not entirely.  HT_MEDIUM might still be used by the kernel, in places where a priority higher than the default is required.
>>The reason I ask is I still see HMT_MEDIUM used in a few places, and it's not
>>clear to me if that is correct.
> 
> 
> HMT_MEDIUM used to be our default no ?
Yes, but I am not sure that all references to HMT_MEDIUM were references to the default kernel priority.
> Also there's an open question... when doing things with interrupts off
> (or worse, in real mode) such as some KVM hcalls etc... should we on the
> contrary boost up to limit interrupt latency ?
Yes. I think that there are cases when one should consider using HT_MEDIUM.

Shouldn't we define a new macro HMT_DEFAULT, to identify explicitely where the default priority is required?

Philippe
