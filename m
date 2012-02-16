Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE005.bigfish.com (am1ehsobe002.messaging.microsoft.com
 [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 889871007D3
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Feb 2012 04:36:23 +1100 (EST)
Message-ID: <4F3D3E89.3050301@freescale.com>
Date: Thu, 16 Feb 2012 11:36:09 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH v4 3/3] KVM: PPC: epapr: install ev_idle hcall for e500
 guest
References: <1329384365-4028-1-git-send-email-yu.liu@freescale.com>
 <1329384365-4028-2-git-send-email-yu.liu@freescale.com>
 <1329384365-4028-3-git-send-email-yu.liu@freescale.com>
 <EAC043A1-A04F-4A27-8488-3C42D99D175E@suse.de>
 <4F3D359E.6030209@freescale.com>
 <9A00D501-8965-478F-8356-6199F5572600@suse.de>
 <4F3D3CBA.2060201@freescale.com>
 <144AF998-6DEE-453A-872A-B148ACA2B7B8@suse.de>
In-Reply-To: <144AF998-6DEE-453A-872A-B148ACA2B7B8@suse.de>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "<linuxppc-dev@ozlabs.org>" <linuxppc-dev@ozlabs.org>,
 Liu Yu <yu.liu@freescale.com>, "<kvm@vger.kernel.org>" <kvm@vger.kernel.org>,
 "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>,
 "<B07421@freescale.com>" <B07421@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/16/2012 11:30 AM, Alexander Graf wrote:
> 
> On 16.02.2012, at 18:28, Scott Wood wrote:
> 
>> On 02/16/2012 11:18 AM, Alexander Graf wrote:
>>> Hrm. But we can clobber ctr, right? So how about we make the generic version do a bctr and then just do a small C wrapper that takes lr, moves it to ctr and branches to the generic one?
>>
>> If it's just for this, I would say don't mess with the normal hcall path
>> for the sake of idle.  If using CTR would let us get away without
>> creating a stack frame in call sites, maybe that would be worthwhile,
>> depending on what sort of hcalls we end up having.
>>
>>> Then we don't have to replicate the hypercall code all over again for every invocation.
>>
>> We shouldn't need to do it for every invocation.  Idle is special due to
>> the TLF_NAPPING hack.
> 
> Famous last words. If it's the only case, duplication should be ok. Let's hope there are no others.

Actually, we can't use CTR -- it's volatile in the ePAPR hypercall ABI.

-Scott
