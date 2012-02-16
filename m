Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 365661007DF
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Feb 2012 04:39:15 +1100 (EST)
Subject: Re: [PATCH v4 3/3] KVM: PPC: epapr: install ev_idle hcall for e500
 guest
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=iso-8859-1
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <4F3D3E89.3050301@freescale.com>
Date: Thu, 16 Feb 2012 18:39:11 +0100
Message-Id: <432728F9-D7B2-4FD8-B31D-87F9714B3CF1@suse.de>
References: <1329384365-4028-1-git-send-email-yu.liu@freescale.com>
 <1329384365-4028-2-git-send-email-yu.liu@freescale.com>
 <1329384365-4028-3-git-send-email-yu.liu@freescale.com>
 <EAC043A1-A04F-4A27-8488-3C42D99D175E@suse.de>
 <4F3D359E.6030209@freescale.com>
 <9A00D501-8965-478F-8356-6199F5572600@suse.de>
 <4F3D3CBA.2060201@freescale.com>
 <144AF998-6DEE-453A-872A-B148ACA2B7B8@suse.de>
 <4F3D3E89.3050301@freescale.com>
To: Scott Wood <scottwood@freescale.com>
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


On 16.02.2012, at 18:36, Scott Wood wrote:

> On 02/16/2012 11:30 AM, Alexander Graf wrote:
>>=20
>> On 16.02.2012, at 18:28, Scott Wood wrote:
>>=20
>>> On 02/16/2012 11:18 AM, Alexander Graf wrote:
>>>> Hrm. But we can clobber ctr, right? So how about we make the =
generic version do a bctr and then just do a small C wrapper that takes =
lr, moves it to ctr and branches to the generic one?
>>>=20
>>> If it's just for this, I would say don't mess with the normal hcall =
path
>>> for the sake of idle.  If using CTR would let us get away without
>>> creating a stack frame in call sites, maybe that would be =
worthwhile,
>>> depending on what sort of hcalls we end up having.
>>>=20
>>>> Then we don't have to replicate the hypercall code all over again =
for every invocation.
>>>=20
>>> We shouldn't need to do it for every invocation.  Idle is special =
due to
>>> the TLF_NAPPING hack.
>>=20
>> Famous last words. If it's the only case, duplication should be ok. =
Let's hope there are no others.
>=20
> Actually, we can't use CTR -- it's volatile in the ePAPR hypercall =
ABI.

Ugh. Alrighty, let's duplicate the hc code then.


Alex
