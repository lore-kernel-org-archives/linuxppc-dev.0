Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E1D061A0329
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jun 2014 00:55:31 +1000 (EST)
Message-ID: <539B10DF.6070509@suse.de>
Date: Fri, 13 Jun 2014 16:55:27 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: "mihai.caraman@freescale.com" <mihai.caraman@freescale.com>,
 Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] KVM: PPC: e500mc: Relax tlb invalidation condition on
 vcpu schedule
References: <1402581610-16585-1-git-send-email-mihai.caraman@freescale.com>
 <5399DDA8.5060404@suse.de>
 <306b1e4daa2f4441aaef7c7383b484fc@BY2PR03MB508.namprd03.prod.outlook.com>
In-Reply-To: <306b1e4daa2f4441aaef7c7383b484fc@BY2PR03MB508.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 13.06.14 16:43, mihai.caraman@freescale.com wrote:
>> -----Original Message-----
>> From: Alexander Graf [mailto:agraf@suse.de]
>> Sent: Thursday, June 12, 2014 8:05 PM
>> To: Caraman Mihai Claudiu-B02008
>> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
>> dev@lists.ozlabs.org; Wood Scott-B07421
>> Subject: Re: [PATCH] KVM: PPC: e500mc: Relax tlb invalidation condition
>> on vcpu schedule
>>
>> On 06/12/2014 04:00 PM, Mihai Caraman wrote:
>>> On vcpu schedule, the condition checked for tlb pollution is too tight.
>>> The tlb entries of one vcpu are polluted when a different vcpu from the
>>> same partition runs in-between. Relax the current tlb invalidation
>>> condition taking into account the lpid.
>>>
>>> Signed-off-by: Mihai Caraman <mihai.caraman <at> freescale.com>
>> Your mailer is broken? :)
>> This really should be an @.
>>
>> I think this should work. Scott, please ack.
> Alex, you were right. I screwed up the patch description by inverting relax
> and tight terms :) It should have been more like this:
>
> KVM: PPC: e500mc: Enhance tlb invalidation condition on vcpu schedule
>
> On vcpu schedule, the condition checked for tlb pollution is too loose.
> The tlb entries of a vcpu are polluted (vs stale) only when a different vcpu
> within the same logical partition runs in-between. Optimize the tlb invalidation
> condition taking into account the lpid.

Can't we give every vcpu its own lpid? Or don't we trap on global 
invalidates?


Alex
