Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F1FD22C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2012 07:54:33 +1000 (EST)
Message-ID: <5051048D.3080309@freescale.com>
Date: Wed, 12 Sep 2012 16:54:21 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] KVM: PPC: bookehv: Allow duplicate calls of DO_KVM macro
References: <1347455894-30044-1-git-send-email-mihai.caraman@freescale.com>
 <F4E2A678-6697-4207-8CEE-2CFB3629F554@suse.de>
 <505100BD.6020304@freescale.com>
 <B9A48F7E-664A-4E8A-883F-CEB01068CC2A@suse.de>
In-Reply-To: <B9A48F7E-664A-4E8A-883F-CEB01068CC2A@suse.de>
Content-Type: text/plain; charset="UTF-8"
Cc: Mihai Caraman <mihai.caraman@freescale.com>,
 "<linuxppc-dev@lists.ozlabs.org>" <linuxppc-dev@lists.ozlabs.org>,
 "<kvm@vger.kernel.org>" <kvm@vger.kernel.org>,
 "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/12/2012 04:45 PM, Alexander Graf wrote:
> 
> 
> On 12.09.2012, at 23:38, Scott Wood <scottwood@freescale.com> wrote:
> 
>> On 09/12/2012 01:56 PM, Alexander Graf wrote:
>>>
>>>
>>> On 12.09.2012, at 15:18, Mihai Caraman <mihai.caraman@freescale.com> wrote:
>>>
>>>> The current form of DO_KVM macro restricts its use to one call per input
>>>> parameter set. This is caused by kvmppc_resume_\intno\()_\srr1 symbol
>>>> definition.
>>>> Duplicate calls of DO_KVM are required by distinct implementations of
>>>> exeption handlers which are delegated at runtime.
>>>
>>> Not sure I understand what you're trying to achieve here. Please elaborate ;)
>>
>> On 64-bit book3e we compile multiple versions of the TLB miss handlers,
>> and choose from them at runtime.  
> 
> Why?

Because one size does not fit all, and we try to not force a separate
kernel build based on what sort of TLB miss handler a piece of hardware
wants.  Some of the differences are too large to be sanely handled by
feature fixups.

>> Without this patch, we get duplicate
>> label errors if more than one variant of the same exception uses DO_KVM.
> 
> Makes sense. The proposed solution also looks good. Just quickly walk me through the reasoning for the runtime check again please.

To start with, you have a TLB miss handler for when partial hardware
tablewalk is used (only the final page table level is looked up in
hardware, so we still need a TLB miss handler to load indirect entries),
and one where that feature is not available.  Then you have the "bolted"
variant used by e5500, which is faster than the generic version because
it doesn't have to deal with recursive faults.  So far the bolted
version is the only one with DO_KVM.

I posted a patch to add another variant, for e6500-style hardware
tablewalk, which shares the bolted prolog/epilog (besides prolog/epilog
performance, e6500 is incompatible with the IBM tablewalk code for
various reasons).  That caused us to have two DO_KVMs for the same
exception type.

-Scott
